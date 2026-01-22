<?php
// get_shift_cut_data.php
// Returns JSON data for the Shift Cut report
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

require_once '../../config/database.php';

try {
    $database = new Database();
    $conn = $database->getConnection();

    // Get date filter (default to today)
    $input = json_decode(file_get_contents('php://input'), true);
    $date = $input['date'] ?? $_GET['date'] ?? date('Y-m-d');

    // Define shift range (08:00 AM to 08:00 AM next day)
    $start_datetime = $date . ' 08:00:00';
    $end_datetime = date('Y-m-d', strtotime($date . ' +1 day')) . ' 07:59:59';

    // 1. Pharmacy Sales (Ventas)
    $stmt = $conn->prepare("SELECT SUM(total) FROM ventas WHERE fecha_venta BETWEEN ? AND ?");
    $stmt->execute([$start_datetime, $end_datetime]);
    $pharmacy_sales = $stmt->fetchColumn() ?: 0;

    // 2. Consultations (Cobros)
    // Assuming 'cobros' table tracks consultation payments
    $stmt = $conn->prepare("SELECT SUM(cantidad_consulta) FROM cobros WHERE fecha_consulta BETWEEN ? AND ?");
    $stmt->execute([$date, $date]); // Using date for cobros as it might be date-based, or adjust if datetime available
    $consultation_income = $stmt->fetchColumn() ?: 0;

    // 3. Laboratories (Exámenes)
    $stmt = $conn->prepare("SELECT SUM(cobro) FROM examenes_realizados WHERE fecha_examen BETWEEN ? AND ?");
    $stmt->execute([$start_datetime, $end_datetime]);
    $lab_income = $stmt->fetchColumn() ?: 0;

    // 4. Minor Procedures
    $stmt = $conn->prepare("SELECT SUM(cobro) FROM procedimientos_menores WHERE fecha_procedimiento BETWEEN ? AND ?");
    $stmt->execute([$start_datetime, $end_datetime]);
    $procedures_income = $stmt->fetchColumn() ?: 0;

    // 5. Ultrasounds (Placeholder)
    $ultrasound_income = 0.00;

    // 6. X-Rays (Placeholder)
    $xray_income = 0.00;

    // Calculate total
    $total_income = $pharmacy_sales + $consultation_income + $lab_income + $procedures_income + $ultrasound_income + $xray_income;

    // Return data
    echo json_encode([
        'success' => true,
        'period' => [
            'start' => $start_datetime,
            'end' => $end_datetime
        ],
        'data' => [
            'pharmacy' => number_format($pharmacy_sales, 2),
            'consultations' => number_format($consultation_income, 2),
            'laboratory' => number_format($lab_income, 2),
            'min_procedures' => number_format($procedures_income, 2),
            'ultrasound' => number_format($ultrasound_income, 2),
            'xray' => number_format($xray_income, 2),
            'total' => number_format($total_income, 2)
        ]
    ]);

} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>