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
    if (isset($_FILES['archivo_resultado'])) {
        $fileCount = is_array($_FILES['archivo_resultado']['name']) ? count($_FILES['archivo_resultado']['name']) : 1;
        $uploadedCount = 0;
        
        $conn->beginTransaction();
        
        for ($i = 0; $i < $fileCount; $i++) {
            $error = is_array($_FILES['archivo_resultado']['error']) ? $_FILES['archivo_resultado']['error'][$i] : $_FILES['archivo_resultado']['error'];
            
            if ($error === UPLOAD_ERR_OK) {
                $fileTmpPath = is_array($_FILES['archivo_resultado']['tmp_name']) ? $_FILES['archivo_resultado']['tmp_name'][$i] : $_FILES['archivo_resultado']['tmp_name'];
                $fileName = is_array($_FILES['archivo_resultado']['name']) ? $_FILES['archivo_resultado']['name'][$i] : $_FILES['archivo_resultado']['name'];
                $fileSize = is_array($_FILES['archivo_resultado']['size']) ? $_FILES['archivo_resultado']['size'][$i] : $_FILES['archivo_resultado']['size'];
                $fileType = is_array($_FILES['archivo_resultado']['type']) ? $_FILES['archivo_resultado']['type'][$i] : $_FILES['archivo_resultado']['type'];
                
                $fileNameCmps = explode(".", $fileName);
                $fileExtension = strtolower(end($fileNameCmps));
                $allowedfileExtensions = ['pdf', 'jpg', 'jpeg', 'png'];

                if (!in_array($fileExtension, $allowedfileExtensions)) {
                    throw new Exception('Tipo de archivo no permitido: ' . $fileName);
                }

                $content = file_get_contents($fileTmpPath);

                $stmt = $conn->prepare("INSERT INTO archivos_resultados_laboratorio (id_orden, nombre_archivo, tipo_contenido, tamano, contenido, notas) VALUES (?, ?, ?, ?, ?, ?)");
                $stmt->execute([$id_orden, $fileName, $fileType, $fileSize, $content, $notas]);
                $uploadedCount++;
            }
        }

        if ($uploadedCount > 0) {
            $conn->commit();
            echo json_encode([
                'success' => true,
                'message' => $uploadedCount . ' archivo(s) cargado(s) correctamente',
            ]);
        } else {
            $conn->rollBack();
            echo json_encode(['success' => false, 'message' => 'Ningún archivo fue recibido o procesado']);
        }

    } else {
        echo json_encode(['success' => false, 'message' => 'Archivo no recibido']);
    }

} catch (Exception $e) {
    if (isset($conn))
        $conn->rollBack();
    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}
?>