-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: buyvuolarphibfd4i5ie-mysql.services.clever-cloud.com:20926
-- Tiempo de generación: 11-02-2026 a las 14:50:43
-- Versión del servidor: 8.4.6-6
-- Versión de PHP: 8.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `buyvuolarphibfd4i5ie`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `abonos_hospitalarios`
--

CREATE TABLE `abonos_hospitalarios` (
  `id_abono` int NOT NULL,
  `id_cuenta` int NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo_pago` enum('Efectivo','Tarjeta','Transferencia','Seguro') NOT NULL DEFAULT 'Efectivo',
  `fecha_abono` datetime DEFAULT CURRENT_TIMESTAMP,
  `saldo_pendiente` decimal(10,2) NOT NULL DEFAULT '0.00',
  `notas` text,
  `registrado_por` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `abonos_hospitalarios`
--

INSERT INTO `abonos_hospitalarios` (`id_abono`, `id_cuenta`, `monto`, `metodo_pago`, `fecha_abono`, `saldo_pendiente`, `notas`, `registrado_por`) VALUES
(10, 9, 2285.00, 'Efectivo', '2026-01-31 13:16:53', 0.00, '', 12),
(11, 10, 3173.00, 'Efectivo', '2026-02-04 08:18:13', 0.00, '', 12),
(12, 11, 2166.00, 'Efectivo', '2026-02-09 12:36:07', 0.00, '', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administracion_medicamentos`
--

CREATE TABLE `administracion_medicamentos` (
  `id_administracion` int NOT NULL,
  `id_encamamiento` int NOT NULL,
  `id_medicamento` int DEFAULT NULL COMMENT 'Referencia a inventario',
  `nombre_medicamento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dosis` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `via_administracion` enum('Oral','Intravenosa','Intramuscular','Subcutánea','Tópica','Rectal','Otra') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `frecuencia` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Ej: Cada 8 horas, 3 veces al día',
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `indicado_por` int DEFAULT NULL,
  `administrado_por` int DEFAULT NULL,
  `fecha_administracion` datetime DEFAULT NULL,
  `notas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `estado` enum('Programado','Administrado','Omitido','Suspendido') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Programado',
  `motivo_omision` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos_orden`
--

CREATE TABLE `archivos_orden` (
  `id_archivo` int NOT NULL,
  `id_orden_prueba` int NOT NULL,
  `nombre_archivo` varchar(255) NOT NULL,
  `tipo_contenido` varchar(100) NOT NULL,
  `tamano` int NOT NULL,
  `contenido` longblob NOT NULL,
  `fecha_carga` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos_resultados_laboratorio`
--

CREATE TABLE `archivos_resultados_laboratorio` (
  `id_archivo` int NOT NULL,
  `id_orden` int NOT NULL,
  `nombre_archivo` varchar(255) NOT NULL,
  `tipo_contenido` varchar(100) NOT NULL,
  `tamano` int NOT NULL,
  `contenido` longblob NOT NULL,
  `notas` text,
  `fecha_carga` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `camas`
--

CREATE TABLE `camas` (
  `id_cama` int NOT NULL,
  `id_habitacion` int NOT NULL,
  `numero_cama` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` enum('Disponible','Ocupada','Mantenimiento','Reservada') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Disponible',
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `camas`
--

INSERT INTO `camas` (`id_cama`, `id_habitacion`, `numero_cama`, `estado`, `descripcion`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(2, 2, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(3, 3, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(4, 4, '1', 'Ocupada', NULL, '2026-01-18 17:10:00', '2026-02-11 13:54:05'),
(5, 5, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(6, 6, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-30 20:25:31'),
(7, 7, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(8, 8, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-30 20:25:17'),
(9, 9, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargos_hospitalarios`
--

CREATE TABLE `cargos_hospitalarios` (
  `id_cargo` int NOT NULL,
  `id_cuenta` int NOT NULL,
  `tipo_cargo` enum('Habitación','Medicamento','Procedimiento','Laboratorio','Honorario','Insumo','Otro') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` decimal(10,3) DEFAULT '1.000',
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS ((`cantidad` * `precio_unitario`)) STORED,
  `fecha_cargo` datetime NOT NULL,
  `fecha_aplicacion` date DEFAULT NULL COMMENT 'Para cargos de habitación por noche',
  `registrado_por` int DEFAULT NULL,
  `referencia_id` int DEFAULT NULL COMMENT 'ID del item original (id_medicamento, id_procedimiento, etc)',
  `referencia_tabla` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Nombre de la tabla de referencia',
  `notas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelado` tinyint(1) DEFAULT '0',
  `fecha_cancelacion` datetime DEFAULT NULL,
  `motivo_cancelacion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cargos_hospitalarios`
--

INSERT INTO `cargos_hospitalarios` (`id_cargo`, `id_cuenta`, `tipo_cargo`, `descripcion`, `cantidad`, `precio_unitario`, `fecha_cargo`, `fecha_aplicacion`, `registrado_por`, `referencia_id`, `referencia_tabla`, `notas`, `cancelado`, `fecha_cancelacion`, `motivo_cancelacion`, `fecha_creacion`) VALUES
(34, 7, 'Habitación', 'Habitación 301 - Cama 1 (Día de ingreso)', 1.000, 950.00, '2026-01-24 22:00:00', '2026-01-24', 7, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-30 20:13:37'),
(35, 7, 'Habitación', 'Habitación 301 - Cama 1 (Noche 2026-01-25)', 1.000, 950.00, '2026-01-30 14:13:41', '2026-01-25', 7, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-30 20:13:41'),
(36, 7, 'Habitación', 'Habitación 301 - Cama 1 (Noche 2026-01-26)', 1.000, 950.00, '2026-01-30 14:13:41', '2026-01-26', 7, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-30 20:13:41'),
(37, 7, 'Habitación', 'Habitación 301 - Cama 1 (Noche 2026-01-27)', 1.000, 950.00, '2026-01-30 14:13:41', '2026-01-27', 7, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-30 20:13:41'),
(38, 7, 'Habitación', 'Habitación 301 - Cama 1 (Noche 2026-01-28)', 1.000, 950.00, '2026-01-30 14:13:41', '2026-01-28', 7, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-30 20:13:41'),
(39, 7, 'Habitación', 'Habitación 301 - Cama 1 (Noche 2026-01-29)', 1.000, 950.00, '2026-01-30 14:13:41', '2026-01-29', 7, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-30 20:13:41'),
(40, 8, 'Habitación', 'Habitación 402 - Cama 1 (Día de ingreso)', 1.000, 950.00, '2026-01-29 20:21:00', '2026-01-29', 7, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-30 20:24:41'),
(41, 9, 'Habitación', 'Habitación 301 - Cama 1 (Día de ingreso)', 1.000, 950.00, '2026-01-29 08:38:00', '2026-01-29', 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 14:53:08'),
(42, 9, 'Medicamento', 'Solucion Hartman 1000ml (frasco 1000ml)', 1.000, 45.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:18'),
(43, 9, 'Medicamento', 'Ampidelt (Vial)', 4.000, 100.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:19'),
(44, 9, 'Medicamento', 'Venoset (Greetmed)', 2.000, 15.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:19'),
(45, 9, 'Medicamento', 'Diclofenaco (Ampolla 3ml)', 2.000, 50.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:19'),
(46, 9, 'Medicamento', 'Metilprednisolona (frasco inyectable)', 1.000, 100.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:20'),
(47, 9, 'Medicamento', 'Mascarillas para nebulizar (M) (Pediatrico)', 1.000, 50.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:20'),
(48, 9, 'Medicamento', 'Angiocath #24 (Insumo)', 1.000, 15.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:20'),
(49, 9, 'Medicamento', 'Jeringas de 10ml (Insumo)', 4.000, 5.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:20'),
(50, 9, 'Medicamento', 'Jeringas de 3ml (Insumo)', 1.000, 5.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:21'),
(51, 9, 'Medicamento', 'Disolflem 200mg (10 Sobres Granulados)', 1.000, 105.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:21'),
(52, 9, 'Medicamento', 'Tracefusin 20ml (fraco/inyectable)', 1.000, 150.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:21'),
(53, 9, 'Medicamento', 'Solucion Salino 100ml (Frasco de 100ml)', 1.000, 25.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:22'),
(54, 9, 'Medicamento', 'sello heparina', 1.000, 15.00, '2026-01-31 09:26:18', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:26:22'),
(55, 9, 'Procedimiento', 'Nebulizacion', 4.000, 50.00, '2026-01-31 09:32:01', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 15:32:02'),
(56, 9, 'Otro', 'alimentacion', 3.000, 25.00, '2026-01-31 12:37:14', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-01-31 18:37:14'),
(57, 10, 'Habitación', 'Habitación 301 - Cama 1 (Día de ingreso)', 1.000, 950.00, '2026-01-24 22:00:00', '2026-01-24', 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:43:18'),
(58, 10, 'Medicamento', 'Jeringas de 10ml (Insumo)', 4.000, 5.00, '2026-02-04 07:45:01', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:45:02'),
(59, 10, 'Medicamento', 'Venoset (Greetmed)', 1.000, 15.00, '2026-02-04 07:48:09', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:48:10'),
(60, 10, 'Medicamento', 'Angiocath #24 (Insumo)', 2.000, 15.00, '2026-02-04 07:48:09', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:48:10'),
(61, 10, 'Medicamento', 'Angiocath #20 (Insumo)', 1.000, 15.00, '2026-02-04 07:48:09', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:48:10'),
(62, 10, 'Medicamento', 'Solucion Hartman 1000ml (frasco 1000ml)', 2.000, 45.00, '2026-02-04 07:51:11', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:51:12'),
(63, 10, 'Medicamento', 'Omeprazol 40mg (Vial Polvo)', 1.000, 100.00, '2026-02-04 07:51:11', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:51:12'),
(64, 10, 'Medicamento', 'Selestina (Ampolla 2ml)', 1.000, 50.00, '2026-02-04 07:51:11', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:51:12'),
(65, 10, 'Medicamento', 'Clevium (Ampolla)', 2.000, 50.00, '2026-02-04 07:51:11', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:51:13'),
(66, 10, 'Medicamento', 'Parenten (Ampolla 2ml)', 1.000, 100.00, '2026-02-04 07:53:59', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:53:59'),
(67, 10, 'Medicamento', 'Suero Hidravida (suero oral)', 1.000, 18.00, '2026-02-04 07:53:59', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:54:00'),
(68, 10, 'Medicamento', 'Isocraneol 500mg (30 Comprimidos)', 1.000, 500.00, '2026-02-04 07:53:59', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:54:00'),
(69, 10, 'Medicamento', 'Jeringas de 3ml (Insumo)', 1.000, 5.00, '2026-02-04 07:53:59', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:54:01'),
(70, 10, 'Medicamento', 'Selestina (Ampolla 2ml)', 1.000, 50.00, '2026-02-04 07:56:09', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 13:56:10'),
(71, 10, 'Otro', 'dietas', 2.000, 35.00, '2026-02-04 08:03:26', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 14:03:26'),
(72, 10, 'Procedimiento', 'EKG', 1.000, 200.00, '2026-02-04 08:03:26', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 14:03:27'),
(73, 10, 'Laboratorio', 'hemato,creatinina,bun,colesterol,trigliceridos,sodio,potasio,tp,tpt,acido urico', 1.000, 860.00, '2026-02-04 08:03:26', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-04 14:03:27'),
(74, 11, 'Habitación', 'Habitación 301 - Cama 1 (Día de ingreso)', 1.000, 950.00, '2026-02-08 10:00:00', '2026-02-08', 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 15:39:17'),
(75, 11, 'Medicamento', 'Angiocath #20 (Insumo)', 1.000, 15.00, '2026-02-09 10:34:23', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 16:34:23'),
(76, 11, 'Medicamento', 'Angiocath #24 (Insumo)', 1.000, 15.00, '2026-02-09 10:34:23', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 16:34:24'),
(77, 11, 'Medicamento', 'Ulcrux Individuales (sobres)', 6.000, 10.00, '2026-02-09 10:34:23', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 16:34:24'),
(78, 11, 'Medicamento', 'Lidocaina sin epinefrina (centimetros)', 3.000, 10.00, '2026-02-09 10:34:23', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 16:34:24'),
(79, 11, 'Medicamento', 'Omeprazol 40mg (Vial Polvo)', 4.000, 100.00, '2026-02-09 10:34:23', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 16:34:25'),
(80, 11, 'Medicamento', 'Clevium (Ampolla)', 1.000, 50.00, '2026-02-09 10:34:23', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 16:34:25'),
(81, 11, 'Medicamento', 'Diclofenaco (Ampolla 3ml)', 1.000, 50.00, '2026-02-09 10:34:23', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 16:34:25'),
(82, 11, 'Medicamento', 'Jeringas de 10ml (Insumo)', 2.000, 5.00, '2026-02-09 10:34:23', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 16:34:25'),
(83, 11, 'Otro', 'Dietas', 6.000, 26.00, '2026-02-09 10:36:43', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 16:36:43'),
(84, 11, 'Laboratorio', 'hematologia,orina', 1.000, 180.00, '2026-02-09 10:36:43', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 16:36:43'),
(85, 11, 'Medicamento', 'Venoset (Greetmed)', 1.000, 15.00, '2026-02-09 10:44:41', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 16:44:41'),
(86, 11, 'Medicamento', 'Solucion Salina 500ml (Frasco 500ml)', 2.000, 35.00, '2026-02-09 10:44:41', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 16:44:41'),
(87, 11, 'Medicamento', 'Uroprin 3g (Fosfomicina 3g)', 1.000, 165.00, '2026-02-09 12:35:20', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-09 18:35:20'),
(88, 12, 'Habitación', 'Habitación 201 - Cama 1 (Día de ingreso)', 1.000, 600.00, '2026-02-11 07:35:00', '2026-02-11', 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-11 13:54:06'),
(89, 12, 'Medicamento', 'Solucion Hartman 1000ml (frasco 1000ml)', 2.000, 25.00, '2026-02-11 08:20:05', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-11 14:20:06'),
(90, 12, 'Insumo', 'Venoset (Greetmed)', 1.000, 15.00, '2026-02-11 08:20:05', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-11 14:20:06'),
(91, 12, 'Insumo', 'Angiocath #22 (Insumo)', 1.000, 15.00, '2026-02-11 08:20:05', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-11 14:20:06'),
(92, 12, 'Medicamento', 'Omeprazol 40mg (Vial Polvo)', 1.000, 50.00, '2026-02-11 08:20:05', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-11 14:20:06'),
(93, 12, 'Medicamento', 'Parenten (Ampolla 2ml)', 1.000, 40.00, '2026-02-11 08:20:05', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-11 14:20:07'),
(94, 12, 'Medicamento', 'Jeringas de 10ml (Insumo)', 1.000, 3.00, '2026-02-11 08:20:05', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-11 14:20:07'),
(95, 12, 'Medicamento', 'Sello Heparina (Insumo)', 1.000, 15.00, '2026-02-11 08:20:05', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-11 14:20:07'),
(96, 12, 'Medicamento', 'Tetravit forte 25000 (Ampolla)', 1.000, 20.00, '2026-02-11 08:20:05', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-11 14:20:08'),
(97, 12, 'Otro', 'dietas', 2.000, 25.00, '2026-02-11 08:20:05', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '2026-02-11 14:20:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_pruebas`
--

CREATE TABLE `catalogo_pruebas` (
  `id_prueba` int NOT NULL,
  `codigo_prueba` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_prueba` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abreviatura` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `muestra_requerida` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Ej: Sangre Total (EDTA)',
  `metodo_toma` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Instrucciones de toma de muestra',
  `precio` decimal(10,2) NOT NULL DEFAULT '0.00',
  `tiempo_procesamiento_horas` int DEFAULT '24',
  `requiere_ayuno` tinyint(1) DEFAULT '0',
  `horas_ayuno` int DEFAULT NULL,
  `estado` enum('Activo','Inactivo','Descontinuado') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Activo',
  `categoria` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Ej: Hematología, Química, Hormonas',
  `notas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `catalogo_pruebas`
--

INSERT INTO `catalogo_pruebas` (`id_prueba`, `codigo_prueba`, `nombre_prueba`, `abreviatura`, `muestra_requerida`, `metodo_toma`, `precio`, `tiempo_procesamiento_horas`, `requiere_ayuno`, `horas_ayuno`, `estado`, `categoria`, `notas`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 'LAB-001', 'Ac. Anticisticercos', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(2, 'LAB-002', 'Ac. Antifosfolípidos IgM o IgG c/u', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(3, 'LAB-003', 'Ac. Antitiroideos c/u', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(4, 'LAB-004', 'Ac. Citrulinados', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(5, 'LAB-005', 'Ac. Salmonella', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(6, 'LAB-006', 'AC. Sífilis', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(7, 'LAB-007', 'Acido láctico', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(8, 'LAB-008', 'Acido úrico', NULL, NULL, NULL, 50.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(9, 'LAB-009', 'Acido Valproico', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(10, 'LAB-010', 'Acido vanilmandélico', NULL, NULL, NULL, 300.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(11, 'LAB-011', 'ACTH-Adrenocorticotropica', NULL, NULL, NULL, 250.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(12, 'LAB-012', 'Adenovirus en heces', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(13, 'LAB-013', 'ADN Proviral VIH 1', NULL, NULL, NULL, 800.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(14, 'LAB-014', 'Aglutininas Frias', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(15, 'LAB-015', 'Albúmina', NULL, NULL, NULL, 50.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(16, 'LAB-016', 'Alcohelemia', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(17, 'LAB-017', 'Aldolasa', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(18, 'LAB-018', 'Alfa-feto Proteinas (AFP)', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(19, 'LAB-019', 'Amilasa', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(20, 'LAB-020', 'Amonio', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(21, 'LAB-021', 'Análisis de Cálculos', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(22, 'LAB-022', 'Analisis de liquidos anmiotico, pleural o cefalorraquideo', NULL, NULL, NULL, 300.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(23, 'LAB-023', 'ANCA', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(24, 'LAB-024', 'Anti- Mitocondriales', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(25, 'LAB-025', 'Anticoagulante lúpico', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(26, 'LAB-026', 'Anticuerpos de covid 19', NULL, NULL, NULL, 400.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(27, 'LAB-027', 'Anti-DNA', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(28, 'LAB-028', 'Antiestreptolisina O (ASO)', NULL, NULL, NULL, 75.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(29, 'LAB-029', 'Antígeno CA 15-3', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(30, 'LAB-030', 'Antígeno CA 19-9', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(31, 'LAB-031', 'Antígeno CA125', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(32, 'LAB-032', 'Antigeno Carcioembrionario (CEA)', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(33, 'LAB-033', 'Antígeno de Covid 19', NULL, NULL, NULL, 400.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(34, 'LAB-034', 'Antígeno H. pylori en heces', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(35, 'LAB-035', 'Antigeno Prostatico Esp/PSA Libre', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(36, 'LAB-036', 'Antígeno Prostático Específico (PSA TOTAL)', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(37, 'LAB-037', 'Antígento CA 27-28', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(38, 'LAB-038', 'Anticuerpos Anti-Smith', NULL, NULL, NULL, 300.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(39, 'LAB-039', 'Anti-Tiroglobulina', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(40, 'LAB-040', 'Azul de metileno', NULL, NULL, NULL, 75.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(41, 'LAB-041', 'Bilirrubina Directa', NULL, NULL, NULL, 50.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(42, 'LAB-042', 'Bilirrubina Indirecta', NULL, NULL, NULL, 50.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(43, 'LAB-043', 'Bilirrubina Total', NULL, NULL, NULL, 50.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(44, 'LAB-044', 'BK de esputo', NULL, NULL, NULL, 100.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(45, 'LAB-045', 'BK en orina', NULL, NULL, NULL, 100.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(46, 'LAB-046', 'Calcio (Ca)', NULL, NULL, NULL, 130.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(47, 'LAB-047', 'Calcio en orina de 24 horas', NULL, NULL, NULL, 130.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(48, 'LAB-048', 'Calcitonina', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(49, 'LAB-049', 'Calprotectina', NULL, NULL, NULL, 250.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(50, 'LAB-050', 'Carbamazepina', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(51, 'LAB-051', 'Cariotipo en Sangre periferica', NULL, NULL, NULL, 1100.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(52, 'LAB-052', 'Células L. E.', NULL, NULL, NULL, 100.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(53, 'LAB-053', 'Chlamydia Trachomatis IgM o IgG c/u', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(54, 'LAB-054', 'Citoquímico de Orina', NULL, NULL, NULL, 40.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(55, 'LAB-055', 'Citología de moco fecal', NULL, NULL, NULL, 60.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(56, 'LAB-056', 'CK-MB', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(57, 'LAB-057', 'CK-Total (CPK)', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 21:41:46'),
(58, 'LAB-058', 'Cloro (Cl)', NULL, NULL, NULL, 130.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(59, 'LAB-059', 'Cloro en orina de 24 horas', NULL, NULL, NULL, 130.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(60, 'LAB-060', 'Colesterol HDL (Bueno)', NULL, NULL, NULL, 50.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(61, 'LAB-061', 'Colesterol LDL (Malo)', NULL, NULL, NULL, 50.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(62, 'LAB-062', 'Colesterol Total', NULL, NULL, NULL, 50.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(63, 'LAB-063', 'Colinesterasa', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(64, 'LAB-064', 'Complemento C3', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(65, 'LAB-065', 'Complemento C4', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(66, 'LAB-066', 'Coombs Directo', NULL, '', NULL, 150.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 21:42:17'),
(67, 'LAB-067', 'Coombs Indirecto', NULL, '', NULL, 150.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 21:42:32'),
(68, 'LAB-068', 'Coprológico', NULL, NULL, NULL, 40.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(69, 'LAB-069', 'Coprocultivo', NULL, '', NULL, 150.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 21:43:03'),
(70, 'LAB-070', 'Cortisol AM', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(71, 'LAB-071', 'Cortisol PM', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(72, 'LAB-072', 'Cortisol en orina 24 hrs', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(73, 'LAB-073', 'Creatinina', NULL, '', NULL, 75.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:07:36'),
(74, 'LAB-074', 'Creatinina en orina de 24 horas', NULL, '', NULL, 75.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:08:21'),
(75, 'LAB-075', 'Creatinina, depuración', NULL, '', NULL, 75.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:09:16'),
(76, 'LAB-076', 'Cuantificación de Proteínas 24 h', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(77, 'LAB-077', 'Cultivo de secreciones varias c/u', NULL, '', NULL, 150.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:09:56'),
(78, 'LAB-078', 'Cultivo de Garganta (Faringeo)', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(79, 'LAB-079', 'Cultivo de Hongos', NULL, '', NULL, 250.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:10:23'),
(80, 'LAB-080', 'Cultivo de punta de catéter', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(81, 'LAB-081', 'Curva de tolerancia a la glucosa 2h', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(82, 'LAB-082', 'Curva de tolerancia a la glucosa 3h', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(83, 'LAB-083', 'Curva de tolerancia a la glucosa 4h', NULL, NULL, NULL, 275.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(84, 'LAB-084', 'Curva de tolerancia a la glucosa 5h', NULL, NULL, NULL, 325.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(85, 'LAB-085', 'D-Dimero', NULL, '', NULL, 225.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:12:09'),
(86, 'LAB-086', 'Dengue IgG e IgM NS1', NULL, '', NULL, 225.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:11:20'),
(87, 'LAB-087', 'Dengue NS1 (Antigeno)', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(88, 'LAB-088', 'Dehidroepiandrosterona (DHEA-S)', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(89, 'LAB-089', 'Digoxina', NULL, '', NULL, 250.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:11:42'),
(90, 'LAB-090', 'Electrolitos (Na, k, Cl)', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(91, 'LAB-091', 'Electroforesis de Hemoglobina', NULL, NULL, NULL, 350.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(92, 'LAB-092', 'Electroforesis de Proteínas', NULL, NULL, NULL, 300.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(93, 'LAB-093', 'Eritrosedimentación (VSG)', NULL, NULL, NULL, 40.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(94, 'LAB-094', 'Escrutinio de Anticuerpos', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(95, 'LAB-095', 'Espermograma', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(96, 'LAB-096', 'Estradiol (E2)', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(97, 'LAB-097', 'Estriol Libre (E3)', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(98, 'LAB-098', 'Examen completo de Orina', NULL, '', NULL, 30.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:15:08'),
(99, 'LAB-099', 'Factor Reumatoide (RA) Cuantitativo', NULL, NULL, NULL, 75.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(100, 'LAB-100', 'Factor V de Leyden', NULL, NULL, NULL, 950.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(101, 'LAB-101', 'Fenitoina (Epamin)', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(102, 'LAB-102', 'Fenobarbital', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(103, 'LAB-103', 'Ferritina', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(104, 'LAB-104', 'Fibrinógeno', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(105, 'LAB-105', 'Fosfatasa Alcalina', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:15:37'),
(106, 'LAB-106', 'Fosfatasa Ácida Total y Prostatica', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(107, 'LAB-107', 'Fósforo (P)', NULL, NULL, NULL, 130.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(108, 'LAB-108', 'Fósforo en orina de 24 horas', NULL, NULL, NULL, 130.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(109, 'LAB-109', 'Frotis de Sangre Periférica', NULL, '', NULL, 200.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:23:33'),
(110, 'LAB-110', 'FSH (H. Foliculo Estimulante)', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(111, 'LAB-111', 'FTA-ABS (Sífilis)', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(112, 'LAB-112', 'Gases Arteriales', NULL, NULL, NULL, 400.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(113, 'LAB-113', 'Gastrina', NULL, NULL, NULL, 250.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(114, 'LAB-114', 'Glicemia Pre (Glucosa)', NULL, '', NULL, 50.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:24:32'),
(115, 'LAB-115', 'Glicemia Post-Prandial (2h)', NULL, '', NULL, 50.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:24:47'),
(116, 'LAB-116', 'Glucosa 6 Fosfato Deshidrogenasa', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(117, 'LAB-117', 'Gonadotropina Corionica (HCG-B) Cuant.', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(118, 'LAB-118', 'Gota Gruesa', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:25:06'),
(119, 'LAB-119', 'Grupo Sanguíneo y Factor Rh', NULL, '', NULL, 75.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:26:46'),
(120, 'LAB-120', 'H. pylori (Anticuerpos IgM o IgG)', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:27:40'),
(121, 'LAB-121', 'H. pylori (Antigeno en heces)', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(122, 'LAB-122', 'Hematocrito y Hemoglobina', NULL, NULL, NULL, 50.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(123, 'LAB-123', 'Hematología Completa (22 parámetros)', NULL, '', NULL, 100.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 21:06:27'),
(124, 'LAB-124', 'Hemoglobina Glicosilada (HbA1c)', NULL, '', NULL, 200.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:29:27'),
(125, 'LAB-125', 'Hemocultivo (Adultos o niños)', NULL, '', NULL, 275.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:28:38'),
(126, 'LAB-126', 'Hepatitis A (Anti-HAV) IgM o IgG', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-27 14:47:50'),
(127, 'LAB-127', 'Hepatitis A (Anti-HAV) Total', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:32:38'),
(128, 'LAB-128', 'Hepatitis B (HBsAg) Antígeno de sup.', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(129, 'LAB-129', 'Hepatitis B (Anti-HBs) Anticuerpos sup.', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:33:36'),
(130, 'LAB-130', 'Hepatitis B (Anti-HBc) IgM', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:32:52'),
(131, 'LAB-131', 'Hepatitis B (Anti-HBc) Total', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:33:09'),
(132, 'LAB-132', 'Hepatitis C (Anti-HCV)', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:33:51'),
(133, 'LAB-133', 'Herpes Simple I y II IgM o IgG c/u', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:34:25'),
(134, 'LAB-134', 'Hierro Sérico', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:35:09'),
(135, 'LAB-135', 'HIV 1 y 2 (Anticuerpos)', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:35:38'),
(136, 'LAB-136', 'HIV (Carga Viral)', NULL, NULL, NULL, 1500.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(137, 'LAB-137', 'Homocisteina', NULL, NULL, NULL, 250.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(138, 'LAB-138', 'Hormona de Crecimiento (HGH)', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(139, 'LAB-139', 'HTLV I y II', NULL, NULL, NULL, 350.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(140, 'LAB-140', 'Identificación de Hongos', NULL, NULL, NULL, 250.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(141, 'LAB-141', 'IgA Cuantitativa', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(142, 'LAB-142', 'IgE Total', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(143, 'LAB-143', 'IgG Cuantitativa', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(144, 'LAB-144', 'IgM Cuantitativa', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(145, 'LAB-145', 'Indice HOMA', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(146, 'LAB-146', 'Inhibina B', NULL, NULL, NULL, 650.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(147, 'LAB-147', 'Insulina Basal', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(148, 'LAB-148', 'Insulina Post-Prandial', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(149, 'LAB-149', 'Isospora Belli', NULL, NULL, NULL, 75.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(150, 'LAB-150', 'Lactato Deshidrogenasa (LDH)', NULL, NULL, NULL, 130.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(151, 'LAB-151', 'Leptospira IgG e IgM', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(152, 'LAB-152', 'LH (H. Luteinizante)', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(153, 'LAB-153', 'Lipasa', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(154, 'LAB-154', 'Lípidos Totales', NULL, '', NULL, 50.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:40:42'),
(155, 'LAB-155', 'Litio (Li)', NULL, '', NULL, 225.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:41:16'),
(156, 'LAB-156', 'Magnesio (Mg)', NULL, NULL, NULL, 130.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(157, 'LAB-157', 'Microalbuminuria', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(158, 'LAB-158', 'Microalbuminuria 24 h', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(159, 'LAB-159', 'Mononucleosis (Monotest)', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-20 20:02:52', '2026-01-26 22:42:09'),
(160, 'LAB-160', 'Oxiuros (Cinta adhesiva)', NULL, NULL, NULL, 60.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(161, 'LAB-161', 'Panel de Alergias (20 o mas)', NULL, NULL, NULL, 950.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(162, 'LAB-162', 'Panel de Drogas (3 drogas)', NULL, NULL, NULL, 250.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(163, 'LAB-163', 'Panel de Drogas (5 drogas)', NULL, NULL, NULL, 350.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(164, 'LAB-164', 'Panel Respiratorio (FilmArray)', NULL, NULL, NULL, 1800.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(165, 'LAB-165', 'Papanicolaou (Varios)', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(166, 'LAB-166', 'PTH (H. Paratiroidea)', NULL, NULL, NULL, 225.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(167, 'LAB-167', 'PCR (Carga Viral) Hepatitis B', NULL, NULL, NULL, 1600.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(168, 'LAB-168', 'PCR (Carga Viral) Hepatitis C', NULL, NULL, NULL, 1600.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(169, 'LAB-169', 'PCR (Carga Viral) VIH 1', NULL, NULL, NULL, 1100.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(170, 'LAB-170', 'PCR ULTRASENSIBLE', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(171, 'LAB-171', 'Potasio (k)', NULL, NULL, NULL, 130.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(172, 'LAB-172', 'PRO-BNP', NULL, NULL, NULL, 250.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(173, 'LAB-173', 'Procalcitonina', NULL, NULL, NULL, 250.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(174, 'LAB-174', 'Progesterona (P4)', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(175, 'LAB-175', 'Prolactina (PRL)', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(176, 'LAB-176', 'Proteína C Reactiva', NULL, NULL, NULL, 75.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(177, 'LAB-177', 'Proteínas en orina de 24 horas', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(178, 'LAB-178', 'Proteínas Totales', NULL, NULL, NULL, 40.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(179, 'LAB-179', 'Prueba de embarazo suero / orina', NULL, NULL, NULL, 75.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(180, 'LAB-180', 'Prueba de paternidad-ADN', NULL, NULL, NULL, 6500.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(181, 'LAB-181', 'PSA Libre', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(182, 'LAB-182', 'Recuento de Eosinófilos', NULL, NULL, NULL, 75.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(183, 'LAB-183', 'Recuento de Plaquetas', NULL, NULL, NULL, 75.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(184, 'LAB-184', 'Recuento de Reticulocitos', NULL, NULL, NULL, 75.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(185, 'LAB-185', 'Relación A/G', NULL, NULL, NULL, 60.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(186, 'LAB-186', 'Rotavirus', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(187, 'LAB-187', 'Rubeola IgG', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(188, 'LAB-188', 'Rubeola IgM', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(189, 'LAB-189', 'Sangre oculta Cuantificado', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(190, 'LAB-190', 'Sífilis (Anticuerpos)', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(191, 'LAB-191', 'Sodio (Na)', NULL, NULL, NULL, 130.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(192, 'LAB-192', 'T3', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(193, 'LAB-193', 'T4', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(194, 'LAB-194', 'T4 Libre', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(195, 'LAB-195', 'Testosterona', NULL, NULL, NULL, 175.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(196, 'LAB-196', 'Testosterona Libre', NULL, NULL, NULL, 200.00, 24, 0, NULL, 'Activo', 'General', NULL, '2026-01-20 20:02:52', '2026-01-20 20:02:52'),
(197, 'LAB-197', 'Carga viral VIH 1', NULL, '', NULL, 500.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-26 22:49:55', '2026-01-26 22:50:36'),
(198, 'LAB-198', 'Chagas ', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:10:40', '2026-01-27 14:10:40'),
(199, 'LAB-199', 'Chikungunya', NULL, '', NULL, 350.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:13:25', '2026-01-27 14:13:25'),
(200, 'LAB-200', 'Clasificación de anemia', NULL, '', NULL, 100.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:17:25', '2026-01-27 14:18:03'),
(201, 'LAB-201', 'Clinitest', NULL, '', NULL, 100.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:18:53', '2026-01-27 14:18:53'),
(202, 'LAB-202', 'CMV IgM o IgG', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:24:50', '2026-01-27 14:24:50'),
(203, 'LAB-203', 'Crioglobulinas', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:25:28', '2026-01-27 14:25:59'),
(204, 'LAB-204', 'Cultivo de orina', NULL, '', NULL, 150.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:26:46', '2026-01-27 14:26:46'),
(205, 'LAB-205', 'Depuración proteína', NULL, '', NULL, 75.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:27:26', '2026-01-27 14:27:26'),
(206, 'LAB-206', 'Deshidrogenasa láctica DHL', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:28:10', '2026-01-27 14:28:10'),
(207, 'LAB-207', 'Enema salino', NULL, '', NULL, 50.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:29:56', '2026-01-27 14:29:56'),
(208, 'LAB-208', 'Eosinófilos moco nasal', NULL, '', NULL, 100.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:30:27', '2026-01-27 14:30:27'),
(209, 'LAB-209', 'Epstein bar virus por Elisa', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:31:46', '2026-01-27 14:31:46'),
(210, 'LAB-210', 'Estrógenos', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:35:23', '2026-01-27 14:35:23'),
(211, 'LAB-211', 'Examen completo de heces', NULL, '', NULL, 30.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:36:06', '2026-01-27 14:36:06'),
(212, 'LAB-212', 'Gama Glutamil Transferasa GGT', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:37:28', '2026-01-27 14:37:28'),
(213, 'LAB-213', 'Globulina', NULL, '', NULL, 50.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:38:06', '2026-01-27 14:38:06'),
(214, 'LAB-214', 'Gram', NULL, '', NULL, 100.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:41:37', '2026-01-27 14:41:37'),
(215, 'LAB-215', 'HCG - Beta cuantificada', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:46:20', '2026-01-27 14:46:20'),
(216, 'LAB-216', 'Hisopado antígeno SARS COV 2', NULL, '', NULL, 400.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:52:55', '2026-01-27 14:52:55'),
(217, 'LAB-217', 'HIV Elisa', NULL, '', NULL, 225.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:53:43', '2026-01-27 14:53:43'),
(218, 'LAB-218', 'Hormona antidiurética ADH', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:54:36', '2026-01-27 14:54:36'),
(219, 'LAB-219', 'INR', NULL, '', NULL, 75.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:55:07', '2026-01-27 14:55:07'),
(220, 'LAB-220', 'Interleucina 6 (IL6)', NULL, '', NULL, 400.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 14:57:53', '2026-01-27 14:57:53'),
(221, 'LAB-221', 'Hidróxido de potasio KOH', NULL, '', NULL, 90.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:02:31', '2026-01-27 15:02:31'),
(222, 'LAB-222', 'Luteinizante LH', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:03:32', '2026-01-27 15:03:32'),
(223, 'LAB-223', 'Nitrógena de urea', NULL, '', NULL, 50.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:04:57', '2026-01-27 15:04:57'),
(224, 'LAB-224', 'Orina completa', NULL, '', NULL, 30.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:05:39', '2026-01-27 15:05:39'),
(225, 'LAB-225', 'Orocultivo (cultivo de garganta)', NULL, '', NULL, 150.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:08:13', '2026-01-27 15:08:13'),
(226, 'LAB-226', 'Panel de drogas en orina (10 parámetros)', NULL, '', NULL, 400.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:09:11', '2026-01-27 15:09:11'),
(227, 'LAB-227', 'Parathormona PTH', NULL, '', NULL, 225.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:09:45', '2026-01-27 15:09:45'),
(228, 'LAB-228', 'PCR de covid 19', NULL, '', NULL, 1100.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:41:38', '2026-01-27 15:41:38'),
(229, 'LAB-229', 'Tiempo de coagulación', NULL, '', NULL, 60.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:48:59', '2026-01-27 15:48:59'),
(230, 'LAB-230', 'Tiempo de protombina TP', NULL, '', NULL, 60.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:50:29', '2026-01-27 15:50:29'),
(231, 'LAB-231', 'Tiempo de sangría', NULL, '', NULL, 60.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:51:06', '2026-01-27 15:51:06'),
(232, 'LAB-232', 'Tiempo de tromboplastina parcial (TPT)', NULL, '', NULL, 60.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:52:00', '2026-01-27 15:52:00'),
(233, 'LAB-233', 'TORCH IgG o IgM c/u', NULL, '', NULL, 250.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:52:48', '2026-01-27 15:52:48'),
(234, 'LAB-234', 'Toxoplasma IgG', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:53:23', '2026-01-27 15:53:23'),
(235, 'LAB-235', 'Toxoplasma IgM', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:53:45', '2026-01-27 15:53:45'),
(236, 'LAB-236', 'Transaminasa Glutámica Oxalacetica (ASAT)', NULL, '', NULL, 40.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:55:10', '2026-01-27 15:55:10'),
(237, 'LAB-237', 'Transaminasa Glutámica Piruvica (ALAT)', NULL, '', NULL, 40.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:55:48', '2026-01-27 15:55:48'),
(238, 'LAB-238', 'Triglicéridos', NULL, '', NULL, 50.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:56:17', '2026-01-27 15:56:17'),
(239, 'LAB-239', 'Triponina I', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:57:33', '2026-01-27 15:57:33'),
(240, 'LAB-240', 'TSH-U', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:58:12', '2026-01-27 15:58:12'),
(241, 'LAB-241', 'TSH', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:58:40', '2026-01-27 15:58:40'),
(242, 'LAB-242', 'Urocultivo (cultivo de orina)', NULL, '', NULL, 150.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 15:59:30', '2026-01-27 15:59:30'),
(243, 'LAB-243', 'VDRL/RPR', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 16:00:15', '2026-01-27 16:00:15'),
(244, 'LAB-244', 'Velocidad de sedimentación', NULL, '', NULL, 30.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 16:01:02', '2026-01-27 16:01:02'),
(245, 'LAB-245', 'VIH', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 16:01:30', '2026-01-27 16:01:30'),
(246, 'LAB-246', 'Virus de Papiloma Humano VPH (PCR)', NULL, '', NULL, 1000.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 16:02:34', '2026-01-27 16:02:34'),
(247, 'LAB-247', 'Vitamina D', NULL, '', NULL, 250.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 16:03:06', '2026-01-27 16:03:06'),
(248, 'LAB-248', 'Widal', NULL, '', NULL, 150.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 16:03:31', '2026-01-27 16:03:31'),
(249, 'LAB-249', 'Ziehl-Neelsen', NULL, '', NULL, 0.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 16:04:15', '2026-01-27 16:04:15'),
(250, 'LAB-250', 'ZIKA', NULL, '', NULL, 350.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-27 16:04:48', '2026-01-27 16:04:48'),
(251, 'LAB-251', 'Troponina I-T', NULL, '', NULL, 175.00, 24, 0, NULL, 'Activo', 'General', '', '2026-01-30 21:12:59', '2026-01-30 21:12:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `id_cita` int NOT NULL,
  `nombre_pac` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `apellido_pac` varchar(50) NOT NULL,
  `num_cita` int NOT NULL,
  `fecha_cita` date NOT NULL,
  `hora_cita` time NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `historial_id` int DEFAULT NULL,
  `id_doctor` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id_cita`, `nombre_pac`, `apellido_pac`, `num_cita`, `fecha_cita`, `hora_cita`, `telefono`, `historial_id`, `id_doctor`) VALUES
(4, 'Maverick Andre', 'Carbajal Lopez', 1, '2025-03-17', '10:53:00', '30681047', NULL, 14),
(5, 'Ana Fabiola ', 'Ramirez', 2, '2026-01-19', '11:57:00', '58377829', NULL, 14),
(6, 'Gabriela María Magdalena', 'Mérida Escobedo de Escobedo', 3, '2026-01-19', '16:20:00', '57633906', NULL, 14),
(7, 'Claudia Ninet', 'Gutierrez Rivas', 4, '2026-01-19', '16:23:00', '47866499', NULL, 14),
(8, 'Ofelia Consuelo', 'Moreno Ordóñez de Morales', 5, '2026-01-20', '13:15:00', '30607328', NULL, 16),
(9, 'Luis Santiago', 'Lorenzo', 6, '2025-01-20', '13:00:00', '49415394', NULL, 14),
(10, 'Luis Santiago', 'Lorenzo', 7, '2026-01-20', '14:31:00', '49415394', NULL, 14),
(11, 'César', 'Velásquez', 8, '2026-01-20', '13:00:00', '45162634', NULL, 14),
(12, 'Mirna Esperanza', 'Gómez Galindo', 9, '2026-01-20', '16:00:00', '56220798', NULL, 20),
(13, 'Iván Omar', 'Montejo Jacinto', 10, '2026-01-20', '17:00:00', '33907163', NULL, 20),
(14, 'Gustavo Adolfo', 'Herrera Gómez', 11, '1982-02-15', '09:20:00', '35968951', NULL, 20),
(15, 'Luis Santiago', 'Lorenzo', 12, '2026-01-21', '08:30:00', '49415394', NULL, 20),
(16, 'Luis Santiago', 'Lorenzo', 13, '2026-01-21', '10:05:00', '49415394', NULL, 20),
(17, 'Gustavo Adolfo', 'Herrera Gómez', 14, '2026-01-21', '09:11:00', '35968951', NULL, 20),
(18, 'Keneth Vinicio', 'López López', 15, '2026-01-21', '09:50:00', '49504141', NULL, 14),
(19, 'Cindy Nohemí', 'Pascual', 16, '1990-09-22', '11:00:00', '43262798', NULL, 20),
(20, 'Cindy Nohemí', 'Pascual', 17, '1990-09-22', '11:15:00', '43262798', NULL, 20),
(21, 'Cindy Nohemí', 'Pascual', 18, '2026-01-21', '11:15:00', '43262798', NULL, 20),
(22, 'William', 'Agustín', 19, '2026-01-21', '11:10:00', '58191429', NULL, 20),
(23, 'Madelyn', 'Lucas', 20, '2026-01-21', '11:45:00', '43262798', NULL, 20),
(24, 'Marvin', 'Tobar', 21, '2026-01-21', '11:30:00', '59064380', NULL, 14),
(25, 'prueba', 'prueba', 22, '2026-01-22', '12:00:00', '12345', NULL, 20),
(26, 'Quenia Shiomara', 'Calderón Villatoro de Gómez', 23, '2026-01-21', '15:50:00', '44765950', NULL, 15),
(27, 'Isabel', 'Lucas Gómez', 24, '2026-01-22', '10:00:00', '50555878', NULL, 21),
(28, 'Melany Floribelly', 'López Suárez', 25, '2026-01-19', '10:00:00', '30681047', NULL, 15),
(29, 'Jennifer Nineth', 'Recinos Fuentes', 26, '2026-01-19', '10:45:00', '58389203', NULL, 15),
(30, 'Maria Cristina', 'Recinos Ramirez', 27, '2026-01-19', '11:20:00', '41601532', NULL, 15),
(31, 'Jafet', 'Tayún Chan', 28, '2026-01-19', '12:30:00', '', NULL, 19),
(32, 'Elvia', 'Argueta Tayún', 29, '2026-01-19', '12:30:00', '', NULL, 14),
(33, 'Maverick André', 'Carbajal López', 30, '2026-01-19', '12:50:00', '30681047', NULL, 14),
(34, 'Rosa Ana', 'Calderón Villatoro de Gómez', 31, '2026-01-19', '14:10:00', '54391553', NULL, 19),
(35, 'Cecilia Gabriela', 'Calderón Villatoro ', 32, '2026-01-19', '14:50:00', '54767583', NULL, 19),
(36, 'Ana Fabiola', 'Ramirez', 33, '2026-01-19', '15:25:00', '58377829', NULL, 19),
(37, 'Maritza Guadalupe', 'Gómez Galindo', 34, '2026-01-19', '15:50:00', '57016496', NULL, 19),
(38, 'Victoria', 'Ramos López', 35, '2026-01-20', '08:30:00', '45162634', NULL, 20),
(39, 'Leyser Damián', 'López López', 36, '2026-01-20', '09:15:00', '38484353', NULL, 20),
(40, 'Maria Luisa', 'Mendoza', 37, '2026-01-20', '09:45:00', '33607235', NULL, 20),
(41, 'Katherine Rocío', 'Félix Tecún', 38, '2026-01-20', '10:15:00', '37347766', NULL, 20),
(42, 'Santiago Gregorio', 'Matías Camposeco', 39, '2026-01-20', '10:45:00', '55251535', NULL, 20),
(43, 'Morthen ', 'Argueta Morales', 40, '2026-01-20', '17:35:00', '', NULL, 20),
(44, 'Juana Irene', 'González Granados', 41, '2026-01-24', '10:00:00', '45787222', NULL, 18),
(45, 'Sydney Betzaida', 'López González', 42, '2026-01-24', '10:45:00', '48836192', NULL, 18),
(46, 'José Luis', 'Reyes Martínez', 43, '2026-01-22', '10:45:00', '39053395', NULL, 21),
(47, 'Maria Isabel', 'Herrera Navas', 44, '2026-01-22', '10:15:00', '41958112', NULL, 14),
(48, 'Rosa Ofelia', 'Castillo Cubillas', 45, '2026-01-23', '11:30:00', '59986187', NULL, 14),
(49, 'Javier Luis', 'Pérez', 46, '2026-01-22', '13:29:00', '53419095', NULL, 14),
(50, 'Rosa Florinda', 'Matías Camposeco', 47, '2026-01-22', '14:45:00', '59900577', NULL, 14),
(51, 'Zoila', 'Cruz Recinos de López', 48, '2026-01-22', '14:45:00', '30712747', NULL, 21),
(52, 'Tecla Eufemia', 'López Cruz de Palacios', 49, '2026-01-22', '14:45:00', '30712747', NULL, 21),
(53, 'Nuvia Ofelia', 'Santos Ramos', 50, '2026-01-22', '15:00:00', '47804106', NULL, 14),
(54, 'Marlen Asucena', 'Cifuentes Chávez', 51, '2026-01-22', '15:35:00', '58808878', NULL, 21),
(55, 'Nuvia Ofelia', 'Santos Ramos', 52, '2026-01-24', '09:00:00', '47804106', NULL, 14),
(56, 'Rosa Florinda ', 'Matías Camposeco de Hernández', 53, '2026-01-22', '14:45:00', '59900577', NULL, 21),
(57, 'Icelda', 'Herrera Tayún', 54, '2026-01-23', '08:25:00', '44570273', NULL, 20),
(58, 'María', 'Recinos López', 55, '2026-01-23', '09:45:00', '57298544', NULL, 20),
(59, 'Shirley Analí', 'Saucedo', 56, '2026-01-23', '10:20:00', '32681284', NULL, 20),
(60, 'Ángela', 'Vásquez Cadona de Vásquez', 57, '2026-01-23', '10:45:00', '45314759', NULL, 14),
(61, 'Enriqueta Hermelinda', 'Vásquez Vásquez', 58, '2026-01-23', '11:00:00', '57446481', NULL, 14),
(62, 'Edwin Deymar', 'Pérez Vásquez', 59, '2026-01-23', '11:00:00', '57446481', NULL, 14),
(63, 'Bernandina', 'Carrillo', 60, '2026-01-23', '11:15:00', '40686706', NULL, 14),
(64, 'Ángela', 'Vásquez Cadona de Vásquez', 61, '2026-02-07', '09:00:00', '45314759', NULL, 14),
(65, 'Elvia', 'Tayún Chan', 62, '2026-01-23', '14:00:00', '59941701', NULL, 14),
(66, 'Jafet', 'Argueta Tayún', 63, '2026-01-23', '09:20:00', '59941701', NULL, 20),
(67, 'Ángela', 'Vásquez Cardona de Vásquez', 64, '2026-01-23', '10:45:00', '45314759', NULL, 14),
(68, 'Antony Francisco', 'Carrillo Ramírez', 65, '2026-01-23', '12:45:00', '32090595', NULL, 20),
(69, 'Sara Eulalia', 'Ramos Cobox', 66, '2026-01-23', '12:35:00', '57225439', NULL, 20),
(70, 'Boran Alejandro', 'Carrilo Ramos', 67, '2026-01-23', '12:35:00', '57225439', NULL, 20),
(71, 'Glendy Maricruz', 'Carrillo Ramos', 68, '2026-01-23', '12:35:00', '57225439', NULL, 20),
(72, 'Boran Alejandro', 'Carrillo Ramos', 69, '2026-01-23', '12:35:00', '57225439', NULL, 20),
(73, 'Audel Alexander', 'Herrera', 70, '2026-01-23', '16:10:00', '56944948', NULL, 14),
(74, 'Martín', 'Villatoro Vásquez', 71, '2026-01-23', '16:00:00', '47903314', NULL, 14),
(75, 'Susana María', 'Juárez Pedro', 72, '2026-01-28', '10:30:00', '37127419', NULL, 19),
(76, 'Uriel Jacob', 'Leiva del Valle', 73, '2026-01-24', '09:45:00', '41081072', NULL, 14),
(77, 'Sydney Betzaida', 'López González', 74, '2026-01-28', '09:00:00', '48836192', NULL, 15),
(78, 'Olga Marina', 'Nájera Ruiz', 75, '2026-01-28', '14:00:00', '53348629', NULL, 22),
(79, 'Olga Marina', 'Nájera Ruiz', 76, '2026-01-26', '11:30:00', '53348629', NULL, 22),
(80, 'Javier Luis', 'Pérez', 77, '2026-02-09', '10:00:00', '53419095', NULL, 14),
(81, 'Wayner Isaác', 'López Gómez', 78, '2026-02-03', '03:00:00', '31823412', NULL, 14),
(82, 'Wayner Isaác', 'López Gómez', 79, '2026-01-26', '15:00:00', '31823412', NULL, 14),
(83, 'Estefany', 'Moreno', 80, '2026-01-28', '10:30:00', '49071998', NULL, 15),
(84, 'Nancy Paola', 'Lucas Sales', 81, '2026-01-28', '10:00:00', '32999802', NULL, 18),
(85, 'Matías Emanuel', 'Gutiérrez mendoza', 82, '2026-01-27', '10:15:00', '59612627', NULL, 14),
(86, 'Edem Osiel', 'Gómez Pérez', 83, '2026-01-27', '12:30:00', '47612763', NULL, 14),
(87, 'Yasmin', 'Alonzo Solís', 84, '2026-01-28', '09:25:00', '33073167', NULL, 21),
(88, 'Suleni María', 'Pu Rodriguez', 85, '2026-01-28', '09:45:00', '53357824', NULL, 21),
(89, 'Ana Yolanda', 'López', 86, '2026-01-28', '08:45:00', '47474920', NULL, 21),
(90, 'Karla Alexandra', 'Reyes Cano', 87, '2026-01-28', '10:15:00', '57369856', NULL, 16),
(91, 'Rebeca Elizabeth', 'Castillo Rojas', 88, '2026-01-29', '08:15:00', '48308122', NULL, 22),
(92, 'Doris Oralia', 'López Villatoro', 89, '2026-01-29', '09:15:00', '34563826', NULL, 22),
(93, 'Edward Otoniel', 'Hernández', 90, '2026-01-27', '06:00:00', '59674838', NULL, 14),
(94, 'Mariela Roxana', 'Esteban Gómez', 91, '2026-01-29', '10:00:00', '57476884', NULL, 22),
(95, 'Paulina', 'Gómez Domingo', 92, '2026-01-29', '13:15:00', '38823816', NULL, 22),
(96, 'Emma Beatriz', 'Gómez Vásquez', 93, '2026-01-29', '13:45:00', '49043931', NULL, 22),
(97, 'Emma Beatriz', 'López Vásquez', 94, '2026-01-29', '13:45:00', '49043931', NULL, 22),
(98, 'Joseph Miguel Ángel', 'Leiva Mazariegos ', 95, '2026-01-30', '14:30:00', '46437528', NULL, 14),
(99, 'Enrique Otoniel', 'López Maldonado', 96, '2026-01-30', '12:50:00', '53229674', NULL, 22),
(100, 'Miriam Olinda', 'Matías Martinez', 97, '2026-01-31', '09:25:00', '40280767', NULL, 14),
(101, 'Imelda', 'Gonzalez', 98, '2026-01-30', '15:30:00', '41933470', NULL, 14),
(102, 'Doris Aminta', 'Gamboa Gómez', 99, '2026-01-30', '16:45:00', '31884705', NULL, 14),
(103, 'Liam Alesandro', 'Reyes Barrios', 100, '2026-01-30', '18:00:00', '51232758', NULL, 14),
(104, 'Javier Anderson', 'Argueta Ixcoy', 101, '2026-02-02', '13:45:00', '53366067', NULL, 14),
(105, 'Rebeca Elizabeth', 'Castillo Rojas', 102, '2026-02-02', '14:40:00', '48308122', NULL, 22),
(106, 'Olga Marina', 'Agustín Zuñiga', 103, '2026-02-02', '15:30:00', ' 55295077', NULL, 13),
(107, 'William Francisco', 'Mendoza Escobar', 104, '2026-02-02', '16:50:00', '58088701', NULL, 13),
(108, 'Joseph Miguel Ángel', 'Leiva Mazariegos ', 105, '2026-02-04', '10:30:00', '46437528', NULL, 14),
(109, 'Ana Jose ', 'Rios', 106, '2026-02-04', '18:00:00', '52901775', NULL, 13),
(110, 'Imelda Judith ', 'López', 107, '2026-02-04', '16:45:00', '53255826', NULL, 13),
(111, 'Luis Rodrigo', 'Jacobs López', 108, '2026-02-04', '16:45:00', '53255826', NULL, 13),
(112, 'Esperanza Margarita', 'Palacios Rios', 109, '2026-02-04', '16:15:00', '56369504', NULL, 13),
(113, 'Maria Jose ', 'Herrera', 110, '2026-02-04', '18:14:00', '52901775', NULL, 13),
(114, 'Zulma Yecenia', 'Villatoro', 111, '2026-02-05', '15:00:00', '', NULL, 14),
(115, 'Fabiana', 'Pérez Felipe', 112, '2026-02-06', '18:00:00', ' 45278747', NULL, 13),
(116, 'Byron Roderico', 'Herrera Mérida', 113, '2026-02-05', '19:00:00', '45627045', NULL, 13),
(117, 'Irma Delma', 'Mendoza Rivas', 114, '2026-02-07', '10:30:00', '36757686', NULL, 14),
(118, 'Victor ', 'Mejia ', 115, '2026-02-07', '16:50:00', '55256683', NULL, 16),
(119, 'Stiven', 'Jesús Fúnes', 116, '2026-02-09', '11:30:00', ' 40754987', NULL, 14),
(120, 'Emilio Alessadro', 'Aguilar Rojas', 117, '2026-02-09', '13:15:00', '53737753', NULL, 14),
(121, 'Laura', 'Alvarado Villaseñor', 118, '2026-02-09', '15:30:00', '53491183', NULL, 13),
(122, 'Brandon Iván', 'Rivas Mauricio', 119, '2026-02-09', '17:00:00', '48741540', NULL, 13),
(123, 'Ismael', 'De León López', 120, '2026-02-09', '17:45:00', '55234919', NULL, 13),
(124, 'Rosa Florinda', 'Matías Camposeco', 121, '2026-02-10', '16:30:00', '59900577', NULL, 14),
(125, 'Rosa Florinda', 'Matías Camposeco de Hernández', 122, '2026-03-10', '15:00:00', ' 59900577', NULL, 14),
(126, 'Petra Micaela', 'Herrera', 123, '2026-02-10', '16:00:00', '32226051', NULL, 14),
(127, 'Dominick Daniel', ' Gómez Rivas', 124, '2026-02-10', '17:15:00', '30664361', NULL, 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobros`
--

CREATE TABLE `cobros` (
  `in_cobro` int NOT NULL,
  `paciente_cobro` int NOT NULL,
  `cantidad_consulta` int NOT NULL,
  `fecha_consulta` datetime NOT NULL,
  `id_doctor` int DEFAULT NULL,
  `tipo_consulta` enum('Consulta','Reconsulta') DEFAULT 'Consulta',
  `tipo_pago` enum('Efectivo','Tarjeta','Transferencia') DEFAULT 'Efectivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `cobros`
--

INSERT INTO `cobros` (`in_cobro`, `paciente_cobro`, `cantidad_consulta`, `fecha_consulta`, `id_doctor`, `tipo_consulta`, `tipo_pago`) VALUES
(1, 20, 250, '2026-01-20 00:00:00', 16, 'Consulta', 'Efectivo'),
(2, 24, 150, '2026-01-20 00:00:00', 20, 'Consulta', 'Efectivo'),
(3, 31, 200, '2026-01-23 00:00:00', 18, 'Consulta', 'Transferencia'),
(4, 65, 100, '2026-01-26 00:00:00', 22, 'Consulta', 'Efectivo'),
(5, 66, 250, '2026-01-26 00:00:00', 19, 'Consulta', 'Efectivo'),
(6, 68, 300, '2026-01-27 00:00:00', 15, 'Consulta', 'Efectivo'),
(7, 70, 100, '2026-01-27 00:00:00', 14, 'Consulta', 'Efectivo'),
(8, 72, 100, '2026-01-28 00:00:00', 21, 'Consulta', 'Efectivo'),
(9, 73, 100, '2026-01-28 00:00:00', 21, 'Consulta', 'Efectivo'),
(10, 69, 150, '2026-01-28 00:00:00', 18, 'Consulta', 'Efectivo'),
(11, 37, 300, '2026-01-28 00:00:00', 15, 'Consulta', 'Efectivo'),
(12, 74, 100, '2026-01-29 00:00:00', 21, 'Consulta', 'Efectivo'),
(13, 75, 250, '2026-01-29 00:00:00', 16, 'Consulta', 'Efectivo'),
(14, 76, 100, '2026-01-29 00:00:00', 22, 'Consulta', 'Efectivo'),
(15, 77, 100, '2026-01-29 00:00:00', 22, 'Consulta', 'Efectivo'),
(16, 79, 100, '2026-01-29 00:00:00', 22, 'Consulta', 'Efectivo'),
(17, 81, 100, '2026-01-30 00:00:00', 22, 'Consulta', 'Efectivo'),
(18, 80, 100, '2026-01-30 00:00:00', 22, 'Consulta', 'Efectivo'),
(19, 82, 100, '2026-01-30 00:00:00', 14, 'Consulta', 'Efectivo'),
(20, 85, 100, '2026-01-31 00:00:00', 14, 'Consulta', 'Efectivo'),
(21, 92, 250, '2026-02-02 00:00:00', 13, 'Consulta', 'Efectivo'),
(22, 93, 250, '2026-02-02 00:00:00', 13, 'Consulta', 'Efectivo'),
(23, 67, 300, '2026-02-03 00:00:00', 14, 'Consulta', 'Efectivo'),
(24, 95, 250, '2026-02-04 00:00:00', 13, 'Consulta', 'Efectivo'),
(25, 96, 250, '2026-02-04 00:00:00', 13, 'Consulta', 'Efectivo'),
(26, 97, 250, '2026-02-04 00:00:00', 13, 'Consulta', 'Efectivo'),
(27, 98, 250, '2026-02-04 00:00:00', 13, 'Consulta', 'Efectivo'),
(28, 99, 200, '2026-02-04 00:00:00', 13, 'Reconsulta', 'Efectivo'),
(29, 102, 250, '2026-02-06 00:00:00', 13, 'Consulta', 'Efectivo'),
(30, 106, 300, '2026-02-07 00:00:00', 16, 'Consulta', 'Efectivo'),
(31, 112, 250, '2026-02-09 00:00:00', 13, 'Consulta', 'Efectivo'),
(32, 114, 250, '2026-02-09 00:00:00', 13, 'Consulta', 'Efectivo'),
(33, 115, 250, '2026-02-09 00:00:00', 13, 'Consulta', 'Efectivo'),
(34, 116, 250, '2026-02-09 00:00:00', 13, 'Consulta', 'Tarjeta'),
(35, 118, 150, '2026-02-10 00:00:00', 14, 'Consulta', 'Efectivo'),
(36, 119, 150, '2026-02-10 00:00:00', 14, 'Consulta', 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control_calidad_lab`
--

CREATE TABLE `control_calidad_lab` (
  `id_control` int NOT NULL,
  `id_prueba` int NOT NULL,
  `fecha_control` date NOT NULL,
  `lote_control` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valor_esperado` decimal(12,4) DEFAULT NULL,
  `valor_obtenido` decimal(12,4) DEFAULT NULL,
  `diferencia` decimal(12,4) GENERATED ALWAYS AS (abs((`valor_obtenido` - `valor_esperado`))) STORED,
  `dentro_rango` tinyint(1) DEFAULT NULL,
  `desviacion_estandar` decimal(12,4) DEFAULT NULL,
  `coeficiente_variacion` decimal(12,4) DEFAULT NULL,
  `accion_correctiva` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `realizado_por` int DEFAULT NULL,
  `aprobado_por` int DEFAULT NULL,
  `estado` enum('Aprobado','Rechazado','Requiere_Acción') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Aprobado',
  `notas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta_hospitalaria`
--

CREATE TABLE `cuenta_hospitalaria` (
  `id_cuenta` int NOT NULL,
  `id_encamamiento` int NOT NULL,
  `subtotal_habitacion` decimal(10,2) DEFAULT '0.00',
  `subtotal_medicamentos` decimal(10,2) DEFAULT '0.00',
  `subtotal_procedimientos` decimal(10,2) DEFAULT '0.00',
  `subtotal_laboratorios` decimal(10,2) DEFAULT '0.00',
  `subtotal_honorarios` decimal(10,2) DEFAULT '0.00',
  `subtotal_otros` decimal(10,2) DEFAULT '0.00',
  `descuento` decimal(10,2) DEFAULT '0.00',
  `total_general` decimal(10,2) GENERATED ALWAYS AS (((((((`subtotal_habitacion` + `subtotal_medicamentos`) + `subtotal_procedimientos`) + `subtotal_laboratorios`) + `subtotal_honorarios`) + `subtotal_otros`) - `descuento`)) STORED,
  `estado_pago` enum('Pendiente','Parcialmente_Pagado','Pagado','Condonado') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pendiente',
  `monto_pagado` decimal(10,2) DEFAULT '0.00',
  `saldo_pendiente` decimal(10,2) GENERATED ALWAYS AS ((((((((`subtotal_habitacion` + `subtotal_medicamentos`) + `subtotal_procedimientos`) + `subtotal_laboratorios`) + `subtotal_honorarios`) + `subtotal_otros`) - `descuento`) - `monto_pagado`)) STORED,
  `metodo_pago` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Efectivo, Tarjeta, Transferencia, Mixto',
  `notas_pago` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `total_pagado` decimal(10,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cuenta_hospitalaria`
--

INSERT INTO `cuenta_hospitalaria` (`id_cuenta`, `id_encamamiento`, `subtotal_habitacion`, `subtotal_medicamentos`, `subtotal_procedimientos`, `subtotal_laboratorios`, `subtotal_honorarios`, `subtotal_otros`, `descuento`, `estado_pago`, `monto_pagado`, `metodo_pago`, `notas_pago`, `fecha_creacion`, `fecha_actualizacion`, `total_pagado`) VALUES
(9, 9, 950.00, 1060.00, 200.00, 0.00, 0.00, 75.00, 0.00, 'Pendiente', 2285.00, NULL, NULL, '2026-01-31 14:53:07', '2026-01-31 19:16:53', 2285.00),
(10, 10, 950.00, 1093.00, 200.00, 860.00, 0.00, 70.00, 0.00, 'Pendiente', 3173.00, NULL, NULL, '2026-02-04 13:43:18', '2026-02-04 14:18:13', 3173.00),
(11, 11, 950.00, 880.00, 0.00, 180.00, 0.00, 156.00, 0.00, 'Pendiente', 2166.00, NULL, NULL, '2026-02-09 15:39:17', '2026-02-09 18:36:08', 2166.00),
(12, 12, 600.00, 178.00, 0.00, 0.00, 0.00, 80.00, 0.00, 'Pendiente', 0.00, NULL, NULL, '2026-02-11 13:54:06', '2026-02-11 14:20:12', 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `id_detalle` int NOT NULL,
  `id_venta` int DEFAULT NULL,
  `id_inventario` int DEFAULT NULL,
  `cantidad_vendida` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS ((`cantidad_vendida` * `precio_unitario`)) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`id_detalle`, `id_venta`, `id_inventario`, `cantidad_vendida`, `precio_unitario`) VALUES
(1, 1, 43, 1, 300.00),
(2, 1, 62, 1, 255.00),
(3, 2, 314, 1, 18.00),
(4, 3, 69, 1, 250.00),
(5, 4, 115, 1, 55.00),
(6, 5, 151, 1, 100.00),
(7, 6, 20, 1, 145.00),
(8, 7, 314, 1, 18.00),
(9, 8, 27, 1, 250.00),
(10, 9, 4, 1, 140.00),
(11, 10, 101, 1, 235.00),
(12, 10, 381, 1, 105.00),
(13, 11, 27, 1, 250.00),
(14, 11, 69, 2, 250.00),
(15, 11, 23, 1, 425.00),
(16, 11, 98, 2, 90.00),
(17, 12, 106, 1, 30.00),
(18, 13, 206, 1, 150.00),
(19, 13, 352, 1, 65.00),
(20, 14, 156, 1, 110.00),
(21, 14, 118, 1, 45.00),
(22, 15, 156, 1, 110.00),
(23, 15, 381, 1, 105.00),
(24, 15, 18, 1, 380.00),
(25, 16, 20, 1, 145.00),
(26, 16, 156, 1, 110.00),
(27, 17, 312, 1, 55.00),
(28, 17, 206, 1, 150.00),
(29, 17, 36, 2, 165.00),
(30, 18, 334, 1, 125.00),
(31, 18, 174, 1, 50.00),
(32, 19, 72, 1, 325.00),
(33, 19, 199, 1, 130.00),
(34, 19, 156, 1, 110.00),
(35, 19, 35, 1, 105.00),
(36, 20, 352, 1, 65.00),
(37, 21, 312, 1, 55.00),
(38, 22, 155, 1, 590.00),
(39, 23, 69, 1, 250.00),
(40, 23, 36, 1, 165.00),
(41, 23, 382, 4, 75.00),
(42, 24, 44, 9, 22.00),
(43, 24, 72, 1, 325.00),
(44, 24, 73, 1, 105.00),
(45, 25, 36, 2, 165.00),
(46, 25, 336, 1, 800.00),
(47, 25, 88, 1, 510.00),
(48, 26, 21, 2, 185.00),
(49, 26, 222, 2, 135.00),
(50, 27, 89, 1, 420.00),
(51, 27, 366, 1, 110.00),
(52, 27, 47, 1, 222.00),
(53, 27, 101, 1, 235.00),
(54, 27, 320, 1, 95.00),
(55, 28, 112, 1, 75.00),
(56, 28, 176, 1, 220.00),
(57, 28, 182, 1, 55.00),
(58, 28, 243, 1, 18.00),
(59, 29, 279, 1, 50.00),
(60, 29, 266, 2, 50.00),
(61, 29, 271, 2, 50.00),
(62, 29, 220, 2, 80.00),
(63, 29, 223, 2, 50.00),
(64, 29, 265, 1, 50.00),
(65, 29, 60, 5, 35.00),
(66, 29, 267, 1, 50.00),
(67, 30, 271, 2, 50.00),
(68, 31, 171, 1, 240.00),
(69, 31, 89, 1, 420.00),
(70, 31, 222, 1, 135.00),
(71, 31, 169, 1, 75.00),
(72, 32, 243, 1, 18.00),
(73, 33, 150, 1, 140.00),
(74, 33, 100, 1, 160.00),
(75, 33, 22, 1, 135.00),
(76, 34, 222, 1, 135.00),
(77, 34, 388, 1, 145.00),
(78, 34, 389, 1, 200.00),
(79, 34, 188, 1, 125.00),
(80, 34, 186, 1, 450.00),
(81, 35, 111, 1, 125.00),
(82, 35, 244, 1, 100.00),
(83, 35, 157, 1, 420.00),
(84, 35, 357, 1, 200.00),
(85, 36, 173, 1, 210.00),
(86, 37, 112, 1, 75.00),
(87, 37, 111, 1, 125.00),
(88, 37, 392, 2, 110.00),
(89, 37, 244, 1, 100.00),
(90, 37, 29, 1, 390.00),
(91, 38, 244, 4, 100.00),
(92, 39, 244, 2, 100.00),
(93, 40, 4, 1, 270.00),
(94, 40, 393, 1, 150.00),
(95, 40, 276, 1, 50.00),
(96, 41, 265, 1, 50.00),
(97, 41, 271, 1, 50.00),
(98, 42, 150, 1, 140.00),
(99, 42, 392, 1, 110.00),
(100, 43, 259, 4, 15.00),
(101, 44, 267, 1, 50.00),
(102, 44, 397, 1, 50.00),
(103, 45, 128, 2, 0.00),
(104, 45, 133, 2, 0.00),
(105, 45, 42, 2, 0.00),
(106, 45, 354, 2, 0.00),
(107, 46, 99, 1, 245.00),
(108, 46, 163, 1, 290.00),
(109, 47, 243, 1, 18.00),
(110, 48, 354, 2, 0.00),
(111, 48, 391, 1, 0.00),
(112, 48, 240, 40, 0.00),
(113, 48, 141, 1, 0.00),
(114, 48, 169, 1, 0.00),
(115, 48, 80, 2, 0.00),
(116, 48, 186, 1, 0.00),
(117, 48, 35, 1, 0.00),
(118, 48, 72, 1, 0.00),
(119, 48, 29, 1, 0.00),
(120, 48, 62, 1, 0.00),
(121, 48, 243, 4, 0.00),
(122, 49, 243, 1, 18.00),
(123, 50, 23, 1, 425.00),
(124, 50, 219, 1, 135.00),
(125, 50, 214, 3, 50.00),
(126, 51, 305, 1, 0.00),
(127, 51, 436, 1, 0.00),
(128, 51, 435, 1, 0.00),
(129, 51, 301, 1, 0.00),
(130, 51, 259, 2, 0.00),
(131, 51, 433, 1, 0.00),
(132, 52, 214, 1, 50.00),
(133, 53, 106, 1, 30.00),
(134, 54, 434, 1, 210.00),
(135, 54, 85, 1, 120.00),
(136, 55, 306, 2, 30.00),
(137, 55, 301, 1, 10.00),
(138, 55, 258, 2, 15.00),
(139, 55, 435, 1, 5.00),
(140, 55, 287, 1, 15.00),
(141, 56, 330, 1, 93.07),
(142, 56, 261, 1, 36.80),
(143, 56, 315, 1, 90.93),
(144, 56, 372, 1, 128.95),
(145, 57, 117, 1, 80.00),
(146, 58, 209, 1, 225.60),
(147, 59, 439, 2, 100.00),
(148, 60, 209, 1, 350.00),
(149, 61, 9, 1, 630.00),
(150, 61, 324, 2, 155.00),
(151, 61, 154, 1, 65.00),
(152, 62, 383, 1, 150.00),
(153, 63, 266, 1, 50.00),
(154, 63, 223, 1, 50.00),
(155, 64, 243, 1, 18.00),
(156, 65, 83, 1, 60.00),
(157, 66, 340, 2, 35.00),
(158, 67, 171, 1, 240.00),
(159, 68, 452, 1, 590.00),
(160, 69, 451, 1, 230.00),
(161, 70, 399, 5, 130.00),
(162, 70, 27, 1, 250.00),
(163, 70, 128, 1, 90.00),
(164, 70, 324, 1, 155.00),
(165, 70, 452, 1, 590.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `electrocardiogramas`
--

CREATE TABLE `electrocardiogramas` (
  `id_electro` int NOT NULL,
  `id_paciente` int NOT NULL,
  `id_doctor` int DEFAULT NULL,
  `fecha_realizado` datetime DEFAULT CURRENT_TIMESTAMP,
  `observaciones` text,
  `precio` decimal(10,2) NOT NULL DEFAULT '0.00',
  `estado_pago` enum('Pendiente','Pagado') DEFAULT 'Pendiente',
  `tipo_pago` varchar(50) DEFAULT 'Efectivo',
  `realizado_por` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encamamientos`
--

CREATE TABLE `encamamientos` (
  `id_encamamiento` int NOT NULL,
  `id_paciente` int NOT NULL,
  `id_cama` int NOT NULL,
  `id_doctor` int DEFAULT NULL,
  `fecha_ingreso` datetime NOT NULL,
  `fecha_alta` datetime DEFAULT NULL,
  `motivo_ingreso` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `diagnostico_ingreso` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diagnostico_egreso` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('Activo','Alta_Medica','Alta_Administrativa','Transferido','Fallecido') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Activo',
  `tipo_ingreso` enum('Programado','Emergencia','Referido') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Programado',
  `notas_ingreso` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `notas_alta` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_by` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `encamamientos`
--

INSERT INTO `encamamientos` (`id_encamamiento`, `id_paciente`, `id_cama`, `id_doctor`, `fecha_ingreso`, `fecha_alta`, `motivo_ingreso`, `diagnostico_ingreso`, `diagnostico_egreso`, `estado`, `tipo_ingreso`, `notas_ingreso`, `notas_alta`, `created_by`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(9, 11, 6, 12, '2026-01-29 08:38:00', '2026-01-30 17:00:00', 'NAC Bacteriano', 'Nac Bacteriano', NULL, 'Alta_Administrativa', 'Referido', '[MÉDICO REFERENTE: Dra. Jannya] [RETRASADO] ', NULL, 12, '2026-01-31 14:53:07', '2026-01-31 14:53:07'),
(10, 63, 6, 14, '2026-01-24 22:00:00', '2026-01-25 17:00:00', 'Paralisis de Bell', 'HTA', NULL, 'Alta_Administrativa', 'Emergencia', '[RETRASADO] ', NULL, 12, '2026-02-04 13:43:18', '2026-02-04 13:43:18'),
(11, 109, 6, 22, '2026-02-08 10:00:00', '2026-02-09 09:34:00', 'vomitos, fiebre', 'Epigastralgia', NULL, 'Alta_Administrativa', 'Emergencia', '[RETRASADO] ', NULL, 12, '2026-02-09 15:39:16', '2026-02-09 15:39:16'),
(12, 102, 4, 14, '2026-02-11 07:35:00', NULL, 'Faringoamigdalitis', 'Faringoamigdalitis', NULL, 'Activo', 'Emergencia', '', NULL, 12, '2026-02-11 13:54:05', '2026-02-11 13:54:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evoluciones_medicas`
--

CREATE TABLE `evoluciones_medicas` (
  `id_evolucion` int NOT NULL,
  `id_encamamiento` int NOT NULL,
  `fecha_evolucion` datetime NOT NULL,
  `id_doctor` int NOT NULL,
  `subjetivo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'SOAP: Subjetivo',
  `objetivo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'SOAP: Objetivo',
  `evaluacion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'SOAP: Evaluación/Assessment',
  `plan_tratamiento` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'SOAP: Plan',
  `notas_adicionales` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examenes_realizados`
--

CREATE TABLE `examenes_realizados` (
  `id_examen_realizado` int NOT NULL,
  `id_paciente` int NOT NULL,
  `nombre_paciente` varchar(255) NOT NULL,
  `tipo_examen` varchar(535) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Nombre del examen (ej. Electrocardiograma, Ultrasonido)',
  `cobro` decimal(10,2) NOT NULL,
  `fecha_examen` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(255) DEFAULT NULL,
  `tipo_pago` enum('Efectivo','Tarjeta','Transferencia') DEFAULT 'Efectivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `examenes_realizados`
--

INSERT INTO `examenes_realizados` (`id_examen_realizado`, `id_paciente`, `nombre_paciente`, `tipo_examen`, `cobro`, `fecha_examen`, `usuario`, `tipo_pago`) VALUES
(1, 71, 'Edem Osiel Gómez Pérez', 'Cobro Laboratorio Orden #Orden #LAB-20260127-001 - Edem Osiel Gómez Pérez (2026-01-27 15:05:04)', 580.00, '2026-01-28 15:00:52', 'Anye', 'Efectivo'),
(2, 50, 'Edwin Deymar Pérez Vásquez', 'Cobro Laboratorio Orden #Orden #LAB-20260127-002 - Edwin Deymar Pérez Vásquez (2026-01-27 16:50:06)', 60.00, '2026-01-28 15:02:02', 'Anye', 'Efectivo'),
(3, 54, 'Ángela Vásquez Cardona de Vásquez', 'Servicios Laboratorio Order #LAB-20260130-001: Examen completo de heces, Examen completo de Orina, Hematología Completa (22 parámetros)', 160.00, '2026-01-30 19:50:51', NULL, 'Efectivo'),
(4, 74, 'Ana Yolanda López', 'Servicios Laboratorio Order #LAB-20260130-002: Hematología Completa (22 parámetros), Tiempo de protombina TP, Tiempo de tromboplastina parcial (TPT)', 220.00, '2026-01-30 19:55:23', NULL, 'Efectivo'),
(5, 40, 'Rosa Florinda Matías Camposeco de Hernández', 'Servicios Laboratorio Order #LAB-20260130-001: D-Dimero, PRO-BNP, Troponina I-T', 650.00, '2026-01-30 21:14:23', NULL, 'Tarjeta'),
(6, 74, 'Ana Yolanda López', 'Servicios Laboratorio Order #LAB-20260130-002: Colesterol Total, Triglicéridos', 100.00, '2026-01-30 21:15:39', NULL, 'Efectivo'),
(7, 83, 'Enrique Otoniel López Maldonado', 'Servicios Laboratorio Order #LAB-20260130-003: Hematología Completa (22 parámetros), Tiempo de protombina TP, Tiempo de tromboplastina parcial (TPT)', 220.00, '2026-01-30 21:17:22', NULL, 'Efectivo'),
(8, 82, 'Joseph Miguel Ángel Leiva Mazariegos ', 'Servicios Laboratorio Order #LAB-20260130-004: Antiestreptolisina O (ASO), Hematología Completa (22 parámetros), Proteína C Reactiva', 250.00, '2026-01-30 21:20:29', NULL, 'Efectivo'),
(9, 85, 'Miriam Olinda Matías Martinez', 'Servicios Laboratorio Order #LAB-20260131-001: Hematología Completa (22 parámetros), Proteína C Reactiva', 175.00, '2026-01-31 16:20:34', NULL, 'Efectivo'),
(10, 37, 'Sydney Betzaida López González', 'Servicios Laboratorio Order #LAB-20260131-002: Colesterol HDL (Bueno), Colesterol LDL (Malo), Colesterol Total, Glicemia Pre (Glucosa), Grupo Sanguíneo y Factor Rh, Triglicéridos', 325.00, '2026-01-31 16:32:13', NULL, 'Tarjeta'),
(11, 93, 'William Francisco Mendoza Escobar', 'Servicios Laboratorio Order #LAB-20260203-001: Antigeno Prostatico Esp/PSA Libre, Hematología Completa (22 parámetros)', 275.00, '2026-02-03 15:22:20', NULL, 'Efectivo'),
(12, 93, 'William Francisco Mendoza Escobar', 'Servicios Laboratorio Order #LAB-20260205-001: Examen completo de Orina', 30.00, '2026-02-05 14:52:09', NULL, 'Efectivo'),
(13, 101, 'Vayron Roderico Herrera Mérida', 'Servicios Laboratorio Order #LAB-20260205-002: Creatinina, Hemoglobina Glicosilada (HbA1c), Nitrógena de urea', 325.00, '2026-02-06 02:34:16', NULL, 'Efectivo'),
(14, 104, 'Eleana Escobedo Ahilón', 'Servicios Laboratorio Order #LAB-20260207-001: T4 Libre, TSH', 350.00, '2026-02-07 17:39:43', NULL, 'Efectivo'),
(15, 105, 'Ander Jared Aguilar Andrés', 'Servicios Laboratorio Order #LAB-20260207-002: Examen completo de heces, Hematología Completa (22 parámetros), Orina completa', 160.00, '2026-02-07 19:55:04', NULL, 'Efectivo'),
(16, 66, 'Ana Cristina Domingo Jiménez', 'Servicios Laboratorio Order #LAB-20260207-003: Ac. Anticisticercos, Ac. Antitiroideos c/u, Ac. Salmonella', 625.00, '2026-02-07 20:46:21', NULL, 'Efectivo'),
(17, 66, 'Ana Cristina Domingo Jiménez', 'Servicios Laboratorio Order #LAB-20260207-004: Ac. Anticisticercos, Ac. Antitiroideos c/u, Ac. Salmonella', 625.00, '2026-02-07 20:47:37', NULL, 'Efectivo'),
(18, 39, 'Javier Luis Pérez', 'Servicios Laboratorio Order #LAB-20260209-001: Antígeno H. pylori en heces', 175.00, '2026-02-09 16:34:14', NULL, 'Efectivo'),
(19, 110, 'Stiven Jesús Funes', 'Servicios Laboratorio Order #LAB-20260209-002: Ac. Salmonella, Examen completo de heces, Hematología Completa (22 parámetros)', 290.00, '2026-02-09 18:21:02', NULL, 'Efectivo'),
(20, 111, 'Emilio Alessandro Aguilar Rojas', 'Servicios Laboratorio Order #LAB-20260209-003: Antiestreptolisina O (ASO), Hematología Completa (22 parámetros)', 175.00, '2026-02-09 20:10:20', NULL, 'Efectivo'),
(21, 113, 'Santos Ángela Castillo Rivas', 'Servicios Laboratorio Order #LAB-20260209-004: Creatinina, Examen completo de heces, Examen completo de Orina, Nitrógena de urea', 185.00, '2026-02-09 22:06:24', NULL, 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitaciones`
--

CREATE TABLE `habitaciones` (
  `id_habitacion` int NOT NULL,
  `numero_habitacion` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_habitacion` enum('Individual','Compartida','UCI','Pediatría','Observación') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tarifa_por_noche` decimal(10,2) NOT NULL,
  `piso` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('Disponible','Ocupada','Mantenimiento','Reservada') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Disponible',
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `tiene_bano` tinyint(1) DEFAULT '1',
  `tiene_tv` tinyint(1) DEFAULT '0',
  `tiene_aire_acondicionado` tinyint(1) DEFAULT '0',
  `capacidad_maxima` int DEFAULT '1',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `habitaciones`
--

INSERT INTO `habitaciones` (`id_habitacion`, `numero_habitacion`, `tipo_habitacion`, `tarifa_por_noche`, `piso`, `estado`, `descripcion`, `tiene_bano`, `tiene_tv`, `tiene_aire_acondicionado`, `capacidad_maxima`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(2, 'Emerg 1', 'Observación', 0.00, '1', 'Disponible', NULL, 1, 0, 0, 1, '2026-01-18 17:09:59', '2026-01-18 17:09:59'),
(3, 'Emerg 2', 'Observación', 0.00, '1', 'Disponible', NULL, 1, 0, 0, 1, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(4, '201', 'Individual', 600.00, '2', 'Disponible', NULL, 1, 0, 0, 1, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(5, '202', 'Individual', 600.00, '2', 'Disponible', NULL, 1, 0, 0, 1, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(6, '301', 'Individual', 950.00, '3', 'Disponible', NULL, 1, 0, 0, 1, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(7, '401', 'Individual', 950.00, '4', 'Disponible', NULL, 1, 0, 0, 1, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(8, '402', 'Individual', 950.00, '4', 'Disponible', NULL, 1, 0, 0, 1, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(9, '403', 'Individual', 1100.00, '4', 'Disponible', NULL, 1, 0, 0, 1, '2026-01-18 17:10:00', '2026-01-18 17:10:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_clinico`
--

CREATE TABLE `historial_clinico` (
  `id_historial` int NOT NULL,
  `id_paciente` int NOT NULL,
  `fecha_consulta` datetime DEFAULT CURRENT_TIMESTAMP,
  `motivo_consulta` text NOT NULL,
  `sintomas` text NOT NULL,
  `diagnostico` text NOT NULL,
  `tratamiento` text NOT NULL,
  `receta_medica` text,
  `antecedentes_personales` text,
  `antecedentes_familiares` text,
  `examenes_realizados` text,
  `resultados_examenes` text,
  `observaciones` text,
  `proxima_cita` date DEFAULT NULL,
  `medico_responsable` varchar(100) NOT NULL,
  `especialidad_medico` varchar(100) DEFAULT NULL,
  `hora_proxima_cita` time DEFAULT NULL,
  `examen_fisico` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `historial_clinico`
--

INSERT INTO `historial_clinico` (`id_historial`, `id_paciente`, `fecha_consulta`, `motivo_consulta`, `sintomas`, `diagnostico`, `tratamiento`, `receta_medica`, `antecedentes_personales`, `antecedentes_familiares`, `examenes_realizados`, `resultados_examenes`, `observaciones`, `proxima_cita`, `medico_responsable`, `especialidad_medico`, `hora_proxima_cita`, `examen_fisico`) VALUES
(8, 63, '2026-01-29 10:46:57', 'Paralisis de bell', '', 'HTA HIPERTROFIA VENTRICULAR', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sistema', NULL, NULL, NULL),
(9, 11, '2026-01-30 14:24:39', 'FIEBRE', '', 'NEUMONIA', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sistema', NULL, NULL, NULL),
(10, 109, '2026-02-09 09:39:16', 'vomitos, fiebre', '', 'Epigastralgia', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sistema', NULL, NULL, NULL),
(11, 102, '2026-02-11 07:54:05', 'Faringoamigdalitis', '', 'Faringoamigdalitis', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sistema', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumos`
--

CREATE TABLE `insumos` (
  `id_insumo` int NOT NULL,
  `id_inventario` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `id_usuario` int NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `insumos`
--

INSERT INTO `insumos` (`id_insumo`, `id_inventario`, `cantidad`, `precio_venta`, `id_usuario`, `fecha`) VALUES
(2, 273, 1, 0.00, 12, '2026-02-04 14:31:28'),
(3, 305, 1, 45.00, 12, '2026-02-04 14:33:02'),
(4, 270, 1, 0.00, 12, '2026-02-04 14:34:25'),
(5, 258, 1, 15.00, 12, '2026-02-04 14:34:41'),
(6, 301, 1, 15.00, 12, '2026-02-04 14:35:00'),
(7, 305, 1, 45.00, 12, '2026-02-04 14:35:50'),
(8, 270, 1, 0.00, 12, '2026-02-04 14:36:32'),
(9, 259, 1, 15.00, 12, '2026-02-04 14:36:58'),
(10, 301, 1, 15.00, 12, '2026-02-04 14:38:06'),
(11, 305, 1, 45.00, 12, '2026-02-04 14:38:34'),
(12, 253, 1, 0.00, 12, '2026-02-04 14:39:08'),
(13, 253, 1, 0.00, 12, '2026-02-04 14:40:39'),
(14, 305, 1, 45.00, 12, '2026-02-04 14:43:17'),
(15, 301, 5, 15.00, 12, '2026-02-04 14:43:42'),
(16, 270, 8, 0.00, 12, '2026-02-04 14:46:05'),
(17, 253, 8, 0.00, 12, '2026-02-04 14:46:22'),
(18, 259, 8, 15.00, 12, '2026-02-04 14:48:03'),
(19, 256, 1, 15.00, 12, '2026-02-04 14:50:13'),
(20, 282, 2, 10.00, 12, '2026-02-04 14:50:34'),
(21, 298, 1, 0.00, 12, '2026-02-04 14:50:51'),
(22, 287, 1, 0.00, 12, '2026-02-04 14:51:55'),
(23, 306, 2, 0.00, 12, '2026-02-04 14:53:45'),
(24, 303, 1, 0.00, 12, '2026-02-04 14:54:08'),
(25, 306, 1, 30.00, 12, '2026-02-09 14:34:53'),
(26, 430, 1, 0.00, 12, '2026-02-09 14:35:17'),
(27, 256, 2, 15.00, 12, '2026-02-09 14:36:57'),
(28, 301, 1, 15.00, 12, '2026-02-09 14:37:44'),
(29, 301, 2, 15.00, 12, '2026-02-10 14:50:33'),
(30, 303, 3, 35.00, 12, '2026-02-10 14:50:57'),
(31, 256, 2, 15.00, 12, '2026-02-10 14:51:20'),
(32, 259, 1, 15.00, 12, '2026-02-10 14:51:48'),
(33, 423, 1, 0.00, 12, '2026-02-10 14:52:11'),
(34, 254, 1, 0.00, 12, '2026-02-10 14:52:32'),
(35, 423, 2, 0.00, 12, '2026-02-10 14:52:55'),
(36, 431, 3, 0.00, 12, '2026-02-10 14:53:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_inventario` int NOT NULL,
  `codigo_barras` varchar(100) DEFAULT NULL,
  `nom_medicamento` varchar(100) NOT NULL,
  `mol_medicamento` varchar(100) NOT NULL,
  `presentacion_med` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `casa_farmaceutica` varchar(100) NOT NULL,
  `cantidad_med` int NOT NULL,
  `fecha_adquisicion` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `estado` enum('Disponible','Pendiente') DEFAULT 'Disponible',
  `id_purchase_item` int DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT '0.00',
  `precio_compra` decimal(10,2) DEFAULT '0.00',
  `precio_hospital` decimal(10,2) DEFAULT '0.00',
  `precio_medico` decimal(10,2) DEFAULT '0.00',
  `stock_hospital` int NOT NULL DEFAULT '0',
  `precio_noche` decimal(10,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_inventario`, `codigo_barras`, `nom_medicamento`, `mol_medicamento`, `presentacion_med`, `casa_farmaceutica`, `cantidad_med`, `fecha_adquisicion`, `fecha_vencimiento`, `estado`, `id_purchase_item`, `precio_venta`, `precio_compra`, `precio_hospital`, `precio_medico`, `stock_hospital`) VALUES
(1, '7401094001530', 'Antigrip', 'Eucolapto-Guayacol', '1 Ampolla', 'Servimedic', 10, '2026-01-16', '2026-10-01', 'Disponible', 1, 35.00, 0.00, 0.00, 0.00, 0),
(2, '7401094605493', 'Ibuvanz 120ml', 'Ibuprofeno100mg/5ml', 'Suspension oral', 'Servimedic', 5, '2026-01-16', '2029-08-01', 'Disponible', 2, 62.00, 25.29, 0.00, 0.00, 0),
(3, '7401094602171', 'Fungiter crema tópica 20g', 'Terbinafina 1g', 'Crema tópica', 'Servimedic', 5, '2026-01-16', '2027-11-01', 'Disponible', 3, 140.00, 0.00, 0.00, 0.00, 0),
(4, '7401094612255', 'D3-FENDER', 'Vitamina D3100,000UI', '1 Cápsula', 'Servimedic', 3, '2026-01-16', '2028-10-01', 'Disponible', 4, 270.00, 109.45, 0.00, 0.00, 0),
(5, '7401094610572', 'Bisocard 5mg', 'Bisoprolol famarato 5mg', '30 Tabletas recubiertas', 'Servimedic', 5, '2026-01-16', '2028-08-01', 'Disponible', 5, 270.00, 0.00, 0.00, 0.00, 0),
(6, '7401094610862', 'Olmepress HCT 40/12.5mg', 'Olmesartan Medoxomil40mg+Hidroclorotiazida 12.5mg', '30 Tabletas recubiertas', 'Servimedic', 5, '2026-01-16', '2027-09-01', 'Disponible', 6, 350.00, 0.00, 0.00, 0.00, 0),
(7, '7460536521098', 'Gacimex 200ml', 'Magaldrato 800mg/Simeticona 60mg/10ml', 'Suspensión oral', 'Servimedic', 5, '2026-01-16', '2027-04-01', 'Disponible', 7, 155.00, 0.00, 0.00, 0.00, 0),
(8, '7401094610367', 'Triacid 100mg/300mg', 'Pinaverium 100mg+Simethicone 300mg', '30 cápsulas', 'Servimedic', 5, '2026-01-16', '2028-09-01', 'Disponible', 9, 230.00, 0.00, 0.00, 0.00, 0),
(9, '7401018117231', 'Metiom H. pylori', 'esomeprazol 40mg-levofloxamina 500mg-amoxicilina 500mg', 'Cápsulas, 10 días', 'Servimedic', 3, '2026-01-16', '2027-03-01', 'Disponible', 11, 630.00, 0.00, 0.00, 0.00, 0),
(10, '7401094612309', 'Vertiless 16mg', 'Betahistina- diclorhidrato 16mg', '30 Tableta', 'Servimedic', 5, '2026-01-16', '2027-08-01', 'Disponible', 12, 180.00, 0.00, 0.00, 0.00, 0),
(11, '7401094604533', 'Lyverium 1mg', 'Alprazolam 1mg', '30 Tabletas', 'Servimedic', 5, '2026-01-16', '2029-07-01', 'Disponible', 13, 255.00, 0.00, 0.00, 0.00, 0),
(12, '7401094604519', 'Lyverium 0.5mg', 'Alprazolam 0.5mg', '30 Tabletas', 'Servimedic', 6, '2026-01-16', '2029-08-01', 'Disponible', 14, 150.00, 0.00, 0.00, 0.00, 0),
(13, '7401094602249', 'Equiliv 10ml', 'clonazepam 2.5/ml', 'Gotero Oral', 'Servimedic', 7, '2026-01-16', '2027-08-01', 'Disponible', 15, 115.00, 0.00, 0.00, 0.00, 0),
(14, '7401018110218', 'Atenua 25mg', 'dexketoprofeno 25mg', '10 Comprimidos', 'Servimedic', 7, '2026-01-16', '2028-01-01', 'Disponible', 16, 140.00, 0.00, 0.00, 0.00, 0),
(15, '7401094609835', 'Sitalev Met 50/500mg', 'sitaglipina 50mg +metformina 500mg', '30 Tabletas', 'Servimedic', 5, '2026-01-16', '2028-07-01', 'Disponible', 17, 220.00, 0.00, 0.00, 0.00, 0),
(16, '7401095800651', 'Inuric-G 80mg', 'Febuxostat 80mg', '30 Tableta', 'Servimedic', 5, '2026-01-16', '2027-10-01', 'Disponible', 18, 320.00, 0.00, 0.00, 0.00, 0),
(17, '7401095800194', 'Gabin 400mg', 'Gabapentina 400mg', '30 Tabletas', 'Servimedic', 5, '2026-01-16', '2026-11-01', 'Disponible', 19, 250.00, 0.00, 0.00, 0.00, 0),
(18, '7401018130162', 'Atrolip Plus 10mg+10mg', 'atorvastatina 10mg + ezetimibe 10 mg', '30 Comprimidos', 'Servimedic', 4, '2026-01-16', '2027-03-01', 'Disponible', 20, 380.00, 0.00, 0.00, 0.00, 0),
(19, '', 'Glutamax C', 'Glutathione + vit C', '5 Viales', 'Servimedic', 3, '2026-01-16', '2028-09-01', 'Disponible', 21, 200.00, 0.00, 0.00, 0.00, 0),
(20, '7441031500948', 'Rupagán 120ml', 'Rupatadina 1mg/ml.', 'Suspensión oral', 'Servimedic', 3, '2026-01-16', '2027-03-01', 'Disponible', 22, 145.00, 0.00, 0.00, 0.00, 0),
(21, '7441041703162', 'Biotos Inmune 170ml.', 'Hedera helix & Pelargonium sidoides', 'Suspensión oral', 'Servimedic', 3, '2026-01-16', '2027-06-01', 'Disponible', 23, 185.00, 0.00, 0.00, 0.00, 0),
(22, '7891317103507', 'Biotos Inmune Pediátrico 120ml.', 'Hedera Helix & Pelargonium sidoides', 'Suspensión oral', 'Servimedic', 4, '2026-01-16', '2027-07-01', 'Disponible', 24, 135.00, 0.00, 0.00, 0.00, 0),
(23, '8429007059996', 'Omega 1000', 'Omega 3', '120 Cápsulas', 'Servimedic', 0, '2026-01-16', '2027-10-01', 'Disponible', 25, 425.00, 0.00, 0.00, 0.00, 0),
(24, '7861000226226', 'Aci-tip 800mg/40mg', 'Magaldrato 800mg - simeticona 40mg', '20 Comprimidos', 'Servimedic', 5, '2026-01-16', '2028-03-01', 'Disponible', 26, 120.00, 0.00, 0.00, 0.00, 0),
(25, '7441041701793', 'Neuralplus', 'Tiamina, piridoxina, cianocobalamina, diclofenaco', '10 Tableta', 'Servimedic', 4, '2026-01-16', '2027-11-01', 'Disponible', 27, 115.00, 0.00, 0.00, 0.00, 0),
(26, '7401094609804', 'Kardiopil HCT 300/12.5mg', 'Irbesartán 300mg + hidroclorotiazida 12.5 mg', '30 Tabletas recubiertas', 'Servimedic', 5, '2026-01-16', '2027-09-01', 'Disponible', 28, 250.00, 0.00, 0.00, 0.00, 0),
(27, '7401018117392', 'Milenium 40mg', 'esomeprazol 40mg', '30 Cápsula', 'Servimedic', 4, '2026-01-16', '2027-11-01', 'Disponible', 29, 250.00, 101.20, 0.00, 0.00, 0),
(28, '4031571081040', 'Man Active', 'extraxto de ginkgo, arginina', '60 Cápsula', 'Servimedic', 3, '2026-01-16', '2026-11-01', 'Disponible', 30, 220.00, 131.10, 0.00, 0.00, 0),
(29, '8429007062750', 'Inmuno biter', 'extracto glicerinado de jara+tomillo', '20 Ampolla bebible', 'Servimedic', 1, '2026-01-16', '2027-10-01', 'Disponible', 31, 390.00, 347.88, 0.00, 0.00, 0),
(30, '7401094601402', 'Spacek 40mg', 'Bromuro de otilonio 40mg', '30 Tabletas', 'Servimedic', 5, '2026-01-16', '2028-07-01', 'Disponible', 32, 170.00, 0.00, 0.00, 0.00, 0),
(31, '7401094609941', 'Spirocard 100mg', 'spironolactone 100mg', '30 Tabletas', 'Servimedic', 6, '2026-01-16', '2028-02-01', 'Disponible', 33, 260.00, 0.00, 0.00, 0.00, 0),
(32, '7401094609774', 'Kardiopil Amlo 300/5mg', 'Irbesartan 300mg + Amlodipine 5mg', '30 Tabletas recubiertas', 'Servimedic', 5, '2026-01-16', '2027-05-01', 'Disponible', 34, 410.00, 0.00, 0.00, 0.00, 0),
(33, '7401094602720', 'Gabex', 'Gabapentin 300mg', '30 Cápsulas', 'Servimedic', 5, '2026-01-16', '2030-07-01', 'Disponible', 35, 200.00, 0.00, 0.00, 0.00, 0),
(34, '7460840418046', 'Biobronq 120ml', 'Hedera Helix 35mg/5ml', 'Suspensión oral', 'Servimedic', 5, '2026-01-16', '2027-09-01', 'Disponible', 36, 80.00, 0.00, 0.00, 0.00, 0),
(35, '7441041700536', 'Disolflem 600mg', 'Acetilcisteína', '10 sticks granulado', 'Servimedic', 1, '2026-01-16', '2027-10-01', 'Disponible', 37, 135.00, 49.14, 0.00, 0.00, 0),
(36, '7460840419517', 'Uroprin 3g', 'Fosfomicina 3g', 'Sticks granulado', 'Servimedic', 0, '2026-01-16', '2028-04-01', 'Disponible', 38, 165.00, 145.36, 0.00, 0.00, 0),
(37, '7401094610121', 'Clevium 25mg/10ml', 'Desketoprofen (Trometamol) 25mg/10ml', '10 Sobres Bebible', 'Servimedic', 2, '2026-01-16', '2028-01-01', 'Disponible', 42, 140.00, 97.32, 0.00, 0.00, 0),
(38, '7401094604649', 'Clevium 30g', 'Dexketoprofeno 1.25%', 'Gel tópico', 'Servimedic', 1, '2026-01-16', '2029-08-01', 'Disponible', 39, 80.00, 0.00, 0.00, 0.00, 0),
(39, '8437024519539', 'Flavia Nocta', 'Melatonina, calcio', '30 Tabletas', 'Servimedic', 5, '2026-01-16', '2026-09-01', 'Disponible', 40, 250.00, 0.00, 0.00, 0.00, 0),
(40, '8470006977842', 'Demilos 600mg/1000 UI', 'carbonato de calcio colecalciferol, vitamina d3', '30 Comprimidos', 'Servimedic', 5, '2026-01-16', '2026-11-01', 'Disponible', 41, 215.00, 154.35, 0.00, 0.00, 0),
(41, '7401094604700', 'Zefalox 400mg', 'cefixime 400mg', '20 Cápsulas', 'Servimedic', 5, '2026-01-16', '2028-03-10', 'Disponible', 42, 650.00, 0.00, 0.00, 0.00, 0),
(42, '7401094600290', 'Zefalox 50ml.', 'Cefixima 100mg/5ml', 'Suspensión 50ml', 'Servimedic', 3, '2026-01-16', '2028-02-01', 'Disponible', 43, 205.00, 0.00, 0.00, 0.00, 0),
(43, '7401094604342', 'Zefalox 100ml.', 'Cefixima 100mg/5ml', 'Suspesión 100ml', 'Servimedic', 4, '2026-01-16', '2028-07-01', 'Disponible', 44, 300.00, 0.00, 0.00, 0.00, 0),
(44, '7441041703100', 'Conflexil Plus Shot 10ml/stick', 'tiocolchicosido 4mg-diclofenaco 50mh', 'Sticks bebible', 'Servimedic', 91, '2026-01-16', '2027-05-01', 'Disponible', 45, 22.00, 0.00, 0.00, 0.00, 0),
(45, '7401094613634', 'Rofemed 1g', 'ceftriaxona 1g', '1 Vial', 'Servimedic', 5, '2026-01-16', '2028-10-01', 'Disponible', 46, 120.00, 0.00, 0.00, 0.00, 0),
(46, '7401018117378', 'Milenium 20mg', 'esomeprazol 20mg', '30 Cápsulas', 'Servimedic', 7, '2026-01-16', '2026-11-01', 'Disponible', 47, 200.00, 0.00, 0.00, 0.00, 0),
(47, '854933102597', 'Gadavyt fibra liquida 480ml.', 'Fibra dietética jugo natural de ciruela', 'Suspensión oral', 'Servimedic', 1, '2026-01-16', '2027-06-01', 'Disponible', 48, 345.00, 0.00, 0.00, 0.00, 0),
(48, '7401094603253', 'Fungiter 40g', 'Terbinafina HCI 1%', 'Spray tópico', 'Servimedic', 6, '2026-01-16', '2027-07-01', 'Disponible', 49, 100.00, 52.57, 0.00, 0.00, 0),
(49, '7401094602188', 'Fungiter 250mg', 'Terbinafine 250 mg', '28 Tabletas', 'Servimedic', 5, '2026-01-16', '2028-08-01', 'Disponible', 50, 545.00, 0.00, 0.00, 0.00, 0),
(50, '7401094603291', 'Septidex 40g', 'Polimixina. neomicina 40g', 'Spray tópico', 'Servimedic', 7, '2026-01-16', '2027-08-01', 'Disponible', 51, 105.00, 0.00, 0.00, 0.00, 0),
(51, '7401094606179', 'Dinivanz Kit ', 'Salbutamol 5mg, salino, solución 9mg', 'Solución p/ nebulizar', 'Servimedic', 7, '2026-01-16', '2028-05-01', 'Disponible', 52, 130.00, 0.00, 0.00, 0.00, 0),
(52, '7401094600122', 'Hicet Pediatrico 10ml', 'Cetirizina diclorhidrato 10mg/ml', 'Gotas pediátricas', 'Servimedic', 5, '2026-01-16', '2029-06-01', 'Disponible', 53, 105.00, 0.00, 0.00, 0.00, 0),
(53, '7401094603703', 'Hicet 120ml', 'Cetirizina diclorhidrato 5mg/ml', 'Jarabe 120ml', 'Servimedic', 5, '2026-01-16', '2028-08-01', 'Disponible', 54, 140.00, 67.57, 0.00, 0.00, 0),
(54, '7401094600153', 'Hicet 60ml', 'Cetirizina diclorhidrato 5mg/5ml', 'Jarabe 60ml', 'Servimedic', 5, '2026-01-16', '2027-11-01', 'Disponible', 55, 90.00, 0.00, 0.00, 0.00, 0),
(55, '7401094609446', 'Hicet 10mg', 'Cetirizina diclorhidrato 10mg', '10 Cápsulas', 'Servimedic', 5, '2026-01-16', '2028-08-01', 'Disponible', 56, 90.00, 0.00, 0.00, 0.00, 0),
(56, '7401094606964', 'Rosecol 20mg', 'Rosuvastatina 20mg', '30 Tabletas recubiertas', 'Servimedic', 5, '2026-01-16', '2028-08-01', 'Disponible', 59, 235.00, 125.87, 0.00, 0.00, 0),
(57, '7401094605059', 'Gabex Plus', 'Gabapentina + vitamina B1 y B12', '30 Tabletas recubiertas', 'Servimedic', 6, '2026-01-16', '2028-08-01', 'Disponible', 57, 350.00, 0.00, 0.00, 0.00, 0),
(58, '7401094608500', 'Levent-Vit-E', 'vitamina E', '30 Cápsulas', 'Servimedic', 3, '2026-01-16', '2029-09-01', 'Disponible', 58, 280.00, 0.00, 0.00, 0.00, 0),
(59, '7401094610145', 'Prednicet 5mg', 'Prednisolona 5mg', '20 Tabletas', 'Servimedic', 6, '2026-01-16', '2027-07-01', 'Disponible', 60, 85.00, 0.00, 0.00, 0.00, 0),
(60, '7441041700116', 'Conflexil 4mg/2ml', 'Tiocolchicósido', 'Ampollas 4mg/2ml', 'Servimedic', 20, '2026-01-16', '2027-08-01', 'Disponible', 61, 35.00, 22.70, 22.70, 22.70, 0),
(61, '8429007050689', 'Viater Forte', 'ginseng, vitamina E, zinc', '20 Viales bebibles con 10ml', 'Servimedic', 1, '2026-01-16', '2026-10-01', 'Disponible', 62, 300.00, 237.94, 0.00, 0.00, 0),
(62, '\0996086\'', 'Symbio flor 1   /50ml', 'enterococcusfaecalis', 'Suspension oral', 'Servimedic', 0, '2026-01-16', '2026-12-01', 'Disponible', 64, 255.00, 204.70, 0.00, 0.00, 0),
(63, '7401094603529', 'Acla-med bid', 'amoxicilina 875mg, acido clavulanico 125mg', '14 tabletas recubiertas', 'Servimedic', 3, '2026-01-16', '2027-06-01', 'Disponible', 63, 215.00, 0.00, 0.00, 0.00, 0),
(64, '7401095800965', 'Klevraxr 500mg', 'levetiracetam 500mg', '30 tabletas', 'Servimedic', 3, '2026-01-16', '2027-03-01', 'Disponible', 65, 170.00, 0.00, 0.00, 0.00, 0),
(65, '7798016922432', 'Suganon 5mg', 'Evogliptina 5mg', '30 Comprimidos', 'Servimedic', 5, '2026-01-16', '2027-04-01', 'Disponible', 66, 505.00, 0.00, 0.00, 0.00, 0),
(66, '7401094609712', 'Zukermin Met 50/1000mg', 'vildagliptina 50ml+metformina 1000mg', '30 Tabletas', 'Servimedic', 5, '2026-01-16', '2028-08-01', 'Disponible', 67, 300.00, 0.00, 0.00, 0.00, 0),
(67, '7401004606466', 'Tusivanz compuesto 30ml', 'dextromethorphan+carboxymethylcysteine', 'gotas pediatricas', 'Servimedic', 5, '2026-01-16', '2028-03-01', 'Disponible', 68, 105.00, 0.00, 0.00, 0.00, 0),
(68, '7401094610732', 'Budoxigen 20g.', 'Budesonida 50mcg/100mcl', 'spray 200 aplicaciones', 'Servimedic', 6, '2026-01-16', '2027-10-01', 'Disponible', 69, 190.00, 0.00, 0.00, 0.00, 0),
(69, '7795337862997', 'Total Magnesiano', 'cloruro de magnesio 4.5H2O 1.5g + fluoruro de magnesio 0.0015g', '30 Sobres efervecentes', 'Servimedic', 0, '2026-01-16', '2028-01-01', 'Disponible', 70, 250.00, 0.00, 0.00, 0.00, 0),
(70, '7401094606155', 'Acla-med 600 /100ml', 'Amoxicilina 600mg+Acido clavulanico 42.9mg', 'Suspensión oral (30 sobres)', 'Servimedic', 6, '2026-01-16', '2027-05-01', 'Disponible', 71, 175.00, 0.00, 0.00, 0.00, 0),
(71, '7401095801030', 'Avsar Plus 320/10/25mg', 'valsartan 320mg+amlodipina 10mg+hidroclorotiazida 25mg', '28 Tabletas', 'Servimedic', 3, '2026-01-16', '2026-09-01', 'Disponible', 72, 520.00, 0.00, 0.00, 0.00, 0),
(72, '7401078930504', 'Deflarin 30mg.', 'desflazacort 30mg', '10 comprimidos', 'Servimedic', 0, '2026-01-16', '2027-04-01', 'Disponible', 73, 325.00, 0.00, 0.00, 0.00, 0),
(73, '7441041700468', 'Disolflem 200mg', 'Acetilcisteina 200mg', '10 Sobres Granulados', 'Servimedic', 1, '2026-01-16', '2027-08-01', 'Disponible', 74, 105.00, 49.14, 0.00, 0.00, 1),
(74, '8429007062002', 'Megamol D3', 'vitamina D3', '100 capsulas', 'Servimedic', 5, '2026-01-16', '2027-10-01', 'Disponible', 75, 250.00, 118.34, 0.00, 0.00, 0),
(75, '7401094607329', 'Diabilev 500mg.', 'Metformina HCI 500mg', '30 Tabletas', 'Servimedic', 4, '2026-01-16', '2026-11-01', 'Disponible', 76, 90.00, 0.00, 0.00, 0.00, 0),
(76, '4031571073847', 'Immun Active', 'Zinc, selenio', '20 Sobres', 'Servimedic', 5, '2026-01-16', '2027-02-01', 'Disponible', 77, 195.00, 136.42, 0.00, 0.00, 0),
(77, '8429007062149', 'Melatina 30ml', 'Melatonina 10.53mg', 'Gotero oral', 'Servimedic', 6, '2026-01-16', '2027-05-01', 'Disponible', 78, 160.00, 0.00, 0.00, 0.00, 0),
(78, '', 'Bru-sone 2ml.', 'betametasona dipropionato 5mg+fosfato sodico 2mg', '1 Ampolla', 'Servimedic', 5, '2026-01-16', '2027-06-01', 'Disponible', 79, 190.00, 0.00, 0.00, 0.00, 0),
(79, '19006601142', 'Adiaplex 10mg', 'Dapagliflozina 10mg', '30 Tabletas', 'Servimedic', 5, '2026-01-16', '2027-06-01', 'Disponible', 82, 410.00, 0.00, 0.00, 0.00, 0),
(80, '7401094612989', 'Gastrexx plus', 'amoxicilina 1g+ levofloxacina 500mg', '28 capsulas', 'Servimedic', 1, '2026-01-16', '2028-07-01', 'Disponible', 80, 480.00, 0.00, 0.00, 0.00, 0),
(81, '7406137004486', 'Modepar', 'Nicotinamida 17.5mg, Acido Ascorbico 50mg', '60 Tabletas', 'Servimedic', 5, '2026-01-16', '2027-02-01', 'Disponible', 81, 550.00, 0.00, 0.00, 0.00, 0),
(82, '7401095801863', 'Glidap Max 5/1000mg', 'Dapagliflozina 5mg+metformina HCI lp 1000mg', '30 tabletas', 'Servimedic', 5, '2026-01-16', '2027-05-01', 'Disponible', 83, 300.00, 0.00, 0.00, 0.00, 0),
(83, '7406137002031', 'Gesimax 550mg', 'Naproxeno sodico 550mg', '10 tabletas', 'Servimedic', 19, '2026-01-16', '2027-03-01', 'Disponible', 84, 60.00, 55.66, 0.00, 0.00, 0),
(84, '', 'Lisinox Compuesto', 'Propinoxato HCL 10mg+clonixinato de lisina 125mg', '10 Tabletas', 'Servimedic', 10, '2026-01-16', '2028-08-01', 'Disponible', 85, 45.00, 0.00, 0.00, 0.00, 0),
(85, '765446471141', 'Ferrum 16 //240ml', 'hierro, vitaminas y minerales', 'Jarabe 240ml', 'Servimedic', 5, '2026-01-16', '2027-01-01', 'Disponible', 87, 120.00, 78.20, 0.00, 0.00, 0),
(86, '7401130000534', 'Solocin Plus', 'pancreatina 400mg+simeticona 60mg+cinitaprina 1mg', '20 comprimidos', 'Servimedic', 5, '2026-01-16', '2027-03-01', 'Disponible', 86, 220.00, 0.00, 0.00, 0.00, 0),
(87, '7401094607060', 'Gadysen 60mg', 'Duloxetina 60mg', '30 cápsulas', 'Servimedic', 5, '2026-01-16', '2027-11-01', 'Disponible', 88, 560.00, 0.00, 0.00, 0.00, 0),
(88, '7401094607046', 'Gadysen 30mg', 'Duloxetina 30mg', '30 capsulas', 'Servimedic', 2, '2026-01-16', '2027-11-01', 'Disponible', 88, 510.00, 0.00, 0.00, 0.00, 0),
(89, '5027314503770', 'Multiflora Advance', 'probiótico', '30 capsulas', 'Servimedic', 0, '2026-01-16', '2027-05-01', 'Disponible', 90, 420.00, 0.00, 0.00, 0.00, 0),
(90, '7401095800859', 'Exlant 30mg', 'dexlansoprazol 30mg', '30 capsulas', 'Servimedic', 4, '2026-01-16', '2027-08-01', 'Disponible', 92, 365.00, 171.93, 0.00, 0.00, 0),
(91, '8429007040543', 'Estoma dol', 'trisilicato de magnesio, carbon vegetal', '30 capsulas', 'Servimedic', 2, '2026-01-16', '2027-11-01', 'Disponible', 91, 140.00, 0.00, 0.00, 0.00, 0),
(92, '7501124184797', 'Ki-Cab 50mg', 'tegoprazan 50mg', '30 tabletas', 'Servimedic', 1, '2026-01-16', '2026-09-01', 'Disponible', 93, 830.00, 0.00, 0.00, 0.00, 0),
(93, '709708000182', 'Colitran 5.0mg/2.5mg', 'clordiazepoxido HCI/ Bromuro de clidinio', '10 grageas', 'Servimedic', 10, '2026-01-16', '2028-05-01', 'Disponible', 96, 40.00, 0.00, 0.00, 0.00, 0),
(94, '7502010581607', 'Sucralfato  1g', 'sucralfato 1g', '40 Tabletas', 'Servimedic', 5, '2026-01-16', '2026-10-01', 'Disponible', 97, 105.00, 68.98, 0.00, 0.00, 0),
(95, '8437022041391', 'Probiocyan', 'lactobacillus plantarum, zinc 5mg', '30 capsulas', 'Servimedic', 7, '2026-01-16', '2026-09-01', 'Disponible', 95, 230.00, 0.00, 0.00, 0.00, 0),
(96, '19006601999', 'Tensinor Plus 160mg/12.5mg/5mg', 'Valsartan 160mg/hidroclorotiazida 12.5mg/amlodipino 5mg', '30 Tabletas', 'Servimedic', 2, '2026-01-16', '2026-07-01', 'Disponible', 99, 480.00, 0.00, 0.00, 0.00, 0),
(97, '19006602019', 'Tensinor Plus 320mg/25mg/10mg', 'Valsartan 320mg/hidroclorotiazida 25mg/amlodipino 10mg', '30 Tabletas', 'Servimedic', 2, '2026-01-16', '2026-07-01', 'Disponible', 99, 480.00, 0.00, 0.00, 0.00, 0),
(98, '7401018110621', 'Cetamin CC', 'Acetaminofen 325mg+codeina 15mg', '10 Tabletas', 'Servimedic', 5, '2026-01-16', '2029-09-01', 'Disponible', 98, 90.00, 0.00, 0.00, 0.00, 0),
(99, '706020100705', 'Metavan 1000mg XR', 'metformina HCI 1000mg', '40 Tabletas', 'Servimedic', 0, '2026-01-16', '2028-11-01', 'Disponible', 101, 245.00, 0.00, 0.00, 0.00, 0),
(100, '7891317103507', 'Filinar G. 120ml', 'acebrifilina 5mg/ml', 'Suspension oral', 'Servimedic', 0, '2026-01-16', '2027-06-01', 'Disponible', 102, 160.00, 0.00, 0.00, 0.00, 0),
(101, '7891317154141', 'Gastroflux 100ml', 'domperidona 1mg/ml', 'Suspension Oral', 'Servimedic', 3, '2026-01-16', '2026-12-01', 'Disponible', 104, 235.00, 0.00, 0.00, 0.00, 0),
(102, '5905718013630', 'Careject 10ml.', 'aceite de soja, glicerol', 'Spray nasal', 'Servimedic', 5, '2026-01-16', '2027-05-01', 'Disponible', 105, 150.00, 0.00, 0.00, 0.00, 0),
(103, '', 'Myo & D-Chiro Inositol', 'inositol chiro', '90 capsulas', 'Servimedic', 2, '2026-01-16', '2028-12-01', 'Disponible', 103, 470.00, 0.00, 0.00, 0.00, 0),
(104, '2350735122123', 'Aidex 25mg/10ml', 'dexketoprofeno 25mg/10ml', '10 Sobres bebibles', 'Servimedic', 5, '2026-01-16', '2027-07-01', 'Disponible', 106, 110.00, 0.00, 0.00, 0.00, 0),
(105, '19006600589', 'Rusitan 120ml.', 'Rupatadina fumarato 1mg/ml', 'Suspensión oral', 'Servimedic', 5, '2026-01-16', '2026-11-01', 'Disponible', 107, 175.00, 0.00, 0.00, 0.00, 0),
(106, '19006521013', 'Acetaminofen 120ml', 'acetaminofen 120/5ml', 'Suspensión oral', 'Servimedic', 4, '2026-01-16', '2027-03-01', 'Disponible', 108, 30.00, 17.25, 40.00, 0.00, 0),
(107, '7401018102428', 'Contractil 4mg.', 'tiocolchicosido 4mg', '10 Tabletas', 'Servimedic', 3, '2026-01-16', '2026-07-01', 'Disponible', 110, 130.00, 0.00, 0.00, 0.00, 0),
(108, '7401018110423', 'Etoricox 120mg', 'Etoricoxib 120mg', '14 Tabletas', 'Servimedic', 1, '2026-01-16', '2026-09-01', 'Disponible', 111, 400.00, 0.00, 0.00, 0.00, 0),
(109, '7401092140958', 'Isocraneol 500mg', 'Citicolina 500mg', '30 Comprimidos', 'Servimedic', 4, '2026-01-16', '2029-05-01', 'Disponible', 112, 500.00, 369.76, 0.00, 0.00, 1),
(110, '', 'Gebrix-G 240ml', 'Jengibre, Equinacea, vitamina C', 'Suspensión oral', 'Servimedic', 3, '2026-01-16', '2027-07-01', 'Disponible', 114, 200.00, 0.00, 0.00, 0.00, 0),
(111, '765446471844', 'Zirtraler-D 60ml', 'Cetirizina HCI, Fenilefrina HCI', 'Suspensión oral', 'Servimedic', 3, '2026-01-16', '2027-10-01', 'Disponible', 115, 125.00, 0.00, 0.00, 0.00, 0),
(112, '7891058008529', 'Neo-melubrina 100ml', 'Metamizol sodico 250mg/5ml', 'Jarabe 100ml', 'Servimedic', 3, '2026-01-16', '2026-12-01', 'Disponible', 116, 75.00, 40.25, 0.00, 0.00, 0),
(113, '764600212040', 'Neobol 30g', 'neomicina- clostebol', 'Spray tópico 30g', 'Servimedic', 4, '2026-01-16', '2027-05-01', 'Disponible', 117, 135.00, 0.00, 0.00, 0.00, 0),
(114, '', 'Mero Clav 70ml.', 'cefuroxima+ acido clavulanico', 'suspension 70ml', 'Servimedic', 2, '2026-01-16', '2027-04-01', 'Disponible', 118, 250.00, 0.00, 0.00, 0.00, 0),
(115, '7401108842302', 'Dexamicina 5ml', 'Dexametazona/neomicina', 'Gotero Oftalmico 5ml', 'Servimedic', 5, '2026-01-16', '2028-05-01', 'Disponible', 119, 55.00, 0.00, 0.00, 0.00, 0),
(116, '7410031492058', 'Bencidamin 30ml', 'Bencidamina CHI 0.15g/100ml.', 'Spray bucal', 'Servimedic', 4, '2026-01-16', '2027-04-01', 'Disponible', 121, 90.00, 0.00, 0.00, 0.00, 0),
(117, '7406313000370', 'Metronis 30 ml.', 'Nitazoxanida 100mg/5ml', 'suspensión Oral', 'Servimedic', 1, '2026-01-16', '2027-03-01', 'Disponible', 122, 80.00, 0.00, 0.00, 0.00, 0),
(118, '7460347607554', 'Sinedol Forte 750mg', 'Acetaminofen 750mg', '10 Tabletas', 'Servimedic', 4, '2026-01-16', '2027-09-01', 'Disponible', 123, 45.00, 34.32, 0.00, 0.00, 0),
(119, '7401092110029', 'Mucarbol Pediatrico 120ml.', 'Carbocisteina 100mg/5ml', 'Jarabe', 'Servimedic', 5, '2026-01-16', '2028-02-01', 'Disponible', 124, 65.00, 0.00, 0.00, 0.00, 0),
(120, '7401092110043', 'Mucarbol Adulto 120ml.', 'Carbocisteina 750mg/15ml', 'Jarabe', 'Servimedic', 5, '2026-01-16', '2028-02-03', 'Disponible', 125, 70.00, 0.00, 0.00, 0.00, 0),
(121, '7401036100321', 'Neo-Melubrina 500mg', 'Metamizol 500mg', '4 Tabletas', 'Servimedic', 75, '2026-01-16', '2026-12-01', 'Disponible', 126, 15.00, 0.00, 0.00, 0.00, 0),
(122, '', 'Wen vision 5ml.', 'Dexametasona, neomicina', 'Gotero Oftalmico 5ml', 'Servimedic', 7, '2026-01-16', '2027-04-01', 'Disponible', 130, 55.00, 0.00, 0.00, 0.00, 0),
(123, '', 'Brucort-A 15g', 'Triamcinolona acetonido 0.1%', 'Crema Topica 0.1%', 'Servimedic', 4, '2026-01-16', '2028-03-01', 'Disponible', 132, 110.00, 57.50, 0.00, 0.00, 0),
(124, '7410031493079', 'Allopurikem 300mg', 'alopurinol 300mg', '10 Tabletas', 'Servimedic', 5, '2026-01-16', '2028-01-01', 'Disponible', 134, 75.00, 33.81, 0.00, 0.00, 0),
(125, '7410031491402', 'Rexacort 18g', 'mometasona furoato 50yg', 'Spray nasal 18g', 'Servimedic', 4, '2026-01-16', '2027-03-01', 'Disponible', 136, 130.00, 0.00, 0.00, 0.00, 0),
(126, '7401117100158', 'Colchinet 0.5mg', 'Colchicina 0.5 mg', '20 Tabletas', 'Servimedic', 15, '2026-01-16', '2027-05-01', 'Disponible', 138, 65.00, 0.00, 0.00, 0.00, 0),
(127, '7404005670078', 'AGE III', 'cucurbita pepo. africanum', '30 Capsulas', 'Servimedic', 5, '2026-01-16', '2027-09-01', 'Disponible', 127, 200.00, 152.78, 0.00, 0.00, 0),
(128, '7795345012452', 'Sertal Forte Perlas', 'Propinox Clorhidrato 20mf', '10 capsulas', 'Servimedic', 3, '2026-01-16', '2028-02-01', 'Disponible', 128, 90.00, 0.00, 0.00, 0.00, 0),
(129, '7401133901043', 'Triglix 160mg', 'Fenofibrato 160mg', '40 capsulas', 'Servimedic', 4, '2026-01-16', '2027-04-01', 'Disponible', 139, 390.00, 251.85, 0.00, 0.00, 0),
(130, '7401094600917', 'Equiliv 2mg', 'Clonazepan 2mg', '30 Tabletas', 'Servimedic', 6, '2026-01-16', '2028-07-01', 'Disponible', 140, 135.00, 0.00, 0.00, 0.00, 0),
(131, '7443000140124', 'Selenio+Vit E', 'Vitamina E 1000UI+ Selenio 200', '60 Capsulas', 'Servimedic', 2, '2026-01-16', '2027-01-04', 'Disponible', 131, 175.00, 0.00, 0.00, 0.00, 0),
(132, '7404000313321', 'Dryskin 60ml', 'Cloruro de Aluminio Hexahidratado 20%', 'Solución Tópica', 'Servimedic', 5, '2026-01-22', '2028-01-01', 'Disponible', 149, 295.00, 220.00, 0.00, 0.00, 0),
(133, '', 'Uxbi', 'Acido ursodesoxicolico 250mg', '30 capsulas', 'Servimedic', 0, '2026-01-16', '2026-07-01', 'Disponible', 133, 375.00, 0.00, 0.00, 0.00, 0),
(134, '8904073001532', 'Zotern 20g', 'terbinafina clorhidrato ', 'Crema Tópica 1%', 'Servimedic', 1, '2026-01-22', '2026-07-01', 'Disponible', 150, 80.00, 46.00, 0.00, 0.00, 0),
(135, '7401010902613', 'Sacameb 120ml', 'Metronidazol 125mg/5ml 120ml', 'suspension Oral', 'Servimedic', 2, '2026-01-22', '2027-04-01', 'Disponible', 153, 55.00, 23.00, 0.00, 0.00, 0),
(136, '7401133901142', 'Muvlax 17g', 'polietilenglicol 3350', 'Sobres 17g', 'Servimedic', 30, '2026-01-22', '2027-03-01', 'Disponible', 156, 14.00, 10.35, 0.00, 0.00, 0),
(137, '7401078990997', 'Nagreg 10mg', 'rupatadina', '10 comprimidos', 'Servimedic', 2, '2026-01-22', '2027-06-01', 'Disponible', 158, 155.00, 140.30, 0.00, 0.00, 0),
(138, '7401133900589', 'propix-duo 15mg/2ml', 'propinoxato15mg/clonixinato de lisina 100mg', 'ampolla', 'Servimedic', 6, '2026-01-24', '2028-02-01', 'Disponible', 180, 50.00, 26.10, 26.10, 26.10, 0),
(139, '7406137002185', 'Gesimax 60ml', 'naproxeno 150mg/5ml', 'suspension ', 'Servimedic', 2, '2026-01-24', '2026-07-01', 'Disponible', 191, 65.00, 40.00, 40.00, 40.00, 0),
(140, '', 'Dolvi plex 500mg', 'Metamizol 500mg', '10 tabletas', 'Servimedic', 1, '2026-01-24', '2026-12-01', 'Disponible', 184, 20.00, 10.35, 10.35, 10.35, 0),
(141, '7401094610343', 'Prednicet 20mg', 'Prednisolana 20mg', '10 Tabletas', 'Servimedic', 0, '2026-01-22', '2028-10-01', 'Disponible', 141, 110.00, 0.00, 0.00, 0.00, 0),
(142, '7401094603482', 'Prednicet 15mg/5ml 100ml', 'Prednisolona 15mg/5ml', 'Suspensión oral', 'Servimedic', 2, '2026-01-22', '2028-08-01', 'Disponible', 142, 170.00, 0.00, 0.00, 0.00, 0),
(143, '7404007270016', 'Yes or Not', 'Sin Molécula Especificada', 'Prueba Embarazo', 'Servimedic', 3, '2026-01-22', '2027-06-28', 'Disponible', 143, 25.00, 0.00, 0.00, 0.00, 0),
(144, '7401094609781', 'Spirocard 25mg', 'Espironolactona 25mg', '30 Tableta Recubiertas', 'Servimedic', 1, '2026-01-22', '2027-05-01', 'Disponible', 144, 210.00, 0.00, 0.00, 0.00, 0),
(145, '7410031492195', 'Melana 3', 'Melatonina 3mg', '30 Cápsulas', 'Servimedic', 1, '2026-01-22', '2026-10-01', 'Disponible', 145, 90.00, 0.00, 0.00, 0.00, 0),
(146, '765446110248', 'Aciclovirax Gel 15g', 'Aciclovir,  D-Pantenol', 'Gel Tópico', 'Servimedic', 5, '2026-01-22', '2026-11-01', 'Disponible', 146, 130.00, 0.00, 0.00, 0.00, 0),
(147, '765446471332', 'Caladermina 120ml', 'Calamina, Alcanfor, Difenhidramina', 'Suspensión Tópica', 'Servimedic', 2, '2026-01-22', '2027-02-01', 'Disponible', 147, 35.00, 0.00, 0.00, 0.00, 0),
(148, '7404000310412', 'Cortiderm 15g', 'Hidrocortisona', 'Crema Tópica 15g', 'Servimedic', 1, '2026-01-22', '2027-03-01', 'Disponible', 148, 95.00, 0.00, 0.00, 0.00, 0),
(149, '5600360013037', 'Supraxil 1g', 'Ceftriaxona', 'Vial+ampolla', 'Servimedic', 2, '2026-01-24', '2026-09-01', 'Disponible', 196, 130.00, 45.00, 45.00, 45.00, 0),
(150, '7410031491334', 'Celedexa 120ml', 'Betametasona dexclorfeniramina', 'Jarabe 120ml', 'Servimedic', 3, '2026-01-24', '2026-05-01', 'Disponible', 199, 140.00, 72.80, 72.80, 72.80, 0),
(151, '8430340003072', 'Anso 15g', 'Lidocaina hidrocloruro/ pentosano polisulfato sodio/Triamcinofona acetónico', 'Pomada Rectal', 'Servimedic', 1, '2026-01-22', '2027-01-01', 'Disponible', 151, 100.00, 62.91, 0.00, 0.00, 0),
(152, '7401108843347', 'Gastrobacter 10 días', 'Amoxicilina 1g/ levofloxamina 500mg/ esomeprazol 40mg', '50 Tabletas', 'Servimedic', 1, '2026-01-22', '2027-03-01', 'Disponible', 152, 380.00, 214.48, 0.00, 0.00, 0),
(153, '7401108840117', 'Ambiare 2mg/0.25mg', 'Dexclorfeniramina,betametasona', '10 Tabletas', 'Servimedic', 2, '2026-01-24', '2028-09-01', 'Disponible', 201, 55.00, 35.00, 35.00, 35.00, 0),
(154, '7401010902613', 'Paverin Compuesto', 'clonixinato de lisina 125mg / propinoxato de clohidrato 10mg', '20 Comprimidos', 'Servimedic', 1, '2026-01-22', '2027-07-01', 'Disponible', 154, 65.00, 43.01, 0.00, 0.00, 0),
(155, '', 'AB-Digest sticks', 'probióticos, prebióticos, zinc.', '30 sticks bebibles', 'Servimedic', 0, '2026-01-22', '2026-12-01', 'Disponible', 155, 590.00, 0.00, 0.00, 0.00, 0),
(156, '7410031492515', 'Fenobrox  240ml', 'Cloperastina', 'suspension oral', 'Servimedic', 0, '2026-01-24', '2026-10-01', 'Disponible', 202, 110.00, 36.00, 36.00, 36.00, 0),
(157, '5027314503770', 'Multiflora Plus', 'vitamina A,C,E, Lactobacilos', '30 cápsulas', 'Servimedic', 0, '2026-01-22', '2026-10-01', 'Disponible', 157, 420.00, 0.00, 0.00, 0.00, 0),
(158, '7410031491761', 'Sargikem', 'Aspartato de L - arginina+B1', '30 Capsulas', 'Servimedic', 1, '2026-01-24', '2026-09-01', 'Disponible', 209, 165.00, 83.60, 83.60, 83.60, 0),
(159, '7401094609835', 'Sitalev Met 50/1000mg', 'Sitagliptina 50mg + metmorfina clorhidrato 1000mg', '30 Tabletas recubiertas', 'Servimedic', 1, '2026-01-22', '2028-07-01', 'Disponible', 350, 225.00, 145.80, 0.00, 0.00, 0),
(160, '2350735122112', 'Oriprox-M 400mg', 'Moxifloxacino 400mg', '10 Tabletas', 'Servimedic', 5, '2026-01-24', '2027-10-01', 'Disponible', 211, 400.00, 225.00, 225.00, 225.00, 0),
(161, '709708000731', 'Albugenol 10ml', 'salbutamol, bromuro de ipratropium', 'gotero p/ nebulizar', 'Servimedic', 1, '2026-01-22', '2027-02-01', 'Disponible', 161, 185.00, 0.00, 0.00, 0.00, 0),
(162, '', 'Airessa compuesta', 'bromuro de clidineo 5mg/ dimetilpolisiloxano 150mg', '10 cápsulas', 'Servimedic', 0, '2026-01-22', '2026-12-01', 'Disponible', 162, 55.00, 0.00, 0.00, 0.00, 0),
(163, '7703889123978', 'Tibonella 2.5mg', 'Tibolona 2.5mg', '28 Tabletas', 'Servimedic', 3, '2026-01-24', '2027-05-01', 'Disponible', 212, 290.00, 170.00, 170.00, 170.00, 0),
(164, '7401133900213', 'Simeflat 40mg', 'simeticona 40mg', '30 tabletas', 'Servimedic', 1, '2026-01-22', '2027-07-01', 'Disponible', 164, 70.00, 0.00, 0.00, 0.00, 0),
(165, '', 'Porbex 30ml', 'acetaminofen+clorfeniramina', 'gotero oral', 'Servimedic', 3, '2026-01-22', '2026-08-01', 'Disponible', 165, 90.00, 0.00, 0.00, 0.00, 0),
(166, '7401018115206', 'Rinofed 120ml', 'clorfeniramida, fenilefrina, codeina', 'Jarabe', 'Servimedic', 1, '2026-01-22', '2027-02-01', 'Disponible', 166, 115.00, 0.00, 0.00, 0.00, 0),
(167, '2350735122081', 'Brox-C 100ml', 'desloratadina 5mg+betametasona 0.25mg', 'Jarabe', 'Servimedic', 2, '2026-01-22', '2028-08-01', 'Disponible', 167, 125.00, 92.00, 0.00, 0.00, 0),
(168, '7406356002904', 'Byetos 120ml', 'codeina, clorfeniramida, fenilefrina', 'Jarabe', 'Servimedic', 2, '2026-01-22', '2027-09-01', 'Disponible', 168, 105.00, 0.00, 0.00, 0.00, 0),
(169, '7406356000917', 'Metricom 500ml', 'metronidazol 500ml', '20 Tabletas recubiertas', 'Servimedic', 0, '2026-01-22', '2027-05-01', 'Disponible', 169, 75.00, 0.00, 0.00, 0.00, 0),
(170, '7401158300173', 'Demelan', 'nitazoxanida', '6 Cápsulas', 'Servimedic', 2, '2026-01-22', '2026-10-01', 'Disponible', 170, 90.00, 39.20, 0.00, 0.00, 0),
(171, '2350735122201', 'Urocram', 'arandano+vitamina C', '30 cápsulas', 'Servimedic', 2, '2026-01-22', '2027-08-01', 'Disponible', 171, 240.00, 0.00, 0.00, 0.00, 0),
(172, '8429007060251', 'Grater Neo Form', 'carnitina, extracto de mango africano', '60 Cápsulas', 'Servimedic', 3, '2026-01-22', '2027-04-01', 'Disponible', 172, 250.00, 178.14, 0.00, 0.00, 0),
(173, '4250632503806', 'Tónico de Alfalfa 100ml', 'Alfalfa', 'Suspension Oral', 'Servimedic', 4, '2026-01-22', '2029-05-01', 'Disponible', 173, 210.00, 0.00, 0.00, 0.00, 0),
(174, '7401010902576', 'Dyflam 15ml', 'Diclofenaco resinato 1.5%', 'Gotas orales', 'Servimedic', 4, '2026-01-24', '2027-08-01', 'Disponible', 223, 50.00, 21.40, 21.40, 21.40, 0),
(175, '19006516118', 'Dediacol 250mg', 'aminosidina', '10 Tabletas', 'Servimedic', 35, '2026-01-22', '2028-10-01', 'Disponible', 175, 65.00, 0.00, 0.00, 0.00, 0),
(176, '7401108841268', 'Cefina 100ml', 'Cefixima 100mg/5ml', 'Suspension oral 100ml', 'Servimedic', 0, '2026-01-24', '2027-04-01', 'Disponible', 339, 220.00, 103.50, 90.00, 90.00, 0),
(177, '7401010902415', 'ESOGASTRIC 10MG', 'ESOMEPRAZOL', '15 SOBRES', 'Servimedic', 2, '2026-01-24', '2027-04-01', 'Disponible', 177, 165.00, 98.12, 98.12, 98.12, 0),
(178, '7401078980028', 'SPASMO-UROLONG', 'NITROFURANTOINA 75MG', '10 COMPRIMIDOS', 'Servimedic', 2, '2026-01-24', '2027-12-01', 'Disponible', 178, 80.00, 43.00, 43.00, 43.00, 0),
(179, '70030165376', 'Burts bees baby', 'esencia coco', 'rolon', 'Servimedic', 3, '2026-01-24', '2028-10-01', 'Disponible', 179, 105.00, 30.00, 30.00, 30.00, 0),
(180, '7401092130089', 'Redical 10mg', 'Esomeprazol 10mg', '28 Sobres', 'Servimedic', 1, '2026-01-24', '2026-07-01', 'Disponible', 220, 420.00, 214.60, 214.60, 214.60, 0),
(181, '7796285051501', 'ovumix', 'metronidazol, sulfato neomicina, centella asiatica', 'ovulos vaginales', 'Servimedic', 1, '2026-01-24', '2027-10-01', 'Disponible', 181, 260.00, 198.10, 198.10, 198.10, 0),
(182, '', 'Gripcol D 120ml', 'Fenilefrina,dextrometorfano,acetaminofen', 'Suspensión oral', 'Servimedic', 0, '2026-01-24', '2026-08-01', 'Disponible', 221, 55.00, 28.00, 28.00, 28.00, 0),
(183, '4031571077203', 'Paracetamol Denk 500mg', 'Paracetamol', '20 comprimidos', 'Servimedic', 2, '2026-01-24', '2027-07-01', 'Disponible', 183, 50.00, 29.50, 29.50, 29.50, 0),
(184, '7410031492447', 'Totalvit ZINC 120ml', 'Sulfatode zinc 20mg', 'Jarabe 120ml', 'Servimedic', 2, '2026-01-24', '2026-07-01', 'Disponible', 223, 110.00, 40.00, 40.00, 40.00, 0),
(185, '8429007048037', 'Melanoblock', 'aqua cetearyl alcohol', 'Crema Facial', 'Servimedic', 5, '2026-01-24', '2028-07-01', 'Disponible', 185, 375.00, 162.00, 162.00, 162.00, 0),
(186, '8429007048228', 'regenhial crema', 'Acido hialuronico 1%', 'Crema Facial', 'Servimedic', 2, '2026-01-24', '2029-11-01', 'Disponible', 186, 450.00, 282.85, 282.85, 282.85, 0),
(187, '8429007042325', 'Regenhial Gel', 'Acido hialuronico 1%', 'Crema Facial', 'Servimedic', 3, '2026-01-24', '2027-05-01', 'Disponible', 187, 275.00, 194.00, 194.00, 194.00, 0),
(188, '7703333007458', 'Hidribet 10%', 'Glicerin, sorbitan', 'Locion topica', 'Servimedic', 0, '2026-01-24', '2030-03-01', 'Disponible', 188, 125.00, 74.15, 74.15, 74.15, 0),
(189, '7703281002482', 'Umbrella', 'aqua,penylene glycol', 'Protector solar facial', 'Servimedic', 2, '2026-01-24', '2026-08-01', 'Disponible', 189, 225.00, 165.64, 165.64, 165.64, 0),
(190, '8429007061609', 'Figure active', 'carnitina,triptofano,buchu', '14 sobres', 'Servimedic', 3, '2026-01-24', '2027-01-01', 'Disponible', 190, 300.00, 217.90, 217.90, 217.90, 0),
(191, '7401158300050', 'Ureactiv 10%', 'carbamida -urea', 'Crema humectante', 'Servimedic', 1, '2026-01-24', '2027-02-01', 'Disponible', 191, 155.00, 95.42, 95.42, 95.42, 0),
(192, '8429007047726', 'Regenhial Gel Oral', 'Acido hialuronico 250mg', 'Enjuague bucal', 'Servimedic', 4, '2026-01-24', '2026-12-01', 'Disponible', 192, 200.00, 110.00, 110.00, 110.00, 0),
(193, '19006516033', 'Claribac 500mg', 'Claritromicina', '10 tabletas', 'Servimedic', 2, '2026-01-24', '2029-01-01', 'Disponible', 193, 325.00, 151.46, 151.46, 151.46, 0),
(194, '5600360010609', 'Unocef 400mg', 'Cefixima', '8 Comprimidos', 'Servimedic', 5, '2026-01-24', '2026-09-01', 'Disponible', 194, 300.00, 201.35, 201.35, 201.35, 0),
(195, '709708000434', 'Quinolide 500mg', 'Ciprofloxacina', '10 tabletas', 'Servimedic', 14, '2026-01-24', '2028-04-01', 'Disponible', 195, 100.00, 27.50, 27.50, 27.50, 0),
(196, '7401010901265', 'Broncodil 120ml', 'Carboximetilcisteina 250mg/5ml', 'Suspension oral', 'Servimedic', 5, '2026-01-24', '2027-06-01', 'Disponible', 227, 110.00, 40.00, 40.00, 40.00, 0),
(197, '7401104600791', 'Tiamina 100mg', 'Tiamina 10ml', 'Vial', 'Servimedic', 3, '2026-01-24', '2027-02-01', 'Disponible', 197, 25.00, 9.00, 9.00, 9.00, 0),
(198, '7401108802405', 'Complejo B', 'Complejo B 10ML', 'Vial', 'Servimedic', 3, '2026-01-24', '2028-08-01', 'Disponible', 198, 25.00, 12.00, 12.00, 12.00, 0),
(199, '737787928325', 'Nocicep RP 10mg', 'Rupatadina 10mg', '10 Tabletas', 'Servimedic', 3, '2026-01-24', '2029-06-01', 'Disponible', 230, 130.00, 56.40, 56.40, 56.40, 0),
(200, '', 'Indugastric 120ml', 'regaliz,resina,', 'Jarabe', 'Servimedic', 1, '2026-01-24', '2027-02-01', 'Disponible', 200, 210.00, 118.14, 118.14, 118.14, 0),
(201, '7404000310542', 'Levax 120ml', 'Levamisol 12.5mg/5ml', 'Suspension oral', 'Servimedic', 2, '2026-01-24', '2027-05-01', 'Disponible', 240, 100.00, 61.60, 61.60, 61.60, 0),
(202, '7404000310528', 'Levax 75mg', 'Levamisol HCI 75mg', '10 tabletas', 'Servimedic', 2, '2026-01-24', '2027-04-01', 'Disponible', 232, 165.00, 107.10, 107.10, 107.10, 0),
(203, '7401094603369', 'Acla-Med Bid 400mg', 'Amoxicilina+acido clavulanico', 'Suspension', 'Servimedic', 4, '2026-01-24', '2027-08-01', 'Disponible', 71, 125.00, 51.20, 51.20, 51.20, 0),
(204, '7703889156501', 'Vaginsol F', 'Clindamicina100mg+clotrimazol 200mg', '7 ovulos vaginales', 'Servimedic', 2, '2026-01-24', '2026-06-01', 'Disponible', 204, 360.00, 244.00, 244.00, 244.00, 0),
(205, '', 'Ferra Q', 'Acido folico1000mcg+hierro aminoquelado 30mg', '30 Capsulas', 'Servimedic', 1, '2026-01-24', '2026-05-01', 'Disponible', 205, 115.00, 55.20, 55.20, 55.20, 0),
(206, '', 'Hepamob', 'Cilimarina+complejo b', '30 Comprimidos', 'Servimedic', 0, '2026-01-24', '2026-11-01', 'Disponible', 206, 150.00, 90.00, 90.00, 90.00, 0),
(207, '7401108200225', 'Prednitab 50mg', 'Prednisona', '20 Tabletas', 'Servimedic', 4, '2026-01-24', '2027-04-01', 'Disponible', 207, 385.00, 265.30, 265.30, 265.30, 0),
(208, '7401010901968', 'Lansogastric 15Mg', 'Lansoprazol', '15 Sobres', 'Servimedic', 3, '2026-01-24', '2027-06-01', 'Disponible', 208, 90.00, 34.00, 34.00, 34.00, 0),
(209, '7401092140088', 'Nocpidem 10mg', 'Zolpidem 10mg', '30 Comprimidos', 'Servimedic', 1, '2026-01-24', '2029-04-01', 'Disponible', 239, 350.00, 225.60, 225.60, 225.60, 0),
(210, '7401134402662', 'Lergiless', 'loratadina 5mg/betametasona 0.25mg', 'Jarabe 60ml', 'Servimedic', 2, '2026-01-24', '2026-11-01', 'Disponible', 210, 110.00, 64.00, 64.00, 64.00, 0),
(211, '7401108842418', 'Triviplex 25000  2ml/1ml', 'Diclofenaco sodico, vitaminas B,B6,B12', 'Ampolla 2ml', 'Servimedic', 5, '2026-01-24', '2027-08-01', 'Disponible', 240, 45.00, 19.00, 19.00, 19.00, 0),
(212, '7401108842258', 'Dexa-triviplex 2ml/1ml', 'Vitaminas neurotropas+dexa', '2 ampollas', 'Servimedic', 5, '2026-01-24', '2027-09-01', 'Disponible', 241, 55.00, 29.00, 29.00, 29.00, 0),
(213, '7401010900725', 'Metocarban AC', 'Metocarbamol400mg/acetaminofen 250mg', '30 Tabletas', 'Servimedic', 3, '2026-01-24', '2029-06-01', 'Disponible', 213, 110.00, 60.20, 60.20, 60.20, 0),
(214, '7401108842418', 'Dolo Triviplex 2ml/1ml', 'Diclofenaco+vitaminas', '2 ampollas', 'Servimedic', 6, '2026-01-24', '2027-09-01', 'Disponible', 242, 50.00, 23.00, 23.00, 23.00, 0),
(215, '', 'Enna pelvic ball', 'pelvica', 'Esfera', 'Servimedic', 1, '2026-01-24', '2029-05-01', 'Disponible', 246, 450.00, 200.00, 0.00, 0.00, 0),
(216, '7401010902958', 'Floxa-Pack 10 Dias', 'Lansoprazol 30mg/levofloxacina 500mg/amoxicilina 500mg', '10 Comprimidos', 'Servimedic', 2, '2026-01-24', '2027-01-27', 'Disponible', 216, 450.00, 190.00, 190.00, 190.00, 0),
(217, '7401010902941', 'Floxa- Pack ES 10 Dias', 'Esomeprazol 40mg/levofloxacina 500mg/amoxicilina 500mg', '10 Comprimidos', 'Servimedic', 1, '2026-01-24', '2027-02-01', 'Disponible', 217, 515.00, 213.00, 213.00, 213.00, 0),
(218, '7401010902583', 'Arginina Junior', 'aspartato de arginina 1g/5ml', '10 ampollas bebibles', 'Servimedic', 2, '2026-01-24', '2027-03-01', 'Disponible', 218, 95.00, 70.00, 70.00, 70.00, 0),
(219, '7401010902378', 'Arginina Forte', 'Aspartato de arginina 5g/10ml', '10 ampollas bebibles', 'Servimedic', 1, '2026-01-24', '2028-05-01', 'Disponible', 219, 135.00, 98.00, 98.00, 98.00, 0),
(220, '7707236126797', 'Omeprazol 40mg', 'Omeprazol 40mg', 'Vial Polvo', 'Servimedic', 57, '2026-01-24', '2028-09-01', 'Disponible', 277, 80.00, 11.27, 25.00, 40.00, 3),
(221, '7401150300096', 'Agujas hipodermicas 24GX1', 'aguja 24GX1', 'Steril', 'Servimedic', 2, '2026-01-24', '2027-08-01', 'Disponible', 284, 0.00, 0.00, 0.00, 0.00, 0),
(222, '7401078930382', 'Deflarin 6mg', 'Deflazacort', '10 Comprimidos', 'Servimedic', 1, '2026-01-24', '2026-04-01', 'Disponible', 222, 135.00, 77.00, 77.00, 77.00, 0),
(223, '', 'Mascarillas para nebulizar (M)', 'Insumo', 'Pediatrico', 'Servimedic', 0, '2026-01-24', '2028-08-01', 'Disponible', 295, 50.00, 25.00, 0.00, 0.00, 1),
(224, '7891317175351', 'Musculare 10mg', 'Clorhidrato de ciclobenzaprina', '15 Tabletas', 'Servimedic', 5, '2026-01-24', '2027-04-01', 'Disponible', 224, 145.00, 102.28, 102.28, 102.28, 0),
(225, '7891317175375', 'Musculare 5mg', 'Clorhidrato de ciclobenzaprina', '15 Tabletas', 'Servimedic', 5, '2026-01-24', '2027-03-01', 'Disponible', 225, 125.00, 91.58, 91.58, 91.58, 0),
(226, '7401010902569', 'Dyflam 120ml', 'Diclofenaco 9mg/5ml', 'Suspension', 'Servimedic', 5, '2026-01-24', '2027-08-01', 'Disponible', 226, 65.00, 34.00, 34.00, 34.00, 0),
(227, '', 'Mascarillas para nebulizar (L)', 'Insumo', 'Adulto', 'Servimedic', 4, '2026-01-24', '2029-06-01', 'Disponible', 296, 50.00, 25.00, 0.00, 0.00, 0),
(228, '7401094612712', 'Gastrexx 40mg', 'Esomeprazol', '15 Capsulas', 'Servimedic', 5, '2026-01-24', '2027-10-01', 'Disponible', 228, 600.00, 220.26, 220.26, 220.26, 0),
(229, '7441041700642', 'valerpan 2ml', 'dipropinato de debetametasona', 'ampolla', 'muestras medicas', 1, '2026-01-29', '2028-04-01', 'Disponible', 342, 200.00, 0.01, 0.00, 0.00, 0),
(230, '7410031492614', 'Benzoclid Duo 100mg/40mg', 'Simeticona 100mg +bromuro de otilonio 40mg', '10  Cápsulas', 'Servimedic', 30, '2026-01-29', '2027-09-01', 'Disponible', 352, 40.00, 443.90, 0.00, 0.00, 0),
(231, '7460347607783', 'Quimida 300mg', 'Quinfamida 300mg', 'comprimido', 'Servimedic', 5, '2026-01-29', '2028-08-01', 'Disponible', 357, 105.00, 0.10, 0.00, 0.00, 0),
(232, '', 'Mascarillas para nebulizar (L)', 'Insumo', 'adulto', 'Servimedic', 25, '2026-01-30', '2030-09-01', 'Disponible', 296, 50.00, 25.00, 0.00, 0.00, 0),
(233, '', 'Mascarillas para nebulizar (M)', 'Insumo', 'Pediatrico', 'Servimedic', 25, '2026-01-30', '2030-09-01', 'Disponible', 295, 50.00, 25.00, 0.00, 0.00, 0),
(234, '7401068500298', 'Dinivanz Compuesto', 'Bromuro de ipatropium/salino/salbutamol', 'kit para nebulizar', 'Servimedic', 5, '2026-01-24', '2028-10-01', 'Disponible', 234, 240.00, 103.44, 103.44, 103.44, 0),
(235, '5600360010050', 'Betasporina', 'Ceftriaxona 1g', 'Vial', 'Servimedic', 10, '2026-01-24', '2027-02-01', 'Disponible', 235, 140.00, 55.00, 55.00, 55.00, 0),
(236, '7703889060662', 'Ceftrian', 'Ceftriaxona 1g', 'Vial', 'Servimedic', 3, '2026-01-24', '2026-04-01', 'Disponible', 236, 110.00, 35.00, 35.00, 35.00, 0),
(237, '764600210909', 'Dipronova', 'Betamethasone dipropionate', 'Vial', 'Servimedic', 1, '2026-01-24', '2028-12-01', 'Disponible', 237, 180.00, 60.00, 60.00, 60.00, 0),
(238, '7410031491815', 'Esomeprakem', 'Esomeprazol 40mg/levofloxacina 500mg/amoxicilina 500mg', '10 Capsulas', 'Servimedic', 3, '2026-01-24', '2026-06-01', 'Disponible', 238, 70.00, 36.00, 36.00, 36.00, 0),
(239, '', 'Morfina Sulfato', 'morfina 10mg', 'Ampolla 1ml', 'Servimedic', 10, '2026-01-30', '2029-12-01', 'Disponible', 370, 200.00, 90.00, 0.00, 0.00, 0),
(240, '', 'Datrax-B', 'Dexketoprofeno+vitaminas neurotropas', '3 ampolls', 'Servimedic', 0, '2026-01-30', '2026-10-01', 'Disponible', 375, 55.00, 33.35, 33.35, 33.35, 0),
(241, '746052793537', 'Reno-Gastru Rekin 27 (10 amp. 2.0ml)', 'Acidum nitricum D6 0.2g, berberis vulgaris D4 0.2', 'caja', 'Servimedic', 1, '2026-01-31', '2028-10-01', 'Disponible', 402, 300.00, 91.89, 0.00, 0.00, 0),
(242, '746052793537', 'Fucus-Gastru Rekin 59 (10 amp. 2.0ml)', 'calcium carbonicum hahnemanni D12 0.2g, fucus vesiculosus D4 0.2g', 'caja', 'Servimedic', 2, '2026-01-31', '2028-02-01', 'Disponible', 403, 300.00, 91.89, 0.00, 0.00, 0),
(243, '7501125171567', 'Suero Hidravida', 'sabor coco', 'suero oral', 'Servimedic', 0, '2026-01-24', '2027-07-01', 'Disponible', 243, 18.00, 14.30, 14.30, 14.30, 1),
(244, '7401092160048', 'Ledestil', 'carbohidratos,lipidos totales', 'ampollas', 'Servimedic', 16, '2026-01-24', '2029-01-01', 'Disponible', 244, 100.00, 52.33, 52.33, 52.33, 0),
(245, '', 'Agujas Hipodermicas', '31GX3/16', '100 Agujas', 'Servimedic', 5, '2026-01-24', '2027-07-01', 'Disponible', 245, 175.00, 90.00, 90.00, 90.00, 0),
(246, '746052793537', 'Hepa Gastru-Rekin 7 (10 amp. 2.0ml)', 'Carduus marianus D4 0.2g, Chelidonum D4 0.2g', 'caja', 'Servimedic', 1, '2026-01-31', '2028-10-01', 'Disponible', 404, 300.00, 91.89, 0.00, 0.00, 0),
(247, '8904240120509', 'Nircip', 'Ciprofloxacina 200mg/100m', 'Frasco Inyectable', 'Servimedic', 6, '2026-01-24', '2027-06-01', 'Disponible', 247, 80.00, 23.00, 23.00, 23.00, 0),
(248, '6921875003290', 'Ampidelt', 'Ampi+sulbactam', 'Vial', 'Servimedic', 26, '2026-01-24', '2027-12-01', 'Disponible', 248, 80.00, 15.75, 25.00, 40.00, 4),
(249, '', 'Tiamina bonin', 'Tiamina', 'Vial', 'Servimedic', 10, '2026-01-24', '2029-01-01', 'Disponible', 249, 25.00, 9.10, 9.10, 9.10, 0),
(250, '7707236125318', 'Fluconazol ', 'Fluconazol 2mg/ml', 'Frasco Inyectable', 'Servimedic', 2, '2026-01-24', '2027-06-01', 'Disponible', 250, 150.00, 37.61, 37.61, 37.61, 0),
(251, '7401108840667', 'Bactemicina 600mg/4ml', 'Clindamicina', 'Ampolla', 'Servimedic', 5, '2026-01-24', '2028-04-01', 'Disponible', 251, 65.00, 34.50, 34.50, 34.50, 0),
(252, '', 'Jeringas de 20ml', 'Insumo', 'Insumo', 'Servimedic', 195, '2026-01-24', '2028-04-01', 'Disponible', 252, 10.00, 1.96, 1.96, 1.96, 0),
(253, '7401108840667', 'Jeringas de 3ml', 'Insumo', 'Insumo', 'Servimedic', 279, '2026-01-24', '2028-04-01', 'Disponible', 253, 5.00, 0.84, 0.84, 0.84, 1),
(254, '7707236128838', 'Jeringa de 1ml', 'Insumo', 'Insumo', 'Servimedic', 499, '2026-01-24', '2028-09-01', 'Disponible', 254, 5.00, 1.67, 1.45, 1.45, 0),
(255, '', 'Baja Lenguas', 'Insumo', 'Insumo', 'Servimedic', 12, '2026-01-24', '2030-12-01', 'Disponible', 255, 0.00, 0.00, 0.00, 0.00, 0),
(256, '', 'Angiocath #22', 'Insumo', 'Insumo', 'Servimedic', 144, '2026-01-24', '2030-03-01', 'Disponible', 256, 15.00, 4.72, 4.72, 4.72, 1),
(257, '', 'Angiocath #18', 'Insumo', 'Insumo', 'Servimedic', 50, '2026-01-24', '2030-02-01', 'Disponible', 257, 15.00, 4.72, 4.72, 4.72, 0),
(258, '', 'Angiocath #20', 'Insumo', 'Insumo', 'Servimedic', 45, '2026-01-24', '2030-04-01', 'Disponible', 258, 15.00, 4.72, 4.72, 4.72, 2),
(259, '', 'Angiocath #24', 'Insumo', 'Insumo', 'Servimedic', 76, '2026-01-24', '2030-01-01', 'Disponible', 259, 15.00, 4.72, 4.72, 4.72, 4),
(260, '7401068500304', 'Lidocaina c/ Epinefrina', 'Insumo', 'Insumo', 'Servimedic', 3, '2026-01-24', '2027-01-01', 'Disponible', 260, 60.00, 41.40, 36.00, 36.00, 0),
(261, '7401068500298', 'LIdocaina SIN/ Epinefrina', 'Insumo', 'Insumo', 'Servimedic', 2, '2026-01-24', '2028-02-01', 'Disponible', 261, 50.00, 36.80, 32.00, 32.00, 0),
(262, '7707236127954', 'Metoclopramida', 'Metoclopramida 10mg', 'Ampolla 2ml', 'Servimedic', 110, '2026-01-24', '2027-08-01', 'Disponible', 262, 50.00, 2.30, 2.30, 2.30, 0),
(263, '7707236127312', 'Ranitidina', 'Ranitidina 50mg', 'Ampolla 2ml', 'Servimedic', 200, '2026-01-24', '2027-09-01', 'Disponible', 263, 50.00, 2.30, 2.30, 2.30, 0),
(264, '7707236128074', 'Tramadol', 'Tramadol 100mg', 'Ampolla 2ml', 'Servimedic', 100, '2026-01-24', '2028-05-01', 'Disponible', 264, 50.00, 2.76, 2.76, 2.76, 0),
(265, '7707236120856', 'Dexametasona', 'Dexametasona 4mg', 'Ampolla 1ml', 'Servimedic', 107, '2026-01-24', '2027-05-01', 'Disponible', 265, 50.00, 2.88, 2.88, 2.88, 0),
(266, '7707236128838', 'Dipirona', 'Dipirona 1g', 'Ampolla 2ml', 'Servimedic', 201, '2026-01-24', '2027-08-01', 'Disponible', 266, 50.00, 3.45, 3.45, 3.45, 0),
(267, '', 'Selestina', 'Dexa 8mg', 'Ampolla 2ml', 'Servimedic', 4, '2026-01-24', '2027-10-01', 'Disponible', 267, 50.00, 2.50, 2.50, 2.50, 2),
(268, '', 'Parenten', 'Diazepoam 10mg', 'Ampolla 2ml', 'Servimedic', 1, '2026-01-24', '2027-08-01', 'Disponible', 268, 100.00, 11.50, 11.50, 11.50, 2),
(269, '7401108840667', 'Jeringas de 5ml', 'Insumo', 'Insumo', 'Servimedic', 200, '2026-01-24', '2030-01-01', 'Disponible', 269, 5.00, 0.43, 0.43, 0.43, 0),
(270, '', 'Jeringas de 10ml', 'Insumo', 'Insumo', 'Servimedic', 75, '2026-01-24', '2029-11-01', 'Disponible', 270, 5.00, 0.67, 0.58, 0.58, 10),
(271, '7401104311840', 'Clorfeniramida', 'Clorfeniramida 10mg', 'Ampolla 2ml', 'Servimedic', 20, '2026-01-24', '2029-06-01', 'Disponible', 271, 50.00, 2.42, 2.42, 2.42, 0),
(272, '3664798030556', 'Neo-Melumbrina', 'Metamizol 500mg', 'Ampolla 2ml', 'Servimedic', 60, '2026-01-24', '2026-07-01', 'Disponible', 272, 50.00, 7.76, 7.76, 7.76, 0),
(273, '7707236122188', 'Ceftriaxona', 'Ceftriaxona 1g', 'Vial Polvo', 'Servimedic', 55, '2026-01-24', '2027-02-01', 'Disponible', 273, 100.00, 8.86, 8.86, 8.86, 0),
(274, '7707236125035', 'Meropenem', 'Meropenem 500mg', 'Vial Polvo', 'Servimedic', 10, '2026-01-24', '2028-03-01', 'Disponible', 274, 150.00, 36.80, 36.80, 36.80, 0),
(275, '', 'Esomeprazol', 'Esomeprazol 40mg', 'Vial Polvo', 'Servimedic', 2, '2026-01-24', '2028-05-01', 'Disponible', 275, 80.00, 27.00, 27.00, 27.00, 0),
(276, '7401068500298', 'Bonadiona', 'Vitamian K 10MG', 'Ampolla 1ml', 'Servimedic', 2, '2026-01-24', '2026-04-01', 'Disponible', 276, 50.00, 10.35, 10.35, 10.35, 0),
(277, '746052793537', 'Scrophulae-Gastru Rekin 17 (10 amp. 2.0ml)', 'acidum lactium D4 0.2g,', 'caja', 'Servimedic', 1, '2026-01-31', '2028-09-01', 'Disponible', 405, 300.00, 91.89, 0.00, 0.00, 0),
(278, '7707236122478', 'Diclofenaco', 'Diclofenaco 75mg', 'Ampolla 3ml', 'Servimedic', 97, '2026-01-24', '2027-09-01', 'Disponible', 278, 50.00, 2.07, 2.07, 2.07, 3),
(279, '', 'Nauseol', 'Dimehidrato 50mg', 'Ampolla 1ml', 'Servimedic', 49, '2026-01-24', '2029-07-01', 'Disponible', 279, 50.00, 7.95, 7.95, 7.95, 0),
(280, '7707236125158', 'Furosemida', 'Furosemida 20mg', 'Ampolla 2ml', 'Servimedic', 200, '2026-01-24', '2028-08-01', 'Disponible', 280, 50.00, 1.73, 1.73, 1.73, 0),
(281, '7707236124786', 'Amikacina', 'Amikacina 500mg', 'Ampolla 2ml', 'Servimedic', 40, '2026-01-24', '2028-02-05', 'Disponible', 281, 80.00, 6.44, 5.40, 5.40, 0),
(282, '723860412256', 'Sello Heparina', 'Insumo', 'Insumo', 'Servimedic', 212, '2026-01-24', '2029-01-01', 'Disponible', 282, 10.00, 1.55, 1.55, 1.55, 2);
INSERT INTO `inventario` (`id_inventario`, `codigo_barras`, `nom_medicamento`, `mol_medicamento`, `presentacion_med`, `casa_farmaceutica`, `cantidad_med`, `fecha_adquisicion`, `fecha_vencimiento`, `estado`, `id_purchase_item`, `precio_venta`, `precio_compra`, `precio_hospital`, `precio_medico`, `stock_hospital`) VALUES
(283, '723860412256', 'Guantes descartables', 'Talla M', 'Magica', 'Servimedic', 5, '2026-01-24', '2027-01-01', 'Disponible', 283, 75.00, 46.00, 0.00, 0.00, 0),
(284, '746052793537', 'colintest-Gastru Rekin 37 (10 amp. 2.0ml)', 'Alumina D12 0.2g, bryonia D4 0.2g', 'caja', 'Servimedic', 1, '2026-01-31', '2028-10-01', 'Disponible', 406, 300.00, 91.89, 0.00, 0.00, 0),
(285, '01075001421012291728122610L4236848', 'Nylon #3-0', '3-0', 'Atramat', 'Servimedic', 50, '2026-01-24', '2028-12-01', 'Disponible', 285, 50.00, 21.60, 0.00, 0.00, 0),
(286, '7401004071271', 'Micropore 1/2', 'color blanco', 'Nexcare', 'Servimedic', 11, '2026-01-24', '2029-12-01', 'Disponible', 286, 12.00, 9.60, 0.00, 0.00, 0),
(287, '3664798030556', 'Bisturi #15', 'Insumo', 'Sterile', 'Servimedic', 55, '2026-01-24', '2027-07-01', 'Disponible', 287, 25.00, 18.00, 18.00, 18.00, 0),
(288, '01008113820155951727043010K1593', 'Blood Lancets', 'Lancetas via med', '100 piezas', 'Servimedic', 6, '2026-01-24', '2027-04-01', 'Disponible', 288, 60.00, 30.00, 0.00, 0.00, 0),
(289, '4015630067084', 'Accu-chek', 'tiras para glucometro', '50 piexas', 'Servimedic', 4, '2026-01-24', '2026-07-01', 'Disponible', 289, 150.00, 90.00, 0.00, 0.00, 0),
(290, '7401235818669', 'Sonda Alimentacion #12', 'sondas', '#12', 'Servimedic', 9, '2026-01-24', '2027-01-01', 'Disponible', 290, 0.00, 0.00, 0.00, 0.00, 0),
(291, '', 'Bolsa recolectora orina', 'Adulto', 'de cama', 'Servimedic', 10, '2026-01-24', '2028-10-01', 'Disponible', 291, 30.00, 8.90, 0.00, 0.00, 0),
(292, '7707236126797', 'Micropore 1p', 'Insumo', 'color blanco', 'Servimedic', 24, '2026-01-24', '2029-08-01', 'Disponible', 292, 15.00, 9.60, 0.00, 0.00, 0),
(293, '524015', 'Micropore 2p', 'Insumo', 'color blanco', 'Servimedic', 12, '2026-01-24', '2029-09-01', 'Disponible', 293, 20.00, 9.60, 0.00, 0.00, 0),
(294, '', 'Mascarillas para nebulizar', 'Insumo', 'neonatal', 'Servimedic', 2, '2026-01-24', '2028-05-01', 'Disponible', 294, 50.00, 25.00, 0.00, 0.00, 0),
(295, '', 'Venda 4*10 yds', 'Venda de Gasa', 'descartable', 'Servimedic', 12, '2026-01-31', '2030-05-01', 'Disponible', 391, 0.10, 0.10, 0.00, 0.00, 0),
(296, '', 'Venda 6*10 yds', 'Venda de Gasa', 'descartable', 'Servimedic', 12, '2026-01-31', '2030-10-01', 'Disponible', 392, 0.10, 0.10, 0.00, 0.00, 0),
(297, '7401235818669', 'Sonda alimentacion #5', 'Insumo', 'Operson', 'Servimedic', 5, '2026-01-24', '2027-12-01', 'Disponible', 297, 0.00, 0.00, 0.00, 0.00, 0),
(298, '7401235818669', 'Sonda alimentacion #8', 'Insumo', 'Operson', 'Servimedic', 3, '2026-01-24', '2028-07-01', 'Disponible', 298, 0.00, 0.00, 0.00, 0.00, 0),
(299, '', 'Bolsa recolectora orina', 'Sterile', 'Pediatrico', 'Servimedic', 31, '2026-01-24', '2030-12-01', 'Disponible', 299, 15.00, 1.80, 0.00, 0.00, 0),
(300, '7401235818669', 'Canula Binasal', 'Insumo', 'Adulto', 'Servimedic', 5, '2026-01-24', '2027-01-01', 'Disponible', 300, 50.00, 9.20, 0.00, 0.00, 0),
(301, '', 'Venoset', 'Insumo', 'Greetmed', 'Servimedic', 71, '2026-01-24', '2027-10-01', 'Disponible', 301, 15.00, 6.90, 0.00, 0.00, 5),
(302, '8904240100013', 'Solucion Glucosa 250ml', 'glucosa, agua', 'frasco de 250ml', 'Servimedic', 24, '2026-01-22', '2026-05-01', 'Disponible', 302, 40.00, 0.00, 0.00, 0.00, 0),
(303, '8904240100228', 'Solucion Salina 500ml', 'Cloruro de sodio', 'Frasco 500ml', 'Servimedic', 22, '2026-01-22', '2027-02-01', 'Disponible', 303, 35.00, 10.93, 0.00, 0.00, 2),
(304, '7501125189289', 'Solucion Mixto 500ml', 'clorhuro de sodio + glucosa', 'frasco 500ml', 'Servimedic', 24, '2026-01-22', '2027-02-01', 'Disponible', 304, 35.00, 12.01, 0.00, 0.00, 0),
(305, '8904240100327', 'Solucion Hartman 1000ml', 'hartman', 'frasco 1000ml', 'Servimedic', 7, '2026-01-22', '2027-03-01', 'Disponible', 305, 45.00, 11.04, 0.00, 0.00, 4),
(306, '8904240100198', 'Solucion Salino 100ml', 'Cloruro de sodio', 'Frasco de 100ml', 'Servimedic', 114, '2026-01-24', '2027-09-01', 'Disponible', 306, 25.00, 7.76, 0.00, 0.00, 1),
(307, '7501125110764', 'Agua esteril 500ml', 'agua esteril', 'frasco 500ml', 'Servimedic', 3, '2026-01-24', '2028-08-01', 'Disponible', 307, 50.00, 11.27, 0.00, 0.00, 0),
(308, '7501125110764', 'Especulo vaginal', 'descartable', 'Talla S', 'Servimedic', 10, '2026-01-24', '2029-11-01', 'Disponible', 308, 35.00, 0.00, 0.00, 0.00, 0),
(309, '7501125110764', 'Especulo vaginal', 'descartable', 'Talla M', 'Servimedic', 10, '2026-01-24', '2030-08-01', 'Disponible', 309, 35.00, 0.00, 0.00, 0.00, 0),
(310, '7501125110764', 'Especulo Vaginal', 'descartable', 'Talla L', 'Servimedic', 10, '2026-01-24', '2028-04-01', 'Disponible', 310, 35.00, 0.00, 0.00, 0.00, 0),
(311, '', 'sucragel 240ml', 'sucralfato', 'suspensión oral', 'Servimedic', 0, '2026-01-22', '2026-10-01', 'Disponible', 176, 105.00, 80.50, 0.00, 0.00, 0),
(312, '', 'Airessa compuesta', 'bromuro de clidineo 5mg/ dimetilpolisiloxano 150mg', '10 cápsulas', 'Servimedic', 0, '2026-01-26', '2026-12-01', 'Disponible', 162, 55.00, 0.00, 0.00, 0.00, 0),
(313, '', 'Sonda alimentacion #8', 'Insumo', 'Operson', 'Servimedic', 1, '2026-01-26', '2028-07-01', 'Disponible', 298, 11.27, 0.00, 0.00, 0.00, 0),
(314, '7501125171567', 'Suero Hidravida', 'sabor coco', 'suero oral', 'Servimedic', 12, '2026-01-26', '2027-07-01', 'Disponible', 243, 18.00, 14.30, 0.00, 0.00, 0),
(315, '7401094612880', 'Budoxigen 0.5ml', 'budesonida micronizada 0.5mg/ml', '5 viales  p/ nebulizar', 'Servimedic', 0, '2026-01-22', '2027-09-01', 'Disponible', 160, 170.00, 90.93, 0.00, 0.00, 0),
(316, '7401117100134', 'Clidipox 5mg/2.5mg', 'clordiazepoxido HCI 5mg, bromuro de clidinio 2.5mg', '20 Tabletas', 'Servimedic', 0, '2026-01-22', '2027-07-01', 'Disponible', 163, 65.00, 35.36, 0.00, 0.00, 0),
(317, '7401181200068', 'Goldkaps', 'minerales, gingseng', '30 capsulas', 'Servimedic', 3, '2026-01-28', '2026-05-01', 'Disponible', 317, 125.00, 0.00, 0.00, 0.00, 0),
(318, '7401181200068', 'Goldkaps', 'minerales, gingseng', '30 capsulas', 'Servimedic', 3, '2026-01-28', '2026-05-01', 'Disponible', 317, 125.00, 0.00, 0.00, 0.00, 0),
(319, '7501125102950', 'Tracefusin 20ml', 'cloruro de zinc, sulfato cuprico', 'fraco/inyectable', 'Servimedic', 5, '2026-01-28', '2027-05-01', 'Disponible', 319, 150.00, 100.00, 0.00, 0.00, 1),
(320, '2019001006', 'Trinara 30ml', 'trinara', 'gotas orales', 'Servimedic', 0, '2026-01-28', '2026-09-01', 'Disponible', 320, 95.00, 0.00, 0.00, 0.00, 0),
(321, '7401094610800', 'Uritam D', 'dutasterida 0.5+ tamsulosina clorhidrato 0.4mg', '30 capsulas', 'Servimedic', 4, '2026-01-28', '2028-03-01', 'Disponible', 321, 600.00, 0.00, 0.00, 0.00, 0),
(322, '7441031500955', 'Tioflex 10ml', 'diclofenaco potasico 50mg, tiocolchicosico 4mg', 'sobres bebibles 10ml', 'Servimedic', 50, '2026-01-28', '2026-08-01', 'Disponible', 322, 25.00, 0.00, 0.00, 0.00, 0),
(323, '6210010720193', 'Sinervit', 'Tiamina, piridoxina, cianocobalamina, diclofenaco', '30 capsulas', 'Servimedic', 1, '2026-01-28', '2026-11-01', 'Disponible', 233, 190.00, 90.00, 0.00, 0.00, 0),
(324, '7401181200044', 'Dige-Kaps', 'pancreatina, simeticona, papaina extracto', '30 capsulas', 'Servimedic', 3, '2026-01-28', '2028-05-01', 'Disponible', 324, 155.00, 0.00, 0.00, 0.00, 0),
(325, '765446471073', 'Aciclovirax 120ml', 'Aciclovir pediatrico', 'Suspension 120ml', 'Servimedic', 5, '2026-01-16', '2027-11-01', 'Disponible', 120, 200.00, 0.00, 0.00, 0.00, 0),
(326, '7410001010817', 'Rodiflux 25ml.', 'Dextrometorfan, carboximetilcisteina, clorfeniramina', 'Gotero', 'Servimedic', 4, '2026-01-16', '2027-05-01', 'Disponible', 113, 110.00, 0.00, 0.00, 0.00, 0),
(327, '', 'Lisinox 20ml.', 'Propinoxato clorhidrato 5mg/ml', 'Gota  ora 20ml', 'Servimedic', 5, '2026-01-16', '2027-03-01', 'Disponible', 327, 80.00, 0.00, 0.00, 0.00, 0),
(328, '7401018115206', 'Rinofed 120ml', 'clorfeniramida, fenilefrina, codeina', 'Jarabe', 'Servimedic', 5, '2026-01-28', '2027-02-01', 'Disponible', 166, 115.00, 0.00, 0.00, 0.00, 0),
(329, '7796285051501', 'ovumix', 'metronidazol, sulfato neomicina, centella asiatica', 'ovulos vaginales', 'Servimedic', 1, '2026-01-28', '2027-10-01', 'Disponible', 181, 260.00, 198.10, 0.00, 0.00, 0),
(330, '7401133901005', 'Ulcrux 1g/5ml', 'Sucralfato 1g', '30 Sobres', 'Servimedic', 0, '2026-01-22', '2027-05-01', 'Disponible', 174, 140.00, 93.07, 0.00, 0.00, 0),
(331, '7401187700050', 'Ardix 25mg', 'dexketoprofeno 25mg', '10 Tabletas', 'Servimedic', 5, '2026-01-16', '2027-02-01', 'Disponible', 129, 95.00, 0.00, 0.00, 0.00, 0),
(332, '2350735122071', 'Bucaglu 30ml.', 'ruibarbo y acido salicilico', 'Tintura Oral', 'Servimedic', 3, '2026-01-16', '2026-05-01', 'Disponible', 109, 130.00, 0.00, 0.00, 0.00, 0),
(333, '7401181200068', 'Goldkaps', 'minerales, gingseng', '30 capsulas', 'Servimedic', 10, '2026-01-30', '2026-06-01', 'Disponible', 317, 125.00, 0.00, 0.00, 0.00, 0),
(334, '7401094603369', 'Acla-Med Bid 400mg', 'Amoxicilina+acido clavulanico', 'Suspension', 'Servimedic', 0, '2026-01-28', '2027-08-01', 'Disponible', 71, 125.00, 0.00, 0.00, 0.00, 0),
(335, '7707236128593', 'Metilprednisolona', 'Metilprednisolona 500mg', 'frasco inyectable', 'Servimedic', 6, '2026-01-28', '2027-12-01', 'Disponible', 335, 250.00, 65.00, 0.00, 0.00, 1),
(336, '', 'Lanzopral Heli-Pack', 'amoxicilina, clarotromicina, lanzoprazol', 'Tabletas 14 dias', 'Servimedic', 0, '2026-01-28', '2027-11-09', 'Disponible', 336, 800.00, 0.00, 0.00, 0.00, 0),
(337, '2019001006', 'Trinara 30ml', 'trinara', 'gotas orales', 'Servimedic', 5, '2026-01-28', '2026-09-01', 'Disponible', 320, 100.00, 0.00, 0.00, 0.00, 0),
(338, '', 'guate 4*4yds', 'relleno ortopedico (guata)', 'descartable', 'Servimedic', 12, '2026-01-31', '2030-09-01', 'Disponible', 412, 20.00, 11.76, 0.00, 0.00, 0),
(339, '', 'Guate 6*4yds', 'relleno ortopedico (guata)', 'descartable', 'Servimedic', 12, '2026-01-31', '2030-08-01', 'Disponible', 413, 25.00, 8.80, 0.00, 0.00, 0),
(340, '7441041700109', 'conflexil 4mg', 'tiocolchicosido', 'ampolla', 'muestras medicas', 1, '2026-01-29', '2027-10-01', 'Disponible', 340, 35.00, 0.01, 0.00, 0.00, 0),
(341, '7441041701816', 'neural 25000', 'vitaminas B1, B6, B12', 'ampollas', 'muestras medicas', 4, '2026-01-29', '2027-07-01', 'Disponible', 341, 80.00, 0.00, 0.00, 0.00, 0),
(342, '', 'sucragel 240ml', 'sucralfato', 'suspensión oral', 'Servimedic', 4, '2026-01-30', '2026-10-01', 'Disponible', 176, 105.00, 0.00, 0.00, 0.00, 0),
(343, '7441041700628', 'valerpan 1ml', 'dipropinato de debetametasona', 'ampolla', 'muestras medicas', 2, '2026-01-29', '2028-01-01', 'Disponible', 343, 180.00, 0.01, 0.00, 0.00, 0),
(344, '7401021630116', 'Deka-C Adultos', 'vitaminas A, D, E y C', '2 Ampollas bebibles 5ml', 'Servimedic', 1, '2026-01-16', '2027-12-01', 'Disponible', 344, 75.00, 0.00, 0.00, 0.00, 0),
(345, '7401078930382', 'Deflarin 6mg', 'Deflazacort', '10 Comprimidos', 'Servimedic', 5, '2026-01-29', '2026-04-01', 'Disponible', 73, 135.00, 0.00, 0.00, 0.00, 0),
(346, '7410003426043', 'Pharmesemid 40mg', 'furisemida, diuréco', '30 Tabletas', 'Servimedic', 6, '2026-01-29', '2026-08-01', 'Disponible', 346, 80.00, 0.00, 0.00, 0.00, 0),
(347, '', 'Batas descartables', 'batas', 'azules', 'Servimedic', 80, '2026-01-29', '2029-12-01', 'Disponible', 347, 35.00, 14.40, 14.40, 14.40, 0),
(348, '', 'Clevium', 'Desketoprofeno 50mg/2ml', 'Ampolla', 'Servimedic', 6, '2026-01-29', '2029-04-01', 'Disponible', 348, 50.00, 5.17, 0.00, 0.00, 3),
(349, '7401094612880', 'Budoxigen 0.5ml', 'budesonida micronizada 0.5mg/ml', '5 viales p/ nebulizar', 'Servimedic', 4, '2026-01-27', '2027-09-01', 'Disponible', 315, 170.00, 0.00, 0.00, 0.00, 0),
(350, '7401094609828', 'Sitalev Met 50/1000mg ', 'Sitagliptina 50mg* metformina clorhidrato 1000mg', '30 Tabletas recubiertas', 'Servimedic', 10, '2026-01-29', '2027-11-01', 'Disponible', 350, 225.00, 154.10, 0.00, 0.00, 0),
(351, '7410031491679', 'Celedexa 0.25mg/2mg', 'Betametazona 0.25mg+Dexclorfeniramina maleato 2mg', '10 tabletas', 'Servimedic', 10, '2026-01-29', '2027-03-01', 'Disponible', 351, 60.00, 165.60, 0.00, 0.00, 0),
(352, '7401117100134', 'Clidipox 5mg/2.5mg', 'clordiazepoxido HCI 5mg, bromuro de clidinio 2.5mg', '20 Tabletas', 'Servimedic', 3, '2026-01-27', '2027-07-01', 'Disponible', 163, 65.00, 0.00, 0.00, 0.00, 0),
(353, '7410031491914', 'Virokem 120ml', 'Amentadina HCI+ Clorfeniramina maleato+ acetaminofen+ Fenilefrina HCI', 'Jarabe 120ml', 'Servimedic', 4, '2026-01-29', '2027-09-01', 'Disponible', 353, 110.00, 0.00, 0.00, 0.00, 0),
(354, '7410031491990', 'Histakem Block 30ml.', 'Cloruro de cetilpiridinio 0.05g+benzocaina 1.0g', 'Spray bucal 30ml', 'Servimedic', 0, '2026-01-16', '2027-05-01', 'Disponible', 137, 125.00, 0.00, 0.00, 0.00, 0),
(355, '7410031491624', 'Virokem', 'Amentadina HCI+ Clorfeniramina maleato+ acetaminofen+ Fenilefrina HCI', '10 capsulas', 'Servimedic', 10, '2026-01-29', '2027-03-01', 'Disponible', 355, 65.00, 28.44, 0.00, 0.00, 0),
(356, '7460840419494', 'Triamin CB', 'Vitamina D3 100000 UI', 'Capsula', 'Servimedic', 11, '2026-01-29', '2028-02-01', 'Disponible', 356, 390.00, 0.00, 0.00, 0.00, 0),
(357, '765446471073', 'Aciclovirax 120ml', 'Aciclovir pediatrico', 'Suspension 120ml', 'Servimedic', 0, '2026-01-30', '2027-11-01', 'Disponible', 120, 200.00, 0.00, 0.00, 0.00, 0),
(358, '7460347607783', 'Quimida 30ml', 'Quinfamida 50mg/5ml', 'Suspension oral', 'Servimedic', 5, '2026-01-29', '2028-05-01', 'Disponible', 358, 75.00, 0.10, 0.00, 0.00, 0),
(359, '7460347609565', 'Espasmex Forte', 'Propixonato HCI 20mg + Clonixinato de linasa 125mg', '10 COmprimidos', 'Servimedic', 5, '2026-01-29', '2027-08-10', 'Disponible', 359, 80.00, 73.60, 0.00, 0.00, 0),
(360, '7410031491525', 'Medibriz Pediatrico 10ml', 'Mebensazol 60mg+ Quindamida 10mg', 'Suspensio oral', 'Servimedic', 6, '2026-01-29', '2027-04-01', 'Disponible', 360, 110.00, 0.00, 0.00, 0.00, 0),
(361, '7410031491532', 'Medibriz Infantil 10ml', 'Mebensazol 60mg+ Quindamida 20mg', 'Suspension Oral', 'Servimedic', 6, '2026-01-29', '2027-05-01', 'Disponible', 361, 110.00, 0.00, 0.00, 0.00, 0),
(362, '7410031492485', 'Tradol 10ml', 'Tramadol HCI 100mg/ml', 'Gotas Orales', 'Servimedic', 5, '2026-01-29', '2027-03-01', 'Disponible', 362, 170.00, 86.40, 0.00, 0.00, 0),
(363, '', 'Especulo Vaginal', 'descartable', 'Talla L', 'Servimedic', 10, '2026-01-30', '2030-05-01', 'Disponible', 310, 35.00, 0.00, 0.00, 0.00, 0),
(364, '', 'Especulo Vaginal', 'descartable', 'Talla M', 'Servimedic', 10, '2026-01-30', '2030-05-01', 'Disponible', 309, 35.00, 0.00, 0.00, 0.00, 0),
(365, '', 'Especulo Vaginal', 'descartable', 'Talla S', 'Servimedic', 10, '2026-01-30', '2029-11-01', 'Disponible', 308, 35.00, 0.00, 0.00, 0.00, 0),
(366, '7410001010817', 'Rodiflux 25ml.', 'Dextrometorfan, carboximetilcisteina, clorfeniramina', 'Gotero', 'Servimedic', 2, '2026-01-28', '2027-05-01', 'Disponible', 113, 110.00, 0.00, 0.00, 0.00, 0),
(367, '', 'Lisinox 20ml.', 'Propinoxato clorhidrato 5mg/ml', 'Gota  ora 20ml', 'Servimedic', 1, '2026-01-28', '2027-03-01', 'Disponible', 327, 80.00, 0.00, 0.00, 0.00, 0),
(368, '7401133901005', 'Ulcrux 1g/5ml', 'Sucralfato 1g', '30 Sobres', 'Servimedic', 2, '2026-01-28', '2027-05-01', 'Disponible', 174, 140.00, 0.00, 0.00, 0.00, 0),
(369, '', 'Parenten', 'Diazepoam 10mg', 'Ampolla 2ml', 'Servimedic', 9, '2026-01-30', '2027-04-01', 'Disponible', 268, 100.00, 11.50, 0.00, 0.00, 0),
(370, '7401187700050', 'Ardix 25mg', 'dexketoprofeno 25mg', '10 Tabletas', 'Servimedic', 1, '2026-01-28', '2027-02-01', 'Disponible', 129, 95.00, 0.00, 0.00, 0.00, 0),
(371, '', 'Haloperidol', 'haloperidol 5mg/ml', 'ampolla 1ml', 'Servimedic', 5, '2026-01-30', '2027-06-01', 'Disponible', 371, 150.00, 43.41, 0.00, 0.00, 0),
(372, '765446471073', 'Aciclovirax 120ml', 'Aciclovir pediatrico', 'Suspension 120ml', 'Servimedic', 1, '2026-01-28', '2027-11-01', 'Disponible', 120, 200.00, 0.00, 0.00, 0.00, 0),
(373, '8429007048068', 'Dermapunt', 'descartables', 'micro-agujas dermaticas', 'Servimedic', 11, '2026-01-30', '2028-03-01', 'Disponible', 373, 0.01, 0.01, 0.00, 0.00, 0),
(374, '7460347608292', 'Deflamol 6mg', 'Deflazacort', '10 comprimidos', 'Servimedic', 4, '2026-01-30', '2028-03-01', 'Disponible', 374, 125.00, 111.96, 0.00, 0.00, 0),
(375, '2350735122071', 'Bucaglu 30ml.', 'ruibarbo y acido salicilico', 'Tintura Oral', 'Servimedic', 2, '2026-01-28', '2026-05-01', 'Disponible', 109, 130.00, 0.00, 0.00, 0.00, 0),
(376, '', 'Tetravit forte 25000', 'neurotropas', 'Ampolla', 'muestras medicas', 1, '2026-01-30', '2026-10-01', 'Disponible', 376, 50.00, 0.01, 0.00, 0.00, 1),
(377, '7410031491990', 'Histakem Block 30ml.', 'Cloruro de cetilpiridinio 0.05g+benzocaina 1.0g', 'Spray bucal 30ml', 'Servimedic', 12, '2026-01-29', '2027-07-01', 'Disponible', 137, 125.00, 84.70, 0.00, 0.00, 0),
(378, '', 'Steri-strip', '10*6mm*100mm', 'descartable', 'Servimedic', 2, '2026-01-30', '2029-03-01', 'Disponible', 378, 0.10, 0.00, 0.00, 0.00, 0),
(379, '', 'Tegaderm', '10*12cm', 'descartable', 'Servimedic', 2, '2026-01-30', '2026-07-01', 'Disponible', 379, 70.00, 44.70, 0.00, 0.00, 0),
(380, '', 'Tegaderm', '15*20cm', 'descartable', 'Servimedic', 4, '2026-01-30', '2026-08-01', 'Disponible', 379, 90.00, 44.70, 0.00, 0.00, 0),
(381, '', 'sucragel 240ml', 'sucralfato', 'suspensión oral', 'Servimedic', 4, '2026-01-24', '2026-10-01', 'Disponible', 176, 105.00, 0.00, 0.00, 0.00, 0),
(382, '7401021630116', 'Deka-C Adultos', 'vitaminas A, D, E y C', '2 Ampollas bebibles 5ml', 'Servimedic', 2, '2026-01-29', '2027-12-01', 'Disponible', 344, 75.00, 0.00, 0.00, 0.00, 0),
(383, '7406280000311', 'Hepamob', 'Cilimarina+complejo b', '30 Comprimidos', 'Servimedic', 3, '2026-01-30', '2026-05-01', 'Disponible', 206, 150.00, 0.00, 0.00, 0.00, 0),
(384, '7410031491815', 'Esomeprakem', 'Esomeprazol 40mg/levofloxacina 500mg/amoxicilina 500mg', '10 Capsulas', 'Servimedic', 10, '2026-01-30', '2026-06-01', 'Disponible', 238, 70.00, 0.00, 0.00, 0.00, 0),
(385, '746052793537', 'Recharje Plus', 'Coenzima Q10 con vitamina y minerales', '30 capsulas', 'Servimedic', 15, '2026-01-28', '2026-06-01', 'Disponible', 385, 170.00, 132.00, 0.00, 0.00, 0),
(386, '7840199555201', 'Unocef 120ml', 'Cefixima 100mg/5ml', 'Suspension oral', 'Servimedic', 1, '2026-01-28', '2026-03-01', 'Disponible', 386, 280.00, 226.58, 0.00, 0.00, 0),
(387, '7840199555201', 'Kitadol 20mg', 'ketorolaco trometamina 20mg', '20 comprimidos', 'Servimedic', 4, '2026-01-28', '2026-05-01', 'Disponible', 387, 185.00, 129.60, 0.00, 0.00, 0),
(388, '', 'AcneVit', 'Vitamina C+niacinamida+ectracto de centella Asiatica', 'Gel limpiador', 'Servimedic', 0, '2026-01-31', '2029-10-01', 'Disponible', 388, 145.00, 118.73, 0.00, 0.00, 0),
(389, '', 'Hydratonic Bamboo', 'Extracto de limon, naranja, caña de azucar y arce', 'Tonico facial', 'Servimedic', 0, '2026-01-31', '2029-09-01', 'Disponible', 389, 200.00, 130.00, 0.00, 0.00, 0),
(390, '', 'Aquabalance cream 50ml', 'rosa mosqueta,sodiu hyaluronate', 'crena hidratante', 'Servimedic', 1, '2026-01-31', '2027-03-01', 'Disponible', 390, 620.00, 476.10, 476.10, 476.10, 0),
(391, '7410031491990', 'Histakem Block 30ml.', 'Cloruro de cetilpiridinio 0.05g+benzocaina 1.0g', 'Spray bucal 30ml', 'Servimedic', 2, '2026-01-30', '2027-07-01', 'Disponible', 137, 125.00, 0.00, 0.00, 0.00, 0),
(392, '7410031492515', 'Fenobrox  240ml', 'Cloperastina', 'suspensión oral', 'Servimedic', 1, '2026-02-02', '2026-10-01', 'Disponible', 393, 110.00, 0.00, 0.00, 0.00, 0),
(393, '', 'hidralazina', 'hidralazina', 'ampolla', 'Servimedic', 0, '2026-02-03', '2027-12-01', 'Disponible', 394, 150.00, 0.00, 0.00, 0.00, 0),
(395, '7441041700468', 'Disolflem 200mg', 'acetilcisteina', '10 sobre', 'servimedic', 5, '2026-02-04', '2027-08-01', 'Disponible', 396, 105.00, 0.00, 0.00, 0.00, 0),
(396, '7441041700536', 'Disolflem 600mg', 'Acetilcisteina', '10 sticks', 'servimedic', 10, '2026-02-04', '2027-08-01', 'Disponible', 397, 135.00, 64.42, 0.00, 0.00, 0),
(397, '7441041803145', 'Dalivium 50mg', 'Dexketoprofeno', 'ampolla', 'servimedic', 49, '2026-02-04', '2028-01-01', 'Disponible', 398, 50.00, 9.41, 0.00, 0.00, 0),
(398, '7441041700116', 'Conflexil 4mg/2ml', 'Tiocolchicosido', 'ampolla 4mg/2ml', 'servimedic', 25, '2026-02-04', '2027-08-01', 'Disponible', 399, 35.00, 23.22, 0.00, 0.00, 0),
(399, '7401158300425', 'Monoflocet 1g/500mg', 'ceftriaxona +sulbactam', 'Frasco Inyectable', 'servimedic', 30, '2026-02-04', '2027-09-01', 'Disponible', 400, 130.00, 0.00, 0.00, 0.00, 0),
(400, '7401158300173', 'Demelan', 'Nitazoxanida', 'Tabletas 500mg', 'servimedic', 18, '2026-02-04', '2027-05-01', 'Disponible', 401, 90.00, 0.00, 0.00, 0.00, 0),
(401, '7401158300180', 'Demelan Pediatrico', 'Nitazoxanida', 'Suspension polvo', 'servimedic', 9, '2026-02-04', '2028-05-01', 'Disponible', 402, 85.00, 0.00, 0.00, 0.00, 0),
(402, '7401158300142', 'Idealift', 'liposomas,acido,poligalacturonico', 'crema', 'servimedic', 6, '2026-02-04', '2027-10-01', 'Disponible', 403, 130.00, 0.00, 0.00, 0.00, 0),
(408, '7401158300005', 'Nopioxx', 'calendula,manzanilla, centella', 'Crema', 'servimedic', 8, '2026-02-04', '2027-02-01', 'Disponible', 409, 80.00, 0.00, 0.00, 0.00, 0),
(409, '7401158300081', 'Lixone-Fem', 'acido hialuronico,melaleuca', 'Gel intimo', 'servimedic', 5, '2026-02-04', '2027-06-01', 'Disponible', 410, 170.00, 0.00, 0.00, 0.00, 0),
(410, '7401158300067', 'Lixone -pediatrico', 'Betainas,extracto de bardana', 'Gel', 'servimedic', 3, '2026-02-04', '2027-08-01', 'Disponible', 411, 165.00, 0.00, 0.00, 0.00, 0),
(411, '7401158300104', 'Dermodian Baby', 'Oxido de zinc,vitamina E, melaleuca', 'Crema', 'servimedic', 6, '2026-02-04', '2027-06-01', 'Disponible', 412, 70.00, 0.00, 0.00, 0.00, 0),
(412, '4348130720198', 'Catlizeg', 'enzimas digestivas con dimetilpoli', '30 Capsulas', 'servimedic', 3, '2026-02-04', '2027-05-01', 'Disponible', 413, 115.00, 0.00, 0.00, 0.00, 0),
(413, '', 'Previtpro', 'semilla de calabaza', '30 Capsulas', 'servimedic', 3, '2026-02-04', '2027-09-01', 'Disponible', 414, 200.00, 125.82, 0.00, 0.00, 0),
(414, '5578901012019', 'Viprena', 'vitamina D,A,E,B1,B2,B3', '30 Capsulas', 'servimedic', 6, '2026-02-04', '2027-06-01', 'Disponible', 415, 130.00, 0.00, 0.00, 0.00, 0),
(415, '2889811020227', 'Higaprof Plus', 'Acidos Grasos,vitamina E,B12,B6', '30 Sobres', 'servimedic', 7, '2026-02-04', '2027-12-01', 'Disponible', 416, 260.00, 0.00, 0.00, 0.00, 0),
(416, '7401117100042', 'Cefaxil', 'cefadroxilo100mg/ml', 'Suspension en polvo', 'servimedic', 7, '2026-02-04', '2027-03-01', 'Disponible', 417, 65.00, 0.00, 0.00, 0.00, 0),
(417, '706020226665', 'Kralvir-us 800', 'Aciclovir', '10 Tabletas', 'servimedic', 28, '2026-02-04', '2027-10-01', 'Disponible', 418, 285.00, 0.00, 0.00, 0.00, 0),
(418, '', 'Bru-sone 2ml', 'betametasona', 'Ampolla', 'servimedic', 30, '2026-02-04', '2027-06-01', 'Disponible', 419, 190.00, 0.00, 0.00, 0.00, 0),
(419, '', 'Meloxicam,Sulfato de glucosamina', 'meloxicam +glucosamina', '30 Sobres', 'servimedic', 5, '2026-02-04', '2027-08-01', 'Disponible', 420, 250.00, 0.00, 0.00, 0.00, 0),
(420, '2350735122061', 'Besart', 'magnesio, extracto de ginkgo', '30 Capsulas', 'servimedic', 6, '2026-02-04', '2027-11-01', 'Disponible', 421, 255.00, 0.00, 0.00, 0.00, 0),
(421, '2350735122011', 'Logenol', 'etoricoxib 90mg', '10 Capsulas', 'servimedic', 10, '2026-02-04', '2028-01-01', 'Disponible', 422, 165.00, 0.00, 0.00, 0.00, 0),
(422, '8429007062750', 'Inmuno Biter', 'calactoferrina,extracto de glicerinado', 'Ampollas bebibles', 'servimedic', 2, '2026-02-06', '2027-10-01', 'Disponible', 423, 390.00, 0.00, 0.00, 0.00, 0),
(423, '', 'Jeringa 5ml', '', 'descartable', 'servimedic', 6, '2026-02-06', '2026-12-01', 'Disponible', 424, 5.00, 0.00, 0.00, 0.00, 0),
(424, '', 'Venoset', '', 'descartable', 'servimedic', 100, '2026-02-06', '2029-07-01', 'Disponible', 425, 15.00, 0.00, 0.00, 0.00, 0),
(425, '', 'Angiocath #22', '', 'descartable', 'servimedic', 100, '2026-02-06', '2029-10-01', 'Disponible', 426, 15.00, 0.00, 0.00, 0.00, 0),
(426, '', 'Angiocath #20', '', 'descartable', 'servimedic', 50, '2026-02-06', '2030-04-01', 'Disponible', 427, 15.00, 0.00, 0.00, 0.00, 0),
(432, '', 'Angiocath #24', '', 'descartable', 'servimedic', 135, '2026-02-06', '2028-09-01', 'Disponible', 433, 15.00, 0.00, 0.00, 0.00, 0),
(433, '7401108841268', 'Cefina 100ml', 'cefixima', 'suspension en polvo', 'servimedic', 1, '2026-02-06', '2027-04-01', 'Disponible', 434, 220.00, 108.00, 0.00, 0.00, 0),
(434, '4250632503806', 'Tonico Alfalfa', 'tonico alfalfa', 'suspension', 'servimedic', 2, '2026-02-06', '2029-05-01', 'Disponible', 435, 210.00, 125.88, 0.00, 0.00, 0),
(435, '', 'Jeringa 10ml', '', 'descartable', 'servimedic', 44, '2026-02-06', '2028-04-01', 'Disponible', 436, 5.00, 0.00, 0.00, 0.00, 0),
(436, '', 'Jeringa 3ml', '', 'descartable', 'servimedic', 115, '2026-02-06', '2028-04-01', 'Disponible', 437, 5.00, 0.00, 0.00, 0.00, 0),
(437, NULL, 'Bru-Cobal', 'Mecobalamina', 'ampolla 1ml', 'Muestra medica', 2, '2026-02-06', '2026-02-06', 'Pendiente', 438, 65.00, 0.00, 0.00, 0.00, 0),
(438, '', 'Atenua', 'dexketoprofeno 50mg', 'Ampolla', 'Muestra medica', 4, '2026-02-06', '2026-05-01', 'Disponible', 439, 50.00, 0.00, 0.00, 0.00, 0),
(439, '', 'Gluconato de Calcio 10ml', 'Gluconato 10%', 'ampolla', 'servimedic', 2, '2026-02-06', '2027-02-09', 'Disponible', 440, 100.00, 0.00, 0.00, 0.00, 0),
(440, '', 'Lidocaina sin epinefrina', 'lidocaina', 'centimetros', 'servimedic', 47, '2026-02-09', '2028-02-01', 'Disponible', 441, 10.00, 1.75, 0.00, 0.00, 3),
(441, '7401133901005', 'Ulcrux Individuales', 'sucralfato', 'sobres', 'servimedic', 23, '2026-02-09', '2027-05-01', 'Disponible', 442, 10.00, 5.29, 0.00, 0.00, 6),
(442, '', 'Uroprin 3g', 'Sticker granulado', 'Fosfomicina 3g', 'servimedic', 0, '2026-02-09', '2027-10-01', 'Disponible', 443, 165.00, 145.36, 0.00, 0.00, 1),
(443, '1612012026245', 'Clindacrem 2%', 'Clindamicina', 'Tubo 40G+ aplicadores', 'servimedic', 10, '2026-02-10', '2028-05-01', 'Disponible', 444, 200.00, 0.00, 0.00, 0.00, 0),
(444, '1612012026436', 'Sesoral', 'Acido glutamico+ complejo b', 'Viales bebibles 15ml', 'servimedic', 10, '2026-02-10', '2027-11-01', 'Disponible', 445, 220.00, 0.00, 0.00, 0.00, 0),
(445, '', 'Gatrodex', 'Rabeprazol sodico', '28 Tabletas', 'servimedic', 20, '2026-02-10', '2027-05-01', 'Disponible', 446, 390.00, 0.00, 0.00, 0.00, 0),
(446, '', 'Dolosal', 'Petidina', 'Ampolla 100mg/2ml', 'servimedic', 10, '2026-02-10', '2029-01-01', 'Disponible', 447, 150.00, 0.00, 0.00, 0.00, 0),
(447, '8904240120509', 'Nircip', 'Ciprofloxacina', 'Frasco de 100ml', 'servimedic', 3, '2026-02-10', '2027-06-01', 'Disponible', 448, 80.00, 0.00, 0.00, 0.00, 0),
(448, '7796285051501', 'Ovumix', 'Metronidazol/nitrato de miconazol', '6 Ovulos Vaginales', 'servimedic', 7, '2026-02-10', '2028-06-01', 'Disponible', 449, 260.00, 0.00, 0.00, 0.00, 0),
(449, '7795375579000', 'Platsul-A', 'Sulfadiazina de plata+vit A', 'Crema 30 G', 'servimedic', 7, '2026-02-10', '2028-09-01', 'Disponible', 450, 130.00, 0.00, 0.00, 0.00, 0),
(450, '7795375582000', 'Platsul-A', 'Sulfadiazina de plata +vit A', 'Tarro', 'servimedic', 2, '2026-02-10', '2028-05-01', 'Disponible', 451, 850.00, 0.00, 0.00, 0.00, 0),
(451, '7795337862997', 'Total Magnesiano', 'Magnesio', '30 Sobres efervecentes', 'servimedic', 17, '2026-02-10', '2028-01-01', 'Disponible', 452, 230.00, 0.00, 0.00, 0.00, 0),
(452, '7441082118413', 'AB-Digest', 'Lactobacillus pediocuccus', '30 Sticks', 'servimedic', 22, '2026-02-10', '2026-10-01', 'Disponible', 453, 590.00, 0.00, 0.00, 0.00, 0),
(453, '7501070903619', 'Dostein 90ml', 'Erdosteina', 'Suspension 175mg/5ml', 'servimedic', 20, '2026-02-10', '2026-07-01', 'Disponible', 454, 155.00, 0.00, 0.00, 0.00, 0),
(454, '7501070903572', 'Dostein 300mg', 'Erdoateina', '20 Tabletas', 'servimedic', 20, '2026-02-10', '2026-07-01', 'Disponible', 455, 175.00, 0.00, 0.00, 0.00, 0),
(455, '7441041700468', 'Disolflem 200mg', 'Acetilcisteina', '10 sobre granulados', 'servimedic', 6, '2026-02-10', '2027-08-01', 'Disponible', 456, 105.00, 0.00, 0.00, 0.00, 0),
(456, '7441041700536', 'Disolflem 600', 'Aceltisteina', '10 Sticks granuladod', 'servimedic', 5, '2026-02-10', '2027-08-01', 'Disponible', 457, 135.00, 0.00, 0.00, 0.00, 0),
(457, '7441041803145', 'Dalivium', 'dexketoprofeno', 'Ampollas 500mg/ml', 'servimedic', 50, '2026-02-10', '2028-01-01', 'Disponible', 458, 50.00, 0.00, 0.00, 0.00, 0),
(458, '7441041700116', 'Conflexil 4mg/2ml', 'Tiocolchicosico', 'Ampoll 4mg/2ml', 'servimedic', 25, '2026-02-10', '2027-08-01', 'Disponible', 459, 35.00, 23.69, 0.00, 0.00, 0),
(459, '7401133900848', 'Costipak', 'Lactulosa', 'Suspension', 'servimedic', 4, '2026-02-10', '2027-12-01', 'Disponible', 460, 190.00, 0.00, 0.00, 0.00, 0),
(460, '7401158300081', 'Lixone Fem', 'Acido Hialuronico,mellaleuca', 'Gel Intimo', 'servimedic', 2, '2026-02-10', '2027-06-01', 'Disponible', 461, 170.00, 0.00, 0.00, 0.00, 0),
(461, '7401094604687', 'Clevium', 'Dexketoprofeno', 'Ampolla', 'Servimedic', 1, '2026-02-10', '2029-05-01', 'Disponible', 462, 50.00, 0.00, 0.00, 0.00, 0),
(462, '7401094606001', 'Bixicort', 'Betametasona', 'Ampolla', 'Servimedic', 1, '2026-02-10', '2027-10-01', 'Disponible', 463, 150.00, 0.00, 0.00, 0.00, 0),
(463, '8430094303107', 'Nutriben', '800g', 'bote', 'Servimedic', 1, '2026-02-10', '2029-10-01', 'Disponible', 464, 225.00, 0.00, 0.00, 0.00, 0),
(464, '8430094081159', 'Nutriben', '400g', 'Bote leche', 'Servimedic', 1, '2026-02-10', '2026-09-01', 'Disponible', 465, 125.00, 0.00, 0.00, 0.00, 0),
(465, '8906104082268', 'Meropenem 500mg', 'Meropenem', 'Frasco vial', 'Servimedic', 10, '2026-02-10', '2026-03-01', 'Disponible', 466, 150.00, 0.00, 0.00, 0.00, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenes_laboratorio`
--

CREATE TABLE `ordenes_laboratorio` (
  `id_orden` int NOT NULL,
  `numero_orden` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_paciente` int NOT NULL,
  `id_doctor` int DEFAULT NULL,
  `id_encamamiento` int DEFAULT NULL COMMENT 'NULL si es paciente ambulatorio',
  `fecha_orden` datetime NOT NULL,
  `prioridad` enum('Rutina','Urgente','STAT') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Rutina',
  `estado` enum('Pendiente','Muestra_Recibida','En_Proceso','Completada','Cancelada','Entregada') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pendiente',
  `diagnostico_clinico` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `indicaciones_especiales` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `creado_por` int DEFAULT NULL,
  `fecha_muestra_recibida` datetime DEFAULT NULL,
  `fecha_completada` datetime DEFAULT NULL,
  `fecha_entregada` datetime DEFAULT NULL,
  `entregado_a` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metodo_entrega` enum('En_Persona','Correo','WhatsApp','Sistema') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'En_Persona',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archivo_resultados` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ordenes_laboratorio`
--

INSERT INTO `ordenes_laboratorio` (`id_orden`, `numero_orden`, `id_paciente`, `id_doctor`, `id_encamamiento`, `fecha_orden`, `prioridad`, `estado`, `diagnostico_clinico`, `indicaciones_especiales`, `observaciones`, `creado_por`, `fecha_muestra_recibida`, `fecha_completada`, `fecha_entregada`, `entregado_a`, `metodo_entrega`, `fecha_creacion`, `fecha_actualizacion`, `archivo_resultados`) VALUES
(10, 'LAB-20260130-001', 40, 14, NULL, '2026-01-30 15:14:21', 'Rutina', 'En_Proceso', NULL, NULL, '', NULL, '2026-02-03 16:07:56', NULL, NULL, NULL, 'En_Persona', '2026-01-30 21:14:21', '2026-02-03 22:08:22', '../../uploads/results/orden_10_698271bc09609.jpeg'),
(11, 'LAB-20260130-002', 74, 22, NULL, '2026-01-30 15:15:38', 'Rutina', 'En_Proceso', NULL, NULL, '', NULL, '2026-02-03 16:09:31', NULL, NULL, NULL, 'En_Persona', '2026-01-30 21:15:38', '2026-02-03 22:09:36', '../../uploads/results/orden_11_6982721b0b33d.jpeg'),
(12, 'LAB-20260130-003', 83, 22, NULL, '2026-01-30 15:17:21', 'Rutina', 'En_Proceso', NULL, NULL, '', NULL, '2026-02-03 16:10:32', NULL, NULL, NULL, 'En_Persona', '2026-01-30 21:17:21', '2026-02-03 22:10:45', '../../uploads/results/orden_12_69827257d4300.jpeg'),
(13, 'LAB-20260130-004', 82, 14, NULL, '2026-01-30 15:20:28', 'Rutina', 'En_Proceso', NULL, NULL, '', NULL, '2026-02-03 16:14:10', NULL, NULL, NULL, 'En_Persona', '2026-01-30 21:20:28', '2026-02-03 22:19:04', '../../uploads/results/orden_13_69827331c5bff.jpeg'),
(14, 'LAB-20260131-001', 85, 14, NULL, '2026-01-31 10:20:34', 'Rutina', 'En_Proceso', NULL, NULL, '', NULL, '2026-02-03 16:17:41', NULL, NULL, NULL, 'En_Persona', '2026-01-31 16:20:34', '2026-02-03 22:17:47', '../../uploads/results/orden_14_69827405b2463.jpeg'),
(15, 'LAB-20260131-002', 37, 14, NULL, '2026-01-31 10:32:11', 'Rutina', 'En_Proceso', NULL, NULL, '', NULL, '2026-02-03 16:05:53', NULL, NULL, NULL, 'En_Persona', '2026-01-31 16:32:11', '2026-02-03 22:08:58', '../../uploads/results/orden_15_698271415b5de.jpeg'),
(16, 'LAB-20260203-001', 93, 13, NULL, '2026-02-03 09:22:20', 'Rutina', 'En_Proceso', NULL, NULL, '', NULL, '2026-02-03 16:04:09', NULL, NULL, NULL, 'En_Persona', '2026-02-03 15:22:20', '2026-02-03 22:04:17', '../../uploads/results/orden_16_698270d921d0d.jpeg'),
(17, 'LAB-20260205-001', 93, 13, NULL, '2026-02-05 08:52:09', 'Rutina', 'En_Proceso', NULL, NULL, '', NULL, '2026-02-06 15:00:33', NULL, NULL, NULL, 'En_Persona', '2026-02-05 14:52:09', '2026-02-06 21:00:38', '../../uploads/results/orden_17_69865670e3064.jpeg'),
(18, 'LAB-20260205-002', 101, 14, NULL, '2026-02-05 20:34:15', 'Rutina', 'En_Proceso', NULL, NULL, '', NULL, '2026-02-06 14:27:30', NULL, NULL, NULL, 'En_Persona', '2026-02-06 02:34:15', '2026-02-06 21:01:04', '../../uploads/results/orden_18_69864eb1e7970.jpeg'),
(19, 'LAB-20260207-001', 104, 24, NULL, '2026-02-07 11:39:42', 'Rutina', 'Pendiente', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 'En_Persona', '2026-02-07 17:39:42', '2026-02-07 17:39:42', NULL),
(20, 'LAB-20260207-002', 105, 24, NULL, '2026-02-07 13:55:03', 'Rutina', 'En_Proceso', NULL, NULL, 'Atentidado por Dr. Diego Vásquez.', NULL, '2026-02-07 14:41:55', NULL, NULL, NULL, 'En_Persona', '2026-02-07 19:55:03', '2026-02-07 20:42:12', '../../uploads/results/orden_20_6987a39357661.jpeg'),
(21, 'LAB-20260207-003', 66, 24, NULL, '2026-02-07 14:46:20', 'Rutina', 'Pendiente', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 'En_Persona', '2026-02-07 20:46:20', '2026-02-07 20:46:20', NULL),
(22, 'LAB-20260207-004', 66, 24, NULL, '2026-02-07 14:47:36', 'Rutina', 'Pendiente', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 'En_Persona', '2026-02-07 20:47:36', '2026-02-07 20:47:36', NULL),
(23, 'LAB-20260209-001', 39, 14, NULL, '2026-02-09 10:34:13', 'Rutina', 'Pendiente', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 'En_Persona', '2026-02-09 16:34:13', '2026-02-09 16:34:13', NULL),
(24, 'LAB-20260209-002', 110, 14, NULL, '2026-02-09 12:21:01', 'Rutina', 'Pendiente', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 'En_Persona', '2026-02-09 18:21:01', '2026-02-09 18:21:01', NULL),
(25, 'LAB-20260209-003', 111, 14, NULL, '2026-02-09 14:10:19', 'Rutina', 'Pendiente', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 'En_Persona', '2026-02-09 20:10:19', '2026-02-09 20:10:19', NULL),
(26, 'LAB-20260209-004', 113, 14, NULL, '2026-02-09 16:06:22', 'Rutina', 'Pendiente', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 'En_Persona', '2026-02-09 22:06:22', '2026-02-09 22:06:22', NULL),
(27, 'LAB-20260210-001', 115, 13, NULL, '2026-02-10 08:22:42', 'Rutina', 'Muestra_Recibida', NULL, '', '', NULL, '2026-02-10 15:03:56', NULL, NULL, NULL, 'En_Persona', '2026-02-10 14:22:42', '2026-02-10 21:03:56', '../../uploads/results/orden_27_698b9d3c28645.jpeg'),
(30, 'LAB-20260211-001', 66, 24, NULL, '2026-02-11 04:04:03', 'Rutina', 'Pendiente', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 'En_Persona', '2026-02-11 10:04:03', '2026-02-11 10:04:03', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_pruebas`
--

CREATE TABLE `orden_pruebas` (
  `id_orden_prueba` int NOT NULL,
  `id_orden` int NOT NULL,
  `id_prueba` int NOT NULL,
  `estado` enum('Pendiente','Muestra_Recibida','En_Proceso','Resultados_Parciales','Completada','Validada','Cancelada') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pendiente',
  `fecha_muestra_recibida` datetime DEFAULT NULL,
  `fecha_inicio_proceso` datetime DEFAULT NULL,
  `fecha_completada` datetime DEFAULT NULL,
  `fecha_validada` datetime DEFAULT NULL,
  `notas_tecnico` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `archivo_resultados` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `procesado_por` int DEFAULT NULL,
  `validado_por` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `orden_pruebas`
--

INSERT INTO `orden_pruebas` (`id_orden_prueba`, `id_orden`, `id_prueba`, `estado`, `fecha_muestra_recibida`, `fecha_inicio_proceso`, `fecha_completada`, `fecha_validada`, `notas_tecnico`, `archivo_resultados`, `procesado_por`, `validado_por`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(30, 10, 85, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-30 21:14:22', '2026-01-30 21:14:22'),
(31, 10, 172, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-30 21:14:22', '2026-01-30 21:14:22'),
(32, 10, 251, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-30 21:14:22', '2026-01-30 21:14:22'),
(33, 11, 62, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-30 21:15:38', '2026-01-30 21:15:38'),
(34, 11, 238, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-30 21:15:38', '2026-01-30 21:15:38'),
(35, 12, 123, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-30 21:17:21', '2026-01-30 21:17:21'),
(36, 12, 230, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-30 21:17:22', '2026-01-30 21:17:22'),
(37, 12, 232, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-30 21:17:22', '2026-01-30 21:17:22'),
(38, 13, 28, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-30 21:20:28', '2026-01-30 21:20:28'),
(39, 13, 123, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-30 21:20:28', '2026-01-30 21:20:28'),
(40, 13, 176, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-30 21:20:28', '2026-01-30 21:20:28'),
(41, 14, 123, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-31 16:20:34', '2026-01-31 16:20:34'),
(42, 14, 176, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-31 16:20:34', '2026-01-31 16:20:34'),
(43, 15, 60, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-31 16:32:11', '2026-01-31 16:32:11'),
(44, 15, 61, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-31 16:32:11', '2026-01-31 16:32:11'),
(45, 15, 62, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-31 16:32:12', '2026-01-31 16:32:12'),
(46, 15, 114, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-31 16:32:12', '2026-01-31 16:32:12'),
(47, 15, 119, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-31 16:32:12', '2026-01-31 16:32:12'),
(48, 15, 238, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-31 16:32:13', '2026-01-31 16:32:13'),
(49, 16, 35, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-03 15:22:20', '2026-02-03 15:22:20'),
(50, 16, 123, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-03 15:22:20', '2026-02-03 15:22:20'),
(51, 17, 98, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-05 14:52:09', '2026-02-05 14:52:09'),
(52, 18, 73, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-06 02:34:15', '2026-02-06 02:34:15'),
(53, 18, 124, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-06 02:34:16', '2026-02-06 02:34:16'),
(54, 18, 223, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-06 02:34:16', '2026-02-06 02:34:16'),
(55, 19, 194, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-07 17:39:42', '2026-02-07 17:39:42'),
(56, 19, 241, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-07 17:39:42', '2026-02-07 17:39:42'),
(57, 20, 211, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-07 19:55:03', '2026-02-07 19:55:03'),
(58, 20, 123, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-07 19:55:04', '2026-02-07 19:55:04'),
(59, 20, 224, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-07 19:55:04', '2026-02-07 19:55:04'),
(60, 21, 1, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-07 20:46:20', '2026-02-07 20:46:20'),
(61, 21, 3, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-07 20:46:21', '2026-02-07 20:46:21'),
(62, 21, 5, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-07 20:46:21', '2026-02-07 20:46:21'),
(63, 22, 1, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-07 20:47:36', '2026-02-07 20:47:36'),
(64, 22, 3, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-07 20:47:37', '2026-02-07 20:47:37'),
(65, 22, 5, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-07 20:47:37', '2026-02-07 20:47:37'),
(66, 23, 34, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-09 16:34:13', '2026-02-09 16:34:13'),
(67, 24, 5, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-09 18:21:01', '2026-02-09 18:21:01'),
(68, 24, 211, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-09 18:21:01', '2026-02-09 18:21:01'),
(69, 24, 123, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-09 18:21:01', '2026-02-09 18:21:01'),
(70, 25, 28, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-09 20:10:19', '2026-02-09 20:10:19'),
(71, 25, 123, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-09 20:10:19', '2026-02-09 20:10:19'),
(72, 26, 73, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-09 22:06:22', '2026-02-09 22:06:22'),
(73, 26, 211, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-09 22:06:23', '2026-02-09 22:06:23'),
(74, 26, 98, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-09 22:06:23', '2026-02-09 22:06:23'),
(75, 26, 223, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-09 22:06:23', '2026-02-09 22:06:23'),
(76, 27, 8, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-10 14:22:42', '2026-02-10 14:22:42'),
(77, 27, 60, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-10 14:22:42', '2026-02-10 14:22:42'),
(78, 27, 61, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-10 14:22:42', '2026-02-10 14:22:42'),
(79, 27, 62, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-10 14:22:43', '2026-02-10 14:22:43'),
(80, 27, 123, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-10 14:22:43', '2026-02-10 14:22:43'),
(81, 27, 230, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-10 14:22:43', '2026-02-10 14:22:43'),
(82, 27, 232, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-10 14:22:44', '2026-02-10 14:22:44'),
(109, 30, 1, 'Pendiente', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-11 10:04:03', '2026-02-11 10:04:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id_paciente` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `genero` enum('Masculino','Femenino') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `notas` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id_paciente`, `nombre`, `apellido`, `fecha_nacimiento`, `genero`, `direccion`, `telefono`, `correo`, `fecha_registro`, `notas`) VALUES
(4, 'Monica Mariceny', 'Alvarado Subuyuj', '1998-05-04', 'Femenino', 'Aldea Tojocaz. Huehuetenango', '37271459', '', '2026-01-19 16:23:01', 'Px de los primeros, cuando aún no habían hoja de historial.'),
(5, 'Rosa Ana', 'Calderón Villatoro', '1964-12-30', 'Femenino', '5ta avenida 7/185 zona 1', '54391553', '', '2026-01-19 16:32:55', 'Primera px, aún no se utilizaban fichas de historial, por lo que los datos de ella están incompletos'),
(6, 'Cecilia Gabriela', 'calderón villatoro', '2003-01-24', 'Femenino', 'zona 1, 7/185 5ta avenida', '54767583', 'ceciliagabycalderon@gmail.com', '2026-01-19 16:35:12', NULL),
(7, 'Melany Floribelly ', 'lopez suarez', '1991-07-11', 'Femenino', 'Cuilco, huehuetenango', '30681047', 'lopezmelany95@yahoo.com', '2026-01-19 16:49:59', NULL),
(8, 'maverick andre', 'Carbajal Lopez', '2025-03-17', 'Masculino', 'Cuilco, Huehuetenango', '30681047', 'lopezmelany95@yahoo.com', '2026-01-19 17:25:45', NULL),
(9, 'Maria Cristina', 'Recinos Ramirez', '1997-08-12', 'Femenino', 'zona 10, huehuetenango', '41601532', 'recinoscris@gmail.com', '2026-01-19 17:40:17', NULL),
(10, 'Maritza Guadalupe', 'Gomez Galindo', '1973-02-22', 'Femenino', 'Zona 1, 7ma calle, huehuetenango.', '57016496', '', '2026-01-19 17:44:39', NULL),
(11, 'Ana Fabiola', 'Ramirez', '1973-07-28', 'Femenino', 'zona 10, huehuetenango.', '58377829', '', '2026-01-19 17:53:50', NULL),
(12, 'jennifer nineth', 'recinos fuentes', '1999-03-02', 'Femenino', 'Zona 10, Huehuetenango', '58389203', 'ninethrecinos22@gmail.com', '2026-01-19 20:22:47', NULL),
(13, 'Gabriela María Magdalena', 'Mérida Escobedo de Escobedo', '1967-03-24', 'Femenino', 'Chuscaj, Chiantla', '57633906', '', '2026-01-19 22:53:31', NULL),
(14, 'Claudia Ninet', 'Gutierrez Rivas', '1976-09-19', 'Femenino', 'Zona 1, Huehuetenango.', '', '', '2026-01-19 22:55:52', NULL),
(15, 'Leyser Damián', 'López López', '2025-04-25', 'Masculino', 'La Democracia, Huehuetenango.', '38484353', '', '2026-01-20 16:02:35', NULL),
(16, 'Katherine Rocío ', 'Félix Tecún', '2000-04-23', 'Femenino', 'Terrero zona 4 de Huehuetenango.', '37347766', 'rociofelixk@gmail.com', '2026-01-20 16:11:12', NULL),
(17, 'Maria Luisa', 'Mendoza', '1960-05-16', 'Femenino', '3era calle 8-34 zona 4 de huehuetenango.', '33607235', '', '2026-01-20 16:13:24', NULL),
(18, 'Santiago Gregorio', 'Matías Camposeco', '1960-05-23', 'Masculino', '6ta avenida zona 4, huehuetenango.', '55251535', '', '2026-01-20 16:23:35', NULL),
(19, 'Victoria', 'Ramos López', '1941-02-10', 'Femenino', 'Chiantla, huehuetenango', '45162634', '', '2026-01-20 18:06:25', NULL),
(20, 'Ofelia Consuelo', 'Moreno Ordóñez de Morales', '1964-08-26', 'Femenino', '3era calle final zona 2, Minerva, Huehuetenango', '30607328', '', '2026-01-20 20:00:54', NULL),
(21, 'Luis Santiago', 'Lorenzo', '2026-02-13', 'Masculino', 'Cambote zona 11.', '49415394', '', '2026-01-20 20:30:37', NULL),
(22, 'Mirna Esperanza', 'Gomez Galindo', '1970-10-26', 'Femenino', 'Colonia la Joya, zona 4.', '56220798', '', '2026-01-20 21:09:11', NULL),
(23, 'César', 'Velásquez', '1997-01-01', 'Masculino', 'Chiantla, Huehuetenngo', '45162634', '', '2026-01-20 21:50:01', NULL),
(24, 'Iván Omar', 'Montejo Jacinto', '1996-06-30', 'Masculino', 'Zona 1, huehuetenango.', '33907163', 'ivanmontejo96@gmail.com', '2026-01-20 22:35:10', NULL),
(25, 'Gustavo Adolfo', 'Herrera Gómez', '1982-02-15', 'Masculino', 'Zona 2 Minerva', '35968951', '', '2026-01-21 15:11:45', NULL),
(26, 'Keneth Vinicio', 'López López', '2022-04-01', 'Masculino', 'Zona 4, cerrito del maíz', '49504141', '', '2026-01-21 15:27:16', NULL),
(27, 'Madelyn ', 'Lucas', '2010-01-21', 'Femenino', 'Zona 4 el terrero, huehuetenango.', '43262798', '', '2026-01-21 17:06:46', NULL),
(28, 'Cindy Nohemí', 'Pascual', '1990-09-22', 'Femenino', 'zona 4 el terrero', '43262798', '', '2026-01-21 17:11:32', NULL),
(29, 'William', 'Agustín', '1978-10-31', 'Masculino', 'zona 4 el terrero, huehuetenango.', '58191429', '', '2026-01-21 17:14:03', NULL),
(30, 'Marvin', 'Tobar', '1971-06-03', 'Masculino', 'zona 8 de Huehuetenango.', '59064380', '', '2026-01-21 17:22:06', NULL),
(32, 'Quenia Shiomara', 'Calderón Villatoro de Gómez', '1993-04-21', 'Femenino', 'Aldea Chinacá.', '44765950', '', '2026-01-21 20:47:43', NULL),
(33, 'Isabel', 'Lucas Gómez', '1978-11-19', 'Femenino', 'Terrero alto zona 4.', '50555878', '', '2026-01-22 15:55:44', NULL),
(34, 'José Luis', 'Reyes Martinez', '1973-10-12', 'Masculino', '3era avenida 1-29 zona 8, colonia hernandez', '39053395', '', '2026-01-22 16:44:51', NULL),
(35, 'María Isabel', 'Herrera Navas', '1998-08-15', 'Femenino', '', '41958112', '', '2026-01-22 16:49:10', NULL),
(36, 'Juana Irene', 'González Granados', '1979-03-05', 'Femenino', 'Zona 1, Huehuetenango.', '45787222', '', '2026-01-22 17:32:27', NULL),
(37, 'Sydney Betzaida', 'López González', '1996-08-02', 'Femenino', 'zona 1, huehuetenango', '48836192', 'lopezbetzy23@gmail.com', '2026-01-22 17:34:04', NULL),
(38, 'Rosa Ofelia', 'Castillo Cubillas', '1963-09-04', 'Femenino', '7ma calle 7-100 zona 1, huehuetenango', '59986187', '', '2026-01-22 18:15:23', NULL),
(39, 'Javier Luis', 'Pérez', '1973-07-23', 'Masculino', 'Aldea Tocaíl, Santa Bárbara', '53419095', '', '2026-01-22 19:29:20', NULL),
(40, 'Rosa Florinda', 'Matías Camposeco de Hernández', '1965-06-30', 'Femenino', 'Jumaj zona 6 de Huehuetenango.', '59900577', '', '2026-01-22 20:15:59', NULL),
(41, 'Zoila ', 'Cruz Recinos de López', '1938-06-26', 'Femenino', 'Zona 4 el terrero\r\n', '30712747', '', '2026-01-22 20:28:31', NULL),
(42, 'Tecla Eufemia', 'López Cruz de Palacios', '1966-09-07', 'Femenino', 'zona 4 el terrero', '30712747', '', '2026-01-22 20:38:04', NULL),
(43, 'Nuvia Ofelia', 'Santos Ramos', '1975-12-10', 'Femenino', 'zona 6 de Huehuetenango.', '47804106', '', '2026-01-22 20:54:33', NULL),
(44, 'Marlen Asucena', 'Cifuentes Chávez', '2004-05-01', 'Femenino', 'Zona 3 de huehuetenango', '58808878', '', '2026-01-22 21:38:43', NULL),
(45, 'Icelda', 'Herrera Tayún', '1975-04-06', 'Femenino', 'Aldea Parraschaj, San Bartolo, Totonicapán.', '44570273', '', '2026-01-23 15:39:03', NULL),
(46, 'María ', 'Recinos López', '1995-03-15', 'Femenino', 'Zona 1 de Huehuetenango.', '57298544', '', '2026-01-23 15:48:53', NULL),
(47, 'Shirley Analí', 'Saucedo', '1988-12-28', 'Femenino', 'zona 4 de Huehuetenango', '32681284', '', '2026-01-23 15:50:45', NULL),
(48, 'Ángela', 'Vásquez Cardona de Vásquez', '1968-09-29', 'Femenino', 'Aldea Sucuj, Huehuetenango', '45314759', '', '2026-01-23 16:06:25', NULL),
(49, 'Bernandina', 'Carrillo', '1968-04-09', 'Femenino', 'Vista Hermosa, Chiantla', '40686706', '', '2026-01-23 16:12:32', NULL),
(50, 'Edwin Deymar', 'Pérez Vásquez', '2017-01-25', 'Masculino', '', '57446481', '', '2026-01-23 16:12:50', NULL),
(51, 'Enriqueta Hermelinda', 'Vásquez Vásquez', '1997-03-02', 'Femenino', '', '57446481', '', '2026-01-23 16:12:59', NULL),
(52, 'Elvia', 'Tayún Chan', '1981-04-14', 'Femenino', '', '59941701', '', '2026-01-23 17:09:46', NULL),
(53, 'Jafet', 'Argueta Tayún', '2018-03-17', 'Masculino', '', '59941701', '', '2026-01-23 17:12:48', NULL),
(54, 'Ángela', 'Vásquez Cardona de Vásquez', '1968-09-29', 'Femenino', 'Aldea Sucuj, Huehuetenango', '45314759', '', '2026-01-23 17:20:51', NULL),
(55, 'Sara Eulalia', 'Ramos Cobox', '1959-01-14', 'Femenino', '3ra. ave. 2-03 zona 1. Chiantla', '57225439', '', '2026-01-23 19:17:55', NULL),
(56, 'Boran Alejandro', 'Carrillo Ramos', '2018-08-30', 'Masculino', '3ra, ave, 2-03 zona 1, Chiantla', '57225439', '', '2026-01-23 19:25:28', NULL),
(57, 'Glendy Maricruz ', 'Carrillo Ramos', '1991-10-09', 'Femenino', '3ra. ave. 2-03 zona 1, Chiantla', '57225439', '', '2026-01-23 19:27:20', NULL),
(58, 'Antony Francisco', 'Carrillo Ramírez', '2025-07-23', 'Masculino', 'San Juan Atitán, Huehuetenango.', '32090595', '', '2026-01-23 21:17:54', NULL),
(59, 'Martín', 'Villatoro Vásquez', '1973-09-03', 'Masculino', 'Terminal zona 5 de Huehuetenango', '47903314', '', '2026-01-23 22:18:12', NULL),
(60, 'Audel Alexander', 'Herrera', '1987-11-10', 'Masculino', 'Zona 5 de Huehuetenango', '56944948', '', '2026-01-23 22:28:06', NULL),
(61, 'Susana María', 'Juárez Pedro', '2004-07-17', 'Femenino', 'Zona 4 el terrero, Huehuetenango.', '37127419', '', '2026-01-24 15:53:28', NULL),
(62, 'Uriel Jacob', 'Leiva del Valle', '2026-01-03', 'Masculino', 'Chiantla, Huehuetenango.', '41081072', '', '2026-01-24 16:48:17', NULL),
(63, 'Matilde Reina', 'López Gutiérrez', '1960-05-08', 'Femenino', 'Zona 5 de Huehuetenango', '48135182', '', '2026-01-26 14:30:16', 'Px hospitalizada (registro y cobros por parte del equipo de enfermería).'),
(64, 'Félix', 'Escobar Rosales', '1944-10-20', 'Masculino', 'Zona 1 de Huehuetenango', '58002077', '', '2026-01-26 15:53:56', 'Únicamente se realizó el procedimiento de toma de presión arterial, sin consulta médica.'),
(65, 'Olga Marina', 'Nájera Ruiz', '1966-07-23', 'Femenino', 'Zona 8 de Huehuetenango', '53348629', '', '2026-01-26 17:17:23', NULL),
(66, 'Ana Cristina', 'Domingo Jiménez', '1997-06-02', 'Femenino', 'Colotenango, (px de Dra. Kreisly Viviana Carrillo', '59483884', '', '2026-01-26 18:50:05', 'Px de Dra. Viviana Carrillo, se le devolvió Q175 de un exámen de laboratorio de H. Pylori cuantificada, pero la px no pudo defecar e indica que no puede regresar a realizarsela de nuevo porque vive lejos, motivo por el cual se le regresa el dinero.'),
(67, 'Wayner Isaác', 'López Gómez', '1995-05-20', 'Masculino', 'Santa Bárbara Huehuetenango.', '31823412', '', '2026-01-26 20:59:47', 'Px cita regresará el 03/02 a cita con el fisioterapia a las 3:00 pm en el centro médico.'),
(68, 'Estefany', 'Moreno', '2007-05-03', 'Femenino', 'Zona 1 de Huehuetenango', '49071998', '', '2026-01-27 15:25:42', NULL),
(69, 'Nancy Paola', 'Lucas Sales', '1995-06-03', 'Femenino', '2do carrizal, zona 3 de Huehuetenango.', '32999802', '', '2026-01-27 15:44:43', NULL),
(70, 'Matías Emanuel', 'Gutiérrez Mendoza', '2015-11-02', 'Masculino', 'Zona 5 colonia Alvarado', '59612627', '', '2026-01-27 16:38:26', NULL),
(71, 'Edem Osiel', 'Gómez Pérez', '2026-01-04', 'Masculino', 'Aldea Suculque', '47612763', '', '2026-01-27 18:49:21', NULL),
(72, 'Yasmin', 'Alonzo Solís', '1999-06-10', 'Femenino', 'zona 4 de Huehuetenango', '33073167', '', '2026-01-28 15:09:34', NULL),
(73, 'Suleni María', 'Pu Rodriguez', '2020-06-05', 'Femenino', 'Aguacatán', '53357824', '', '2026-01-28 17:11:30', NULL),
(74, 'Ana Yolanda', 'López', '1972-04-26', 'Femenino', 'Zona 1 de Huehuetenango.', '47474920', '', '2026-01-29 14:09:02', NULL),
(75, 'Karla Alexandra', 'Reyes Cano', '2002-06-10', 'Femenino', 'Barillas Huehuetenango.', '57369856', '', '2026-01-29 14:26:19', NULL),
(76, 'Rebeca Elizabeth', 'Castillo Rojas', '1984-11-29', 'Femenino', '1era avenida 3-41 zona 8 de Huehuetenango.', '48308122', '', '2026-01-29 14:48:04', NULL),
(77, 'Doris Oralia', 'López Villatoro', '1999-07-29', 'Femenino', 'Zona 8 Corral Chiquito de Huehuetenango.', '34563826', '', '2026-01-29 15:14:54', NULL),
(78, 'Edward Otoniel', 'Hernández', '2018-08-27', 'Masculino', '', '59674838', '', '2026-01-29 15:23:02', NULL),
(79, 'Mariela Roxana', 'Esteban Gómez', '1995-12-03', 'Femenino', 'Caserio la Cumbre, Malacatancito, Huehuetenango.', '57476884', '', '2026-01-29 16:22:53', NULL),
(80, 'Paulina', 'Gómez Domingo', '1971-05-14', 'Femenino', 'Cerrito del Maíz, zona 4 de Huehuetenango.', '38823816', '', '2026-01-30 16:26:18', NULL),
(81, 'Emma Beatriz', 'López Vásquez', '1990-11-21', 'Femenino', 'Jumaj zona 6 de Huehuetenango.', '49043931', '', '2026-01-30 16:35:36', NULL),
(82, 'Joseph Miguel Ángel', 'Leiva Mazariegos ', '2025-03-27', 'Masculino', 'Chiantla, Huehuetenango.', '46437528', '', '2026-01-30 21:06:30', NULL),
(83, 'Enrique Otoniel', 'López Maldonado', '2000-03-15', 'Masculino', '', '53229674', '', '2026-01-30 21:08:13', 'No pagó consulta, es hijo de una de nuestras colaboradoras.'),
(84, 'Javier Anderson', 'Argueta Ixcoy', '2018-07-10', 'Masculino', 'Momostenango', '53366067', '', '2026-01-31 14:42:52', 'Px hospitalizado.'),
(85, 'Miriam Olinda', 'Matías Martinez', '1981-10-20', 'Femenino', 'Zaculeu central zona 9', '40280767', '', '2026-01-31 15:26:52', NULL),
(86, 'Imelda', 'Gonzalez', '1975-01-30', 'Femenino', 'Zona 4 de Huehuetenango', '41933470', '', '2026-01-31 17:52:48', NULL),
(87, 'Doris Aminta', 'Gamboa Gómez', '1965-09-04', 'Femenino', '', '31884705', '', '2026-01-31 18:04:25', NULL),
(88, 'Liam Alesandro', 'Reyes Barrios', '2025-10-15', 'Masculino', '', '51232758', '', '2026-01-31 18:06:32', NULL),
(89, 'Sergio', 'Samayoa', '1989-05-19', 'Masculino', '', '41908300', '', '2026-01-31 18:50:28', 'Px vino únicamente para procedimiento de inyección, él traía el medicamento que se le inyectó.'),
(90, 'Keiry ', 'López', '2007-05-30', 'Femenino', 'Huehuetenango zona 1', '51669353', '', '2026-01-31 19:16:08', 'Px del seguro, por lo que con ellos se llevará otras opciones distintas de ingreso de datos.'),
(91, 'Melvin ', 'García Funes', '2024-11-11', 'Femenino', 'Cantón la Reforma, Chiantla.', '12345678', '', '2026-02-02 14:17:21', 'Px de la Dra. Belén López, misma que aún no tenemos registrada en sistema.'),
(92, 'Olga Marina', 'Agustín Zuñiga', '1975-05-26', 'Femenino', 'Zona 4 de Huehuetenango.', '55295077', '', '2026-02-02 21:56:38', NULL),
(93, 'William Francisco', 'Mendoza Escobar', '1976-03-05', 'Masculino', 'Zona 3 de Huehuetenango.', '58088701', '', '2026-02-02 22:53:06', NULL),
(94, 'Floridalma', 'López', '1983-08-11', 'Femenino', 'Zona 7 de Huehuetenango.', '57407074', '', '2026-02-03 15:28:17', 'Px del seguro.\r\n'),
(95, 'Esperanza Margarita', 'Palacios Rios', '1967-10-10', 'Femenino', '', '56369504', '', '2026-02-04 21:33:46', NULL),
(96, 'Ana Jose ', 'Rios', '2000-12-21', 'Femenino', '4ta calle 6-25 zona 1 de Huehuetenango', '52901775', '', '2026-02-04 21:59:53', NULL),
(97, 'Imelda Judith ', 'López', '1968-04-27', 'Femenino', 'Malacatancito Huehuetenango', '53255826', '', '2026-02-04 22:32:41', NULL),
(98, 'Luis Rodrigo', 'Jacobs López', '2012-01-12', 'Masculino', 'Malacatancito Huehuetenango', '53255826', '', '2026-02-04 22:34:10', NULL),
(99, 'Maria Jose ', 'Herrera ', '1982-07-14', 'Femenino', 'zona 7 Huehuetenango ', '52901775', '', '2026-02-05 01:15:32', NULL),
(100, 'Zulma Yecenia', 'Villatoro', '1973-06-30', 'Femenino', '', '', '', '2026-02-05 21:21:44', NULL),
(101, 'Byron Roderico', 'Herrera Mérida', '1965-09-30', 'Masculino', '5ta av. 7ma-140 zona 1', '45627045', '', '2026-02-06 02:20:23', NULL),
(102, 'Fabiana ', 'Pérez Felipe', '1984-12-18', 'Femenino', 'Ixtahuacán, Huheuetenango', '45278747', '', '2026-02-06 21:28:02', NULL),
(103, 'Irma Delma', 'Mendoza Rivas', '1976-08-26', 'Femenino', 'Zona 9 de Huehuetenango.', '36757686', '', '2026-02-07 16:15:07', NULL),
(104, 'Eleana', 'Escobedo Ahilón', '2025-07-11', 'Femenino', 'Chiantla', '38616346', '', '2026-02-07 17:39:06', NULL),
(105, 'Ander Jared', 'Aguilar Andrés', '2025-07-23', 'Masculino', 'San Juan Atitán', '', '', '2026-02-07 19:53:52', NULL),
(106, 'Victor ', 'Mejia ', '1968-10-10', 'Masculino', 'zona 4 de Huehuetenango ', '55256683', '', '2026-02-07 22:53:10', NULL),
(107, 'Eva María', 'Nicolás López', '1994-08-12', 'Femenino', '', '', '', '2026-02-09 15:29:46', NULL),
(108, 'Patricia Guadalupe', 'Vásquez Soberanis', '1999-01-11', 'Femenino', '', '32670429', '', '2026-02-09 15:30:51', NULL),
(109, 'Blanca Estela', 'Velásquez García', '1965-05-16', 'Femenino', 'Buena Vista, zon 3, 2do Carrizal.', '50697897', '', '2026-02-09 15:33:58', NULL),
(110, 'Stiven Jesús', 'Funes', '2022-12-12', 'Masculino', 'Zona 11 de Huheuetenango.', '40754987', '', '2026-02-09 18:20:01', NULL),
(111, 'Emilio Alessandro', 'Aguilar Rojas', '2012-05-21', 'Masculino', 'zona 1', '', '', '2026-02-09 20:08:34', NULL),
(112, 'Laura', 'Alvarado Villaseñor', '1967-10-12', 'Femenino', 'Zona 7 de Huehuetenango.', '53491183', '', '2026-02-09 21:04:12', NULL),
(113, 'Santos Ángela', 'Castillo Rivas', '1958-10-02', 'Femenino', 'Zona 5, Colonia Alvarado Huehuetenango', '40148242', '', '2026-02-09 22:05:14', NULL),
(114, 'Brandon Iván', 'Rivas Mauricio', '1999-05-23', 'Masculino', 'Zona 9 de Huehuetenango.', '48741540', '', '2026-02-09 22:47:53', NULL),
(115, 'Ismael', 'De León López', '1945-08-18', 'Masculino', 'La Libertad', '55234919', '', '2026-02-09 22:58:46', NULL),
(116, 'Liliana Maritza', 'Martinez Ramos', '1983-04-26', 'Femenino', 'Brasilia zona 7 de Huehuetenango.', '55723718', '', '2026-02-09 23:32:19', NULL),
(117, 'Cornelia', 'Chan Cuyuch', '1943-01-08', 'Femenino', 'San Bartolo', '59941701', '', '2026-02-10 20:04:46', NULL),
(118, 'Petra Micaela', 'Herrera', '1946-07-11', 'Femenino', 'San Idelfonso Ixtahuacán', '32226051', '', '2026-02-10 21:56:37', NULL),
(119, 'Domick Daniel', 'Gómez Rivas', '2023-01-25', 'Masculino', 'Zona 6 de Huehuetenango.', '30664361', '', '2026-02-10 22:40:21', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametros_pruebas`
--

CREATE TABLE `parametros_pruebas` (
  `id_parametro` int NOT NULL,
  `id_prueba` int NOT NULL,
  `nombre_parametro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `unidad_medida` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valor_ref_hombre_min` decimal(12,4) DEFAULT NULL,
  `valor_ref_hombre_max` decimal(12,4) DEFAULT NULL,
  `valor_ref_mujer_min` decimal(12,4) DEFAULT NULL,
  `valor_ref_mujer_max` decimal(12,4) DEFAULT NULL,
  `valor_ref_pediatrico_min` decimal(12,4) DEFAULT NULL,
  `valor_ref_pediatrico_max` decimal(12,4) DEFAULT NULL,
  `tipo_dato` enum('Numérico','Texto','Selección','Cualitativo') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Numérico',
  `opciones_seleccion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'JSON con opciones si es tipo Selección',
  `valores_normales` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Para resultados cualitativos',
  `orden_visualizacion` int DEFAULT '0',
  `critico_bajo` decimal(12,4) DEFAULT NULL COMMENT 'Valor crítico bajo',
  `critico_alto` decimal(12,4) DEFAULT NULL COMMENT 'Valor crítico alto',
  `formula_calculo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Si se calcula a partir de otros parámetros',
  `notas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `procedimientos_menores`
--

CREATE TABLE `procedimientos_menores` (
  `id_procedimiento` int NOT NULL,
  `id_paciente` int NOT NULL,
  `nombre_paciente` varchar(255) NOT NULL,
  `procedimiento` varchar(255) NOT NULL COMMENT 'Nombre del procedimiento (ej. Sutura, Curación)',
  `cobro` decimal(10,2) NOT NULL,
  `fecha_procedimiento` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(255) DEFAULT NULL,
  `tipo_pago` enum('Efectivo','Tarjeta','Transferencia') DEFAULT 'Efectivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `procedimientos_menores`
--

INSERT INTO `procedimientos_menores` (`id_procedimiento`, `id_paciente`, `nombre_paciente`, `procedimiento`, `cobro`, `fecha_procedimiento`, `usuario`, `tipo_pago`) VALUES
(1, 53, 'Jafet Argueta Tayún', 'Lavado de Oido', 100.00, '2026-01-23 17:31:35', 'system', 'Efectivo'),
(2, 51, 'Enriqueta Hermelinda Vásquez Vásquez', 'Lavado de Oido', 100.00, '2026-01-23 18:11:07', 'system', 'Efectivo'),
(3, 64, 'Félix Escobar Rosales', 'Toma de Presion', 5.00, '2026-01-26 15:55:20', 'system', 'Efectivo'),
(5, 50, 'Edwin Deymar Pérez Vásquez', 'Canalizacion con Solucion', 175.00, '2026-01-27 22:00:26', 'system', 'Efectivo'),
(6, 89, 'Sergio Samayoa', 'Inyeccion', 10.00, '2026-01-31 18:51:51', 'atello', 'Efectivo'),
(7, 102, 'Fabiana  Pérez Felipe', 'Canalizacion con Solucion', 250.00, '2026-02-07 15:31:59', 'atello', 'Efectivo'),
(8, 111, 'Emilio Alessandro Aguilar Rojas', 'Nebulizacion', 40.00, '2026-02-09 20:11:54', 'atello', 'Efectivo'),
(9, 111, 'Emilio Alessandro Aguilar Rojas', 'Nebulizacion', 40.00, '2026-02-09 20:12:41', 'atello', 'Efectivo'),
(10, 117, 'Cornelia Chan Cuyuch', 'Lavado de Oido', 100.00, '2026-02-10 20:05:01', 'AnyeSec', 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `purchase_headers`
--

CREATE TABLE `purchase_headers` (
  `id` int NOT NULL,
  `document_type` enum('Factura','Nota de Envío','Consumidor Final') NOT NULL,
  `document_number` varchar(50) DEFAULT NULL,
  `provider_name` varchar(100) DEFAULT NULL,
  `purchase_date` date NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('Pendiente','Completado') DEFAULT 'Pendiente',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `paid_amount` decimal(10,2) DEFAULT '0.00',
  `payment_status` enum('Pendiente','Parcial','Pagado') DEFAULT 'Pendiente',
  `created_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `purchase_headers`
--

INSERT INTO `purchase_headers` (`id`, `document_type`, `document_number`, `provider_name`, `purchase_date`, `total_amount`, `status`, `created_at`, `paid_amount`, `payment_status`, `created_by`) VALUES
(4, 'Nota de Envío', 'SVM-001', 'Servimedic', '2026-01-16', 41369.17, 'Completado', '2026-01-16 19:58:11', 0.00, 'Pendiente', NULL),
(5, 'Nota de Envío', 'SVM-002', 'Servimedic', '2026-01-16', 44778.47, 'Completado', '2026-01-17 04:51:31', 0.00, 'Pendiente', NULL),
(6, 'Nota de Envío', 'SVM-003', 'Servimedic', '2026-01-22', 2345.04, 'Completado', '2026-01-22 15:55:29', 0.00, 'Pendiente', 1),
(7, 'Nota de Envío', 'SVM-004', 'Servimedic', '2026-01-22', 144.69, 'Completado', '2026-01-22 16:25:25', 0.00, 'Pendiente', 9),
(8, 'Nota de Envío', 'SVM-005', 'Servimedic', '2026-01-22', 273.10, 'Completado', '2026-01-22 16:44:59', 0.00, 'Pendiente', 9),
(9, 'Nota de Envío', 'SVM-006', 'Servimedic', '2026-01-22', 98.92, 'Completado', '2026-01-22 16:49:09', 0.00, 'Pendiente', 9),
(10, 'Nota de Envío', 'SVM-007', 'Servimedic', '2026-01-22', 872.86, 'Completado', '2026-01-22 17:56:09', 0.00, 'Pendiente', 9),
(11, 'Nota de Envío', 'SVM-008', 'Servimedic', '2026-01-22', 681.88, 'Completado', '2026-01-22 17:59:14', 0.00, 'Pendiente', 9),
(12, 'Nota de Envío', 'SVM-009', 'Servimedic', '2026-01-22', 272.24, 'Completado', '2026-01-22 18:09:58', 0.00, 'Pendiente', 9),
(13, 'Nota de Envío', 'SVM-010', 'Servimedic', '2026-01-22', 212.59, 'Completado', '2026-01-22 18:26:54', 0.00, 'Pendiente', 9),
(14, 'Nota de Envío', 'SVM-011', 'Servimedic', '2026-01-22', 216.89, 'Completado', '2026-01-22 18:31:44', 0.00, 'Pendiente', 9),
(15, 'Nota de Envío', 'SVM-012', 'Servimedic', '2026-01-22', 537.99, 'Completado', '2026-01-22 18:37:33', 0.00, 'Pendiente', 9),
(16, 'Nota de Envío', 'SVM-013', 'Servimedic', '2026-01-22', 2404.75, 'Completado', '2026-01-22 18:44:09', 0.00, 'Pendiente', 9),
(18, 'Nota de Envío', 'SVM-014', 'Servimedic', '2026-01-22', 1311.35, 'Completado', '2026-01-22 19:13:14', 0.00, 'Pendiente', 9),
(20, 'Nota de Envío', 'SVM-015', 'Servimedic', '2026-01-22', 92.58, 'Completado', '2026-01-22 19:23:48', 0.00, 'Pendiente', 9),
(21, 'Nota de Envío', 'SVM-016', 'Servimedic', '2026-01-24', 40574.98, 'Pendiente', '2026-01-24 07:32:04', 0.00, 'Pendiente', NULL),
(22, 'Nota de Envío', 'SVM-017', 'Servimedic', '2026-01-22', 1245.65, 'Completado', '2026-01-24 14:53:51', 0.00, 'Pendiente', 9),
(23, 'Nota de Envío', 'SVM-018', 'Servimedic', '2026-01-24', 1347.81, 'Completado', '2026-01-24 15:01:11', 0.00, 'Pendiente', 9),
(24, 'Nota de Envío', 'SVM-019', 'Servimedic', '2026-01-24', 402.50, 'Completado', '2026-01-26 16:44:30', 0.00, 'Pendiente', 9),
(25, 'Nota de Envío', 'SVM-020', 'Servimedic', '2026-01-26', 34.50, 'Completado', '2026-01-26 20:51:33', 0.00, 'Pendiente', 9),
(26, 'Nota de Envío', 'SVM-021', 'Servimedic', '2026-01-26', 4.00, 'Completado', '2026-01-26 21:43:05', 0.00, 'Pendiente', 9),
(27, 'Nota de Envío', 'SVM-022', 'Servimedic', '2026-01-26', 171.60, 'Completado', '2026-01-26 22:56:51', 0.00, 'Pendiente', 9),
(28, 'Nota de Envío', 'SVM-023', 'Servimedic', '2026-01-27', 363.72, 'Completado', '2026-01-27 15:47:22', 0.00, 'Pendiente', 9),
(29, 'Nota de Envío', 'SVM-024', 'Servimedic', '2026-01-27', 141.44, 'Completado', '2026-01-27 16:04:59', 0.00, 'Pendiente', 9),
(30, 'Nota de Envío', 'SVM-025', 'Servimedic', '2026-01-28', 150.00, 'Completado', '2026-01-28 17:41:12', 0.00, 'Pendiente', 9),
(31, 'Nota de Envío', 'SVM-026', 'Servimedic', '2026-01-28', 100.00, 'Completado', '2026-01-28 17:48:05', 0.00, 'Pendiente', 9),
(32, 'Nota de Envío', 'SVM-027', 'Servimedic', '2026-01-28', 3243.96, 'Completado', '2026-01-28 18:36:17', 0.00, 'Pendiente', 9),
(33, 'Nota de Envío', 'SVM-028', 'Servimedic', '2026-01-28', 428.17, 'Completado', '2026-01-28 18:43:30', 0.00, 'Pendiente', 9),
(34, 'Nota de Envío', 'SVM-029', 'Servimedic', '2026-01-28', 837.40, 'Completado', '2026-01-28 18:49:00', 0.00, 'Pendiente', 9),
(35, 'Nota de Envío', 'SVM-030', 'Servimedic', '2026-01-28', 385.25, 'Completado', '2026-01-28 18:59:03', 0.00, 'Pendiente', 9),
(36, 'Nota de Envío', 'SVM-031', 'Servimedic', '2026-01-28', 455.00, 'Completado', '2026-01-28 19:37:52', 0.00, 'Pendiente', 9),
(37, 'Nota de Envío', 'SVM-032', 'Servimedic', '2026-01-28', 470.40, 'Completado', '2026-01-28 21:28:37', 0.00, 'Pendiente', 9),
(38, 'Nota de Envío', 'SVM-033', 'Servimedic', '2026-01-28', 360.00, 'Completado', '2026-01-28 21:33:25', 0.00, 'Pendiente', 9),
(39, 'Nota de Envío', 'SVM-034', 'Servimedic', '2026-01-28', 105.00, 'Completado', '2026-01-28 21:35:04', 0.00, 'Pendiente', 9),
(40, 'Nota de Envío', 'SVM-035', 'muestras medicas', '2026-01-29', 0.64, 'Completado', '2026-01-29 14:35:35', 0.00, 'Pendiente', 12),
(41, 'Nota de Envío', 'SVM-036', 'Servimedic', '2026-01-29', 763.12, 'Completado', '2026-01-29 15:05:45', 0.00, 'Pendiente', 12),
(42, 'Nota de Envío', 'SVM-037', 'Servimedic', '2026-01-29', 8.00, 'Completado', '2026-01-29 16:06:32', 0.00, 'Pendiente', 12),
(43, 'Nota de Envío', 'SVM-038', 'Servimedic', '2026-01-29', 81.03, 'Completado', '2026-01-29 17:13:34', 0.00, 'Pendiente', 12),
(44, 'Nota de Envío', 'SVM-039', 'Servimedic', '2026-01-29', 15867.40, 'Completado', '2026-01-29 23:33:01', 0.00, 'Pendiente', 9),
(45, 'Nota de Envío', 'SVM-040', 'Servimedic', '2026-01-29', 3430.30, 'Completado', '2026-01-29 23:41:27', 0.00, 'Pendiente', 9),
(46, 'Nota de Envío', 'SVM-041', 'Servimedic', '2026-01-29', 1063.10, 'Completado', '2026-01-29 23:49:04', 0.00, 'Pendiente', 9),
(47, 'Nota de Envío', 'SVM-042', 'Servimedic', '2026-01-30', 966.40, 'Completado', '2026-01-30 17:57:05', 0.00, 'Pendiente', 12),
(48, 'Nota de Envío', 'SVM-043', 'Servimedic', '2026-01-30', 966.40, 'Pendiente', '2026-01-30 17:57:08', 0.00, 'Pendiente', 12),
(49, 'Nota de Envío', 'SVM-044', 'Servimedic', '2026-01-30', 91.50, 'Completado', '2026-01-30 18:06:52', 0.00, 'Pendiente', 12),
(50, 'Nota de Envío', 'SVM-045', 'Servimedic', '2026-01-30', 128.95, 'Completado', '2026-01-30 18:19:05', 0.00, 'Pendiente', 12),
(51, 'Nota de Envío', 'SVM-046', 'Servimedic', '2026-01-30', 5.50, 'Completado', '2026-01-30 18:27:21', 0.00, 'Pendiente', 12),
(52, 'Nota de Envío', 'SVM-047', 'muestras medicas', '2026-01-30', 0.20, 'Completado', '2026-01-30 18:44:13', 0.00, 'Pendiente', 12),
(53, 'Nota de Envío', 'SVM-048', 'Servimedic', '2026-01-30', 276.80, 'Completado', '2026-01-30 19:22:39', 0.00, 'Pendiente', 12),
(54, 'Nota de Envío', 'SVM-049', 'Servimedic', '2026-01-30', 1542.00, 'Completado', '2026-01-30 20:21:36', 0.00, 'Pendiente', 12),
(55, 'Nota de Envío', 'SVM-050', 'Servimedic', '2026-01-28', 2.00, 'Completado', '2026-01-31 15:53:35', 0.00, 'Pendiente', 12),
(56, 'Nota de Envío', 'SVM-051', 'Servimedic', '2026-01-31', 0.60, 'Completado', '2026-01-31 16:56:19', 0.00, 'Pendiente', 9),
(57, 'Nota de Envío', 'SVM-052', 'Servimedic', '2026-01-31', 0.20, 'Completado', '2026-01-31 17:32:14', 0.00, 'Pendiente', 9),
(58, 'Nota de Envío', 'SVM-053', 'Servimedic', '2026-01-31', 0.10, 'Completado', '2026-01-31 18:12:29', 0.00, 'Pendiente', 12),
(59, 'Nota de Envío', 'SVM-054', 'Servimedic', '2026-01-31', 2.40, 'Completado', '2026-01-31 18:18:22', 0.00, 'Pendiente', 12),
(60, 'Nota de Envío', 'SVM-055', 'Servimedic', '2026-01-31', 2.40, 'Completado', '2026-01-31 18:48:27', 0.00, 'Pendiente', 12),
(61, 'Nota de Envío', 'SVM-056', 'Servimedic', '2026-01-31', 2.00, 'Completado', '2026-01-31 18:50:32', 0.00, 'Pendiente', 12),
(62, 'Nota de Envío', '', 'Servimedic', '2026-02-02', 144.00, 'Completado', '2026-02-02 22:44:32', 0.00, 'Pendiente', 9),
(63, 'Nota de Envío', '', 'Servimedic', '2026-02-03', 87.60, 'Completado', '2026-02-03 18:16:12', 0.00, 'Pendiente', 12),
(64, 'Nota de Envío', '', 'Servimedic', '2026-02-03', 2.00, 'Completado', '2026-02-03 21:34:56', 0.00, 'Pendiente', 9),
(65, 'Nota de Envío', '', 'servimedic', '2026-02-04', 1946.55, 'Completado', '2026-02-04 16:09:29', 0.00, 'Pendiente', 12),
(66, 'Nota de Envío', '', 'servimedic', '2026-02-04', 3582.72, 'Completado', '2026-02-04 17:25:40', 0.00, 'Pendiente', 12),
(68, 'Nota de Envío', '', 'servimedic', '2026-02-04', 2145.28, 'Completado', '2026-02-04 18:10:44', 0.00, 'Pendiente', 12),
(69, 'Nota de Envío', '', 'servimedic', '2026-02-04', 2309.38, 'Completado', '2026-02-04 18:35:46', 0.00, 'Pendiente', 12),
(70, 'Nota de Envío', '', 'servimedic', '2026-02-04', 13316.16, 'Completado', '2026-02-04 22:17:15', 0.00, 'Pendiente', 12),
(71, 'Nota de Envío', '', 'servimedic', '2026-02-06', 2354.34, 'Completado', '2026-02-06 15:29:13', 0.00, 'Pendiente', 12),
(73, 'Nota de Envío', '', 'servimedic', '2026-02-06', 1584.04, 'Completado', '2026-02-06 16:30:53', 0.00, 'Pendiente', 12),
(74, 'Nota de Envío', '', 'Muestra medica', '2026-02-06', 0.06, 'Pendiente', '2026-02-06 21:14:34', 0.00, 'Pendiente', 12),
(75, 'Nota de Envío', '', 'servimedic', '2026-02-06', 200.00, 'Completado', '2026-02-09 14:31:50', 0.00, 'Pendiente', 12),
(76, 'Nota de Envío', '', 'servimedic', '2026-02-09', 240.91, 'Completado', '2026-02-09 16:12:04', 0.00, 'Pendiente', 12),
(77, 'Nota de Envío', '', 'servimedic', '2026-02-09', 145.36, 'Completado', '2026-02-09 17:10:51', 0.00, 'Pendiente', 12),
(78, 'Nota de Envío', '', 'servimedic', '2026-02-10', 10060.20, 'Completado', '2026-02-10 15:26:07', 0.00, 'Pendiente', 12),
(79, 'Nota de Envío', '', 'servimedic', '2026-02-10', 21056.17, 'Completado', '2026-02-10 15:39:17', 0.00, 'Pendiente', 12),
(80, 'Nota de Envío', '', 'servimedic', '2026-02-10', 1212.97, 'Completado', '2026-02-10 15:53:24', 0.00, 'Pendiente', 12),
(81, 'Nota de Envío', '', 'Servimedic', '2026-02-10', 0.14, 'Completado', '2026-02-10 21:16:58', 0.00, 'Pendiente', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `purchase_items`
--

CREATE TABLE `purchase_items` (
  `id` int NOT NULL,
  `purchase_header_id` int NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `presentation` varchar(100) DEFAULT NULL,
  `molecule` varchar(100) DEFAULT NULL,
  `pharmaceutical_house` varchar(100) DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_cost` decimal(10,2) NOT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `status` enum('Pendiente','Recibido') DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `purchase_items`
--

INSERT INTO `purchase_items` (`id`, `purchase_header_id`, `product_name`, `presentation`, `molecule`, `pharmaceutical_house`, `quantity`, `unit_cost`, `sale_price`, `subtotal`, `status`) VALUES
(1, 4, 'Antigrip', 'Ampolla', 'Eucolapto-Guayacol', 'Servimedic', 5, 24.94, 35.00, 143.41, 'Recibido'),
(2, 4, 'Ibuvanz', 'Suspension', 'Ibuprofeno100mg/5ml', 'Servimedic', 5, 25.29, 62.00, 145.42, 'Recibido'),
(3, 4, 'Fungiter', 'Crema topica', 'Terbinafina 1g', 'Servimedic', 5, 31.43, 140.00, 180.72, 'Recibido'),
(4, 4, 'D3-fENDER', 'Capsula', 'Vitamina D3100, 000UI', 'Servimedic', 5, 109.45, 140.00, 629.34, 'Recibido'),
(5, 4, 'Bisocard 5mg', 'Tableta', 'Bisoprolol famarato 5mg', 'Servimedic', 5, 133.77, 270.00, 769.18, 'Recibido'),
(6, 4, 'Olmepress HCT 40/12.5mg', 'Tableta', 'Olmesartan Medoxomil40mg+Hidroclorotiazida 12.5mg', 'Servimedic', 5, 195.94, 350.00, 1126.66, 'Recibido'),
(7, 4, 'Gacimex', 'suspension', 'Magaldrato 800mg/Simeticona 60mg/10ml', 'Servimedic', 5, 106.01, 155.00, 609.56, 'Recibido'),
(8, 4, 'Ultram D', 'Capsula', 'Dutasterida 0.5+Tamsulona clorhidrato 0.4mg', 'Servimedic', 4, 340.68, 600.00, 1567.13, 'Recibido'),
(9, 4, 'Triacid', 'Tableta', 'Pinaverium 100mg+Simethicone 300mg', 'Servimedic', 5, 163.85, 230.00, 942.14, 'Recibido'),
(10, 4, 'Tónico de alfalfa R95', 'Suspensión', 'tónico de alfalfa', 'Servimedic', 5, 120.64, 210.00, 693.68, 'Recibido'),
(11, 4, 'Metiom H. pylori', 'Cápsula', 'esomeprazol-levofloxamina-amoxicilina', 'Servimedic', 4, 512.29, 630.00, 2356.53, 'Recibido'),
(12, 4, 'Vertiless', 'Tableta', 'Betahistina- diclorhidrato 16mg', 'Servimedic', 5, 99.36, 180.00, 571.32, 'Recibido'),
(13, 4, 'Lyverium 1mg', 'Tableta', 'Alprazolam 1mg', 'Servimedic', 5, 128.82, 255.00, 740.72, 'Recibido'),
(14, 4, 'Lyverium 0.5mg', 'Tableta', 'Alprazolam 0.5mg', 'Servimedic', 5, 83.57, 150.00, 480.53, 'Recibido'),
(15, 4, 'Equiliv', 'Gotero', 'clonazepam 2.5/ml', 'Servimedic', 5, 90.16, 115.00, 518.42, 'Recibido'),
(16, 4, 'Atenua', 'Comprimidos', 'dexketoprofeno 25mg', 'Servimedic', 5, 56.33, 140.00, 323.90, 'Recibido'),
(17, 4, 'Sitalev Met', 'Tabletas', 'sitaglipina 50mg +metformina 500mg', 'Servimedic', 5, 142.16, 220.00, 817.42, 'Recibido'),
(18, 4, 'Inuric-G', 'Tableta', 'Febuxostat 80mg', 'Servimedic', 5, 170.78, 320.00, 981.99, 'Recibido'),
(19, 4, 'Gabin', 'Tableta', 'Gabapentina 400mg', 'Servimedic', 5, 112.13, 250.00, 644.75, 'Recibido'),
(20, 4, 'Atrolip Plus', 'Comprimidos', 'atorvastatina 10mg + ezetimibe 10 mg', 'Servimedic', 5, 234.09, 380.00, 1346.02, 'Recibido'),
(21, 4, 'Glutamax C', 'Viales', 'Glutathione + vit C', 'Servimedic', 3, 102.58, 200.00, 353.90, 'Recibido'),
(22, 4, 'Rupagán', 'Suspensión', 'Rupatadina 1mg/ml.', 'Servimedic', 5, 92.15, 145.00, 529.86, 'Recibido'),
(23, 4, 'Biotos Inmune', 'Suspensión', 'Hedera helix & Pelargonium sidoides', 'Servimedic', 5, 86.43, 185.00, 496.97, 'Recibido'),
(24, 4, 'Biotos Inmune Pediátrico', 'Suspensión', 'Hedera Helix & Pelargonium sidoides', 'Servimedic', 5, 63.15, 135.00, 363.11, 'Recibido'),
(25, 4, 'Omega 1000', 'Cápsulas', 'Omega 3', 'Servimedic', 2, 262.09, 425.00, 602.81, 'Recibido'),
(26, 4, 'Aci-tip', 'Comprimidos', 'Magaldrato 800mg - simeticona 40mg', 'Servimedic', 5, 63.89, 120.00, 367.37, 'Recibido'),
(27, 4, 'Neuralplus', 'Tableta', 'Tiamina, piridoxina, cianocobalamina, diclofenaco', 'Servimedic', 4, 44.25, 115.00, 203.55, 'Recibido'),
(28, 4, 'Kardiopil HCT', 'Tableta', 'Irbesartán 300mg + hidroclorotiazida 12.5 mg', 'Servimedic', 5, 166.22, 250.00, 955.77, 'Recibido'),
(29, 4, 'Milenium', 'Cápsula', 'esomeprazol 40mg', 'Servimedic', 5, 101.20, 250.00, 581.90, 'Recibido'),
(30, 4, 'Denk man active', 'Cápsula', 'extraxto de ginkgo, arginina', 'Servimedic', 3, 131.10, 220.00, 452.30, 'Recibido'),
(31, 4, 'Inmuno biter', 'Ampolla bebible', 'extracto glicerinado de jara+tomillo', 'Servimedic', 3, 333.39, 390.00, 1150.20, 'Recibido'),
(32, 4, 'Spacek', 'Tabletas', 'Bromuro de otilonio 40mg', 'Servimedic', 5, 81.65, 170.00, 469.49, 'Recibido'),
(33, 4, 'Spirocard', 'Tableta', 'spironolactone 100mg', 'Servimedic', 5, 166.64, 260.00, 958.18, 'Recibido'),
(34, 4, 'Kardiopil Amlo', 'Tableta', 'Irbesartan 300mg + Amlodipine 5mg', 'Servimedic', 5, 273.38, 410.00, 1571.94, 'Recibido'),
(35, 4, 'Gabex', 'Cápsula', 'Gabapentin 300mg', 'Servimedic', 5, 104.57, 200.00, 601.28, 'Recibido'),
(36, 4, 'biobronq', 'Suspensión', 'Hedera Helix 35mg/5ml', 'Servimedic', 5, 58.20, 80.00, 334.65, 'Recibido'),
(37, 4, 'Disolflem', 'sticks granulado', 'Acetilcisteína', 'Servimedic', 5, 49.14, 105.00, 282.56, 'Recibido'),
(38, 4, 'Uroprin', 'Sticks granulado', 'Fosfomicina 3g', 'Servimedic', 5, 145.36, 165.00, 835.82, 'Recibido'),
(39, 4, 'Clevium', 'Gel', 'Dexketoprofeno 1.25%', 'Servimedic', 5, 42.55, 80.00, 244.66, 'Recibido'),
(40, 4, 'Flavia', 'Tabletas', 'Melatonina, calcio', 'Servimedic', 5, 176.92, 250.00, 1017.29, 'Recibido'),
(41, 4, 'Demilos', 'Comprimidos', 'carbonato de calcio colecalciferol, vitamina d3', 'Servimedic', 5, 154.35, 215.00, 887.51, 'Recibido'),
(42, 4, 'Zefalox', '20 Cápsulas', 'cefixime 400mg', 'Servimedic', 5, 330.49, 650.00, 1900.32, 'Recibido'),
(43, 4, 'Zefalox', 'Suspensión 50ml', 'Cefixima 100mg/5ml', 'Servimedic', 5, 76.79, 205.00, 441.54, 'Recibido'),
(44, 4, 'Zefalox', 'Suspesión 100ml', 'Cefixima', 'Servimedic', 5, 116.64, 300.00, 670.68, 'Recibido'),
(45, 4, 'Conflexil Plus Shot', 'Sticks bebible', 'tiocolchicosido 4mg-diclofenaco 50mh', 'Servimedic', 100, 13.87, 22.00, 1595.05, 'Recibido'),
(46, 4, 'Rofemed', 'Vial', 'ceftriaxona 1g', 'Servimedic', 5, 24.56, 120.00, 141.22, 'Recibido'),
(47, 4, 'Milenium', '30 Cápsulas', 'esomeprazol 20ml', 'Servimedic', 5, 61.53, 200.00, 353.80, 'Recibido'),
(48, 4, 'Gadavyt fibra liquida', 'Suspensión', 'Fibra dietética jugo natural de ciruela', 'Servimedic', 2, 247.78, 345.00, 569.89, 'Recibido'),
(49, 4, 'Fungiter', 'Spray', 'Terbinafine HCI 1%', 'Servimedic', 5, 52.57, 100.00, 302.28, 'Recibido'),
(50, 4, 'Fungiter', '28 Tabletas', 'Terbinafine 250 mg', 'Servimedic', 5, 252.72, 545.00, 1453.14, 'Recibido'),
(51, 4, 'Septidex', 'Spray', 'Polimixina. neomicina 40g', 'Servimedic', 5, 60.32, 105.00, 346.84, 'Recibido'),
(52, 4, 'Dinivanz', 'Solución p/ nebulizar', 'Salbutamol, salino solucion', 'Servimedic', 5, 49.39, 130.00, 283.99, 'Recibido'),
(53, 4, 'Hicet', 'Gotas pediátricas', 'Cetirizina diclorhidrato 10mg/ml', 'Servimedic', 5, 48.60, 105.00, 279.45, 'Recibido'),
(54, 4, 'Hicet', 'Jarabe 120ml', 'Cetirizina diclorhidrato 5mg/ml', 'Servimedic', 5, 67.57, 140.00, 388.53, 'Recibido'),
(55, 4, 'Hicet', 'Jarabe 60ml', 'Cetirizina diclorhidrato 5mg/5ml', 'Servimedic', 5, 41.35, 90.00, 237.76, 'Recibido'),
(56, 4, 'Hicet', '10 Cápsulas', 'Cetirizina diclorhidrato 10mg', 'Servimedic', 5, 43.73, 90.00, 251.45, 'Recibido'),
(57, 4, 'Gabex Plus', '30 Tabletas recubiertas', 'Gabapentina + vitamina B1 y B12', 'Servimedic', 5, 179.63, 350.00, 1032.87, 'Recibido'),
(58, 4, 'Levent-Vit-E', '30 Cápsulas', 'vitamina E', 'Servimedic', 3, 207.77, 280.00, 716.81, 'Recibido'),
(59, 4, 'Rosecol', '30 Tabletas recubiertas', 'Rosuvastatina 20mg', 'Servimedic', 5, 125.87, 235.00, 723.75, 'Recibido'),
(60, 4, 'Prednicet', '20 Tabletas', 'Prednisolona 5mg', 'Servimedic', 5, 47.00, 85.00, 270.25, 'Recibido'),
(61, 5, 'Conflexil', 'Ampollas 4mg/2ml', 'Tiocolchicósido', 'Servimedic', 25, 15.53, 35.00, 446.49, 'Recibido'),
(62, 5, 'Viater Forte', 'Viales bebibles', 'ginseng, vitamina E, zinc', 'Servimedic', 1, 237.94, 300.00, 273.63, 'Recibido'),
(63, 5, 'Acla-med bid', '14 tabletas recubiertas', 'amoxicilina 875mg, acido clavulanico 125mg', 'Servimedic', 1, 98.93, 215.00, 113.77, 'Recibido'),
(64, 5, 'Symbio flor 1', 'Suspension oral', 'enterococcusfaecalis', 'Servimedic', 1, 204.70, 255.00, 235.41, 'Recibido'),
(65, 5, 'Klevraxr', '30 tabletas', 'levetiracetam 500mg', 'Servimedic', 3, 120.75, 170.00, 416.59, 'Recibido'),
(66, 5, 'Suganon', '30 Comprimidos', 'Evogliptina 5mg', 'Servimedic', 5, 412.85, 505.00, 2373.89, 'Recibido'),
(67, 5, 'Zukermen Met', '30 Tabletas', 'vildagliptina 50ml+metformina 1000mg', 'Servimedic', 5, 145.80, 300.00, 838.35, 'Recibido'),
(68, 5, 'Tusivanz', 'gotas pediatricas', 'dextromethorphan+carboxymethylcysteine', 'Servimedic', 5, 53.10, 105.00, 305.33, 'Recibido'),
(69, 5, 'Budoxigen', 'spray 200 aplicaciones', 'Budesonida 50mcg/100mcl', 'Servimedic', 5, 105.04, 190.00, 603.98, 'Recibido'),
(70, 5, 'Total Magnesiano', 'Sobres efervecentes', 'cloruro de magnesio 4.5H2O 1.5g + fluoruro de magnesio 0.0015g', 'Servimedic', 2, 174.80, 250.00, 402.04, 'Recibido'),
(71, 5, 'Acla-med', 'Suspension', 'Amoxicilina 600mg+Acido clavulanico 42.9mg', 'Servimedic', 3, 74.09, 175.00, 255.61, 'Recibido'),
(72, 5, 'Avsar Plus', '28 Tabletas', 'valsartan 320mg+amlodipina 10mg+hidroclorotiazida 25mg', 'Servimedic', 3, 191.71, 520.00, 661.40, 'Recibido'),
(73, 5, 'Deflarin', '10 comprimidos', 'desflazacort 30mg', 'Servimedic', 3, 241.50, 325.00, 833.18, 'Recibido'),
(74, 5, 'Disoflem', 'Sobres Granulados', 'Acetilcisteina 200mg', 'Servimedic', 5, 49.14, 105.00, 282.56, 'Recibido'),
(75, 5, 'Megamol', '100 capsulas', 'vitamina D3', 'Servimedic', 5, 118.34, 250.00, 680.46, 'Recibido'),
(76, 5, 'Diabilev', '30 Tabletas', 'Metformina HCI 500mg', 'Servimedic', 2, 62.91, 90.00, 144.69, 'Recibido'),
(77, 5, 'Denk immun active', 'Sobres', 'Zinc, selenio', 'Servimedic', 5, 136.42, 195.00, 784.42, 'Recibido'),
(78, 5, 'Melatina', 'Gotero', 'Melatonina 10.53mg', 'Servimedic', 5, 95.34, 160.00, 548.21, 'Recibido'),
(79, 5, 'Bru-sone', 'Ampolla', 'betametasona dipropionato 5mg+fosfato sodico 2mg', 'Servimedic', 5, 111.94, 190.00, 643.66, 'Recibido'),
(80, 5, 'Gastrexx plus', '28 capsulas', 'amoxicilina 1g+ levofloxacina 500mg', 'Servimedic', 3, 230.63, 480.00, 795.67, 'Recibido'),
(81, 5, 'Modepar', '60 Tabletas', 'Nicotinamida 17.5mg, Acido Ascorbico 50mg', 'Servimedic', 5, 431.83, 550.00, 2483.02, 'Recibido'),
(82, 5, 'Adiaplex', '30 Tabletas', 'Dapagliflozina 10mg', 'Servimedic', 5, 315.02, 410.00, 1811.37, 'Recibido'),
(83, 5, 'Glidap Max', '30 tabletas', 'Dapagliflozina 5mg+metformina HCI lp 1000mg', 'Servimedic', 5, 149.50, 300.00, 859.63, 'Recibido'),
(84, 5, 'Gesimax', '10 tabletas', 'Naproxeno sodico 550mg', 'Servimedic', 20, 55.66, 60.00, 1280.18, 'Recibido'),
(85, 5, 'Lisinox', '10 Tabletas', 'Propinoxato HCL 10mg+clonixinato de lisina 125mg', 'Servimedic', 10, 21.06, 45.00, 242.19, 'Recibido'),
(86, 5, 'Solocin Plus', '20 comprimidos', 'pancreatina 400mg+simeticona 60mg+cinitaprina 1mg', 'Servimedic', 5, 125.74, 220.00, 723.01, 'Recibido'),
(87, 5, 'Ferrum 16', 'Jarabe 240ml', 'hierro, vitaminas y minerales', 'Servimedic', 5, 78.20, 120.00, 449.65, 'Recibido'),
(88, 5, 'Gadysen', '30 capsulas', 'Duloxetina 60mg', 'Servimedic', 5, 296.42, 560.00, 1704.42, 'Recibido'),
(89, 5, 'Gadysen', '30 capsulas', 'Duloxetina 30mg', 'Servimedic', 3, 259.90, 510.00, 896.66, 'Recibido'),
(90, 5, 'Multiflora Adance', '30 capsulas', 'probiotico', 'Servimedic', 3, 312.34, 420.00, 1077.57, 'Recibido'),
(91, 5, 'Estoma dol', '30 capsulas', 'trisilicato de magnesio, carbon vegetal', 'Servimedic', 2, 95.34, 140.00, 219.28, 'Recibido'),
(92, 5, 'Exlant', '30 capsulas', 'dexlansoprazol 30mg', 'Servimedic', 4, 171.93, 365.00, 790.88, 'Recibido'),
(93, 5, 'Ki-Cab', '50 tabletas', 'tegoprazan 50mg', 'Servimedic', 1, 682.42, 830.00, 784.78, 'Recibido'),
(94, 5, 'Lisinox', 'Gotas 20ml', 'Propinoxato clorhidrato 5mg/ml', 'Servimedic', 3, 48.83, 80.00, 168.46, 'Recibido'),
(95, 5, 'Probiocyan', '30 capsulas', 'lactobacillus plantarum, zinc 5mg', 'Servimedic', 5, 159.09, 230.00, 914.77, 'Recibido'),
(96, 5, 'Colitran', '10 grageas', 'clordiazepoxido HCI/ Bromuro de clidinio', 'Servimedic', 10, 26.45, 40.00, 304.18, 'Recibido'),
(97, 5, 'Sucralfato', '40 Tabletas', 'sucralfato 1g', 'Servimedic', 1, 68.98, 105.00, 79.33, 'Recibido'),
(98, 5, 'Cetamin CC', '10 Tabletas', 'Acetaminofen 325mg+codeina 15mg', 'Servimedic', 5, 50.14, 90.00, 288.31, 'Recibido'),
(99, 5, 'Tensinor Plus', '30 Tabletas', 'Valsartan 160mg/hidroclorotiazida 12.5mg/amlodipino 5mg', 'Servimedic', 2, 310.50, 480.00, 714.15, 'Recibido'),
(100, 5, 'Tensinor Plus', '30 Tabletas', 'Valsartan 320mg/hidroclorotiazida 25mg/amlodipino 10mg', 'Servimedic', 2, 310.50, 480.00, 714.15, 'Recibido'),
(101, 5, 'Metavan', '30 Tabletas', 'metformina HCI 1000mg', 'Servimedic', 1, 241.66, 245.00, 277.91, 'Recibido'),
(102, 5, 'FILINAR g', 'Suspension', 'acebrifilina 5mg/ml', 'Servimedic', 1, 118.15, 160.00, 135.87, 'Recibido'),
(103, 5, 'Myo & D-Chiro Inositol', '90 capsulas', 'inositol chiro', 'Servimedic', 2, 402.50, 470.00, 925.75, 'Recibido'),
(104, 5, 'Gastroflux', 'suspension', 'domperidona 1mg/ml', 'Servimedic', 5, 196.22, 235.00, 1128.27, 'Recibido'),
(105, 5, 'Careject', 'Spray nasal', 'aceite de soja, glicerol', 'Servimedic', 5, 85.65, 150.00, 492.49, 'Recibido'),
(106, 5, 'Aidex', 'Sobres bebibles', 'dexketoprofeno 25mg/10ml', 'Servimedic', 5, 97.75, 110.00, 562.06, 'Recibido'),
(107, 5, 'Rusitan', 'Suspension', 'Rupatadina fumarato 1mg/ml', 'Servimedic', 5, 123.86, 175.00, 712.20, 'Recibido'),
(108, 5, 'Acetaminofen lancasco', 'Suspension', 'acetaminofen 120/5ml', 'Servimedic', 3, 17.25, 30.00, 59.51, 'Recibido'),
(109, 5, 'Bucaglu', 'Tintura Oral', 'ruibarbo y acido salicilico', 'Servimedic', 3, 63.25, 130.00, 218.21, 'Recibido'),
(110, 5, 'Contractil', '10 Tabletas', 'tiocolchicosido 4mg', 'Servimedic', 3, 79.04, 130.00, 272.69, 'Recibido'),
(111, 5, 'Etoricox', '14 Tabletas', 'Etoricoxib 120mg', 'Servimedic', 1, 316.25, 400.00, 363.69, 'Recibido'),
(112, 5, 'Isocraneol', '30 Comprimidos', 'Citicolina 500mg', 'Servimedic', 5, 369.76, 500.00, 2126.12, 'Recibido'),
(113, 5, 'Rodiflux', 'Gotero', 'Dextrometorfan, carboximetilcisteina, clorfeniramina', 'Servimedic', 5, 60.72, 110.00, 349.14, 'Recibido'),
(114, 5, 'Gebrix-G 240ml', 'Suspension', 'Jengibre, Equinacea, vitamina C', 'Servimedic', 3, 115.00, 200.00, 396.75, 'Recibido'),
(115, 5, 'Zirtraler-D 60ml', 'Suspension', 'Cetirizina HCI, Fenilefrina HCI', 'Servimedic', 5, 75.54, 125.00, 434.36, 'Recibido'),
(116, 5, 'Neo-melubrina', 'Jarabe 100ml', 'Metamizol sodico 250mg/5ml', 'Servimedic', 2, 40.25, 75.00, 92.58, 'Recibido'),
(117, 5, 'Neobol', 'Spray 30g', 'neomicina- clostebol', 'Servimedic', 2, 69.00, 135.00, 158.70, 'Recibido'),
(118, 5, 'Mero Clav', 'suspension 70ml', 'cefuroxima+ acido clavulanico', 'Servimedic', 2, 166.75, 250.00, 383.53, 'Recibido'),
(119, 5, 'Dexamicina', 'Gotero Oftalmico 5ml', 'Dexametazona/neomicina', 'Servimedic', 5, 28.75, 55.00, 165.31, 'Recibido'),
(120, 5, 'Aciclovirax', 'Suspension 120ml', 'Aciclovir pediatrico', 'Servimedic', 5, 128.95, 200.00, 741.46, 'Recibido'),
(121, 5, 'Bencidamin', 'Spray bucal', 'Bencidamina', 'Servimedic', 2, 36.80, 90.00, 84.64, 'Recibido'),
(122, 5, 'Metronis', 'suspension', 'Nitazoxanida 100mg/5ml', 'Servimedic', 2, 39.48, 80.00, 90.80, 'Recibido'),
(123, 5, 'Sinedol Forte', '10 Tabletas', 'Acetaminofen 750mg', 'Servimedic', 5, 34.32, 45.00, 197.34, 'Recibido'),
(124, 5, 'Mucarbol Pediatrico', 'Jarabe', 'Carbocisteina 100mg/5ml', 'Servimedic', 5, 45.11, 65.00, 259.38, 'Recibido'),
(125, 5, 'Mucarbol Adulto', 'Jarabe', 'Carbocisteina 750mg/15ml', 'Servimedic', 5, 48.73, 70.00, 280.20, 'Recibido'),
(126, 5, 'Neo-Melubrina', '4 Tabletas', 'Metamizol 500mg', 'Servimedic', 25, 3.22, 15.00, 92.58, 'Recibido'),
(127, 5, 'AGE III', '30 Capsulas', 'cucurbita pepo. africanum', 'Servimedic', 5, 152.78, 200.00, 878.49, 'Recibido'),
(128, 5, 'Sertal Forte Perlas', '10 capsulas', 'Propinox Clorhidrato 20mf', 'Servimedic', 6, 57.35, 90.00, 395.72, 'Recibido'),
(129, 5, 'Ardix', '10 Tabletas', 'dexketoprofeno 25mg', 'Servimedic', 1, 57.50, 95.00, 66.13, 'Recibido'),
(130, 5, 'Wen vision', 'Gotero Oftalmico 5ml', 'Dexametasona, neomicina', 'Servimedic', 5, 28.75, 55.00, 165.31, 'Recibido'),
(131, 5, 'Selenio+Vit E', '60 Capsulas', 'Vitamina E 1000UI+ Selenio 200', 'Servimedic', 2, 64.78, 175.00, 148.99, 'Recibido'),
(132, 5, 'Brucort-A', 'Crema Topica', 'Triamcinolona acetonido 0.1%', 'Servimedic', 4, 57.50, 110.00, 264.50, 'Recibido'),
(133, 5, 'Uxbi', '30 capsulas', 'Acido ursodesoxicolico 250mg', 'Servimedic', 2, 230.00, 375.00, 529.00, 'Recibido'),
(134, 5, 'Allopurikem', '10 Tabletas', 'alopurinol 300mg', 'Servimedic', 5, 33.81, 75.00, 194.41, 'Recibido'),
(135, 5, 'Deka-C Adultos', 'Ampollas bebibles 5ml', 'vitaminas A, D, E y C', 'Servimedic', 5, 29.61, 75.00, 170.26, 'Recibido'),
(136, 5, 'Rexacort', 'Spray nasal 18g', 'mometasona furoato 50pg', 'Servimedic', 3, 63.69, 130.00, 219.73, 'Recibido'),
(137, 5, 'Histakem Block', 'Spray bucal 30ml', 'Cloruro de cetilpiridinio 0.05g+benzocaina 1.0g', 'Servimedic', 2, 92.00, 125.00, 211.60, 'Recibido'),
(138, 5, 'Colchinet', '20 Tabletas', 'Colchicina 0.5 mg', 'Servimedic', 15, 41.40, 65.00, 714.15, 'Recibido'),
(139, 5, 'Triglix', '40 capsulas', 'Fenofibrato 160mg', 'Servimedic', 4, 251.85, 390.00, 1158.51, 'Recibido'),
(140, 5, 'Equiliv', '30 Tabletas', 'Clonazepan 2mg', 'Servimedic', 5, 89.53, 135.00, 514.80, 'Recibido'),
(141, 6, 'Prednicet 20mg', '10 Tabletas', 'Prednisolana 20mg', 'Servimedic', 1, 61.46, 110.00, 70.68, 'Recibido'),
(142, 6, 'Prednicet 15mg/5ml 100ml', 'Suspensión oral', 'Prednisolona 15mg/5ml', 'Servimedic', 2, 77.76, 170.00, 178.85, 'Recibido'),
(143, 6, 'Yes or Not', 'Prueba Embarazo', 'Sin Molécula Especificada', 'Servimedic', 3, 11.50, 25.00, 39.68, 'Recibido'),
(144, 6, 'Spirocard 25mg', '30 Tableta Recubiertas', 'Espironolactona 25mg', 'Servimedic', 1, 131.22, 210.00, 150.90, 'Recibido'),
(145, 6, 'Melana 3', '30 Cápsulas', 'Melatonina 3mg', 'Servimedic', 1, 35.39, 90.00, 40.70, 'Recibido'),
(146, 6, 'Aciclovirax Gel 15g', 'Gel Tópico', 'Aciclovir, D-Pantenol', 'Servimedic', 5, 73.70, 130.00, 423.78, 'Recibido'),
(147, 6, 'Caladermina 120ml', 'Suspensión Tópica', 'Calamina, Alcanfor, Difenhidramina', 'Servimedic', 2, 18.26, 35.00, 42.00, 'Recibido'),
(148, 6, 'Cortiderm 15g', 'Crema Tópica 15g', 'Hidrocortisona', 'Servimedic', 1, 70.04, 95.00, 80.55, 'Recibido'),
(149, 6, 'Dryskin 20%', 'Solución Tópica', 'Cloruro de Aluminio, Hexahidratado', 'Servimedic', 5, 220.00, 295.00, 1265.00, 'Recibido'),
(150, 6, 'Zotern 20g', 'Crema Tópica', 'Pendiente', 'Servimedic', 1, 46.00, 80.00, 52.90, 'Recibido'),
(151, 7, 'Anso 15g', 'Pomada Rectal', 'Lidocaina hidrocloruro/ pentosano polisulfato sodio/Triamcinofona acetónico', 'Servimedic', 2, 62.91, 100.00, 144.69, 'Recibido'),
(152, 8, 'Gastrobacter 10 días', '50 Tabletas', 'Amoxicilina 1g/ levofloxamina 500mg/ esomeprazol 40mg', 'Servimedic', 1, 214.48, 380.00, 246.65, 'Recibido'),
(153, 8, 'Sacameb Metronidazol 125mg/5ml 120ml', 'suspension Oral', 'Metronidazol', 'Servimedic', 1, 23.00, 55.00, 26.45, 'Recibido'),
(154, 9, 'Paverin COmpuesto', '20 Comprimidos', 'clonixinato de lisina 125mg / propinoxato de clohidrato 10mg', 'Servimedic', 2, 43.01, 65.00, 98.92, 'Recibido'),
(155, 10, 'AB-Digest sticks', '30 sticks bebibles', 'probióticos, prebióticos, zinc.', 'Servimedic', 1, 448.50, 590.00, 515.78, 'Recibido'),
(156, 10, 'Muvlax 3350', 'Sobres 17g', 'polietilenglicol', 'Servimedic', 30, 10.35, 14.00, 357.08, 'Recibido'),
(157, 11, 'Multiflora Plus', '30 cápsulas', 'vitamina A, C, E, Lactobacilos', 'Servimedic', 1, 312.34, 420.00, 359.19, 'Recibido'),
(158, 11, 'Nagreg', '10 comprimidos', 'rupatadina', 'Servimedic', 2, 140.30, 155.00, 322.69, 'Recibido'),
(159, 12, 'Sitalev Met 50/1000mg', '30 Tabletas recubiertas', 'Sitagliptina 50mg + metmorfina clorhidrato 1000mg', 'Servimedic', 1, 145.80, 220.00, 167.67, 'Recibido'),
(160, 12, 'Budoxigen', '5 viales  p/ nebulizar', 'budesonida micronizada 0.5mg/ml', 'Servimedic', 1, 90.93, 170.00, 104.57, 'Recibido'),
(161, 13, 'Albugenol 10ml', 'gotero p/ nebulizar', 'salbutamol, bromuro de ipratropium', 'Servimedic', 1, 115.00, 185.00, 132.25, 'Recibido'),
(162, 13, 'Airessa compuesta', '10 cápsulas', 'bromuro de clidineo 5mg/ dimetilpolisiloxano 150mg', 'Servimedic', 1, 34.50, 55.00, 39.68, 'Recibido'),
(163, 13, 'Clidipox', '20 Tabletas', 'clordiazepoxido HCI 5mg, bromuro de clidinio 2.5mg', 'Servimedic', 1, 35.36, 65.00, 40.66, 'Recibido'),
(164, 14, 'Simeflat 40mg', '30 tabletas', 'simeticona 40mg', 'Servimedic', 1, 50.60, 70.00, 58.19, 'Recibido'),
(165, 14, 'Porbex 30ml', 'gotero oral', 'acetaminofen+clorfeniramina', 'Servimedic', 3, 46.00, 90.00, 158.70, 'Recibido'),
(166, 15, 'Rinofed 120ml', 'Jarabe', 'clorfeniramida, fenilefrina, codeina', 'Servimedic', 1, 95.80, 115.00, 110.17, 'Recibido'),
(167, 15, 'Brox-C 100ml', 'Jarabe', 'desloratadina 5mg+betametasona 0.25mg', 'Servimedic', 2, 92.00, 125.00, 211.60, 'Recibido'),
(168, 15, 'Byetos 120ml', 'Jarabe', 'codeina, clorfeniramida, fenilefrina', 'Servimedic', 2, 61.81, 105.00, 142.16, 'Recibido'),
(169, 15, 'Metricom 500ml', '20 Tabletas recubiertas', 'metronidazol 500ml', 'Servimedic', 2, 32.20, 75.00, 74.06, 'Recibido'),
(170, 16, 'Demelan 500mg', '6 Cápsulas', 'nitazoxanida', 'Servimedic', 2, 39.20, 90.00, 90.16, 'Recibido'),
(171, 16, 'Urocram', '30 cápsulas', 'arandano+vitamina C', 'Servimedic', 4, 195.50, 240.00, 899.30, 'Recibido'),
(172, 16, 'Grater Neo Form', '60 Cápsulas', 'carnitina, extracto de mango africano', 'Servimedic', 3, 178.14, 250.00, 614.58, 'Recibido'),
(173, 16, 'Tónico de Alfalfa 100ml', 'Suspension Oral', 'Alfalfa', 'Servimedic', 5, 120.64, 210.00, 693.68, 'Recibido'),
(174, 16, 'Ulcrux', '30 Sobres', 'Sucralfato 1g', 'Servimedic', 1, 93.07, 140.00, 107.03, 'Recibido'),
(175, 18, 'Dediacol 250mg', '10 Tabletas', 'aminosidina', 'Servimedic', 35, 32.58, 65.00, 1311.35, 'Recibido'),
(176, 20, 'sucragel', 'suspensión oral', 'sucralfato', 'Servimedic', 1, 80.50, 105.00, 92.58, 'Recibido'),
(177, 21, 'ESOGASTRIC 10MG', '15 SOBRES', 'ESOMEPRAZOL', 'Servimedic', 2, 112.84, 165.00, 259.53, 'Pendiente'),
(178, 21, 'SPASMO-UROLONG', '10 COMPRIMIDOS', 'NITROFURANTOINA 75MG', 'Servimedic', 2, 49.45, 80.00, 113.74, 'Pendiente'),
(179, 21, 'Burts bees baby', 'rolon', 'esencia coco', 'Servimedic', 3, 34.50, 105.00, 119.03, 'Pendiente'),
(180, 21, 'propix-duo', 'ampolla', 'propinoxato15mg/clonixinato de lisina 100mg', 'Servimedic', 6, 30.02, 50.00, 207.14, 'Pendiente'),
(181, 21, 'ovumix', 'ovulos vaginales', 'metronidazol, sulfato neomicina, centella asiatica', 'Servimedic', 1, 198.10, 255.00, 227.82, 'Pendiente'),
(182, 21, 'Gesimax 150mg/5ml', 'suspension 60ml', 'naproxeno', 'Servimedic', 2, 46.00, 65.00, 105.80, 'Pendiente'),
(183, 21, 'Paracetamol Denk 500mg', '20 comprimidos', 'Paracetamol', 'Servimedic', 2, 33.93, 50.00, 78.04, 'Pendiente'),
(184, 21, 'Dolvi plex', '10 tabletas', 'Metamizol 500mg', 'Servimedic', 1, 10.35, 20.00, 11.90, 'Pendiente'),
(185, 21, 'Melanoblock', 'Crema Facial', 'aqua cetearyl alcohol', 'Servimedic', 5, 186.30, 375.00, 1071.23, 'Pendiente'),
(186, 21, 'regenhial crema', 'Crema Facial', 'Acido hialuronico 1%', 'Servimedic', 4, 325.28, 450.00, 1496.29, 'Recibido'),
(187, 21, 'Regenhial Gel', 'Crema Facial', 'Acido hialuronico 1%', 'Servimedic', 3, 223.10, 275.00, 769.70, 'Recibido'),
(188, 21, 'Hidribet 10%', 'Locion topica', 'Glicerin, sorbitan', 'Servimedic', 1, 85.27, 125.00, 98.06, 'Recibido'),
(189, 21, 'Umbrella', 'Protector solar facial', 'aqua, penylene glycol', 'Servimedic', 2, 190.49, 225.00, 438.13, 'Recibido'),
(190, 21, 'Figure active', '14 sobres', 'carnitina, triptofano, buchu', 'Servimedic', 3, 250.59, 300.00, 864.54, 'Recibido'),
(191, 21, 'Ureactiv 10%', 'Crema humectante', 'carbamida -urea', 'Servimedic', 1, 109.73, 155.00, 126.19, 'Recibido'),
(192, 21, 'Regenhial Gel Oral', 'Enjuague bucal', 'Acido hialuronico 250mg', 'Servimedic', 4, 126.50, 200.00, 581.90, 'Recibido'),
(193, 21, 'Claribac 500mg', '10 tabletas', 'Claritromicina', 'Servimedic', 2, 174.18, 325.00, 400.61, 'Recibido'),
(194, 21, 'Unocef 400mg', '8 Comprimidos', 'Cefixima', 'Servimedic', 5, 231.55, 300.00, 1331.41, 'Recibido'),
(195, 21, 'Quinolide 500mg', '10 tabletas', 'Ciprofloxacina', 'Servimedic', 14, 31.63, 100.00, 509.24, 'Recibido'),
(196, 21, 'Supraxil 1g', 'Vial', 'Ceftriaxona', 'Servimedic', 2, 51.75, 130.00, 119.03, 'Recibido'),
(197, 21, 'Tiamina 100mg', 'Vial', 'Tiamina 10ml', 'Servimedic', 3, 10.35, 25.00, 35.71, 'Recibido'),
(198, 21, 'Complejo B', 'Vial', 'Complejo B 10ML', 'Servimedic', 3, 13.80, 25.00, 47.61, 'Recibido'),
(199, 21, 'Celedexa', 'Jarabe 120ml', 'Betametasona dexclorfeniramina', 'Servimedic', 5, 83.72, 140.00, 481.39, 'Recibido'),
(200, 21, 'Indugastric 120ml', 'Jarabe', 'regaliz, resina, ', ', Servimedic', 1, 135.86, 210.00, 156.24, 'Recibido'),
(201, 21, 'Ambiare', '10 Tabletas', 'Dexclorfeniramina, betametasona', 'Servimedic', 2, 40.25, 55.00, 92.58, 'Recibido'),
(202, 21, 'Fenobrox', 'suspension', 'Cloperastina', 'Servimedic', 4, 41.40, 110.00, 190.44, 'Recibido'),
(203, 21, 'Acla-Med Bid 400mg', 'Suspension', 'Amoxicilina+acido clavulanico', 'Servimedic', 4, 58.88, 125.00, 270.85, 'Recibido'),
(204, 21, 'Vaginsol F', '7 ovulos vaginales', 'Clindamicina100mg+clotrimazol 200mg', 'Servimedic', 2, 280.60, 360.00, 645.38, 'Recibido'),
(205, 21, 'Ferra Q', '30 Capsulas', 'Acido folico1000mcg+hierro aminoquelado 30mg', 'Servimedic', 1, 63.48, 115.00, 73.00, 'Recibido'),
(206, 21, 'Hepamob', '30 Comprimidos', 'Cilimarina+complejo b', 'Servimedic', 2, 103.50, 150.00, 238.05, 'Recibido'),
(207, 21, 'Prednitab 50mg', '20 Tabletas', 'Prednisona', 'Servimedic', 4, 305.10, 385.00, 1403.46, 'Recibido'),
(208, 21, 'Lansogastric 15Mg', '15 Sobres', 'Lansoprazol', 'Servimedic', 3, 39.10, 90.00, 134.90, 'Recibido'),
(209, 21, 'Sargikem', '30 Capsulas', 'Aspartato de L arginina', 'Servimedic', 1, 96.14, 165.00, 110.56, 'Recibido'),
(210, 21, 'Lergiless', 'Jarabe 60ml', 'loratadina 5mg/betametasona 0.25mg', 'Servimedic', 2, 73.60, 110.00, 169.28, 'Recibido'),
(211, 21, 'Oriprox-M', '10 Tabletas', 'Moxifloxacino 400mg', 'Servimedic', 5, 258.75, 400.00, 1487.81, 'Recibido'),
(212, 21, 'Tibonella', '28 Tabletas', 'Tibolona 2.5mg', 'Servimedic', 4, 195.50, 290.00, 899.30, 'Recibido'),
(213, 21, 'Metocarban AC', '30 Tabletas', 'Metocarbamol400mg/acetaminofen 250mg', 'Servimedic', 3, 69.23, 110.00, 238.84, 'Recibido'),
(214, 21, 'Dyflam', 'Gotas 15ml', 'Diclofenaco resinato', 'Servimedic', 5, 24.61, 50.00, 141.51, 'Recibido'),
(215, 21, 'Cefina 100mg/5ml', 'Suspension 100ml', 'Cefixima', 'Servimedic', 1, 103.50, 220.00, 119.03, 'Recibido'),
(216, 21, 'Floxa-Pack 10 Dias', '10 Comprimidos', 'Lansoprazol 30mg/levofloxacina 500mg/amoxicilina 500mg', 'Servimedic', 2, 218.50, 450.00, 502.55, 'Recibido'),
(217, 21, 'Floxa- Pack ES 10 Dias', '10 Comprimidos', 'Esomeprazol 40mg/levofloxacina 500mg/amoxicilina 500mg', 'Servimedic', 1, 244.95, 515.00, 281.69, 'Recibido'),
(218, 21, 'Arginina Junior', '10 ampollas bebibles', 'aspartato de arginina 1g/5ml', 'Servimedic', 2, 80.50, 95.00, 185.15, 'Recibido'),
(219, 21, 'Arginina Forte', '10 ampollas bebibles', 'Aspartato de arginina 5g/10ml', 'Servimedic', 2, 112.70, 135.00, 259.21, 'Recibido'),
(220, 21, 'Redical', '28 Sobres', 'Esomeprazol 10mg', 'Servimedic', 1, 246.79, 420.00, 283.81, 'Recibido'),
(221, 21, 'Gripcol D', 'Susspencion 120ml', 'Fenilefrina, dextrometorfano, acetaminofen', 'Servimedic', 1, 32.20, 55.00, 37.03, 'Recibido'),
(222, 21, 'Deflarin 6mg', '10 Comprimidos', 'Deflazacort', 'Servimedic', 5, 88.55, 135.00, 509.16, 'Recibido'),
(223, 21, 'Totalvit ZINC', 'Jarabe 120ml', 'Sulfatode zinc 20mg', 'Servimedic', 2, 46.00, 110.00, 105.80, 'Recibido'),
(224, 21, 'Musculare 10mg', '15 Tabletas', 'Clorhidrato de ciclobenzaprina', 'Servimedic', 5, 117.62, 145.00, 676.32, 'Recibido'),
(225, 21, 'Musculare 5mg', '15 Tabletas', 'Clorhidrato de ciclobenzaprina', 'Servimedic', 5, 105.32, 125.00, 605.59, 'Recibido'),
(226, 21, 'Dyflam 120ml', 'Suspension', 'Diclofenaco 9mg/5ml', 'Servimedic', 5, 39.10, 65.00, 224.83, 'Recibido'),
(227, 21, 'Broncodil 120ml', 'Suapension', 'Carboximetilcisteina', 'Servimedic', 5, 46.00, 110.00, 264.50, 'Recibido'),
(228, 21, 'Gastrexx 40mg', '15 Capsulas', 'Esomeprazol', 'Servimedic', 5, 253.30, 600.00, 1456.48, 'Recibido'),
(229, 21, 'Levamisol 12.5mg/5ml', 'Sobres bebibles', 'Diclofenaco 50mg+tiocolchicosico', 'Servimedic', 50, 14.24, 22.00, 818.80, 'Recibido'),
(230, 21, 'Nocicep 10mg', '10 Tabletas', 'Rupatadina', 'Servimedic', 4, 64.86, 130.00, 298.36, 'Recibido'),
(231, 21, 'Levax', 'Suspension 120ml', 'Levamisol 12.5mg/5ml', 'Servimedic', 2, 70.84, 100.00, 162.93, 'Recibido'),
(232, 21, 'Levax', '10 tabletas', 'Levamisol 75mg', 'Servimedic', 2, 123.17, 165.00, 283.29, 'Recibido'),
(233, 21, 'Sinervit', '30 Capsulas', 'Tiamina, piridoxina, cianocobalamina', 'Servimedic', 1, 103.50, 190.00, 119.03, 'Recibido'),
(234, 21, 'Dinivanz Compuesto', 'kit para nebulizar', 'Bromuro de ipatropium/salino/salbutamol', 'Servimedic', 5, 118.96, 240.00, 684.02, 'Recibido'),
(235, 21, 'Betasporina', 'Vial', 'Ceftriaxona 1g', 'Servimedic', 10, 63.25, 140.00, 727.38, 'Recibido'),
(236, 21, 'Ceftrian', 'Vial', 'Ceftriaxona 1g', 'Servimedic', 3, 40.25, 110.00, 138.86, 'Recibido'),
(237, 21, 'Dipronova', 'Vial', 'Betamethasone dipropionate', 'Servimedic', 1, 69.00, 180.00, 79.35, 'Recibido'),
(238, 21, 'Esomeprakem', '10 Capsulas', 'Esomeprazol 40mg/levofloxacina 500mg/amoxicilina 500mg', 'Servimedic', 3, 41.40, 70.00, 142.83, 'Recibido'),
(239, 21, 'Nocpidem', '30 Comprimidos', 'Zolpidem 10mg', 'Servimedic', 3, 259.44, 350.00, 895.07, 'Recibido'),
(240, 21, 'Triviplex 25000', 'Ampolla 2ml', 'Vitaminas B12, B2, B12', 'Servimedic', 5, 21.85, 45.00, 125.64, 'Recibido'),
(241, 21, 'Dexa-triviplex', '2 ampollas', 'Vitaminas neurotropas+dexa', 'Servimedic', 5, 33.35, 55.00, 191.76, 'Recibido'),
(242, 21, 'Dolo Triviplex', '2 ampollas', 'Diclofenaco+vitaminas', 'Servimedic', 10, 26.45, 50.00, 304.18, 'Recibido'),
(243, 21, 'Suero Hidravida', 'suero oral', 'sabor coco', 'Servimedic', 12, 16.45, 18.00, 227.01, 'Recibido'),
(244, 21, 'Ledestil', 'ampollas', 'carbohidratos, lipidos totales', 'Servimedic', 24, 60.18, 100.00, 1660.97, 'Recibido'),
(245, 21, 'Agujas Hipodermicas', '100 Agujas', '31GX3/16', 'Servimedic', 5, 103.50, 140.00, 595.13, 'Recibido'),
(246, 21, 'Enna', 'Esfera', '', 'Servimedic', 1, 0.00, 450.00, 0.00, 'Recibido'),
(247, 21, 'Nircip', 'Frasco Inyectable', 'Ciprofloxacina 200mg/100m', 'Servimedic', 6, 26.45, 80.00, 182.51, 'Recibido'),
(248, 21, 'Ampidelt', 'Vial', 'Ampi+sulbactam', 'Servimedic', 30, 18.11, 80.00, 624.80, 'Recibido'),
(249, 21, 'Tiamina bonin', 'Vial', 'Tiamina', 'Servimedic', 10, 10.47, 25.00, 120.41, 'Recibido'),
(250, 21, 'Fluconazol 100ml', 'Frasco Inyectable', 'Fluconazol 200mg/100ml', 'Servimedic', 2, 37.61, 0.00, 86.50, 'Recibido'),
(251, 21, 'Bactemicina 600mg/4ml', 'Ampolla', 'Clindamicina', 'Servimedic', 5, 35.08, 0.00, 201.71, 'Recibido'),
(252, 21, 'Jeringas de 20ml', 'Insumo', 'Insumo', 'Servimedic', 195, 1.96, 0.00, 439.53, 'Recibido'),
(253, 21, 'Jeringas de 3ml', 'Insumo', 'Insumo', 'Servimedic', 290, 0.84, 0.00, 280.14, 'Recibido'),
(254, 21, 'Jeringa de 1ml', 'Insumo', 'Insumo', 'Servimedic', 500, 1.67, 0.00, 960.25, 'Recibido'),
(255, 21, 'Baja Lenguas', 'Insumo', 'Insumo', 'Servimedic', 12, 0.00, 0.00, 0.00, 'Recibido'),
(256, 21, 'Angiocath #22', 'Insumo', 'Insumo', 'Servimedic', 150, 4.72, 0.00, 814.20, 'Recibido'),
(257, 21, 'Angiocath #18', 'Insumo', 'Insumo', 'Servimedic', 50, 4.72, 0.00, 271.40, 'Recibido'),
(258, 21, 'Angiocath #20', 'Insumo', 'Insumo', 'Servimedic', 50, 4.72, 0.00, 271.40, 'Recibido'),
(259, 21, 'Angiocath #24', 'Insumo', 'Insumo', 'Servimedic', 96, 4.72, 0.00, 521.09, 'Recibido'),
(260, 21, 'Lidocaina c/ Epinefrina', 'Insumo', 'Insumo', 'Servimedic', 3, 41.40, 0.00, 142.83, 'Recibido'),
(261, 21, 'LIdocaina SIN/ Epinefrina', 'Insumo', 'Insumo', 'Servimedic', 3, 36.80, 0.00, 126.96, 'Recibido'),
(262, 21, 'Metoclopramida', 'Ampolla 2ml', 'Metoclopramida 10mg', 'Servimedic', 110, 2.30, 50.00, 290.95, 'Recibido'),
(263, 21, 'Ranitidina', 'Ampolla 2ml', 'Ranitidina 50mg', 'Servimedic', 200, 2.30, 50.00, 529.00, 'Recibido'),
(264, 21, 'Tramadol', 'Ampolla 2ml', 'Tramadol 100mg', 'Servimedic', 100, 2.76, 50.00, 317.40, 'Recibido'),
(265, 21, 'Dexametasona', 'Ampolla 1ml', 'Dexametasona 4mg', 'Servimedic', 109, 2.88, 50.00, 361.01, 'Recibido'),
(266, 21, 'Dipirona', 'Ampolla 2ml', 'Dipirona 1g', 'Servimedic', 204, 3.45, 50.00, 809.37, 'Recibido'),
(267, 21, 'Selestina', 'Ampolla 2ml', 'Dexa 8mg', 'Servimedic', 8, 2.88, 50.00, 26.50, 'Recibido'),
(268, 21, 'Parenten', 'Ampolla 2ml', 'Diazepoam 10mg', 'Servimedic', 3, 11.50, 75.00, 39.68, 'Recibido'),
(269, 21, 'Jeringas de 5ml', 'Insumo', 'Insumo', 'Servimedic', 200, 0.43, 0.00, 98.90, 'Recibido'),
(270, 21, 'Jeringas de 10ml', 'Insumo', 'Insumo', 'Servimedic', 95, 0.67, 0.00, 73.20, 'Recibido'),
(271, 21, 'Clorfeniramida', 'Ampolla 2ml', 'Clorfeniramida 10mg', 'Servimedic', 25, 2.42, 50.00, 69.58, 'Recibido'),
(272, 21, 'Neo-Melumbrina', 'Ampolla 2ml', 'Metamizol 500mg', 'Servimedic', 60, 7.76, 50.00, 535.44, 'Recibido'),
(273, 21, 'Ceftriaxona', 'Vial Polvo', 'Ceftriaxona 1g', 'Servimedic', 56, 8.86, 0.00, 570.58, 'Recibido'),
(274, 21, 'Meropenem', 'Vial Polvo', 'Meropenem 500mg', 'Servimedic', 10, 36.80, 0.00, 423.20, 'Recibido'),
(275, 21, 'Esomeprazol', 'Vial Polvo', 'Esomeprazol 40mg', 'Servimedic', 2, 31.05, 80.00, 71.42, 'Recibido'),
(276, 21, 'Bonadiona', 'Ampolla 1ml', 'Vitamian K 10MG', 'Servimedic', 3, 10.35, 25.00, 35.71, 'Recibido'),
(277, 21, 'Omeprazol', 'Vial Polvo', 'Omeprazol 40mg', 'Servimedic', 62, 11.27, 80.00, 803.55, 'Recibido'),
(278, 21, 'Diclofenaco', 'Ampolla 3ml', 'Diclofenaco 75mg', 'Servimedic', 100, 2.07, 50.00, 238.05, 'Recibido'),
(279, 21, 'Nauseol', 'Ampolla 1ml', 'Dimehidrato 50mg', 'Servimedic', 50, 7.95, 50.00, 457.13, 'Recibido'),
(280, 21, 'Furosemida', 'Ampolla 2ml', 'Furosemida 20mg', 'Servimedic', 200, 1.73, 50.00, 397.90, 'Recibido'),
(281, 21, 'Amikacina', 'Ampolla 2ml', 'Amikacina 500mg', 'Servimedic', 40, 6.21, 80.00, 285.66, 'Recibido'),
(282, 21, 'Sello Heparina', 'Insumo', 'Insumo', 'Servimedic', 216, 1.55, 0.00, 385.02, 'Recibido'),
(283, 21, 'Guantes descartables', 'Magica', 'Talla M', 'Servimedic', 5, 0.00, 0.00, 0.00, 'Recibido'),
(284, 21, 'Agujas hipodermicas', 'Steril', 'aguja 24GX1', 'Servimedic', 2, 0.00, 0.00, 0.00, 'Recibido'),
(285, 21, 'Nylon #3-0', 'Atramat', '3-0', 'Servimedic', 50, 0.00, 0.00, 0.00, 'Recibido'),
(286, 21, 'Micropore 1/2', 'Nexcare', 'color blanco', 'Servimedic', 11, 0.00, 0.00, 0.00, 'Recibido'),
(287, 21, 'Bisturi #15', 'Sterile', 'Insumo', 'Servimedic', 57, 0.00, 0.00, 0.00, 'Recibido'),
(288, 21, 'Blood Lancets', '100 piezas', 'Lancetas via med', 'Servimedic', 6, 0.00, 0.00, 0.00, 'Recibido'),
(289, 21, 'Accu-chek', '50 piexas', 'tiras para glucometro', 'Servimedic', 4, 0.00, 0.00, 0.00, 'Recibido'),
(290, 21, 'Sonda Alimentacion #12', '#12', 'sondas', 'Servimedic', 9, 0.00, 0.00, 0.00, 'Recibido'),
(291, 21, 'Bolsa recolectora orina', 'de cama', 'Adulto', 'Servimedic', 10, 0.00, 0.00, 0.00, 'Recibido'),
(292, 21, 'Micropore 1p', 'color blanco', 'Insumo', 'Servimedic', 24, 0.00, 0.00, 0.00, 'Recibido'),
(293, 21, 'Micropore 2p', 'color blanco', 'Insumo', 'Servimedic', 12, 0.00, 0.00, 0.00, 'Recibido'),
(294, 21, 'Mascarillas para nebulizar', 'neonatal', 'Insumo', 'Servimedic', 2, 0.00, 0.00, 0.00, 'Recibido'),
(295, 21, 'Mascarillas para nebulizar', 'Pediatrico', 'Insumo', 'Servimedic', 4, 0.00, 0.00, 0.00, 'Recibido'),
(296, 21, 'Mascarillas para nebulizar', 'Adulto', 'Insumo', 'Servimedic', 4, 0.00, 0.00, 0.00, 'Recibido'),
(297, 21, 'Sonda alimentacion #5', 'Operson', 'Insumo', 'Servimedic', 5, 0.00, 0.00, 0.00, 'Recibido'),
(298, 21, 'Sonda alimentacion #8', 'Operson', 'Insumo', 'Servimedic', 4, 0.00, 0.00, 0.00, 'Recibido'),
(299, 21, 'Bolsa recolectora orina', 'Pediatrico', 'Sterile', 'Servimedic', 31, 0.00, 0.00, 0.00, 'Recibido'),
(300, 21, 'Canula Binasal', 'Adulto', 'Insumo', 'Servimedic', 5, 0.00, 0.00, 0.00, 'Recibido'),
(301, 21, 'Venoset', 'Greetmed', 'Insumo', 'Servimedic', 88, 0.00, 0.00, 0.00, 'Recibido'),
(302, 22, 'Solucion Glucosa 250ml', 'frasco de 250ml', 'glucosa, agua', 'Servimedic', 24, 13.01, 40.00, 359.08, 'Recibido'),
(303, 22, 'Solucion Salina 500ml', 'Frasco 500ml', 'Cloruro de sodio', 'Servimedic', 28, 10.93, 75.00, 351.95, 'Recibido'),
(304, 22, 'Solucion Mixto 500ml', 'frasco 500ml', 'clorhuro de sodio + glucosa', 'Servimedic', 24, 12.01, 75.00, 331.48, 'Recibido'),
(305, 22, 'Solucion Hartman 1000ml', 'frasco 1000ml', 'hartman', 'Servimedic', 16, 11.04, 100.00, 203.14, 'Recibido'),
(306, 23, 'Solucion Salino 100ml', 'Frasco de 100ml', 'Cloruro de sodio', 'Servimedic', 120, 7.76, 35.00, 1070.88, 'Recibido'),
(307, 23, 'Agua esteril 500ml', 'frasco 500ml', 'agua esteril', 'Servimedic', 3, 11.27, 50.00, 38.88, 'Recibido'),
(308, 23, 'Especulo vaginal', 'Talla S', 'descartable', 'Servimedic', 10, 6.90, 35.00, 79.35, 'Recibido'),
(309, 23, 'Especulo vaginal', 'Talla M', 'descartable', 'Servimedic', 10, 6.90, 35.00, 79.35, 'Recibido'),
(310, 23, 'Especulo Vaginal', 'Talla L', 'descartable', 'Servimedic', 10, 6.90, 35.00, 79.35, 'Recibido'),
(311, 24, 'sucragel 240ml', 'suspensión oral', 'sucralfato', 'Servimedic', 5, 80.50, 105.00, 402.50, 'Recibido'),
(312, 25, 'Airessa compuesta', '10 cápsulas', 'bromuro de clidineo 5mg/ dimetilpolisiloxano 150mg', 'Servimedic', 1, 34.50, 55.00, 34.50, 'Recibido'),
(313, 26, 'Sonda alimentacion #8', 'Operson', 'Insumo', 'Servimedic', 1, 4.00, 11.27, 4.00, 'Recibido'),
(314, 27, 'Suero Hidravida', 'suero oral', 'sabor coco', 'Servimedic', 12, 14.30, 18.00, 171.60, 'Recibido'),
(315, 28, 'Budoxigen 0.5ml', '5 viales p/ nebulizar', 'budesonida micronizada 0.5mg/ml', 'Servimedic', 4, 90.93, 170.00, 363.72, 'Recibido'),
(316, 29, 'Clidipox 5mg/2.5mg', '20 Tabletas', 'clordiazepoxido HCI 5mg, bromuro de clidinio 2.5mg', 'Servimedic', 4, 35.36, 65.00, 141.44, 'Recibido'),
(317, 30, 'Goldkaps', '30 capsulas', 'minerales, gingseng', 'Servimedic', 3, 50.00, 125.00, 150.00, 'Recibido'),
(318, 31, 'Goldkaps', '30 capsulas', 'minerales, gingseng', 'Servimedic', 2, 50.00, 125.00, 100.00, 'Recibido'),
(319, 32, 'Tracefusin 20ml', 'fraco/inyectable', 'cloruro de zinc, sulfato cuprico', 'Servimedic', 6, 100.00, 150.00, 600.00, 'Recibido'),
(320, 32, 'Trinara 30ml', 'gotas orales', 'trinara', 'Servimedic', 6, 50.00, 100.00, 300.00, 'Recibido'),
(321, 32, 'Uritam D', '30 capsulas', 'dutasterida 0.5+ tamsulosina clorhidrato 0.4mg', 'Servimedic', 4, 296.24, 600.00, 1184.96, 'Recibido'),
(322, 32, 'Tioflex 10ml', 'sobres bebibles 10ml', 'diclofenaco potasico 50mg, tiocolchicosico 4mg', 'Servimedic', 50, 12.38, 25.00, 619.00, 'Recibido'),
(323, 32, 'Sinervit', '30 capsulas', 'Tiamina, piridoxina, cianocobalamina, diclofenaco', 'Servimedic', 1, 90.00, 190.00, 90.00, 'Recibido'),
(324, 32, 'Dige-Kaps', '30 capsulas', 'pancreatina, simeticona, papaina extracto', 'Servimedic', 6, 75.00, 155.00, 450.00, 'Recibido'),
(325, 33, 'Aciclovirax 120ml', 'Suspension 120ml', 'Aciclovir pediatrico', 'Servimedic', 2, 128.95, 200.00, 257.90, 'Recibido'),
(326, 33, 'Rodiflux 25ml.', 'Gotero', 'Dextrometorfan, carboximetilcisteina, clorfeniramina', 'Servimedic', 2, 60.72, 110.00, 121.44, 'Recibido'),
(327, 33, 'Lisinox 20ml.', 'Gota  ora 20ml', 'Propinoxato clorhidrato 5mg/ml', 'Servimedic', 1, 48.83, 80.00, 48.83, 'Recibido'),
(328, 34, 'Rinofed 120ml', 'Jarabe', 'clorfeniramida, fenilefrina, codeina', 'Servimedic', 5, 95.80, 115.00, 479.00, 'Recibido'),
(329, 34, 'ovumix', 'ovulos vaginales', 'metronidazol, sulfato neomicina, centella asiatica', 'Servimedic', 1, 172.26, 255.00, 172.26, 'Recibido'),
(330, 34, 'Ulcrux 1g/5ml', '30 Sobres', 'Sucralfato 1g', 'Servimedic', 2, 93.07, 140.00, 186.14, 'Recibido'),
(331, 35, 'Ardix 25mg', '10 Tabletas', 'dexketoprofeno 25mg', 'Servimedic', 1, 57.55, 95.00, 57.55, 'Recibido'),
(332, 35, 'Bucaglu 30ml.', 'Tintura Oral', 'ruibarbo y acido salicilico', 'Servimedic', 2, 63.25, 130.00, 126.50, 'Recibido'),
(333, 35, 'Goldkaps', '30 capsulas', 'minerales, gingseng', 'Servimedic', 3, 50.00, 125.00, 150.00, 'Recibido'),
(334, 35, 'Acla-Med Bid 400mg', 'Suspension', 'Amoxicilina+acido clavulanico', 'Servimedic', 1, 51.20, 125.00, 51.20, 'Recibido'),
(335, 36, 'Metilprednisolona', 'frasco inyectable', 'Metilprednisolona 500mg', 'Servimedic', 7, 65.00, 250.00, 455.00, 'Recibido'),
(336, 37, 'Lanzopral Heli-Pack', 'Tabletas 14 dias', 'amoxicilina, clarotromicina, lanzoprazol', 'Servimedic', 1, 470.40, 800.00, 470.40, 'Recibido'),
(337, 38, 'Trinara 30ml', 'gotas orales', 'trinara', 'Servimedic', 1, 60.00, 95.00, 60.00, 'Recibido'),
(338, 38, 'Trinara 30ml', 'gotas orales', 'trinara', 'Servimedic', 5, 60.00, 100.00, 300.00, 'Recibido'),
(339, 39, 'Cefina 100ml', 'Suspecio Oral', 'cefixima 100mlg/5ml', 'Servimedic', 1, 105.00, 220.00, 105.00, 'Recibido'),
(340, 40, 'conflexil 4mg', 'ampolla', 'tiocolchicosido', 'muestras medicas', 3, 0.10, 35.00, 0.30, 'Recibido'),
(341, 40, 'neural 25000', 'ampollas', 'vitaminas B1, B6, B12', 'muestras medicas', 4, 0.01, 80.00, 0.04, 'Recibido'),
(342, 40, 'valepan 2ml', 'ampolla', 'dipropinato de debetametasona', 'muestras medicas', 1, 0.10, 200.00, 0.10, 'Recibido'),
(343, 40, 'valerpan 1ml', 'ampolla', 'dipropinato de debetametasona', 'muestras medicas', 2, 0.10, 180.00, 0.20, 'Recibido'),
(344, 41, 'Deka-C Adultos', '2 Ampollas bebibles 5ml', 'vitaminas A, D, E y C', 'Servimedic', 2, 29.61, 75.00, 59.22, 'Recibido'),
(345, 41, 'Deflarin 6mg', '10 Comprimidos', 'Deflazacort', 'Servimedic', 5, 77.00, 135.00, 385.00, 'Recibido'),
(346, 41, 'Pharmesemid 40mg', '30 Tabletas', 'furisemida, diuréco', 'Servimedic', 6, 53.15, 80.00, 318.90, 'Recibido'),
(347, 42, 'Batas descartables', 'azules', 'batas', 'Servimedic', 80, 0.10, 0.10, 8.00, 'Recibido'),
(348, 43, 'Clevium', 'Ampolla', 'Desketoprofeno 50mg/2ml', 'Servimedic', 9, 5.17, 50.00, 46.53, 'Recibido'),
(349, 43, 'Parenten', 'ampolla', 'parenten 10mg +diazepan 5mg', 'Servimedic', 3, 11.50, 100.00, 34.50, 'Recibido'),
(350, 44, 'Sitalev Met 50/1000mg', '30 Tabletas recubiertas', 'Sitagliptina 50mg* metformina clorhidrato 1000mg', 'Servimedic', 10, 154.10, 215.00, 1541.00, 'Recibido'),
(351, 44, 'Celedexa 0.25mg/2mg', '10 tabletas', 'Betametazona 0.25mg+Dexclorfeniramina maleato 2mg', 'Servimedic', 10, 144.00, 0.10, 1440.00, 'Recibido'),
(352, 44, 'Benzoclid Duo', '10  Cápsulas', 'Simeticona+bromuro de otilonio', 'Servimedic', 30, 386.00, 0.10, 11580.00, 'Recibido'),
(353, 44, 'Virokem 120ml', 'Jarabe 120ml', 'Amentadina HCI+ Clorfeniramina maleato+ acetaminofen+ Fenilefrina HCI', 'Servimedic', 4, 50.60, 110.00, 202.40, 'Recibido'),
(354, 44, 'Histakem Block 30ml.', 'Spray bucal 30ml', 'Cloruro de cetilpiridinio 0.05g+benzocaina 1.0g', 'Servimedic', 12, 92.00, 125.00, 1104.00, 'Recibido'),
(355, 45, 'Virokem', '10 capsulas', 'Amentadina HCI+ Clorfeniramina maleato+ acetaminofen+ Fenilefrina HCI', 'Servimedic', 10, 138.00, 65.00, 1380.00, 'Recibido'),
(356, 45, 'Triamin CB', 'Capsula', 'Vitamina D3 100000 UI', 'Servimedic', 11, 186.30, 390.00, 2049.30, 'Recibido'),
(357, 45, 'Quimida 300mg', 'comprimido', 'Quimfamida 300mg', 'Servimedic', 5, 0.10, 0.10, 0.50, 'Recibido'),
(358, 45, 'Quimida 30ml', 'Suspension oral', 'Quinfamida 50mg/5ml', 'Servimedic', 5, 0.10, 0.10, 0.50, 'Recibido'),
(359, 46, 'Espasmex Forte', '10 COmprimidos', 'Propixonato HCI 20mg + Clonixinato de linasa 125mg', 'Servimedic', 5, 0.10, 0.10, 0.50, 'Recibido'),
(360, 46, 'Medibriz Pediatrico 10ml', 'Suspensio oral', 'Mebensazol 60mg+ Quindamida 10mg', 'Servimedic', 6, 59.80, 110.00, 358.80, 'Recibido'),
(361, 46, 'Medibriz Infantil 10ml', 'Suspension Oral', 'Mebensazol 60mg+ Quindamida 20mg', 'Servimedic', 6, 59.80, 110.00, 358.80, 'Recibido'),
(362, 46, 'Tramadol 10ml', 'Gotas Orales', 'Tramadol HCI 100mg/ml', 'Servimedic', 5, 69.00, 110.00, 345.00, 'Recibido'),
(363, 47, 'Especulo Vaginal', 'Talla L', 'descartable', 'Servimedic', 10, 6.33, 35.00, 63.30, 'Recibido'),
(364, 47, 'Especulo Vaginal', 'Talla M', 'descartable', 'Servimedic', 10, 6.33, 35.00, 63.30, 'Recibido'),
(365, 47, 'Especulo Vaginal', 'Talla S', 'descartable', 'Servimedic', 10, 6.33, 35.00, 63.30, 'Recibido'),
(366, 48, 'Especulo Vaginal', 'Talla L', 'descartable', 'Servimedic', 10, 6.33, 35.00, 63.30, 'Pendiente'),
(367, 48, 'Especulo Vaginal', 'Talla M', 'descartable', 'Servimedic', 10, 6.33, 35.00, 63.30, 'Pendiente'),
(368, 48, 'Especulo Vaginal', 'Talla S', 'descartable', 'Servimedic', 10, 6.33, 35.00, 63.30, 'Pendiente'),
(369, 49, 'Parenten', 'Ampolla 2ml', 'Diazepoam 10mg', 'Servimedic', 9, 10.00, 100.00, 90.00, 'Recibido'),
(370, 49, 'Morfina Sulfato', 'Ampolla 1ml', 'morfina', 'Servimedic', 10, 0.10, 0.10, 1.00, 'Recibido'),
(371, 49, 'Haloperidol', 'ampolla 1ml', 'haloperidol 5mg/ml', 'Servimedic', 5, 0.10, 0.10, 0.50, 'Recibido'),
(372, 50, 'Aciclovirax 120ml', 'Suspension 120ml', 'Aciclovir pediatrico', 'Servimedic', 1, 128.95, 200.00, 128.95, 'Recibido'),
(373, 51, 'Dermapunt', 'micro-agujas dermaticas', 'descartables', 'Servimedic', 11, 0.10, 0.10, 1.10, 'Recibido'),
(374, 51, 'Deflamol 6mg', '10 comprimidos', 'Deflazacort', 'Servimedic', 4, 0.10, 0.10, 0.40, 'Recibido'),
(375, 51, 'Dartrax-B', '3 ampolls', 'Dexketoprofeno+vitaminas neurotropas', 'Servimedic', 40, 0.10, 0.10, 4.00, 'Recibido'),
(376, 52, 'Tetravit forte 25000', 'Ampolla', 'neurotropas', 'muestras medicas', 2, 0.10, 45.00, 0.20, 'Recibido'),
(377, 53, 'Histakem Block 30ml.', 'Spray bucal 30ml', 'Cloruro de cetilpiridinio 0.05g+benzocaina 1.0g', 'Servimedic', 3, 92.00, 125.00, 276.00, 'Recibido'),
(378, 53, 'Steri-strip', 'descartable', '10*6mm*100mm', 'Servimedic', 2, 0.10, 0.10, 0.20, 'Recibido'),
(379, 53, 'Tegaderm', 'descartable', '10*12cm', 'Servimedic', 2, 0.10, 0.10, 0.20, 'Recibido'),
(380, 53, 'Tegaderm', 'descartable', '15*20cm', 'Servimedic', 4, 0.10, 0.10, 0.40, 'Recibido'),
(381, 54, 'sucragel 240ml', 'suspensión oral', 'sucralfato', 'Servimedic', 4, 80.50, 105.00, 322.00, 'Recibido'),
(382, 54, 'Goldkaps', '30 capsulas', 'minerales, gingseng', 'Servimedic', 10, 50.00, 125.00, 500.00, 'Recibido'),
(383, 54, 'Hepamob', '30 Comprimidos', 'Cilimarina+complejo b', 'Servimedic', 4, 90.00, 150.00, 360.00, 'Recibido'),
(384, 54, 'Esomeprakem', '10 Capsulas', 'Esomeprazol 40mg/levofloxacina 500mg/amoxicilina 500mg', 'Servimedic', 10, 36.00, 70.00, 360.00, 'Recibido'),
(385, 55, 'Recharje Plus', '30 capsulas', 'Coenzima Q10 con vitamina y minerales', 'Servimedic', 15, 0.10, 0.10, 1.50, 'Recibido'),
(386, 55, 'Unocef 120ml', 'Suspension oral', 'Cefixima 100mg/5ml', 'Servimedic', 1, 0.10, 280.00, 0.10, 'Recibido'),
(387, 55, 'Kitadol 20mg', '20 comprimidos', 'ketorolaco trometamina 20mg', 'Servimedic', 4, 0.10, 0.10, 0.40, 'Recibido'),
(388, 57, 'AcneVit', 'Gel limpiador', 'Vitamina C+niacinamida+ectracto de centella Asiatica', 'Servimedic', 1, 0.10, 0.10, 0.10, 'Recibido'),
(389, 57, 'Hydratonic Bamboo', 'Tonico facial', 'Extracto de limon, naranja, caña de azucar y arce', 'Servimedic', 1, 0.10, 0.10, 0.10, 'Recibido'),
(390, 58, 'Aquabalance cream 50ml', 'crena hidratante', 'rosa mosqueta, sodiu hyaluronate', 'Servimedic', 1, 0.10, 0.10, 0.10, 'Recibido'),
(391, 59, 'Operson  4*10 yds', 'descartable', 'Venda de Gasa', 'Servimedic', 12, 0.10, 0.10, 1.20, 'Recibido'),
(392, 59, 'Operson 6*10 yds', 'descartable', 'Venda de Gasa', 'Servimedic', 12, 0.10, 0.10, 1.20, 'Recibido'),
(393, 62, 'Fenobrox  240ml', 'suspensión oral', 'Cloperastina', 'Servimedic', 4, 36.00, 110.00, 144.00, 'Recibido'),
(394, 63, 'hidralazina', 'ampolla', 'hidralazina', 'Servimedic', 1, 87.60, 150.00, 87.60, 'Recibido'),
(395, 64, 'Sonda Foley 2 vias', 'descartable', 'sonda 2 vias', 'Servimedic', 20, 0.10, 0.10, 2.00, 'Recibido'),
(396, 65, 'Disolflem 200mg', '10 sobre', 'acetilcisteina', 'servimedic', 5, 50.27, 105.00, 251.35, 'Recibido'),
(397, 65, 'Disolflem 600', '10 sticks', 'Acetilcisteina', 'servimedic', 10, 64.42, 105.00, 644.20, 'Recibido'),
(398, 65, 'Dalivium 50mg', 'Dexketoprofeno', 'ampolla', 'servimedic', 50, 9.41, 50.00, 470.50, 'Recibido'),
(399, 65, 'Conflexil', 'ampolla 4mg/2ml', 'Tiocolchicosido', 'servimedic', 25, 23.22, 35.00, 580.50, 'Recibido'),
(400, 66, 'Monoflocet 1g/500mg', 'Frasco Inyectable', 'ceftriaxona +sulbactam', 'servimedic', 35, 45.60, 130.00, 1596.00, 'Recibido'),
(401, 66, 'Demelan', 'Tabletas 500mg', 'Nitazoxanida', 'servimedic', 18, 54.00, 90.00, 972.00, 'Recibido'),
(402, 66, 'Demelan Pediatrico', 'Suspension polvo', 'Nitazoxanida', 'servimedic', 9, 43.52, 85.00, 391.68, 'Recibido'),
(403, 66, 'Idealift', 'crema', 'liposomas,acido,poligalacturonico', 'servimedic', 6, 103.84, 130.00, 623.04, 'Recibido'),
(409, 68, 'Nopioxx', 'Crema', 'calendula,manzanilla, centella', 'servimedic', 8, 66.12, 80.00, 528.96, 'Recibido'),
(410, 68, 'Lixone-Fem', 'Gel intimo', 'acido hialuronico,melaleuca', 'servimedic', 5, 128.57, 170.00, 642.85, 'Recibido'),
(411, 68, 'Lixone -pediatrico', 'Gel', 'Betainas,extracto de bardana', 'servimedic', 3, 119.26, 165.00, 357.78, 'Recibido'),
(412, 68, 'Dermodian Baby', 'Crema', 'Oxido de zinc,vitamina E, melaleuca', 'servimedic', 6, 56.48, 70.00, 338.88, 'Recibido'),
(413, 68, 'Catlizeg', '30 Capsulas', 'enzimas digestivas con dimetilpoli', 'servimedic', 3, 92.27, 115.00, 276.81, 'Recibido'),
(414, 69, 'Previtro', '30 Capsulas', 'semilla de calabaza', 'servimedic', 3, 125.82, 200.00, 377.46, 'Recibido'),
(415, 69, 'Viprena', '30 Capsulas', 'vitamina D,A,E,B1,B2,B3', 'servimedic', 6, 72.60, 130.00, 435.60, 'Recibido'),
(416, 69, 'Higaprof Plus', '30 Sobres', 'Acidos Grasos,vitamina E,B12,B6', 'servimedic', 7, 167.76, 260.00, 1174.32, 'Recibido'),
(417, 69, 'Cefaxil', 'Suspension en polvo', 'cefadroxilo100mg/ml', 'servimedic', 7, 46.00, 65.00, 322.00, 'Recibido'),
(418, 70, 'Kralvir-us 800', '10 Tabletas', 'Aciclovir', 'servimedic', 28, 225.42, 285.00, 6311.76, 'Recibido'),
(419, 70, 'Bru-sone 2ml', 'Ampolla', 'betametasona', 'servimedic', 30, 111.48, 190.00, 3344.40, 'Recibido'),
(420, 70, 'Meloxicam,Sulfato de glucosamina', '30 Sobres', 'meloxicam +glucosamina', 'servimedic', 5, 204.00, 250.00, 1020.00, 'Recibido'),
(421, 70, 'Besart', '30 Capsulas', 'magnesio, extracto de ginkgo', 'servimedic', 6, 210.00, 255.00, 1260.00, 'Recibido'),
(422, 70, 'Logenol', '10 Capsulas', 'etoricoxib 90mg', 'servimedic', 10, 138.00, 165.00, 1380.00, 'Recibido'),
(423, 71, 'Inmuno Biter', 'Ampollas bebibles', 'calactoferrina,extracto de glicerinado', 'servimedic', 2, 333.39, 390.00, 666.78, 'Recibido'),
(424, 71, 'Jeringa 5ml', 'descartable', '', 'servimedic', 9, 0.84, 5.00, 7.56, 'Recibido'),
(425, 71, 'Venoset', 'descartable', '', 'servimedic', 100, 6.90, 15.00, 690.00, 'Recibido'),
(426, 71, 'Angiocath #22', 'descartable', '', 'servimedic', 100, 6.60, 15.00, 660.00, 'Recibido'),
(427, 71, 'Angiocath #20', 'descartable', '', 'servimedic', 50, 6.60, 15.00, 330.00, 'Recibido');
INSERT INTO `purchase_items` (`id`, `purchase_header_id`, `product_name`, `presentation`, `molecule`, `pharmaceutical_house`, `quantity`, `unit_cost`, `sale_price`, `subtotal`, `status`) VALUES
(433, 73, 'Angiocath #24', 'descartable', '', 'servimedic', 135, 6.60, 15.00, 891.00, 'Recibido'),
(434, 73, 'Cefina 100ml', 'suspension en polvo', 'cefixima', 'servimedic', 2, 103.50, 2520.00, 207.00, 'Recibido'),
(435, 73, 'Tonico Alfalfa', 'suspension', 'tonico alfalfa', 'servimedic', 3, 120.64, 210.00, 361.92, 'Recibido'),
(436, 73, 'Jeringa 10ml', 'descartable', '', 'servimedic', 46, 0.58, 5.00, 26.68, 'Recibido'),
(437, 73, 'Jeringa 3ml', 'descartable', '', 'servimedic', 116, 0.84, 5.00, 97.44, 'Recibido'),
(438, 74, 'Bru-Cobal', 'ampolla 1ml', 'Mecobalamina', 'Muestra medica', 2, 0.01, 65.00, 0.02, 'Pendiente'),
(439, 74, 'Atenua', 'Ampolla', 'dexketoprofeno 50mg', 'Muestra medica', 4, 0.01, 50.00, 0.04, 'Recibido'),
(440, 75, 'Gluconato de Calcio 10ml', 'ampolla', 'Gluconato 10%', 'servimedic', 4, 50.00, 100.00, 200.00, 'Recibido'),
(441, 76, 'Lidocaina sin epinefrina', 'centimetros', 'lidocaina', 'servimedic', 50, 1.75, 10.00, 87.50, 'Recibido'),
(442, 76, 'Ulcrux Individuales', 'sobres', 'sucralfato', 'servimedic', 29, 5.29, 10.00, 153.41, 'Recibido'),
(443, 77, 'Uroprin 3g', 'Fosfomicina 3g', 'Sticker granulado', 'servimedic', 1, 145.36, 165.00, 145.36, 'Recibido'),
(444, 78, 'Clindacrem 2%', 'Tubo 40G+ aplicadores', 'Clindamicina', 'servimedic', 10, 114.00, 200.00, 1140.00, 'Recibido'),
(445, 78, 'Sesoral', 'Viales bebibles 15ml', 'Acido glutamico+ complejo b', 'servimedic', 10, 120.00, 220.00, 1200.00, 'Recibido'),
(446, 78, 'Gatrodex', '28 Tabletas', 'Rabeprazol sodico', 'servimedic', 20, 237.93, 390.00, 4758.60, 'Recibido'),
(447, 78, 'Dolosal', 'Ampolla 100mg/2ml', 'Petidina', 'servimedic', 10, 72.00, 150.00, 720.00, 'Recibido'),
(448, 78, 'Nircip', 'Frasco de 100ml', 'Ciprofloxacina', 'servimedic', 3, 27.60, 80.00, 82.80, 'Recibido'),
(449, 78, 'Ovumix', '6 Ovulos Vaginales', 'Metronidazol/nitrato de miconazol', 'servimedic', 7, 207.60, 260.00, 1453.20, 'Recibido'),
(450, 78, 'Platsul-A', 'Crema 30 G', 'Sulfadiazina de plata+vit A', 'servimedic', 7, 100.80, 130.00, 705.60, 'Recibido'),
(451, 79, 'Platsul-A', 'Tarro', 'Sulfadiazina de plata +vit A', 'servimedic', 2, 594.00, 850.00, 1188.00, 'Recibido'),
(452, 79, 'Total Magnesiano', '30 Sobres efervecentes', 'Magnesio', 'servimedic', 18, 152.00, 230.00, 2736.00, 'Recibido'),
(453, 79, 'AB-Digest', '30 Sticks', 'Lactobacillus pediocuccus', 'servimedic', 24, 439.00, 590.00, 10536.00, 'Recibido'),
(454, 79, 'Dostein 90ml', 'Suspension 175mg/5ml', 'Erdosteina', 'servimedic', 20, 130.00, 155.00, 2600.00, 'Recibido'),
(455, 79, 'Dostein 300mg', '20 Tabletas', 'Erdoateina', 'servimedic', 20, 144.00, 175.00, 2880.00, 'Recibido'),
(456, 79, 'Disolflem 200mg', '10 sobre granulados', 'Acetilcisteina', 'servimedic', 6, 51.27, 105.00, 307.62, 'Recibido'),
(457, 79, 'Disolflem 600', '10 Sticks granuladod', 'Aceltisteina', 'servimedic', 5, 65.71, 135.00, 328.55, 'Recibido'),
(458, 79, 'Dalivium', 'Ampollas 500mg/ml', 'dexketoprofeno', 'servimedic', 50, 9.60, 50.00, 480.00, 'Recibido'),
(459, 80, 'Conflexil', 'Ampoll 4mg/2ml', 'Tiocolchicosico', 'servimedic', 25, 23.69, 35.00, 592.25, 'Recibido'),
(460, 80, 'Costipak', 'Suspension', 'Lactulosa', 'servimedic', 4, 90.90, 190.00, 363.60, 'Recibido'),
(461, 80, 'Lixone Fem', 'Gel Intimo', 'Acido Hialuronico,mellaleuca', 'servimedic', 2, 128.56, 170.00, 257.12, 'Recibido'),
(462, 81, 'Clevium', 'Ampolla', 'Dexketoprofeno', 'Servimedic', 1, 0.01, 50.00, 0.01, 'Recibido'),
(463, 81, 'Bixicort', 'Ampolla', 'Betametasona', 'Servimedic', 1, 0.01, 150.00, 0.01, 'Recibido'),
(464, 81, 'Nutriben', 'bote', '800g', 'Servimedic', 1, 0.01, 225.00, 0.01, 'Recibido'),
(465, 81, 'Nutriben', 'Bote leche', '400g', 'Servimedic', 1, 0.01, 125.00, 0.01, 'Recibido'),
(466, 81, 'Meropenem 500mg', 'Frasco vial', 'Meropenem', 'Servimedic', 10, 0.01, 150.00, 0.10, 'Recibido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `purchase_payments`
--

CREATE TABLE `purchase_payments` (
  `id` int NOT NULL,
  `purchase_header_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` date NOT NULL,
  `payment_method` varchar(50) DEFAULT 'Efectivo',
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rayos_x`
--

CREATE TABLE `rayos_x` (
  `id_rayos_x` int NOT NULL,
  `id_paciente` int NOT NULL,
  `nombre_paciente` varchar(255) NOT NULL,
  `tipo_estudio` varchar(255) NOT NULL,
  `cobro` decimal(10,2) NOT NULL,
  `fecha_estudio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(255) DEFAULT NULL,
  `tipo_pago` enum('Efectivo','Tarjeta','Transferencia') DEFAULT 'Efectivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `rayos_x`
--

INSERT INTO `rayos_x` (`id_rayos_x`, `id_paciente`, `nombre_paciente`, `tipo_estudio`, `cobro`, `fecha_estudio`, `usuario`, `tipo_pago`) VALUES
(1, 93, 'William Francisco Mendoza Escobar', 'Senos Paranasales', 300.00, '2026-02-03 16:43:00', 'Anye', 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reactivos_laboratorio`
--

CREATE TABLE `reactivos_laboratorio` (
  `id_reactivo` int NOT NULL,
  `codigo_reactivo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_reactivo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fabricante` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proveedor` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_lote` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_serie` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_fabricacion` date DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `cantidad_disponible` decimal(10,3) NOT NULL DEFAULT '0.000',
  `unidad_medida` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ml, piezas, tests, etc',
  `cantidad_minima` decimal(10,3) DEFAULT '10.000',
  `costo_unitario` decimal(10,2) DEFAULT NULL,
  `ubicacion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Refrigeradora A, Estante 3, etc',
  `condiciones_almacenamiento` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Temperatura, luz, humedad',
  `estado` enum('Disponible','Por_Vencer','Vencido','Agotado','En_Cuarentena') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Disponible',
  `notas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_ingreso` date DEFAULT NULL,
  `ingresado_por` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes_estadisticas`
--

CREATE TABLE `reportes_estadisticas` (
  `id_reporte` int NOT NULL,
  `tipo_reporte` varchar(50) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `datos` json NOT NULL,
  `fecha_generacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_generacion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas_inventario`
--

CREATE TABLE `reservas_inventario` (
  `id_reserva` int NOT NULL,
  `id_inventario` int NOT NULL,
  `cantidad` int NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `fecha_reserva` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultados_laboratorio`
--

CREATE TABLE `resultados_laboratorio` (
  `id_resultado` int NOT NULL,
  `id_orden_prueba` int NOT NULL,
  `id_parametro` int NOT NULL,
  `valor_resultado` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Valor como texto',
  `valor_numerico` decimal(12,4) DEFAULT NULL COMMENT 'Para facilitar queries y análisis',
  `fuera_rango` enum('Normal','Alto','Bajo','Crítico_Alto','Crítico_Bajo') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Normal',
  `valor_referencia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Rango aplicable según paciente',
  `unidad_medida` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metodo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Método de análisis utilizado',
  `validado` tinyint(1) DEFAULT '0',
  `fecha_resultado` datetime DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `procesado_por` int DEFAULT NULL,
  `validado_por` int DEFAULT NULL,
  `fecha_validacion` datetime DEFAULT NULL,
  `firma_digital` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Hash o firma del validador',
  `enviado_medico` tinyint(1) DEFAULT '0',
  `fecha_envio_medico` datetime DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `signos_vitales`
--

CREATE TABLE `signos_vitales` (
  `id_signo` int NOT NULL,
  `id_encamamiento` int NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `temperatura` decimal(4,2) DEFAULT NULL COMMENT 'Celsius',
  `presion_sistolica` int DEFAULT NULL COMMENT 'mmHg',
  `presion_diastolica` int DEFAULT NULL COMMENT 'mmHg',
  `pulso` int DEFAULT NULL COMMENT 'latidos por minuto',
  `frecuencia_respiratoria` int DEFAULT NULL COMMENT 'respiraciones por minuto',
  `saturacion_oxigeno` decimal(5,2) DEFAULT NULL COMMENT 'Porcentaje',
  `peso_kg` decimal(6,2) DEFAULT NULL,
  `talla_cm` decimal(5,2) DEFAULT NULL,
  `imc` decimal(5,2) GENERATED ALWAYS AS ((case when (`talla_cm` > 0) then (`peso_kg` / ((`talla_cm` / 100) * (`talla_cm` / 100))) else NULL end)) STORED,
  `glucometria` decimal(5,2) DEFAULT NULL COMMENT 'mg/dL',
  `dolor_escala` int DEFAULT NULL COMMENT 'Escala 0-10',
  `estado_conciencia` enum('Alerta','Somnoliento','Estuporoso','Comatoso') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `registrado_por` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ultrasonidos`
--

CREATE TABLE `ultrasonidos` (
  `id_ultrasonido` int NOT NULL,
  `id_paciente` int NOT NULL,
  `nombre_paciente` varchar(255) NOT NULL,
  `tipo_ultrasonido` varchar(255) NOT NULL,
  `cobro` decimal(10,2) NOT NULL,
  `fecha_ultrasonido` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(255) DEFAULT NULL,
  `tipo_pago` enum('Efectivo','Tarjeta','Transferencia') DEFAULT 'Efectivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `ultrasonidos`
--

INSERT INTO `ultrasonidos` (`id_ultrasonido`, `id_paciente`, `nombre_paciente`, `tipo_ultrasonido`, `cobro`, `fecha_ultrasonido`, `usuario`, `tipo_pago`) VALUES
(1, 90, 'Keiry  López', 'Inguinal', 500.00, '2026-02-02 20:55:57', 'Anye', 'Efectivo'),
(2, 93, 'William Francisco Mendoza Escobar', 'Prostatico', 250.00, '2026-02-03 16:42:12', 'Anye', 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` int NOT NULL,
  `usuario` varchar(255) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `especialidad` varchar(255) DEFAULT NULL,
  `tipoUsuario` enum('admin','doc','user','') NOT NULL,
  `clinica` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `permisos_modulos` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `usuario`, `password`, `nombre`, `apellido`, `especialidad`, `tipoUsuario`, `clinica`, `telefono`, `email`, `permisos_modulos`) VALUES
(1, 'admin', 'admin', 'Samuel', 'Ramirez', 'Ingeniero en Sistemas', 'admin', 'Centro Médico Herrera Saenz', '49617032', 'samuel.ramirez25prs@gmail.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}'),
(6, 'JeimiFarm', 'CMHS39', 'Jeimi', 'Rivas', 'Farmacia', 'user', 'Centro Médico Herrera Saenz', '0000', 'jeimi@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(7, 'AnyeSec', 'CMHS48', 'Anye', 'Tello', 'Recepción y Cobros', 'user', 'Centro Médico Herrera Saenz', '0000', 'anye@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(8, 'fherrera', 'cmhs', 'Francisco', 'Herrera', 'Administrador General', 'admin', 'Centro Médico Herrera Saenz', '0000', 'francisco@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}'),
(9, 'JannyaAdmi', 'CMHS100', 'Jannya', 'Rivas', 'Administrador General', 'admin', 'Centro Médico Herrera Saenz', '0000', 'jannya@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}'),
(10, 'epineda', 'cmhs', 'Enrique', 'Pineda', 'Administrador General', 'admin', 'Centro Médico Herrera Saenz', '0000', 'enrique@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}'),
(11, 'iherrera', 'cmhs', 'Isabel', 'Herrera', 'Administrador General', 'admin', 'Centro Médico Herrera Saenz', '0000', 'isabel@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}'),
(12, 'YeniferAdmi', 'CMHS12', 'Yenifer', 'Santos', 'Farmacia Interna y Controles', 'admin', 'Centro Médico Herrera Saenz', '0000', 'yenifer@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}'),
(13, 'lvalle', 'cmhs', 'Luis Carlos', 'del Valle', 'Medicina Interna', 'doc', 'Centro Médico Herrera Saenz', '0000', 'luis@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(14, 'jrivas_saenz', 'cmhs', 'Jannya', 'Rivas Sáenz', 'Medico y cirujano', 'doc', 'Centro Médico Herrera Saenz', '0000', 'jannyas@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(15, 'erivas', 'cmhs', 'Estuardo', 'Rivas', 'Ginecólogo y Obstetra', 'doc', 'Centro Médico Herrera Saenz', '0000', 'estuardo@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(16, 'mmutas', 'cmhs', 'Mayeli', 'Mutás Ochoa', 'Medicina Interna', 'doc', 'Centro Médico Herrera Saenz', '0000', 'mayeli@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(17, 'lrecinos', 'cmhs', 'Libny', 'Recinos', 'Pediatra', 'doc', 'Centro Médico Herrera Saenz', '0000', 'libny@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(18, 'iherrera_nutri', 'cmhs', 'Isabel', 'Herrera', 'Nutricionista', 'doc', 'Centro Médico Herrera Saenz', '0000', 'isabel_n@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(19, 'doc_turno1', 'cmhs', 'Bryam', 'Martinez', 'Médico de Turno', 'doc', 'Centro Médico Herrera Saenz', '0000', 'turno1@example.com', '{\"billing\": true, \"patients\": true}'),
(20, 'doc_turno2', 'cmhs', 'Engie', 'Sarmiento', 'Médico de Turno', 'doc', 'Centro Médico Herrera Saenz', '0000', 'turno2@example.com', '{\"billing\": true, \"patients\": true}'),
(21, 'doc_turno3', 'cmhs', 'Cristian', 'Mendoza', 'Médico de Turno', 'doc', 'Centro Médico Herrera Saenz', '0000', 'turno3@example.com', '{\"billing\": true, \"patients\": true}'),
(22, 'doc_turno4', 'cmhs', 'Odin', 'Rivas', 'Médico de Turno', 'doc', 'Centro Médico Herrera Saenz', '0000', 'lab@example.com', '{\"billing\": true, \"patients\": true}'),
(23, 'farmacia_2', 'cmhs', 'Farmacia', 'Usuario 2', 'Farmacia', 'user', 'Centro Médico Herrera Saenz', '0000', 'farmacia2@example.com', '{\"hospitalization\": false, \"laboratory\": false, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": false, \"inventory\": true, \"billing\": false, \"reports\": false, \"appointments\": false, \"patients\": false, \"medications\": true, \"settings\": false}'),
(24, 'dra.belen', '12345', 'Belén', 'López', 'Pediatra', 'doc', 'Centro Médico Herrera Saenz', '0000', 'dra.belen@cmhs.com', '{\"billing\": true, \"patients\": true}'),
(25, 'dra.yoana', '12345', 'Yoana Mabel', 'Gómez López', 'Médico General', 'doc', 'Centro Médico Herrera Saenz', '0000', 'dra.yoana@cmhs.com', '{\"billing\": true, \"patients\": true}'),
(26, 'KenniaEnf', 'CMHS25', 'Enf', 'Kennia', 'Enfermera Profesional', 'user', 'Centro Médico Herrera Saenz', '0000', 'kennia@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(27, 'MarlenyEnf', 'CMHS40', 'Enf', 'Marleny', 'Enfermera Profesional', 'user', 'Centro Médico Herrera Saenz', '0000', 'marleny@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(28, 'HeidyEnf', 'CMHS75', 'Enf', 'Heidy', 'Enfermera Profesional', 'user', 'Centro Médico Herrera Saenz', '0000', 'heidy@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int NOT NULL,
  `id_usuario` int DEFAULT NULL,
  `fecha_venta` datetime DEFAULT CURRENT_TIMESTAMP,
  `nombre_cliente` varchar(100) DEFAULT NULL,
  `nit_cliente` varchar(50) DEFAULT 'C/F',
  `tipo_pago` enum('Efectivo','Tarjeta','Seguro Médico','Transferencia','Traslado') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `total` decimal(10,2) DEFAULT '0.00',
  `estado` enum('Pendiente','Pagado','Cancelado') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `id_usuario`, `fecha_venta`, `nombre_cliente`, `nit_cliente`, `tipo_pago`, `total`, `estado`) VALUES
(1, 6, '2026-01-20 11:03:43', 'Laseser Damian', 'C/F', 'Efectivo', 555.00, 'Pagado'),
(2, 6, '2026-01-25 13:22:35', 'jrivas_farmacia', 'C/F', 'Efectivo', 18.00, 'Pagado'),
(3, 6, '2026-01-26 08:57:20', 'jeimi rivas', 'C/F', 'Efectivo', 250.00, 'Pagado'),
(4, 6, '2026-01-26 09:14:35', 'Hermelinda Vásquez', 'C/F', 'Efectivo', 55.00, 'Pagado'),
(5, 6, '2026-01-26 09:23:56', 'Elvia Tayún', 'C/F', 'Efectivo', 100.00, 'Pagado'),
(6, 6, '2026-01-26 09:29:19', 'Santiago Lorenzo', 'C/F', 'Efectivo', 145.00, 'Pagado'),
(7, 6, '2026-01-26 09:46:10', 'Leyser Lopez', 'C/F', 'Efectivo', 18.00, 'Pagado'),
(8, 6, '2026-01-26 09:50:34', 'Matilde Lopez', 'C/F', 'Efectivo', 250.00, 'Pagado'),
(9, 6, '2026-01-26 09:53:56', 'Martin Villatoro', 'C/F', 'Efectivo', 140.00, 'Pagado'),
(10, 6, '2026-01-26 10:05:17', 'Edwin Perez', 'C/F', 'Efectivo', 340.00, 'Pagado'),
(11, 6, '2026-01-26 11:59:24', 'Matilde Lopez', 'C/F', 'Tarjeta', 1355.00, 'Pagado'),
(12, 6, '2026-01-26 12:06:39', 'le', 'C/F', 'Efectivo', 30.00, 'Pagado'),
(13, 6, '2026-01-26 14:12:21', 'Javier Luis', 'C/F', 'Efectivo', 215.00, 'Pagado'),
(14, 6, '2026-01-26 14:17:15', 'Ivan  montejo', 'C/F', 'Tarjeta', 155.00, 'Pagado'),
(15, 6, '2026-01-26 14:25:30', 'jrivas_farmacia', 'C/F', 'Efectivo', 595.00, 'Pagado'),
(16, 6, '2026-01-26 14:32:47', 'jafit figueroa', 'C/F', 'Efectivo', 255.00, 'Pagado'),
(17, 6, '2026-01-26 14:53:21', 'Javier Luis', 'C/F', 'Efectivo', 535.00, 'Pagado'),
(18, 6, '2026-01-28 14:05:21', 'Uriel Leiva', 'C/F', 'Efectivo', 175.00, 'Pagado'),
(19, 6, '2026-01-28 14:17:30', 'Nancy Perez', 'C/F', 'Efectivo', 670.00, 'Pagado'),
(20, 6, '2026-01-28 14:40:50', 'Javier Luis', 'C/F', 'Efectivo', 65.00, 'Pagado'),
(21, 6, '2026-01-28 14:46:51', 'c/f', 'C/F', 'Efectivo', 55.00, 'Pagado'),
(22, 6, '2026-01-28 14:54:07', 'Angela vasquez', 'C/F', 'Efectivo', 590.00, 'Pagado'),
(23, 6, '2026-01-28 14:58:05', 'Edwin Perez', 'C/F', 'Efectivo', 715.00, 'Pagado'),
(24, 6, '2026-01-28 15:11:05', 'Rosa Castillo', 'C/F', 'Efectivo', 628.00, 'Pagado'),
(25, 6, '2026-01-28 15:44:56', 'Icelda Herrera', 'C/F', 'Efectivo', 1640.00, 'Pagado'),
(26, 6, '2026-01-28 15:47:50', 'Maria', 'C/F', 'Efectivo', 640.00, 'Pagado'),
(27, 6, '2026-01-28 15:51:13', 'Edem Gomez', 'C/F', 'Efectivo', 1205.00, 'Pagado'),
(28, 6, '2026-01-28 15:55:08', 'Edwin Hernandez', 'C/F', 'Efectivo', 368.00, 'Pagado'),
(29, 6, '2026-01-28 16:16:34', 'c/f', 'C/F', 'Efectivo', 785.00, 'Pagado'),
(30, 6, '2026-01-28 16:46:36', 'c/f', 'C/F', 'Efectivo', 100.00, 'Pagado'),
(31, 6, '2026-01-31 13:39:15', 'keiry lopez', 'C/F', 'Efectivo', 870.00, 'Pagado'),
(32, 6, '2026-02-02 14:21:53', 'consumidor final', 'C/F', 'Efectivo', 18.00, 'Pagado'),
(33, 6, '2026-02-02 14:43:29', 'Anderson Figueroa', 'C/F', 'Efectivo', 435.00, 'Pagado'),
(34, 6, '2026-02-02 17:03:00', 'Miriam matias', 'C/F', 'Efectivo', 1055.00, 'Pagado'),
(35, 6, '2026-02-02 17:09:11', 'Joseph Leiva', 'C/F', 'Efectivo', 845.00, 'Pagado'),
(36, 6, '2026-02-02 17:10:32', 'Jhosep Leiva', 'C/F', 'Efectivo', 210.00, 'Pagado'),
(37, 6, '2026-02-02 17:12:51', 'Anderson Argueta', 'C/F', 'Efectivo', 910.00, 'Pagado'),
(38, 6, '2026-02-02 17:14:26', 'Jhosep Leiva', 'C/F', 'Efectivo', 400.00, 'Pagado'),
(39, 6, '2026-02-02 17:16:47', 'Anderson Argueta', 'C/F', 'Efectivo', 200.00, 'Pagado'),
(40, 6, '2026-02-03 12:21:57', 'consumidor final', 'C/F', 'Efectivo', 470.00, 'Pagado'),
(41, 6, '2026-02-04 10:04:33', 'consumidor final', 'C/F', 'Efectivo', 100.00, 'Pagado'),
(42, 6, '2026-02-04 11:42:23', 'Jhosep Leiva', 'C/F', 'Efectivo', 250.00, 'Pagado'),
(43, 6, '2026-02-04 12:30:40', 'Dra. Jannya Rivas', 'C/F', 'Efectivo', 60.00, 'Pagado'),
(44, 23, '2026-02-04 15:12:35', '03-02-2026', 'C/F', 'Efectivo', 100.00, 'Pagado'),
(45, 1, '2026-02-04 21:35:07', 'Servimedic', 'C/F', 'Traslado', 0.00, 'Pagado'),
(46, 6, '2026-02-05 15:41:41', 'Zulma Villatoro', 'C/F', 'Efectivo', 535.00, 'Pagado'),
(47, 6, '2026-02-05 18:04:11', 'c/f', 'C/F', 'Efectivo', 18.00, 'Pagado'),
(48, 12, '2026-02-06 08:43:23', 'Gaby', 'C/F', 'Traslado', 0.00, 'Pagado'),
(49, 6, '2026-02-06 10:06:00', 'c/f', 'C/F', 'Efectivo', 18.00, 'Pagado'),
(50, 6, '2026-02-06 14:19:10', 'eufenia', 'C/F', 'Tarjeta', 710.00, 'Pagado'),
(51, 12, '2026-02-07 09:48:18', 'Santi', 'C/F', 'Traslado', 0.00, 'Pagado'),
(52, 6, '2026-02-07 11:03:53', 'c/f', 'C/F', 'Efectivo', 50.00, 'Pagado'),
(53, 6, '2026-02-07 11:48:27', 'Pablo Josue', 'C/F', 'Efectivo', 30.00, 'Pagado'),
(54, 6, '2026-02-07 15:54:29', 'Ander Jared', 'C/F', 'Efectivo', 330.00, 'Pagado'),
(55, 12, '2026-02-09 08:11:07', 'Byron Samuel', 'C/F', 'Efectivo', 120.00, 'Pagado'),
(56, 12, '2026-02-09 08:24:08', 'pabientes', 'C/F', 'Efectivo', 349.75, 'Pagado'),
(57, 6, '2026-02-09 08:25:48', 'stiven jesus', 'C/F', 'Efectivo', 80.00, 'Pagado'),
(58, 12, '2026-02-09 08:27:31', 'Mariano Saenz', 'C/F', 'Efectivo', 225.60, 'Pagado'),
(59, 6, '2026-02-09 08:37:13', 'fabiana perez', 'C/F', 'Efectivo', 200.00, 'Pagado'),
(60, 6, '2026-02-09 10:57:40', 'fabiana perez felipe', 'C/F', 'Efectivo', 350.00, 'Pagado'),
(61, 6, '2026-02-09 12:08:53', 'javier perez', 'C/F', 'Efectivo', 1005.00, 'Pagado'),
(62, 6, '2026-02-09 12:13:43', 'javier perez', 'C/F', 'Efectivo', 150.00, 'Pagado'),
(63, 6, '2026-02-09 14:46:04', 'PACIENTE NEBULIZADO', 'C/F', 'Efectivo', 100.00, 'Pagado'),
(64, 6, '2026-02-09 15:02:56', 'consumidor final', 'C/F', 'Efectivo', 18.00, 'Pagado'),
(65, 6, '2026-02-09 16:18:03', 'emilio aguilar', 'C/F', 'Efectivo', 60.00, 'Pagado'),
(66, 6, '2026-02-10 08:11:41', 'CONSUMIDOR FINAL', 'C/F', 'Efectivo', 70.00, 'Pagado'),
(67, 6, '2026-02-10 12:08:03', 'santos Angela', 'C/F', 'Efectivo', 240.00, 'Pagado'),
(68, 6, '2026-02-10 12:34:40', 'javier perez', 'C/F', 'Efectivo', 590.00, 'Pagado'),
(69, 6, '2026-02-10 16:56:41', 'ROSA MATIAS', 'C/F', 'Efectivo', 230.00, 'Pagado'),
(70, 28, '2026-02-10 19:17:25', 'Micaela Herrera 7401158300425', 'C/F', 'Efectivo', 1735.00, 'Pagado');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `abonos_hospitalarios`
--
ALTER TABLE `abonos_hospitalarios`
  ADD PRIMARY KEY (`id_abono`),
  ADD KEY `id_cuenta` (`id_cuenta`),
  ADD KEY `registrado_por` (`registrado_por`);

--
-- Indices de la tabla `administracion_medicamentos`
--
ALTER TABLE `administracion_medicamentos`
  ADD PRIMARY KEY (`id_administracion`),
  ADD KEY `id_medicamento` (`id_medicamento`),
  ADD KEY `indicado_por` (`indicado_por`),
  ADD KEY `administrado_por` (`administrado_por`),
  ADD KEY `idx_encamamiento` (`id_encamamiento`),
  ADD KEY `idx_estado` (`estado`),
  ADD KEY `idx_fecha_admin` (`fecha_administracion`);

--
-- Indices de la tabla `archivos_orden`
--
ALTER TABLE `archivos_orden`
  ADD PRIMARY KEY (`id_archivo`),
  ADD KEY `id_orden_prueba` (`id_orden_prueba`);

--
-- Indices de la tabla `archivos_resultados_laboratorio`
--
ALTER TABLE `archivos_resultados_laboratorio`
  ADD PRIMARY KEY (`id_archivo`);

--
-- Indices de la tabla `camas`
--
ALTER TABLE `camas`
  ADD PRIMARY KEY (`id_cama`),
  ADD UNIQUE KEY `unique_cama` (`id_habitacion`,`numero_cama`),
  ADD KEY `idx_estado` (`estado`);

--
-- Indices de la tabla `cargos_hospitalarios`
--
ALTER TABLE `cargos_hospitalarios`
  ADD PRIMARY KEY (`id_cargo`),
  ADD KEY `registrado_por` (`registrado_por`),
  ADD KEY `idx_cuenta` (`id_cuenta`),
  ADD KEY `idx_tipo_cargo` (`tipo_cargo`),
  ADD KEY `idx_fecha_cargo` (`fecha_cargo`),
  ADD KEY `idx_cancelado` (`cancelado`);

--
-- Indices de la tabla `catalogo_pruebas`
--
ALTER TABLE `catalogo_pruebas`
  ADD PRIMARY KEY (`id_prueba`),
  ADD UNIQUE KEY `codigo_prueba` (`codigo_prueba`),
  ADD KEY `idx_codigo` (`codigo_prueba`),
  ADD KEY `idx_estado` (`estado`),
  ADD KEY `idx_categoria` (`categoria`);

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `fk_doctor_cita` (`id_doctor`);

--
-- Indices de la tabla `cobros`
--
ALTER TABLE `cobros`
  ADD PRIMARY KEY (`in_cobro`),
  ADD KEY `paciente_cobro` (`paciente_cobro`);

--
-- Indices de la tabla `control_calidad_lab`
--
ALTER TABLE `control_calidad_lab`
  ADD PRIMARY KEY (`id_control`),
  ADD KEY `realizado_por` (`realizado_por`),
  ADD KEY `aprobado_por` (`aprobado_por`),
  ADD KEY `idx_prueba` (`id_prueba`),
  ADD KEY `idx_fecha` (`fecha_control`),
  ADD KEY `idx_estado` (`estado`);

--
-- Indices de la tabla `cuenta_hospitalaria`
--
ALTER TABLE `cuenta_hospitalaria`
  ADD PRIMARY KEY (`id_cuenta`),
  ADD UNIQUE KEY `id_encamamiento` (`id_encamamiento`),
  ADD KEY `idx_estado_pago` (`estado_pago`);

--
-- Indices de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_inventario` (`id_inventario`);

--
-- Indices de la tabla `electrocardiogramas`
--
ALTER TABLE `electrocardiogramas`
  ADD PRIMARY KEY (`id_electro`),
  ADD KEY `electrocardiogramas_ibfk_1` (`id_paciente`),
  ADD KEY `electrocardiogramas_ibfk_2` (`id_doctor`),
  ADD KEY `electrocardiogramas_ibfk_3` (`realizado_por`);

--
-- Indices de la tabla `encamamientos`
--
ALTER TABLE `encamamientos`
  ADD PRIMARY KEY (`id_encamamiento`),
  ADD KEY `id_cama` (`id_cama`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_paciente` (`id_paciente`),
  ADD KEY `idx_estado` (`estado`),
  ADD KEY `idx_fecha_ingreso` (`fecha_ingreso`),
  ADD KEY `idx_doctor` (`id_doctor`);

--
-- Indices de la tabla `evoluciones_medicas`
--
ALTER TABLE `evoluciones_medicas`
  ADD PRIMARY KEY (`id_evolucion`),
  ADD KEY `idx_encamamiento` (`id_encamamiento`),
  ADD KEY `idx_fecha` (`fecha_evolucion`),
  ADD KEY `idx_doctor` (`id_doctor`);

--
-- Indices de la tabla `examenes_realizados`
--
ALTER TABLE `examenes_realizados`
  ADD PRIMARY KEY (`id_examen_realizado`),
  ADD UNIQUE KEY `id_examen_realizado` (`id_examen_realizado`);

--
-- Indices de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  ADD PRIMARY KEY (`id_habitacion`),
  ADD UNIQUE KEY `numero_habitacion` (`numero_habitacion`),
  ADD KEY `idx_estado` (`estado`),
  ADD KEY `idx_tipo` (`tipo_habitacion`);

--
-- Indices de la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `id_paciente` (`id_paciente`);

--
-- Indices de la tabla `insumos`
--
ALTER TABLE `insumos`
  ADD PRIMARY KEY (`id_insumo`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_inventario`),
  ADD KEY `idx_codigo_barras` (`codigo_barras`);

--
-- Indices de la tabla `ordenes_laboratorio`
--
ALTER TABLE `ordenes_laboratorio`
  ADD PRIMARY KEY (`id_orden`),
  ADD UNIQUE KEY `numero_orden` (`numero_orden`),
  ADD KEY `id_doctor` (`id_doctor`),
  ADD KEY `id_encamamiento` (`id_encamamiento`),
  ADD KEY `creado_por` (`creado_por`),
  ADD KEY `idx_numero_orden` (`numero_orden`),
  ADD KEY `idx_paciente` (`id_paciente`),
  ADD KEY `idx_estado` (`estado`),
  ADD KEY `idx_fecha_orden` (`fecha_orden`),
  ADD KEY `idx_prioridad` (`prioridad`);

--
-- Indices de la tabla `orden_pruebas`
--
ALTER TABLE `orden_pruebas`
  ADD PRIMARY KEY (`id_orden_prueba`),
  ADD KEY `procesado_por` (`procesado_por`),
  ADD KEY `validado_por` (`validado_por`),
  ADD KEY `idx_orden` (`id_orden`),
  ADD KEY `idx_prueba` (`id_prueba`),
  ADD KEY `idx_estado` (`estado`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id_paciente`);

--
-- Indices de la tabla `parametros_pruebas`
--
ALTER TABLE `parametros_pruebas`
  ADD PRIMARY KEY (`id_parametro`),
  ADD KEY `idx_prueba` (`id_prueba`),
  ADD KEY `idx_orden` (`orden_visualizacion`);

--
-- Indices de la tabla `procedimientos_menores`
--
ALTER TABLE `procedimientos_menores`
  ADD PRIMARY KEY (`id_procedimiento`),
  ADD UNIQUE KEY `id_procedimiento` (`id_procedimiento`);

--
-- Indices de la tabla `purchase_headers`
--
ALTER TABLE `purchase_headers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indices de la tabla `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_header_id` (`purchase_header_id`);

--
-- Indices de la tabla `purchase_payments`
--
ALTER TABLE `purchase_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_header_id` (`purchase_header_id`);

--
-- Indices de la tabla `rayos_x`
--
ALTER TABLE `rayos_x`
  ADD PRIMARY KEY (`id_rayos_x`);

--
-- Indices de la tabla `reactivos_laboratorio`
--
ALTER TABLE `reactivos_laboratorio`
  ADD PRIMARY KEY (`id_reactivo`),
  ADD UNIQUE KEY `codigo_reactivo` (`codigo_reactivo`),
  ADD KEY `ingresado_por` (`ingresado_por`),
  ADD KEY `idx_codigo` (`codigo_reactivo`),
  ADD KEY `idx_estado` (`estado`),
  ADD KEY `idx_vencimiento` (`fecha_vencimiento`);

--
-- Indices de la tabla `reportes_estadisticas`
--
ALTER TABLE `reportes_estadisticas`
  ADD PRIMARY KEY (`id_reporte`);

--
-- Indices de la tabla `reservas_inventario`
--
ALTER TABLE `reservas_inventario`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `id_inventario` (`id_inventario`),
  ADD KEY `session_id` (`session_id`);

--
-- Indices de la tabla `resultados_laboratorio`
--
ALTER TABLE `resultados_laboratorio`
  ADD PRIMARY KEY (`id_resultado`),
  ADD KEY `procesado_por` (`procesado_por`),
  ADD KEY `validado_por` (`validado_por`),
  ADD KEY `idx_orden_prueba` (`id_orden_prueba`),
  ADD KEY `idx_parametro` (`id_parametro`),
  ADD KEY `idx_validado` (`validado`),
  ADD KEY `idx_fuera_rango` (`fuera_rango`);

--
-- Indices de la tabla `signos_vitales`
--
ALTER TABLE `signos_vitales`
  ADD PRIMARY KEY (`id_signo`),
  ADD KEY `registrado_por` (`registrado_por`),
  ADD KEY `idx_encamamiento` (`id_encamamiento`),
  ADD KEY `idx_fecha` (`fecha_registro`);

--
-- Indices de la tabla `ultrasonidos`
--
ALTER TABLE `ultrasonidos`
  ADD PRIMARY KEY (`id_ultrasonido`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `abonos_hospitalarios`
--
ALTER TABLE `abonos_hospitalarios`
  MODIFY `id_abono` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `administracion_medicamentos`
--
ALTER TABLE `administracion_medicamentos`
  MODIFY `id_administracion` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `archivos_orden`
--
ALTER TABLE `archivos_orden`
  MODIFY `id_archivo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `archivos_resultados_laboratorio`
--
ALTER TABLE `archivos_resultados_laboratorio`
  MODIFY `id_archivo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `camas`
--
ALTER TABLE `camas`
  MODIFY `id_cama` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `cargos_hospitalarios`
--
ALTER TABLE `cargos_hospitalarios`
  MODIFY `id_cargo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT de la tabla `catalogo_pruebas`
--
ALTER TABLE `catalogo_pruebas`
  MODIFY `id_prueba` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=252;

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `id_cita` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT de la tabla `cobros`
--
ALTER TABLE `cobros`
  MODIFY `in_cobro` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `control_calidad_lab`
--
ALTER TABLE `control_calidad_lab`
  MODIFY `id_control` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cuenta_hospitalaria`
--
ALTER TABLE `cuenta_hospitalaria`
  MODIFY `id_cuenta` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `id_detalle` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=166;

--
-- AUTO_INCREMENT de la tabla `electrocardiogramas`
--
ALTER TABLE `electrocardiogramas`
  MODIFY `id_electro` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `encamamientos`
--
ALTER TABLE `encamamientos`
  MODIFY `id_encamamiento` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `evoluciones_medicas`
--
ALTER TABLE `evoluciones_medicas`
  MODIFY `id_evolucion` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `examenes_realizados`
--
ALTER TABLE `examenes_realizados`
  MODIFY `id_examen_realizado` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  MODIFY `id_habitacion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  MODIFY `id_historial` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `insumos`
--
ALTER TABLE `insumos`
  MODIFY `id_insumo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_inventario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=466;

--
-- AUTO_INCREMENT de la tabla `ordenes_laboratorio`
--
ALTER TABLE `ordenes_laboratorio`
  MODIFY `id_orden` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `orden_pruebas`
--
ALTER TABLE `orden_pruebas`
  MODIFY `id_orden_prueba` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id_paciente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT de la tabla `parametros_pruebas`
--
ALTER TABLE `parametros_pruebas`
  MODIFY `id_parametro` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `procedimientos_menores`
--
ALTER TABLE `procedimientos_menores`
  MODIFY `id_procedimiento` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `purchase_headers`
--
ALTER TABLE `purchase_headers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT de la tabla `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=467;

--
-- AUTO_INCREMENT de la tabla `purchase_payments`
--
ALTER TABLE `purchase_payments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rayos_x`
--
ALTER TABLE `rayos_x`
  MODIFY `id_rayos_x` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `reactivos_laboratorio`
--
ALTER TABLE `reactivos_laboratorio`
  MODIFY `id_reactivo` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reportes_estadisticas`
--
ALTER TABLE `reportes_estadisticas`
  MODIFY `id_reporte` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reservas_inventario`
--
ALTER TABLE `reservas_inventario`
  MODIFY `id_reserva` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=224;

--
-- AUTO_INCREMENT de la tabla `resultados_laboratorio`
--
ALTER TABLE `resultados_laboratorio`
  MODIFY `id_resultado` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `signos_vitales`
--
ALTER TABLE `signos_vitales`
  MODIFY `id_signo` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ultrasonidos`
--
ALTER TABLE `ultrasonidos`
  MODIFY `id_ultrasonido` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `abonos_hospitalarios`
--
ALTER TABLE `abonos_hospitalarios`
  ADD CONSTRAINT `abonos_hospitalarios_ibfk_1` FOREIGN KEY (`id_cuenta`) REFERENCES `cuenta_hospitalaria` (`id_cuenta`) ON DELETE CASCADE,
  ADD CONSTRAINT `abonos_hospitalarios_ibfk_2` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `archivos_orden`
--
ALTER TABLE `archivos_orden`
  ADD CONSTRAINT `fk_archivos_orden_prueba` FOREIGN KEY (`id_orden_prueba`) REFERENCES `orden_pruebas` (`id_orden_prueba`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cuenta_hospitalaria`
--
ALTER TABLE `cuenta_hospitalaria`
  ADD CONSTRAINT `cuenta_hospitalaria_ibfk_1` FOREIGN KEY (`id_encamamiento`) REFERENCES `encamamientos` (`id_encamamiento`) ON DELETE CASCADE;

--
-- Filtros para la tabla `electrocardiogramas`
--
ALTER TABLE `electrocardiogramas`
  ADD CONSTRAINT `electrocardiogramas_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`) ON DELETE RESTRICT,
  ADD CONSTRAINT `electrocardiogramas_ibfk_2` FOREIGN KEY (`id_doctor`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  ADD CONSTRAINT `electrocardiogramas_ibfk_3` FOREIGN KEY (`realizado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
