<?php
// laboratory/api/upload_results.php - Handle file upload for lab results
session_start();
require_once '../../../config/database.php';
require_once '../../../includes/functions.php';

verify_session();

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Método no permitido']);
    exit;
}

$id_orden = $_POST['id_orden'] ?? null;
$notas = $_POST['notas'] ?? '';

if (!$id_orden) {
    echo json_encode(['success' => false, 'message' => 'Faltan parámetros requeridos']);
    exit;
}

try {
    $database = new Database();
    $conn = $database->getConnection();

    // Handle file upload
    if (isset($_FILES['archivo_resultado']) && $_FILES['archivo_resultado']['error'] === UPLOAD_ERR_OK) {

        $fileTmpPath = $_FILES['archivo_resultado']['tmp_name'];
        $fileName = $_FILES['archivo_resultado']['name'];
        $fileSize = $_FILES['archivo_resultado']['size'];
        $fileType = $_FILES['archivo_resultado']['type'];
        $fileNameCmps = explode(".", $fileName);
        $fileExtension = strtolower(end($fileNameCmps));

        $allowedfileExtensions = ['pdf', 'jpg', 'jpeg', 'png'];

        if (!in_array($fileExtension, $allowedfileExtensions)) {
            echo json_encode(['success' => false, 'message' => 'Tipo de archivo no permitido. Solo PDF, JPG, PNG.']);
            exit;
        }

        // Read file content
        $content = file_get_contents($fileTmpPath);

        $conn->beginTransaction();

        // Insert file into archivos_resultados_laboratorio
        $stmt = $conn->prepare("INSERT INTO archivos_resultados_laboratorio (id_orden, nombre_archivo, tipo_contenido, tamano, contenido, notas) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->execute([$id_orden, $fileName, $fileType, $fileSize, $content, $notas]);

        // Update order status if needed (optional based on workflow requirements)
        // For now, we assume uploading results might mark it as Completada or En_Proceso depending on business logic
        // But the prompt was just to upload. We will leave the status update to the "Validar" button logic unless requested.

        $conn->commit();

        echo json_encode([
            'success' => true,
            'message' => 'Resultados cargados correctamente',
        ]);

    } else {
        $error = $_FILES['archivo_resultado']['error'] ?? 'Archivo no recibido';
        echo json_encode(['success' => false, 'message' => 'Error en la carga: ' . $error]);
    }

} catch (Exception $e) {
    if (isset($conn))
        $conn->rollBack();
    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}
?>