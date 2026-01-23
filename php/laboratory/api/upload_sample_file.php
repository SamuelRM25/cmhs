<?php
// laboratory/api/upload_sample_file.php - Handle file upload for sample reception
session_start();
require_once '../../../config/database.php';
require_once '../../../includes/functions.php';

verify_session();

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Método no permitido']);
    exit;
}

$id_orden_prueba = $_POST['id_orden_prueba'] ?? null;
$id_orden = $_POST['id_orden'] ?? null;
$notas = $_POST['notas'] ?? '';

if (!$id_orden_prueba || !$id_orden) {
    echo json_encode(['success' => false, 'message' => 'Faltan parámetros requeridos']);
    exit;
}

try {
    $database = new Database();
    $conn = $database->getConnection();

    // Handle file upload
    if (isset($_FILES['archivo_muestra']) && $_FILES['archivo_muestra']['error'] === UPLOAD_ERR_OK) {
        $uploadDir = '../../../uploads/samples/';
        if (!file_exists($uploadDir)) {
            mkdir($uploadDir, 0755, true);
        }

        $fileInfo = pathinfo($_FILES['archivo_muestra']['name']);
        $extension = strtolower($fileInfo['extension']);
        $newFileName = 'sample_' . $id_orden_prueba . '_' . uniqid() . '.' . $extension;
        $targetPath = $uploadDir . $newFileName;

        $allowedExts = ['pdf', 'jpg', 'jpeg', 'png'];

        if (!in_array($extension, $allowedExts)) {
            echo json_encode(['success' => false, 'message' => 'Tipo de archivo no permitido']);
            exit;
        }

        if (move_uploaded_file($_FILES['archivo_muestra']['tmp_name'], $targetPath)) {
            // Save relative path to DB
            $dbPath = '../../uploads/samples/' . $newFileName;

            $conn->beginTransaction();

            // Update orden_pruebas status and add file reference
            $stmt = $conn->prepare("
                UPDATE orden_pruebas 
                SET estado = 'Muestra_Recibida', 
                    fecha_muestra_recibida = NOW(),
                    notas_tecnico = ?,
                    archivo_resultados = ?
                WHERE id_orden_prueba = ?
            ");
            $stmt->execute([$notas, $dbPath, $id_orden_prueba]);

            // Update order status if it was Pendiente
            $stmt = $conn->prepare("
                UPDATE ordenes_laboratorio 
                SET estado = 'Muestra_Recibida', fecha_muestra_recibida = NOW()
                WHERE id_orden = ? AND estado = 'Pendiente'
            ");
            $stmt->execute([$id_orden]);

            // You might want to store the file path in a dedicated column
            // For now, we'll add it to notas_tecnico or you can add a new column

            $conn->commit();

            echo json_encode([
                'success' => true,
                'message' => 'Archivo cargado y muestra recibida correctamente',
                'file_path' => $dbPath
            ]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Error al guardar el archivo']);
        }
    } else {
        $error = $_FILES['archivo_muestra']['error'] ?? 'Archivo no recibido';
        echo json_encode(['success' => false, 'message' => 'Error en la carga: ' . $error]);
    }

} catch (Exception $e) {
    if (isset($conn))
        $conn->rollBack();
    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}
?>