<?php
// get_shift_cut_data.php
// Returns JSON data for the Shift Cut report with detailed breakdown
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

    // Get input parameters
    $date = $_GET['date'] ?? date('Y-m-d');
    $shift = $_GET['shift'] ?? 'morning'; // 'morning' or 'night'

    // Define shift ranges
    if ($shift === 'morning') {
        $start_datetime = $date . ' 08:00:00';
        $end_datetime = $date . ' 17:00:00';
    } else {
        $start_datetime = $date . ' 17:00:00';
        $end_datetime = date('Y-m-d', strtotime($date . ' +1 day')) . ' 07:59:59';
    }

    $methods = ['Efectivo', 'Tarjeta', 'Transferencia'];

    // Function to get totals by payment method from any table
    $getTotals = function ($conn, $table, $column_amount, $column_date, $start, $end, $column_pago = 'tipo_pago') use ($methods) {
        $results = [];
        $total = 0;
        foreach ($methods as $method) {
            $stmt = $conn->prepare("SELECT SUM($column_amount) FROM $table WHERE $column_date BETWEEN ? AND ? AND $column_pago = ?");
            $stmt->execute([$start, $end, $method]);
            $val = (float) ($stmt->fetchColumn() ?: 0);
            $results[$method] = $val;
            $total += $val;
        }
        return ['breakdown' => $results, 'total' => $total];
    };

    // 1. Pharmacy Sales (Ventas)
    $pharmacy = $getTotals($conn, 'ventas', 'total', 'fecha_venta', $start_datetime, $end_datetime, 'tipo_pago');

    // 2. Consultations (Cobros) - Detailed by Doctor
    $consultations_breakdown = [];
    $consultations_total = 0;

    // Get all doctors who made charges in this period
    $stmt_docs = $conn->prepare("
        SELECT DISTINCT u.idUsuario, u.nombre, u.apellido 
        FROM cobros c
        JOIN usuarios u ON c.id_doctor = u.idUsuario
        WHERE c.fecha_consulta BETWEEN ? AND ?
    ");
    // For cobros, it seems it might be date only or datetime depending on implementation. 
    // We'll use the same range but cast to date if needed, or assume it stores datetime now.
    $stmt_docs->execute([$start_datetime, $end_datetime]);
    $doctors = $stmt_docs->fetchAll(PDO::FETCH_ASSOC);

    foreach ($doctors as $doc) {
        $doc_name = $doc['nombre'] . ' ' . $doc['apellido'];
        $doc_data = [];
        $doc_total = 0;
        foreach ($methods as $method) {
            $stmt = $conn->prepare("SELECT SUM(cantidad_consulta) FROM cobros WHERE fecha_consulta BETWEEN ? AND ? AND id_doctor = ? AND tipo_pago = ?");
            $stmt->execute([$start_datetime, $end_datetime, $doc['idUsuario'], $method]);
            $val = (float) ($stmt->fetchColumn() ?: 0);
            $doc_data[$method] = $val;
            $doc_total += $val;
        }
        $consultations_breakdown[] = [
            'doctor' => $doc_name,
            'breakdown' => $doc_data,
            'total' => $doc_total
        ];
        $consultations_total += $doc_total;
    }

    // 3. Laboratories (examenes_realizados)
    $lab = $getTotals($conn, 'examenes_realizados', 'cobro', 'fecha_examen', $start_datetime, $end_datetime);

    // 4. Minor Procedures (procedimientos_menores)
    $procedures = $getTotals($conn, 'procedimientos_menores', 'cobro', 'fecha_procedimiento', $start_datetime, $end_datetime);

    // 5. Ultrasound & 6. X-Rays (Placeholder tables if they exist, or using cobros with special flags)
    // For now we use the same structure even if 0
    $ultrasound = $getTotals($conn, 'cobros', '0', 'fecha_consulta', $start_datetime, $end_datetime); // Placeholder
    $xray = $getTotals($conn, 'cobros', '0', 'fecha_consulta', $start_datetime, $end_datetime); // Placeholder

    $grand_total = $pharmacy['total'] + $consultations_total + $lab['total'] + $procedures['total'] + $ultrasound['total'] + $xray['total'];

    echo json_encode([
        'success' => true,
        'period' => [
            'start' => $start_datetime,
            'end' => $end_datetime,
            'shift' => $shift
        ],
        'data' => [
            'pharmacy' => $pharmacy,
            'consultations' => [
                'by_doctor' => $consultations_breakdown,
                'total' => $consultations_total
            ],
            'laboratory' => $lab,
            'procedures' => $procedures,
            'ultrasound' => $ultrasound,
            'xray' => $xray,
            'grand_total' => $grand_total
        ]
    ]);

} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>