-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: bzlwnzdfwf8n1tct7ebf-mysql.services.clever-cloud.com:3306
-- Tiempo de generación: 18-01-2026 a las 17:26:26
-- Versión del servidor: 8.0.22-13
-- Versión de PHP: 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bzlwnzdfwf8n1tct7ebf`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administracion_medicamentos`
--

CREATE TABLE `administracion_medicamentos` (
  `id_administracion` int NOT NULL,
  `id_encamamiento` int NOT NULL,
  `id_medicamento` int DEFAULT NULL COMMENT 'Referencia a inventario',
  `nombre_medicamento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dosis` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `via_administracion` enum('Oral','Intravenosa','Intramuscular','Subcutánea','Tópica','Rectal','Otra') COLLATE utf8mb4_unicode_ci NOT NULL,
  `frecuencia` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Ej: Cada 8 horas, 3 veces al día',
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `indicado_por` int DEFAULT NULL,
  `administrado_por` int DEFAULT NULL,
  `fecha_administracion` datetime DEFAULT NULL,
  `notas` text COLLATE utf8mb4_unicode_ci,
  `estado` enum('Programado','Administrado','Omitido','Suspendido') COLLATE utf8mb4_unicode_ci DEFAULT 'Programado',
  `motivo_omision` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `camas`
--

CREATE TABLE `camas` (
  `id_cama` int NOT NULL,
  `id_habitacion` int NOT NULL,
  `numero_cama` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` enum('Disponible','Ocupada','Mantenimiento','Reservada') COLLATE utf8mb4_unicode_ci DEFAULT 'Disponible',
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `camas`
--

INSERT INTO `camas` (`id_cama`, `id_habitacion`, `numero_cama`, `estado`, `descripcion`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(2, 2, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(3, 3, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(4, 4, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(5, 5, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(6, 6, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(7, 7, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(8, 8, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00'),
(9, 9, '1', 'Disponible', NULL, '2026-01-18 17:10:00', '2026-01-18 17:10:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargos_hospitalarios`
--

CREATE TABLE `cargos_hospitalarios` (
  `id_cargo` int NOT NULL,
  `id_cuenta` int NOT NULL,
  `tipo_cargo` enum('Habitación','Medicamento','Procedimiento','Laboratorio','Honorario','Insumo','Otro') COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` decimal(10,3) DEFAULT '1.000',
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS ((`cantidad` * `precio_unitario`)) STORED,
  `fecha_cargo` datetime NOT NULL,
  `fecha_aplicacion` date DEFAULT NULL COMMENT 'Para cargos de habitación por noche',
  `registrado_por` int DEFAULT NULL,
  `referencia_id` int DEFAULT NULL COMMENT 'ID del item original (id_medicamento, id_procedimiento, etc)',
  `referencia_tabla` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Nombre de la tabla de referencia',
  `notas` text COLLATE utf8mb4_unicode_ci,
  `cancelado` tinyint(1) DEFAULT '0',
  `fecha_cancelacion` datetime DEFAULT NULL,
  `motivo_cancelacion` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_pruebas`
--

CREATE TABLE `catalogo_pruebas` (
  `id_prueba` int NOT NULL,
  `codigo_prueba` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_prueba` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abreviatura` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `muestra_requerida` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Ej: Sangre Total (EDTA)',
  `metodo_toma` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Instrucciones de toma de muestra',
  `precio` decimal(10,2) NOT NULL DEFAULT '0.00',
  `tiempo_procesamiento_horas` int DEFAULT '24',
  `requiere_ayuno` tinyint(1) DEFAULT '0',
  `horas_ayuno` int DEFAULT NULL,
  `estado` enum('Activo','Inactivo','Descontinuado') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo',
  `categoria` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Ej: Hematología, Química, Hormonas',
  `notas` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `id_cita` int NOT NULL,
  `nombre_pac` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apellido_pac` varchar(50) NOT NULL,
  `num_cita` int NOT NULL,
  `fecha_cita` date NOT NULL,
  `hora_cita` time NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `historial_id` int DEFAULT NULL,
  `id_doctor` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id_cita`, `nombre_pac`, `apellido_pac`, `num_cita`, `fecha_cita`, `hora_cita`, `telefono`, `historial_id`, `id_doctor`) VALUES
(3, 'Juan ', 'Matias', 3, '2026-01-13', '15:15:00', '6485268756', NULL, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobros`
--

CREATE TABLE `cobros` (
  `in_cobro` int NOT NULL,
  `paciente_cobro` int NOT NULL,
  `id_doctor` int DEFAULT NULL,
  `tipo_consulta` enum('Consulta','Reconsulta') DEFAULT 'Consulta',
  `cantidad_consulta` int NOT NULL,
  `fecha_consulta` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compras` int NOT NULL,
  `nombre_compra` varchar(100) NOT NULL,
  `presentacion_compra` varchar(100) NOT NULL,
  `molecula_compra` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `casa_compra` varchar(100) NOT NULL,
  `cantidad_compra` int NOT NULL,
  `precio_unidad` int NOT NULL,
  `precio_venta` int NOT NULL,
  `fecha_compra` date NOT NULL,
  `abono_compra` int NOT NULL,
  `total_compra` int NOT NULL,
  `tipo_pago` enum('Al Contado','Credito 30','Credito 60','') NOT NULL,
  `estado_compra` enum('Pendiente','Abonado','Completo','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control_calidad_lab`
--

CREATE TABLE `control_calidad_lab` (
  `id_control` int NOT NULL,
  `id_prueba` int NOT NULL,
  `fecha_control` date NOT NULL,
  `lote_control` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valor_esperado` decimal(12,4) DEFAULT NULL,
  `valor_obtenido` decimal(12,4) DEFAULT NULL,
  `diferencia` decimal(12,4) GENERATED ALWAYS AS (abs((`valor_obtenido` - `valor_esperado`))) STORED,
  `dentro_rango` tinyint(1) DEFAULT NULL,
  `desviacion_estandar` decimal(12,4) DEFAULT NULL,
  `coeficiente_variacion` decimal(12,4) DEFAULT NULL,
  `accion_correctiva` text COLLATE utf8mb4_unicode_ci,
  `realizado_por` int DEFAULT NULL,
  `aprobado_por` int DEFAULT NULL,
  `estado` enum('Aprobado','Rechazado','Requiere_Acción') COLLATE utf8mb4_unicode_ci DEFAULT 'Aprobado',
  `notas` text COLLATE utf8mb4_unicode_ci,
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
  `estado_pago` enum('Pendiente','Parcialmente_Pagado','Pagado','Condonado') COLLATE utf8mb4_unicode_ci DEFAULT 'Pendiente',
  `monto_pagado` decimal(10,2) DEFAULT '0.00',
  `saldo_pendiente` decimal(10,2) GENERATED ALWAYS AS ((((((((`subtotal_habitacion` + `subtotal_medicamentos`) + `subtotal_procedimientos`) + `subtotal_laboratorios`) + `subtotal_honorarios`) + `subtotal_otros`) - `descuento`) - `monto_pagado`)) STORED,
  `metodo_pago` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Efectivo, Tarjeta, Transferencia, Mixto',
  `notas_pago` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `motivo_ingreso` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `diagnostico_ingreso` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diagnostico_egreso` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('Activo','Alta_Medica','Alta_Administrativa','Transferido','Fallecido') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo',
  `tipo_ingreso` enum('Programado','Emergencia','Referido') COLLATE utf8mb4_unicode_ci DEFAULT 'Programado',
  `notas_ingreso` text COLLATE utf8mb4_unicode_ci,
  `notas_alta` text COLLATE utf8mb4_unicode_ci,
  `created_by` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `encamamientos_con_dias`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `encamamientos_con_dias` (
`created_by` int
,`diagnostico_egreso` varchar(500)
,`diagnostico_ingreso` varchar(500)
,`dias_hospitalizacion` int
,`estado` enum('Activo','Alta_Medica','Alta_Administrativa','Transferido','Fallecido')
,`fecha_actualizacion` timestamp
,`fecha_alta` datetime
,`fecha_creacion` timestamp
,`fecha_ingreso` datetime
,`id_cama` int
,`id_doctor` int
,`id_encamamiento` int
,`id_paciente` int
,`motivo_ingreso` text
,`notas_alta` text
,`notas_ingreso` text
,`tipo_ingreso` enum('Programado','Emergencia','Referido')
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evoluciones_medicas`
--

CREATE TABLE `evoluciones_medicas` (
  `id_evolucion` int NOT NULL,
  `id_encamamiento` int NOT NULL,
  `fecha_evolucion` datetime NOT NULL,
  `id_doctor` int NOT NULL,
  `subjetivo` text COLLATE utf8mb4_unicode_ci COMMENT 'SOAP: Subjetivo',
  `objetivo` text COLLATE utf8mb4_unicode_ci COMMENT 'SOAP: Objetivo',
  `evaluacion` text COLLATE utf8mb4_unicode_ci COMMENT 'SOAP: Evaluación/Assessment',
  `plan_tratamiento` text COLLATE utf8mb4_unicode_ci COMMENT 'SOAP: Plan',
  `notas_adicionales` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examenes_realizados`
--

CREATE TABLE `examenes_realizados` (
  `id_examen_realizado` int DEFAULT NULL,
  `id_paciente` int NOT NULL,
  `nombre_paciente` varchar(255) NOT NULL,
  `tipo_examen` varchar(255) NOT NULL COMMENT 'Nombre del examen (ej. Electrocardiograma, Ultrasonido)',
  `cobro` decimal(10,2) NOT NULL,
  `fecha_examen` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitaciones`
--

CREATE TABLE `habitaciones` (
  `id_habitacion` int NOT NULL,
  `numero_habitacion` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_habitacion` enum('Individual','Compartida','UCI','Pediatría','Observación') COLLATE utf8mb4_unicode_ci NOT NULL,
  `tarifa_por_noche` decimal(10,2) NOT NULL,
  `piso` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('Disponible','Ocupada','Mantenimiento','Reservada') COLLATE utf8mb4_unicode_ci DEFAULT 'Disponible',
  `descripcion` text COLLATE utf8mb4_unicode_ci,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_inventario` int NOT NULL,
  `codigo_barras` varchar(100) DEFAULT NULL,
  `nom_medicamento` varchar(100) NOT NULL,
  `mol_medicamento` varchar(100) NOT NULL,
  `presentacion_med` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `casa_farmaceutica` varchar(100) NOT NULL,
  `cantidad_med` int NOT NULL,
  `fecha_adquisicion` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `estado` enum('Disponible','Pendiente') DEFAULT 'Disponible',
  `id_purchase_item` int DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_inventario`, `codigo_barras`, `nom_medicamento`, `mol_medicamento`, `presentacion_med`, `casa_farmaceutica`, `cantidad_med`, `fecha_adquisicion`, `fecha_vencimiento`, `estado`, `id_purchase_item`, `precio_venta`) VALUES
(4, NULL, 'Antigrip', 'Eucolapto-Guayacol', 'Ampolla', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 4, 35.00),
(5, NULL, 'Ibuvanz', 'Ibuprofeno100mg/5ml', 'Suspension', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 5, 62.00),
(6, NULL, 'Fungiter', 'Terbinafina 1g', 'Crema topica', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 6, 140.00),
(7, NULL, 'D3-fENDER', 'Vitamina D3100,000UI', 'Capsula', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 7, 140.00),
(8, NULL, 'Bisocard 5mg', 'Bisoprolol famarato 5mg', 'Tableta', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 8, 270.00),
(9, NULL, 'Olmepress HCT 40/12.5mg', 'Olmesartan Medoxomil40mg+Hidroclorotiazida 12.5mg', 'Tableta', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 9, 350.00),
(10, NULL, 'Gacimex', 'Magaldrato 800mg/Simeticona 60mg/10ml', 'suspension', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 10, 155.00),
(11, NULL, 'Ultram D', 'Dutasterida 0.5+Tamsulona clorhidrato 0.4mg', 'Capsula', 'Servimedic', 4, '2026-01-16', '2026-01-16', 'Pendiente', 11, 600.00),
(12, NULL, 'Triacid', 'Pinaverium 100mg+Simethicone 300mg', 'Tableta', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 12, 230.00),
(13, NULL, 'Tónico de alfalfa R95', 'tónico de alfalfa', 'Suspensión', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 13, 210.00),
(14, NULL, 'Metiom H. pylori', 'esomeprazol-levofloxamina-amoxicilina', 'Cápsula', 'Servimedic', 4, '2026-01-16', '2026-01-16', 'Pendiente', 14, 630.00),
(15, NULL, 'Vertiless', 'Betahistina- diclorhidrato 16mg', 'Tableta', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 15, 180.00),
(16, NULL, 'Lyverium 1mg', 'Alprazolam 1mg', 'Tableta', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 16, 255.00),
(17, NULL, 'Lyverium 0.5mg', 'Alprazolam 0.5mg', 'Tableta', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 17, 150.00),
(18, NULL, 'Equiliv', 'clonazepam 2.5/ml', 'Gotero', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 18, 115.00),
(19, NULL, 'Atenua', 'dexketoprofeno 25mg', 'Comprimidos', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 19, 140.00),
(20, NULL, 'Sitalev Met', 'sitaglipina 50mg +metformina 500mg', 'Tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 20, 220.00),
(21, NULL, 'Inuric-G', 'Febuxostat 80mg', 'Tableta', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 21, 320.00),
(22, NULL, 'Gabin', 'Gabapentina 400mg', 'Tableta', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 22, 250.00),
(23, NULL, 'Atrolip Plus', 'atorvastatina 10mg + ezetimibe 10 mg', 'Comprimidos', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 23, 380.00),
(24, NULL, 'Glutamax C', 'Glutathione + vit C', 'Viales', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 24, 200.00),
(25, NULL, 'Rupagán', 'Rupatadina 1mg/ml.', 'Suspensión', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 25, 145.00),
(26, NULL, 'Biotos Inmune', 'Hedera helix & Pelargonium sidoides', 'Suspensión', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 26, 185.00),
(27, NULL, 'Biotos Inmune Pediátrico', 'Hedera Helix & Pelargonium sidoides', 'Suspensión', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 27, 135.00),
(28, NULL, 'Omega 1000', 'Omega 3', 'Cápsulas', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 28, 425.00),
(29, NULL, 'Aci-tip', 'Magaldrato 800mg - simeticona 40mg', 'Comprimidos', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 29, 120.00),
(30, NULL, 'Neuralplus', 'Tiamina, piridoxina, cianocobalamina, diclofenaco', 'Tableta', 'Servimedic', 4, '2026-01-16', '2026-01-16', 'Pendiente', 30, 115.00),
(31, NULL, 'Kardiopil HCT', 'Irbesartán 300mg + hidroclorotiazida 12.5 mg', 'Tableta', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 31, 250.00),
(32, NULL, 'Milenium', 'esomeprazol 40mg', 'Cápsula', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 32, 250.00),
(33, NULL, 'Denk man active', 'extraxto de ginkgo, arginina', 'Cápsula', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 33, 220.00),
(34, NULL, 'Inmuno biter', 'extracto glicerinado de jara+tomillo', 'Ampolla bebible', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 34, 390.00),
(35, NULL, 'Spacek', 'Bromuro de otilonio 40mg', 'Tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 35, 170.00),
(36, NULL, 'Spirocard', 'spironolactone 100mg', 'Tableta', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 36, 260.00),
(37, NULL, 'Kardiopil Amlo', 'Irbesartan 300mg + Amlodipine 5mg', 'Tableta', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 37, 410.00),
(38, NULL, 'Gabex', 'Gabapentin 300mg', 'Cápsula', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 38, 200.00),
(39, NULL, 'biobronq', 'Hedera Helix 35mg/5ml', 'Suspensión', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 39, 80.00),
(40, NULL, 'Disolflem', 'Acetilcisteína', 'sticks granulado', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 40, 105.00),
(41, NULL, 'Uroprin', 'Fosfomicina 3g', 'Sticks granulado', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 41, 165.00),
(42, NULL, 'Clevium', 'Desketoprofen (Trometamol) 25mg/10ml', 'Sobres Bebible', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 42, 140.00),
(43, NULL, 'Clevium', 'Dexketoprofeno 1.25%', 'Gel', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 43, 80.00),
(44, NULL, 'Flavia', 'Melatonina, calcio', 'Tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 44, 250.00),
(45, NULL, 'Demilos', 'carbonato de calcio colecalciferol, vitamina d3', 'Comprimidos', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 45, 215.00),
(46, NULL, 'Zefalox', 'cefixime 400mg', '20 Cápsulas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 46, 650.00),
(47, NULL, 'Zefalox', 'Cefixima 100mg/5ml', 'Suspensión 50ml', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 47, 205.00),
(48, NULL, 'Zefalox', 'Cefixima', 'Suspesión 100ml', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 48, 300.00),
(49, NULL, 'Conflexil Plus Shot', 'tiocolchicosido 4mg-diclofenaco 50mh', 'Sticks bebible', 'Servimedic', 100, '2026-01-16', '2026-01-16', 'Pendiente', 49, 22.00),
(50, NULL, 'Rofemed', 'ceftriaxona 1g', 'Vial', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 50, 120.00),
(51, NULL, 'Milenium', 'esomeprazol 20ml', '30 Cápsulas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 51, 200.00),
(52, NULL, 'Gadavyt fibra liquida', 'Fibra dietética jugo natural de ciruela', 'Suspensión', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 52, 345.00),
(53, NULL, 'Fungiter', 'Terbinafine HCI 1%', 'Spray', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 53, 100.00),
(54, NULL, 'Fungiter', 'Terbinafine 250 mg', '28 Tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 54, 545.00),
(55, NULL, 'Septidex', 'Polimixina. neomicina 40g', 'Spray', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 55, 105.00),
(56, NULL, 'Dinivanz', 'Salbutamol, salino solucion', 'Solución p/ nebulizar', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 56, 130.00),
(57, NULL, 'Hicet', 'Cetirizina diclorhidrato 10mg/ml', 'Gotas pediátricas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 57, 105.00),
(58, NULL, 'Hicet', 'Cetirizina diclorhidrato 5mg/ml', 'Jarabe 120ml', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 58, 140.00),
(59, NULL, 'Hicet', 'Cetirizina diclorhidrato 5mg/5ml', 'Jarabe 60ml', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 59, 90.00),
(60, NULL, 'Hicet', 'Cetirizina diclorhidrato 10mg', '10 Cápsulas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 60, 90.00),
(61, NULL, 'Gabex Plus', 'Gabapentina + vitamina B1 y B12', '30 Tabletas recubiertas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 61, 350.00),
(62, NULL, 'Levent-Vit-E', 'vitamina E', '30 Cápsulas', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 62, 280.00),
(63, NULL, 'Rosecol', 'Rosuvastatina 20mg', '30 Tabletas recubiertas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 63, 235.00),
(64, NULL, 'Prednicet', 'Prednisolona 5mg', '20 Tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 64, 85.00),
(65, NULL, 'Conflexil', 'Tiocolchicósido', 'Ampollas 4mg/2ml', 'Servimedic', 25, '2026-01-16', '2026-01-16', 'Pendiente', 65, 35.00),
(66, NULL, 'Viater Forte', 'ginseng, vitamina E, zinc', 'Viales bebibles', 'Servimedic', 1, '2026-01-16', '2026-01-16', 'Pendiente', 66, 300.00),
(67, NULL, 'Acla-med bid', 'amoxicilina 875mg, acido clavulanico 125mg', '14 tabletas recubiertas', 'Servimedic', 1, '2026-01-16', '2026-01-16', 'Pendiente', 67, 215.00),
(68, NULL, 'Symbio flor 1', 'enterococcusfaecalis', 'Suspension oral', 'Servimedic', 1, '2026-01-16', '2026-01-16', 'Pendiente', 68, 255.00),
(69, NULL, 'Klevraxr', 'levetiracetam 500mg', '30 tabletas', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 69, 170.00),
(70, NULL, 'Suganon', 'Evogliptina 5mg', '30 Comprimidos', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 70, 505.00),
(71, NULL, 'Zukermen Met', 'vildagliptina 50ml+metformina 1000mg', '30 Tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 71, 300.00),
(72, NULL, 'Tusivanz', 'dextromethorphan+carboxymethylcysteine', 'gotas pediatricas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 72, 105.00),
(73, NULL, 'Budoxigen', 'Budesonida 50mcg/100mcl', 'spray 200 aplicaciones', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 73, 190.00),
(74, NULL, 'Total Magnesiano', 'cloruro de magnesio 4.5H2O 1.5g + fluoruro de magnesio 0.0015g', 'Sobres efervecentes', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 74, 250.00),
(75, NULL, 'Acla-med', 'Amoxicilina 600mg+Acido clavulanico 42.9mg', 'Suspension', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 75, 175.00),
(76, NULL, 'Avsar Plus', 'valsartan 320mg+amlodipina 10mg+hidroclorotiazida 25mg', '28 Tabletas', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 76, 520.00),
(77, NULL, 'Deflarin', 'desflazacort 30mg', '10 comprimidos', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 77, 325.00),
(78, NULL, 'Disoflem', 'Acetilcisteina 200mg', 'Sobres Granulados', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 78, 105.00),
(79, NULL, 'Megamol', 'vitamina D3', '100 capsulas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 79, 250.00),
(80, NULL, 'Diabilev', 'Metformina HCI 500mg', '30 Tabletas', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 80, 90.00),
(81, NULL, 'Denk immun active', 'Zinc, selenio', 'Sobres', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 81, 195.00),
(82, NULL, 'Melatina', 'Melatonina 10.53mg', 'Gotero', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 82, 160.00),
(83, NULL, 'Bru-sone', 'betametasona dipropionato 5mg+fosfato sodico 2mg', 'Ampolla', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 83, 190.00),
(84, NULL, 'Gastrexx plus', 'amoxicilina 1g+ levofloxacina 500mg', '28 capsulas', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 84, 480.00),
(85, NULL, 'Modepar', 'Nicotinamida 17.5mg, Acido Ascorbico 50mg', '60 Tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 85, 550.00),
(86, NULL, 'Adiaplex', 'Dapagliflozina 10mg', '30 Tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 86, 410.00),
(87, NULL, 'Glidap Max', 'Dapagliflozina 5mg+metformina HCI lp 1000mg', '30 tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 87, 300.00),
(88, NULL, 'Gesimax', 'Naproxeno sodico 550mg', '10 tabletas', 'Servimedic', 20, '2026-01-16', '2026-01-16', 'Pendiente', 88, 60.00),
(89, NULL, 'Lisinox', 'Propinoxato HCL 10mg+clonixinato de lisina 125mg', '10 Tabletas', 'Servimedic', 10, '2026-01-16', '2026-01-16', 'Pendiente', 89, 45.00),
(90, NULL, 'Solocin Plus', 'pancreatina 400mg+simeticona 60mg+cinitaprina 1mg', '20 comprimidos', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 90, 220.00),
(91, NULL, 'Ferrum 16', 'hierro, vitaminas y minerales', 'Jarabe 240ml', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 91, 120.00),
(92, NULL, 'Gadysen', 'Duloxetina 60mg', '30 capsulas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 92, 560.00),
(93, NULL, 'Gadysen', 'Duloxetina 30mg', '30 capsulas', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 93, 510.00),
(94, NULL, 'Multiflora Adance', 'probiotico', '30 capsulas', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 94, 420.00),
(95, NULL, 'Estoma dol', 'trisilicato de magnesio, carbon vegetal', '30 capsulas', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 95, 140.00),
(96, NULL, 'Exlant', 'dexlansoprazol 30mg', '30 capsulas', 'Servimedic', 4, '2026-01-16', '2026-01-16', 'Pendiente', 96, 365.00),
(97, NULL, 'Ki-Cab', 'tegoprazan 50mg', '50 tabletas', 'Servimedic', 1, '2026-01-16', '2026-01-16', 'Pendiente', 97, 830.00),
(98, NULL, 'Lisinox', 'Propinoxato clorhidrato 5mg/ml', 'Gotas 20ml', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 98, 80.00),
(99, NULL, 'Probiocyan', 'lactobacillus plantarum, zinc 5mg', '30 capsulas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 99, 230.00),
(100, NULL, 'Colitran', 'clordiazepoxido HCI/ Bromuro de clidinio', '10 grageas', 'Servimedic', 10, '2026-01-16', '2026-01-16', 'Pendiente', 100, 40.00),
(101, NULL, 'Sucralfato', 'sucralfato 1g', '40 Tabletas', 'Servimedic', 1, '2026-01-16', '2026-01-16', 'Pendiente', 101, 105.00),
(102, NULL, 'Cetamin CC', 'Acetaminofen 325mg+codeina 15mg', '10 Tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 102, 90.00),
(103, NULL, 'Tensinor Plus', 'Valsartan 160mg/hidroclorotiazida 12.5mg/amlodipino 5mg', '30 Tabletas', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 103, 480.00),
(104, NULL, 'Tensinor Plus', 'Valsartan 320mg/hidroclorotiazida 25mg/amlodipino 10mg', '30 Tabletas', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 104, 480.00),
(105, NULL, 'Metavan', 'metformina HCI 1000mg', '30 Tabletas', 'Servimedic', 1, '2026-01-16', '2026-01-16', 'Pendiente', 105, 245.00),
(106, NULL, 'FILINAR g', 'acebrifilina 5mg/ml', 'Suspension', 'Servimedic', 1, '2026-01-16', '2026-01-16', 'Pendiente', 106, 160.00),
(107, NULL, 'Myo & D-Chiro Inositol', 'inositol chiro', '90 capsulas', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 107, 470.00),
(108, NULL, 'Gastroflux', 'domperidona 1mg/ml', 'suspension', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 108, 235.00),
(109, NULL, 'Careject', 'aceite de soja, glicerol', 'Spray nasal', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 109, 150.00),
(110, NULL, 'Aidex', 'dexketoprofeno 25mg/10ml', 'Sobres bebibles', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 110, 110.00),
(111, NULL, 'Rusitan', 'Rupatadina fumarato 1mg/ml', 'Suspension', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 111, 175.00),
(112, NULL, 'Acetaminofen lancasco', 'acetaminofen 120/5ml', 'Suspension', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 112, 30.00),
(113, NULL, 'Bucaglu', 'ruibarbo y acido salicilico', 'Tintura Oral', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 113, 130.00),
(114, NULL, 'Contractil', 'tiocolchicosido 4mg', '10 Tabletas', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 114, 130.00),
(115, NULL, 'Etoricox', 'Etoricoxib 120mg', '14 Tabletas', 'Servimedic', 1, '2026-01-16', '2026-01-16', 'Pendiente', 115, 400.00),
(116, NULL, 'Isocraneol', 'Citicolina 500mg', '30 Comprimidos', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 116, 500.00),
(117, NULL, 'Rodiflux', 'Dextrometorfan, carboximetilcisteina, clorfeniramina', 'Gotero', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 117, 110.00),
(118, NULL, 'Gebrix-G 240ml', 'Jengibre, Equinacea, vitamina C', 'Suspension', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 118, 200.00),
(119, NULL, 'Zirtraler-D 60ml', 'Cetirizina HCI, Fenilefrina HCI', 'Suspension', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 119, 125.00),
(120, NULL, 'Neo-melubrina', 'Metamizol sodico 250mg/5ml', 'Jarabe 100ml', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 120, 75.00),
(121, NULL, 'Neobol', 'neomicina- clostebol', 'Spray 30g', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 121, 135.00),
(122, NULL, 'Mero Clav', 'cefuroxima+ acido clavulanico', 'suspension 70ml', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 122, 250.00),
(123, NULL, 'Dexamicina', 'Dexametazona/neomicina', 'Gotero Oftalmico 5ml', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 123, 55.00),
(124, NULL, 'Aciclovirax', 'Aciclovir pediatrico', 'Suspension 120ml', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 124, 200.00),
(125, NULL, 'Bencidamin', 'Bencidamina', 'Spray bucal', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 125, 90.00),
(126, NULL, 'Metronis', 'Nitazoxanida 100mg/5ml', 'suspension', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 126, 80.00),
(127, NULL, 'Sinedol Forte', 'Acetaminofen 750mg', '10 Tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 127, 45.00),
(128, NULL, 'Mucarbol Pediatrico', 'Carbocisteina 100mg/5ml', 'Jarabe', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 128, 65.00),
(129, NULL, 'Mucarbol Adulto', 'Carbocisteina 750mg/15ml', 'Jarabe', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 129, 70.00),
(130, NULL, 'Neo-Melubrina', 'Metamizol 500mg', '4 Tabletas', 'Servimedic', 25, '2026-01-16', '2026-01-16', 'Pendiente', 130, 15.00),
(131, NULL, 'AGE III', 'cucurbita pepo. africanum', '30 Capsulas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 131, 200.00),
(132, NULL, 'Sertal Forte Perlas', 'Propinox Clorhidrato 20mf', '10 capsulas', 'Servimedic', 6, '2026-01-16', '2026-01-16', 'Pendiente', 132, 90.00),
(133, NULL, 'Ardix', 'dexketoprofeno 25mg', '10 Tabletas', 'Servimedic', 1, '2026-01-16', '2026-01-16', 'Pendiente', 133, 95.00),
(134, NULL, 'Wen vision', 'Dexametasona, neomicina', 'Gotero Oftalmico 5ml', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 134, 55.00),
(135, NULL, 'Selenio+Vit E', 'Vitamina E 1000UI+ Selenio 200', '60 Capsulas', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 135, 175.00),
(136, NULL, 'Brucort-A', 'Triamcinolona acetonido 0.1%', 'Crema Topica', 'Servimedic', 4, '2026-01-16', '2026-01-16', 'Pendiente', 136, 110.00),
(137, NULL, 'Uxbi', 'Acido ursodesoxicolico 250mg', '30 capsulas', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 137, 375.00),
(138, NULL, 'Allopurikem', 'alopurinol 300mg', '10 Tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 138, 75.00),
(139, NULL, 'Deka-C Adultos', 'vitaminas A, D, E y C', 'Ampollas bebibles 5ml', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 139, 75.00),
(140, NULL, 'Rexacort', 'mometasona furoato 50pg', 'Spray nasal 18g', 'Servimedic', 3, '2026-01-16', '2026-01-16', 'Pendiente', 140, 130.00),
(141, NULL, 'Histakem Block', 'Cloruro de cetilpiridinio 0.05g+benzocaina 1.0g', 'Spray bucal 30ml', 'Servimedic', 2, '2026-01-16', '2026-01-16', 'Pendiente', 141, 125.00),
(142, NULL, 'Colchinet', 'Colchicina 0.5 mg', '20 Tabletas', 'Servimedic', 15, '2026-01-16', '2026-01-16', 'Pendiente', 142, 65.00),
(143, NULL, 'Triglix', 'Fenofibrato 160mg', '40 capsulas', 'Servimedic', 4, '2026-01-16', '2026-01-16', 'Pendiente', 143, 390.00),
(144, NULL, 'Equiliv', 'Clonazepan 2mg', '30 Tabletas', 'Servimedic', 5, '2026-01-16', '2026-01-16', 'Pendiente', 144, 135.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenes_laboratorio`
--

CREATE TABLE `ordenes_laboratorio` (
  `id_orden` int NOT NULL,
  `numero_orden` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_paciente` int NOT NULL,
  `id_doctor` int DEFAULT NULL,
  `id_encamamiento` int DEFAULT NULL COMMENT 'NULL si es paciente ambulatorio',
  `fecha_orden` datetime NOT NULL,
  `prioridad` enum('Rutina','Urgente','STAT') COLLATE utf8mb4_unicode_ci DEFAULT 'Rutina',
  `estado` enum('Pendiente','Muestra_Recibida','En_Proceso','Completada','Cancelada','Entregada') COLLATE utf8mb4_unicode_ci DEFAULT 'Pendiente',
  `diagnostico_clinico` text COLLATE utf8mb4_unicode_ci,
  `indicaciones_especiales` text COLLATE utf8mb4_unicode_ci,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `creado_por` int DEFAULT NULL,
  `fecha_muestra_recibida` datetime DEFAULT NULL,
  `fecha_completada` datetime DEFAULT NULL,
  `fecha_entregada` datetime DEFAULT NULL,
  `entregado_a` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metodo_entrega` enum('En_Persona','Correo','WhatsApp','Sistema') COLLATE utf8mb4_unicode_ci DEFAULT 'En_Persona',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_pruebas`
--

CREATE TABLE `orden_pruebas` (
  `id_orden_prueba` int NOT NULL,
  `id_orden` int NOT NULL,
  `id_prueba` int NOT NULL,
  `estado` enum('Pendiente','Muestra_Recibida','En_Proceso','Resultados_Parciales','Completada','Validada','Cancelada') COLLATE utf8mb4_unicode_ci DEFAULT 'Pendiente',
  `fecha_muestra_recibida` datetime DEFAULT NULL,
  `fecha_inicio_proceso` datetime DEFAULT NULL,
  `fecha_completada` datetime DEFAULT NULL,
  `fecha_validada` datetime DEFAULT NULL,
  `notas_tecnico` text COLLATE utf8mb4_unicode_ci,
  `procesado_por` int DEFAULT NULL,
  `validado_por` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id_paciente` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `genero` enum('Masculino','Femenino') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id_paciente`, `nombre`, `apellido`, `fecha_nacimiento`, `genero`, `direccion`, `telefono`, `correo`, `fecha_registro`) VALUES
(3, 'Emilia Alejndra', 'Pérez Castillo', '2018-03-21', 'Femenino', 'Chiantla, zona 1, Huehuetenango', '', '', '2026-01-17 17:38:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametros_pruebas`
--

CREATE TABLE `parametros_pruebas` (
  `id_parametro` int NOT NULL,
  `id_prueba` int NOT NULL,
  `nombre_parametro` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unidad_medida` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valor_ref_hombre_min` decimal(12,4) DEFAULT NULL,
  `valor_ref_hombre_max` decimal(12,4) DEFAULT NULL,
  `valor_ref_mujer_min` decimal(12,4) DEFAULT NULL,
  `valor_ref_mujer_max` decimal(12,4) DEFAULT NULL,
  `valor_ref_pediatrico_min` decimal(12,4) DEFAULT NULL,
  `valor_ref_pediatrico_max` decimal(12,4) DEFAULT NULL,
  `tipo_dato` enum('Numérico','Texto','Selección','Cualitativo') COLLATE utf8mb4_unicode_ci DEFAULT 'Numérico',
  `opciones_seleccion` text COLLATE utf8mb4_unicode_ci COMMENT 'JSON con opciones si es tipo Selección',
  `valores_normales` text COLLATE utf8mb4_unicode_ci COMMENT 'Para resultados cualitativos',
  `orden_visualizacion` int DEFAULT '0',
  `critico_bajo` decimal(12,4) DEFAULT NULL COMMENT 'Valor crítico bajo',
  `critico_alto` decimal(12,4) DEFAULT NULL COMMENT 'Valor crítico alto',
  `formula_calculo` text COLLATE utf8mb4_unicode_ci COMMENT 'Si se calcula a partir de otros parámetros',
  `notas` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `procedimientos_menores`
--

CREATE TABLE `procedimientos_menores` (
  `id_procedimiento` int DEFAULT NULL,
  `id_paciente` int NOT NULL,
  `nombre_paciente` varchar(255) NOT NULL,
  `procedimiento` varchar(255) NOT NULL COMMENT 'Nombre del procedimiento (ej. Sutura, Curación)',
  `cobro` decimal(10,2) NOT NULL,
  `fecha_procedimiento` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(4, 'Nota de Envío', 'A-0001', 'Servimedic', '2026-01-16', 31280.84, 'Pendiente', '2026-01-16 19:58:11', 0.00, 'Pendiente', NULL),
(5, 'Nota de Envío', 'A-0002', 'Servimedic', '2026-01-16', 31162.24, 'Pendiente', '2026-01-17 04:51:31', 0.00, 'Pendiente', NULL);

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
(4, 4, 'Antigrip', 'Ampolla', 'Eucolapto-Guayacol', 'Servimedic', 5, 21.69, 35.00, 108.45, 'Pendiente'),
(5, 4, 'Ibuvanz', 'Suspension', 'Ibuprofeno100mg/5ml', 'Servimedic', 5, 21.99, 62.00, 109.95, 'Pendiente'),
(6, 4, 'Fungiter', 'Crema topica', 'Terbinafina 1g', 'Servimedic', 5, 27.33, 140.00, 136.65, 'Pendiente'),
(7, 4, 'D3-fENDER', 'Capsula', 'Vitamina D3100,000UI', 'Servimedic', 5, 95.17, 140.00, 475.85, 'Pendiente'),
(8, 4, 'Bisocard 5mg', 'Tableta', 'Bisoprolol famarato 5mg', 'Servimedic', 5, 116.32, 270.00, 581.60, 'Pendiente'),
(9, 4, 'Olmepress HCT 40/12.5mg', 'Tableta', 'Olmesartan Medoxomil40mg+Hidroclorotiazida 12.5mg', 'Servimedic', 5, 170.38, 350.00, 851.90, 'Pendiente'),
(10, 4, 'Gacimex', 'suspension', 'Magaldrato 800mg/Simeticona 60mg/10ml', 'Servimedic', 5, 92.18, 155.00, 460.90, 'Pendiente'),
(11, 4, 'Ultram D', 'Capsula', 'Dutasterida 0.5+Tamsulona clorhidrato 0.4mg', 'Servimedic', 4, 296.24, 600.00, 1184.96, 'Pendiente'),
(12, 4, 'Triacid', 'Tableta', 'Pinaverium 100mg+Simethicone 300mg', 'Servimedic', 5, 142.48, 230.00, 712.40, 'Pendiente'),
(13, 4, 'Tónico de alfalfa R95', 'Suspensión', 'tónico de alfalfa', 'Servimedic', 5, 104.90, 210.00, 524.50, 'Pendiente'),
(14, 4, 'Metiom H. pylori', 'Cápsula', 'esomeprazol-levofloxamina-amoxicilina', 'Servimedic', 4, 445.47, 630.00, 1781.88, 'Pendiente'),
(15, 4, 'Vertiless', 'Tableta', 'Betahistina- diclorhidrato 16mg', 'Servimedic', 5, 86.40, 180.00, 432.00, 'Pendiente'),
(16, 4, 'Lyverium 1mg', 'Tableta', 'Alprazolam 1mg', 'Servimedic', 5, 112.02, 255.00, 560.10, 'Pendiente'),
(17, 4, 'Lyverium 0.5mg', 'Tableta', 'Alprazolam 0.5mg', 'Servimedic', 5, 72.67, 150.00, 363.35, 'Pendiente'),
(18, 4, 'Equiliv', 'Gotero', 'clonazepam 2.5/ml', 'Servimedic', 5, 78.40, 115.00, 392.00, 'Pendiente'),
(19, 4, 'Atenua', 'Comprimidos', 'dexketoprofeno 25mg', 'Servimedic', 5, 48.98, 140.00, 244.90, 'Pendiente'),
(20, 4, 'Sitalev Met', 'Tabletas', 'sitaglipina 50mg +metformina 500mg', 'Servimedic', 5, 123.62, 220.00, 618.10, 'Pendiente'),
(21, 4, 'Inuric-G', 'Tableta', 'Febuxostat 80mg', 'Servimedic', 5, 148.50, 320.00, 742.50, 'Pendiente'),
(22, 4, 'Gabin', 'Tableta', 'Gabapentina 400mg', 'Servimedic', 5, 97.50, 250.00, 487.50, 'Pendiente'),
(23, 4, 'Atrolip Plus', 'Comprimidos', 'atorvastatina 10mg + ezetimibe 10 mg', 'Servimedic', 5, 203.56, 380.00, 1017.80, 'Pendiente'),
(24, 4, 'Glutamax C', 'Viales', 'Glutathione + vit C', 'Servimedic', 3, 89.20, 200.00, 267.60, 'Pendiente'),
(25, 4, 'Rupagán', 'Suspensión', 'Rupatadina 1mg/ml.', 'Servimedic', 5, 80.13, 145.00, 400.65, 'Pendiente'),
(26, 4, 'Biotos Inmune', 'Suspensión', 'Hedera helix & Pelargonium sidoides', 'Servimedic', 5, 75.16, 185.00, 375.80, 'Pendiente'),
(27, 4, 'Biotos Inmune Pediátrico', 'Suspensión', 'Hedera Helix & Pelargonium sidoides', 'Servimedic', 5, 54.91, 135.00, 274.55, 'Pendiente'),
(28, 4, 'Omega 1000', 'Cápsulas', 'Omega 3', 'Servimedic', 2, 227.90, 425.00, 455.80, 'Pendiente'),
(29, 4, 'Aci-tip', 'Comprimidos', 'Magaldrato 800mg - simeticona 40mg', 'Servimedic', 5, 55.56, 120.00, 277.80, 'Pendiente'),
(30, 4, 'Neuralplus', 'Tableta', 'Tiamina, piridoxina, cianocobalamina, diclofenaco', 'Servimedic', 4, 38.48, 115.00, 153.92, 'Pendiente'),
(31, 4, 'Kardiopil HCT', 'Tableta', 'Irbesartán 300mg + hidroclorotiazida 12.5 mg', 'Servimedic', 5, 144.54, 250.00, 722.70, 'Pendiente'),
(32, 4, 'Milenium', 'Cápsula', 'esomeprazol 40mg', 'Servimedic', 5, 88.00, 250.00, 440.00, 'Pendiente'),
(33, 4, 'Denk man active', 'Cápsula', 'extraxto de ginkgo, arginina', 'Servimedic', 3, 114.00, 220.00, 342.00, 'Pendiente'),
(34, 4, 'Inmuno biter', 'Ampolla bebible', 'extracto glicerinado de jara+tomillo', 'Servimedic', 3, 289.90, 390.00, 869.70, 'Pendiente'),
(35, 4, 'Spacek', 'Tabletas', 'Bromuro de otilonio 40mg', 'Servimedic', 5, 71.00, 170.00, 355.00, 'Pendiente'),
(36, 4, 'Spirocard', 'Tableta', 'spironolactone 100mg', 'Servimedic', 5, 144.90, 260.00, 724.50, 'Pendiente'),
(37, 4, 'Kardiopil Amlo', 'Tableta', 'Irbesartan 300mg + Amlodipine 5mg', 'Servimedic', 5, 237.72, 410.00, 1188.60, 'Pendiente'),
(38, 4, 'Gabex', 'Cápsula', 'Gabapentin 300mg', 'Servimedic', 5, 90.93, 200.00, 454.65, 'Pendiente'),
(39, 4, 'biobronq', 'Suspensión', 'Hedera Helix 35mg/5ml', 'Servimedic', 5, 50.61, 80.00, 253.05, 'Pendiente'),
(40, 4, 'Disolflem', 'sticks granulado', 'Acetilcisteína', 'Servimedic', 5, 42.73, 105.00, 213.65, 'Pendiente'),
(41, 4, 'Uroprin', 'Sticks granulado', 'Fosfomicina 3g', 'Servimedic', 5, 126.40, 165.00, 632.00, 'Pendiente'),
(42, 4, 'Clevium', 'Sobres Bebible', 'Desketoprofen (Trometamol) 25mg/10ml', 'Servimedic', 5, 84.63, 140.00, 423.15, 'Pendiente'),
(43, 4, 'Clevium', 'Gel', 'Dexketoprofeno 1.25%', 'Servimedic', 5, 37.00, 80.00, 185.00, 'Pendiente'),
(44, 4, 'Flavia', 'Tabletas', 'Melatonina, calcio', 'Servimedic', 5, 153.84, 250.00, 769.20, 'Pendiente'),
(45, 4, 'Demilos', 'Comprimidos', 'carbonato de calcio colecalciferol, vitamina d3', 'Servimedic', 5, 134.22, 215.00, 671.10, 'Pendiente'),
(46, 4, 'Zefalox', '20 Cápsulas', 'cefixime 400mg', 'Servimedic', 5, 287.38, 650.00, 1436.90, 'Pendiente'),
(47, 4, 'Zefalox', 'Suspensión 50ml', 'Cefixima 100mg/5ml', 'Servimedic', 5, 66.77, 205.00, 333.85, 'Pendiente'),
(48, 4, 'Zefalox', 'Suspesión 100ml', 'Cefixima', 'Servimedic', 5, 101.43, 300.00, 507.15, 'Pendiente'),
(49, 4, 'Conflexil Plus Shot', 'Sticks bebible', 'tiocolchicosido 4mg-diclofenaco 50mh', 'Servimedic', 100, 12.06, 22.00, 1206.00, 'Pendiente'),
(50, 4, 'Rofemed', 'Vial', 'ceftriaxona 1g', 'Servimedic', 5, 21.36, 120.00, 106.80, 'Pendiente'),
(51, 4, 'Milenium', '30 Cápsulas', 'esomeprazol 20ml', 'Servimedic', 5, 53.50, 200.00, 267.50, 'Pendiente'),
(52, 4, 'Gadavyt fibra liquida', 'Suspensión', 'Fibra dietética jugo natural de ciruela', 'Servimedic', 2, 215.46, 345.00, 430.92, 'Pendiente'),
(53, 4, 'Fungiter', 'Spray', 'Terbinafine HCI 1%', 'Servimedic', 5, 45.71, 100.00, 228.55, 'Pendiente'),
(54, 4, 'Fungiter', '28 Tabletas', 'Terbinafine 250 mg', 'Servimedic', 5, 219.76, 545.00, 1098.80, 'Pendiente'),
(55, 4, 'Septidex', 'Spray', 'Polimixina. neomicina 40g', 'Servimedic', 5, 52.45, 105.00, 262.25, 'Pendiente'),
(56, 4, 'Dinivanz', 'Solución p/ nebulizar', 'Salbutamol, salino solucion', 'Servimedic', 5, 42.95, 130.00, 214.75, 'Pendiente'),
(57, 4, 'Hicet', 'Gotas pediátricas', 'Cetirizina diclorhidrato 10mg/ml', 'Servimedic', 5, 42.26, 105.00, 211.30, 'Pendiente'),
(58, 4, 'Hicet', 'Jarabe 120ml', 'Cetirizina diclorhidrato 5mg/ml', 'Servimedic', 5, 58.76, 140.00, 293.80, 'Pendiente'),
(59, 4, 'Hicet', 'Jarabe 60ml', 'Cetirizina diclorhidrato 5mg/5ml', 'Servimedic', 5, 35.96, 90.00, 179.80, 'Pendiente'),
(60, 4, 'Hicet', '10 Cápsulas', 'Cetirizina diclorhidrato 10mg', 'Servimedic', 5, 38.03, 90.00, 190.15, 'Pendiente'),
(61, 4, 'Gabex Plus', '30 Tabletas recubiertas', 'Gabapentina + vitamina B1 y B12', 'Servimedic', 5, 156.20, 350.00, 781.00, 'Pendiente'),
(62, 4, 'Levent-Vit-E', '30 Cápsulas', 'vitamina E', 'Servimedic', 3, 180.67, 280.00, 542.01, 'Pendiente'),
(63, 4, 'Rosecol', '30 Tabletas recubiertas', 'Rosuvastatina 20mg', 'Servimedic', 5, 109.45, 235.00, 547.25, 'Pendiente'),
(64, 4, 'Prednicet', '20 Tabletas', 'Prednisolona 5mg', 'Servimedic', 5, 40.87, 85.00, 204.35, 'Pendiente'),
(65, 5, 'Conflexil', 'Ampollas 4mg/2ml', 'Tiocolchicósido', 'Servimedic', 25, 13.50, 35.00, 337.50, 'Pendiente'),
(66, 5, 'Viater Forte', 'Viales bebibles', 'ginseng, vitamina E, zinc', 'Servimedic', 1, 206.90, 300.00, 206.90, 'Pendiente'),
(67, 5, 'Acla-med bid', '14 tabletas recubiertas', 'amoxicilina 875mg, acido clavulanico 125mg', 'Servimedic', 1, 86.03, 215.00, 86.03, 'Pendiente'),
(68, 5, 'Symbio flor 1', 'Suspension oral', 'enterococcusfaecalis', 'Servimedic', 1, 178.00, 255.00, 178.00, 'Pendiente'),
(69, 5, 'Klevraxr', '30 tabletas', 'levetiracetam 500mg', 'Servimedic', 3, 105.00, 170.00, 315.00, 'Pendiente'),
(70, 5, 'Suganon', '30 Comprimidos', 'Evogliptina 5mg', 'Servimedic', 5, 359.00, 505.00, 1795.00, 'Pendiente'),
(71, 5, 'Zukermen Met', '30 Tabletas', 'vildagliptina 50ml+metformina 1000mg', 'Servimedic', 5, 126.78, 300.00, 633.90, 'Pendiente'),
(72, 5, 'Tusivanz', 'gotas pediatricas', 'dextromethorphan+carboxymethylcysteine', 'Servimedic', 5, 46.17, 105.00, 230.85, 'Pendiente'),
(73, 5, 'Budoxigen', 'spray 200 aplicaciones', 'Budesonida 50mcg/100mcl', 'Servimedic', 5, 91.34, 190.00, 456.70, 'Pendiente'),
(74, 5, 'Total Magnesiano', 'Sobres efervecentes', 'cloruro de magnesio 4.5H2O 1.5g + fluoruro de magnesio 0.0015g', 'Servimedic', 2, 152.00, 250.00, 304.00, 'Pendiente'),
(75, 5, 'Acla-med', 'Suspension', 'Amoxicilina 600mg+Acido clavulanico 42.9mg', 'Servimedic', 3, 64.43, 175.00, 193.29, 'Pendiente'),
(76, 5, 'Avsar Plus', '28 Tabletas', 'valsartan 320mg+amlodipina 10mg+hidroclorotiazida 25mg', 'Servimedic', 3, 166.70, 520.00, 500.10, 'Pendiente'),
(77, 5, 'Deflarin', '10 comprimidos', 'desflazacort 30mg', 'Servimedic', 3, 210.00, 325.00, 630.00, 'Pendiente'),
(78, 5, 'Disoflem', 'Sobres Granulados', 'Acetilcisteina 200mg', 'Servimedic', 5, 42.73, 105.00, 213.65, 'Pendiente'),
(79, 5, 'Megamol', '100 capsulas', 'vitamina D3', 'Servimedic', 5, 102.90, 250.00, 514.50, 'Pendiente'),
(80, 5, 'Diabilev', '30 Tabletas', 'Metformina HCI 500mg', 'Servimedic', 2, 54.70, 90.00, 109.40, 'Pendiente'),
(81, 5, 'Denk immun active', 'Sobres', 'Zinc, selenio', 'Servimedic', 5, 118.63, 195.00, 593.15, 'Pendiente'),
(82, 5, 'Melatina', 'Gotero', 'Melatonina 10.53mg', 'Servimedic', 5, 82.90, 160.00, 414.50, 'Pendiente'),
(83, 5, 'Bru-sone', 'Ampolla', 'betametasona dipropionato 5mg+fosfato sodico 2mg', 'Servimedic', 5, 97.34, 190.00, 486.70, 'Pendiente'),
(84, 5, 'Gastrexx plus', '28 capsulas', 'amoxicilina 1g+ levofloxacina 500mg', 'Servimedic', 3, 200.55, 480.00, 601.65, 'Pendiente'),
(85, 5, 'Modepar', '60 Tabletas', 'Nicotinamida 17.5mg, Acido Ascorbico 50mg', 'Servimedic', 5, 375.50, 550.00, 1877.50, 'Pendiente'),
(86, 5, 'Adiaplex', '30 Tabletas', 'Dapagliflozina 10mg', 'Servimedic', 5, 273.93, 410.00, 1369.65, 'Pendiente'),
(87, 5, 'Glidap Max', '30 tabletas', 'Dapagliflozina 5mg+metformina HCI lp 1000mg', 'Servimedic', 5, 130.00, 300.00, 650.00, 'Pendiente'),
(88, 5, 'Gesimax', '10 tabletas', 'Naproxeno sodico 550mg', 'Servimedic', 20, 48.40, 60.00, 968.00, 'Pendiente'),
(89, 5, 'Lisinox', '10 Tabletas', 'Propinoxato HCL 10mg+clonixinato de lisina 125mg', 'Servimedic', 10, 18.31, 45.00, 183.10, 'Pendiente'),
(90, 5, 'Solocin Plus', '20 comprimidos', 'pancreatina 400mg+simeticona 60mg+cinitaprina 1mg', 'Servimedic', 5, 109.34, 220.00, 546.70, 'Pendiente'),
(91, 5, 'Ferrum 16', 'Jarabe 240ml', 'hierro, vitaminas y minerales', 'Servimedic', 5, 68.00, 120.00, 340.00, 'Pendiente'),
(92, 5, 'Gadysen', '30 capsulas', 'Duloxetina 60mg', 'Servimedic', 5, 257.76, 560.00, 1288.80, 'Pendiente'),
(93, 5, 'Gadysen', '30 capsulas', 'Duloxetina 30mg', 'Servimedic', 3, 226.00, 510.00, 678.00, 'Pendiente'),
(94, 5, 'Multiflora Adance', '30 capsulas', 'probiotico', 'Servimedic', 3, 271.60, 420.00, 814.80, 'Pendiente'),
(95, 5, 'Estoma dol', '30 capsulas', 'trisilicato de magnesio, carbon vegetal', 'Servimedic', 2, 82.90, 140.00, 165.80, 'Pendiente'),
(96, 5, 'Exlant', '30 capsulas', 'dexlansoprazol 30mg', 'Servimedic', 4, 149.50, 365.00, 598.00, 'Pendiente'),
(97, 5, 'Ki-Cab', '50 tabletas', 'tegoprazan 50mg', 'Servimedic', 1, 593.41, 830.00, 593.41, 'Pendiente'),
(98, 5, 'Lisinox', 'Gotas 20ml', 'Propinoxato clorhidrato 5mg/ml', 'Servimedic', 3, 42.46, 80.00, 127.38, 'Pendiente'),
(99, 5, 'Probiocyan', '30 capsulas', 'lactobacillus plantarum, zinc 5mg', 'Servimedic', 5, 138.34, 230.00, 691.70, 'Pendiente'),
(100, 5, 'Colitran', '10 grageas', 'clordiazepoxido HCI/ Bromuro de clidinio', 'Servimedic', 10, 23.00, 40.00, 230.00, 'Pendiente'),
(101, 5, 'Sucralfato', '40 Tabletas', 'sucralfato 1g', 'Servimedic', 1, 59.98, 105.00, 59.98, 'Pendiente'),
(102, 5, 'Cetamin CC', '10 Tabletas', 'Acetaminofen 325mg+codeina 15mg', 'Servimedic', 5, 43.60, 90.00, 218.00, 'Pendiente'),
(103, 5, 'Tensinor Plus', '30 Tabletas', 'Valsartan 160mg/hidroclorotiazida 12.5mg/amlodipino 5mg', 'Servimedic', 2, 270.00, 480.00, 540.00, 'Pendiente'),
(104, 5, 'Tensinor Plus', '30 Tabletas', 'Valsartan 320mg/hidroclorotiazida 25mg/amlodipino 10mg', 'Servimedic', 2, 270.00, 480.00, 540.00, 'Pendiente'),
(105, 5, 'Metavan', '30 Tabletas', 'metformina HCI 1000mg', 'Servimedic', 1, 210.14, 245.00, 210.14, 'Pendiente'),
(106, 5, 'FILINAR g', 'Suspension', 'acebrifilina 5mg/ml', 'Servimedic', 1, 102.74, 160.00, 102.74, 'Pendiente'),
(107, 5, 'Myo & D-Chiro Inositol', '90 capsulas', 'inositol chiro', 'Servimedic', 2, 350.00, 470.00, 700.00, 'Pendiente'),
(108, 5, 'Gastroflux', 'suspension', 'domperidona 1mg/ml', 'Servimedic', 5, 170.63, 235.00, 853.15, 'Pendiente'),
(109, 5, 'Careject', 'Spray nasal', 'aceite de soja, glicerol', 'Servimedic', 5, 74.48, 150.00, 372.40, 'Pendiente'),
(110, 5, 'Aidex', 'Sobres bebibles', 'dexketoprofeno 25mg/10ml', 'Servimedic', 5, 85.00, 110.00, 425.00, 'Pendiente'),
(111, 5, 'Rusitan', 'Suspension', 'Rupatadina fumarato 1mg/ml', 'Servimedic', 5, 107.70, 175.00, 538.50, 'Pendiente'),
(112, 5, 'Acetaminofen lancasco', 'Suspension', 'acetaminofen 120/5ml', 'Servimedic', 3, 15.00, 30.00, 45.00, 'Pendiente'),
(113, 5, 'Bucaglu', 'Tintura Oral', 'ruibarbo y acido salicilico', 'Servimedic', 3, 55.00, 130.00, 165.00, 'Pendiente'),
(114, 5, 'Contractil', '10 Tabletas', 'tiocolchicosido 4mg', 'Servimedic', 3, 68.73, 130.00, 206.19, 'Pendiente'),
(115, 5, 'Etoricox', '14 Tabletas', 'Etoricoxib 120mg', 'Servimedic', 1, 275.00, 400.00, 275.00, 'Pendiente'),
(116, 5, 'Isocraneol', '30 Comprimidos', 'Citicolina 500mg', 'Servimedic', 5, 321.53, 500.00, 1607.65, 'Pendiente'),
(117, 5, 'Rodiflux', 'Gotero', 'Dextrometorfan, carboximetilcisteina, clorfeniramina', 'Servimedic', 5, 52.80, 110.00, 264.00, 'Pendiente'),
(118, 5, 'Gebrix-G 240ml', 'Suspension', 'Jengibre, Equinacea, vitamina C', 'Servimedic', 3, 100.00, 200.00, 300.00, 'Pendiente'),
(119, 5, 'Zirtraler-D 60ml', 'Suspension', 'Cetirizina HCI, Fenilefrina HCI', 'Servimedic', 5, 65.69, 125.00, 328.45, 'Pendiente'),
(120, 5, 'Neo-melubrina', 'Jarabe 100ml', 'Metamizol sodico 250mg/5ml', 'Servimedic', 2, 35.00, 75.00, 70.00, 'Pendiente'),
(121, 5, 'Neobol', 'Spray 30g', 'neomicina- clostebol', 'Servimedic', 2, 60.00, 135.00, 120.00, 'Pendiente'),
(122, 5, 'Mero Clav', 'suspension 70ml', 'cefuroxima+ acido clavulanico', 'Servimedic', 2, 145.00, 250.00, 290.00, 'Pendiente'),
(123, 5, 'Dexamicina', 'Gotero Oftalmico 5ml', 'Dexametazona/neomicina', 'Servimedic', 5, 25.00, 55.00, 125.00, 'Pendiente'),
(124, 5, 'Aciclovirax', 'Suspension 120ml', 'Aciclovir pediatrico', 'Servimedic', 5, 112.13, 200.00, 560.65, 'Pendiente'),
(125, 5, 'Bencidamin', 'Spray bucal', 'Bencidamina', 'Servimedic', 2, 32.00, 90.00, 64.00, 'Pendiente'),
(126, 5, 'Metronis', 'suspension', 'Nitazoxanida 100mg/5ml', 'Servimedic', 2, 34.33, 80.00, 68.66, 'Pendiente'),
(127, 5, 'Sinedol Forte', '10 Tabletas', 'Acetaminofen 750mg', 'Servimedic', 5, 29.84, 45.00, 149.20, 'Pendiente'),
(128, 5, 'Mucarbol Pediatrico', 'Jarabe', 'Carbocisteina 100mg/5ml', 'Servimedic', 5, 39.23, 65.00, 196.15, 'Pendiente'),
(129, 5, 'Mucarbol Adulto', 'Jarabe', 'Carbocisteina 750mg/15ml', 'Servimedic', 5, 42.37, 70.00, 211.85, 'Pendiente'),
(130, 5, 'Neo-Melubrina', '4 Tabletas', 'Metamizol 500mg', 'Servimedic', 25, 2.80, 15.00, 70.00, 'Pendiente'),
(131, 5, 'AGE III', '30 Capsulas', 'cucurbita pepo. africanum', 'Servimedic', 5, 132.85, 200.00, 664.25, 'Pendiente'),
(132, 5, 'Sertal Forte Perlas', '10 capsulas', 'Propinox Clorhidrato 20mf', 'Servimedic', 6, 49.87, 90.00, 299.22, 'Pendiente'),
(133, 5, 'Ardix', '10 Tabletas', 'dexketoprofeno 25mg', 'Servimedic', 1, 50.00, 95.00, 50.00, 'Pendiente'),
(134, 5, 'Wen vision', 'Gotero Oftalmico 5ml', 'Dexametasona, neomicina', 'Servimedic', 5, 25.00, 55.00, 125.00, 'Pendiente'),
(135, 5, 'Selenio+Vit E', '60 Capsulas', 'Vitamina E 1000UI+ Selenio 200', 'Servimedic', 2, 56.33, 175.00, 112.66, 'Pendiente'),
(136, 5, 'Brucort-A', 'Crema Topica', 'Triamcinolona acetonido 0.1%', 'Servimedic', 4, 50.00, 110.00, 200.00, 'Pendiente'),
(137, 5, 'Uxbi', '30 capsulas', 'Acido ursodesoxicolico 250mg', 'Servimedic', 2, 200.00, 375.00, 400.00, 'Pendiente'),
(138, 5, 'Allopurikem', '10 Tabletas', 'alopurinol 300mg', 'Servimedic', 5, 29.40, 75.00, 147.00, 'Pendiente'),
(139, 5, 'Deka-C Adultos', 'Ampollas bebibles 5ml', 'vitaminas A, D, E y C', 'Servimedic', 5, 25.75, 75.00, 128.75, 'Pendiente'),
(140, 5, 'Rexacort', 'Spray nasal 18g', 'mometasona furoato 50pg', 'Servimedic', 3, 55.38, 130.00, 166.14, 'Pendiente'),
(141, 5, 'Histakem Block', 'Spray bucal 30ml', 'Cloruro de cetilpiridinio 0.05g+benzocaina 1.0g', 'Servimedic', 2, 80.00, 125.00, 160.00, 'Pendiente'),
(142, 5, 'Colchinet', '20 Tabletas', 'Colchicina 0.5 mg', 'Servimedic', 15, 36.00, 65.00, 540.00, 'Pendiente'),
(143, 5, 'Triglix', '40 capsulas', 'Fenofibrato 160mg', 'Servimedic', 4, 219.00, 390.00, 876.00, 'Pendiente'),
(144, 5, 'Equiliv', '30 Tabletas', 'Clonazepan 2mg', 'Servimedic', 5, 77.85, 135.00, 389.25, 'Pendiente');

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
-- Estructura de tabla para la tabla `reactivos_laboratorio`
--

CREATE TABLE `reactivos_laboratorio` (
  `id_reactivo` int NOT NULL,
  `codigo_reactivo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_reactivo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fabricante` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proveedor` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_lote` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_serie` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_fabricacion` date DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `cantidad_disponible` decimal(10,3) NOT NULL DEFAULT '0.000',
  `unidad_medida` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ml, piezas, tests, etc',
  `cantidad_minima` decimal(10,3) DEFAULT '10.000',
  `costo_unitario` decimal(10,2) DEFAULT NULL,
  `ubicacion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Refrigeradora A, Estante 3, etc',
  `condiciones_almacenamiento` text COLLATE utf8mb4_unicode_ci COMMENT 'Temperatura, luz, humedad',
  `estado` enum('Disponible','Por_Vencer','Vencido','Agotado','En_Cuarentena') COLLATE utf8mb4_unicode_ci DEFAULT 'Disponible',
  `notas` text COLLATE utf8mb4_unicode_ci,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `valor_resultado` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Valor como texto',
  `valor_numerico` decimal(12,4) DEFAULT NULL COMMENT 'Para facilitar queries y análisis',
  `fuera_rango` enum('Normal','Alto','Bajo','Crítico_Alto','Crítico_Bajo') COLLATE utf8mb4_unicode_ci DEFAULT 'Normal',
  `valor_referencia` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Rango aplicable según paciente',
  `unidad_medida` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metodo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Método de análisis utilizado',
  `validado` tinyint(1) DEFAULT '0',
  `fecha_resultado` datetime DEFAULT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `procesado_por` int DEFAULT NULL,
  `validado_por` int DEFAULT NULL,
  `fecha_validacion` datetime DEFAULT NULL,
  `firma_digital` text COLLATE utf8mb4_unicode_ci COMMENT 'Hash o firma del validador',
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
  `estado_conciencia` enum('Alerta','Somnoliento','Estuporoso','Comatoso') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notas` text COLLATE utf8mb4_unicode_ci,
  `registrado_por` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` int NOT NULL,
  `usuario` varchar(255) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `especialidad` varchar(255) DEFAULT NULL,
  `tipoUsuario` enum('admin','doc','user','') NOT NULL,
  `clinica` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `permisos_modulos` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `usuario`, `password`, `nombre`, `apellido`, `especialidad`, `tipoUsuario`, `clinica`, `telefono`, `email`, `permisos_modulos`) VALUES
(1, 'admin', 'admin', 'Samuel', 'Ramirez', 'Ingeniero en Sistemas', 'admin', 'Centro Médico Herrera Saenz', '49617032', 'samuel.ramirez25prs@gmail.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}'),
(6, 'jrivas_farmacia', 'password123', 'Jeimi', 'Rivas', 'Farmacia', 'user', 'Centro Médico Herrera Saenz', '0000', 'jeimi@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(7, 'atello', 'password123', 'Anye', 'Tello', 'Recepción y Cobros', 'user', 'Centro Médico Herrera Saenz', '0000', 'anye@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(8, 'fherrera', 'password123', 'Francisco', 'Herrera', 'Administrador General', 'admin', 'Centro Médico Herrera Saenz', '0000', 'francisco@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}'),
(9, 'jannyar', 'password123', 'Jannya', 'Rivas', 'Administrador General', 'admin', 'Centro Médico Herrera Saenz', '0000', 'jannya@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}'),
(10, 'epineda', 'password123', 'Enrique', 'Pineda', 'Administrador General', 'admin', 'Centro Médico Herrera Saenz', '0000', 'enrique@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}'),
(11, 'iherrera', 'password123', 'Isabel', 'Herrera', 'Administrador General', 'admin', 'Centro Médico Herrera Saenz', '0000', 'isabel@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}'),
(12, 'ysantos', 'password123', 'Yenifer', 'Santos', 'Farmacia Interna y Controles', 'admin', 'Centro Médico Herrera Saenz', '0000', 'yenifer@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}'),
(13, 'lvalle', 'password123', 'Luis Carlos', 'del Valle', 'Medicina Interna', 'doc', 'Centro Médico Herrera Saenz', '0000', 'luis@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(14, 'jrivas_saenz', 'password123', 'Jannya', 'Rivas Sáenz', 'Medico y cirujano', 'doc', 'Centro Médico Herrera Saenz', '0000', 'jannyas@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(15, 'erivas', 'password123', 'Estuardo', 'Rivas', 'Ginecólogo y Obstetra', 'doc', 'Centro Médico Herrera Saenz', '0000', 'estuardo@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(16, 'mmutas', 'password123', 'Mayeli', 'Mutás Ochoa', 'Medicina Interna', 'doc', 'Centro Médico Herrera Saenz', '0000', 'mayeli@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(17, 'lrecinos', 'password123', 'Libny', 'Recinos', 'Pediatra', 'doc', 'Centro Médico Herrera Saenz', '0000', 'libny@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(18, 'iherrera_nutri', 'password123', 'Isabel', 'Herrera', 'Nutricionista', 'doc', 'Centro Médico Herrera Saenz', '0000', 'isabel_n@example.com', '{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": true, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}'),
(19, 'doc_turno1', 'password123', 'Médico', 'Turno 1', 'Médico de Turno', 'doc', 'Centro Médico Herrera Saenz', '0000', 'turno1@example.com', '{\"billing\": true, \"patients\": true}'),
(20, 'doc_turno2', 'password123', 'Médico', 'Turno 2', 'Médico de Turno', 'doc', 'Centro Médico Herrera Saenz', '0000', 'turno2@example.com', '{\"billing\": true, \"patients\": true}'),
(21, 'doc_turno3', 'password123', 'Médico', 'Turno 3', 'Médico de Turno', 'doc', 'Centro Médico Herrera Saenz', '0000', 'turno3@example.com', '{\"billing\": true, \"patients\": true}'),
(22, 'lab_user', 'password123', 'Usuario', 'Laboratorio', 'Técnico de Laboratorio', 'user', 'Centro Médico Herrera Saenz', '0000', 'lab@example.com', '{\"laboratory\": true, \"patients\": true}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int NOT NULL,
  `id_usuario` int DEFAULT NULL,
  `fecha_venta` datetime DEFAULT CURRENT_TIMESTAMP,
  `nombre_cliente` varchar(100) DEFAULT NULL,
  `tipo_pago` enum('Efectivo','Tarjeta','Seguro Médico') DEFAULT NULL,
  `total` decimal(10,2) DEFAULT '0.00',
  `estado` enum('Pendiente','Pagado','Cancelado') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

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
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compras`);

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
-- AUTO_INCREMENT de la tabla `administracion_medicamentos`
--
ALTER TABLE `administracion_medicamentos`
  MODIFY `id_administracion` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `camas`
--
ALTER TABLE `camas`
  MODIFY `id_cama` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `cargos_hospitalarios`
--
ALTER TABLE `cargos_hospitalarios`
  MODIFY `id_cargo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `catalogo_pruebas`
--
ALTER TABLE `catalogo_pruebas`
  MODIFY `id_prueba` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `id_cita` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cobros`
--
ALTER TABLE `cobros`
  MODIFY `in_cobro` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compras` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `control_calidad_lab`
--
ALTER TABLE `control_calidad_lab`
  MODIFY `id_control` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cuenta_hospitalaria`
--
ALTER TABLE `cuenta_hospitalaria`
  MODIFY `id_cuenta` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `id_detalle` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `encamamientos`
--
ALTER TABLE `encamamientos`
  MODIFY `id_encamamiento` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `evoluciones_medicas`
--
ALTER TABLE `evoluciones_medicas`
  MODIFY `id_evolucion` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  MODIFY `id_habitacion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  MODIFY `id_historial` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_inventario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT de la tabla `ordenes_laboratorio`
--
ALTER TABLE `ordenes_laboratorio`
  MODIFY `id_orden` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `orden_pruebas`
--
ALTER TABLE `orden_pruebas`
  MODIFY `id_orden_prueba` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id_paciente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `parametros_pruebas`
--
ALTER TABLE `parametros_pruebas`
  MODIFY `id_parametro` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `purchase_headers`
--
ALTER TABLE `purchase_headers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT de la tabla `purchase_payments`
--
ALTER TABLE `purchase_payments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_reserva` int NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int NOT NULL AUTO_INCREMENT;

-- --------------------------------------------------------

--
-- Estructura para la vista `encamamientos_con_dias`
--
DROP TABLE IF EXISTS `encamamientos_con_dias`;

CREATE ALGORITHM=UNDEFINED DEFINER=`uiewshfkax9viaaw`@`%` SQL SECURITY DEFINER VIEW `encamamientos_con_dias`  AS SELECT `e`.`id_encamamiento` AS `id_encamamiento`, `e`.`id_paciente` AS `id_paciente`, `e`.`id_cama` AS `id_cama`, `e`.`id_doctor` AS `id_doctor`, `e`.`fecha_ingreso` AS `fecha_ingreso`, `e`.`fecha_alta` AS `fecha_alta`, `e`.`motivo_ingreso` AS `motivo_ingreso`, `e`.`diagnostico_ingreso` AS `diagnostico_ingreso`, `e`.`diagnostico_egreso` AS `diagnostico_egreso`, `e`.`estado` AS `estado`, `e`.`tipo_ingreso` AS `tipo_ingreso`, `e`.`notas_ingreso` AS `notas_ingreso`, `e`.`notas_alta` AS `notas_alta`, `e`.`created_by` AS `created_by`, `e`.`fecha_creacion` AS `fecha_creacion`, `e`.`fecha_actualizacion` AS `fecha_actualizacion`, (case when (`e`.`fecha_alta` is null) then (to_days(curdate()) - to_days(cast(`e`.`fecha_ingreso` as date))) else (to_days(`e`.`fecha_alta`) - to_days(`e`.`fecha_ingreso`)) end) AS `dias_hospitalizacion` FROM `encamamientos` AS `e` ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administracion_medicamentos`
--
ALTER TABLE `administracion_medicamentos`
  ADD CONSTRAINT `administracion_medicamentos_ibfk_1` FOREIGN KEY (`id_encamamiento`) REFERENCES `encamamientos` (`id_encamamiento`) ON DELETE CASCADE,
  ADD CONSTRAINT `administracion_medicamentos_ibfk_2` FOREIGN KEY (`id_medicamento`) REFERENCES `inventario` (`id_inventario`) ON DELETE SET NULL,
  ADD CONSTRAINT `administracion_medicamentos_ibfk_3` FOREIGN KEY (`indicado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  ADD CONSTRAINT `administracion_medicamentos_ibfk_4` FOREIGN KEY (`administrado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `camas`
--
ALTER TABLE `camas`
  ADD CONSTRAINT `camas_ibfk_1` FOREIGN KEY (`id_habitacion`) REFERENCES `habitaciones` (`id_habitacion`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cargos_hospitalarios`
--
ALTER TABLE `cargos_hospitalarios`
  ADD CONSTRAINT `cargos_hospitalarios_ibfk_1` FOREIGN KEY (`id_cuenta`) REFERENCES `cuenta_hospitalaria` (`id_cuenta`) ON DELETE CASCADE,
  ADD CONSTRAINT `cargos_hospitalarios_ibfk_2` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `fk_doctor_cita` FOREIGN KEY (`id_doctor`) REFERENCES `usuarios` (`idUsuario`);

--
-- Filtros para la tabla `cobros`
--
ALTER TABLE `cobros`
  ADD CONSTRAINT `paciente_cobro` FOREIGN KEY (`paciente_cobro`) REFERENCES `pacientes` (`id_paciente`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `control_calidad_lab`
--
ALTER TABLE `control_calidad_lab`
  ADD CONSTRAINT `control_calidad_lab_ibfk_1` FOREIGN KEY (`id_prueba`) REFERENCES `catalogo_pruebas` (`id_prueba`) ON DELETE CASCADE,
  ADD CONSTRAINT `control_calidad_lab_ibfk_2` FOREIGN KEY (`realizado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  ADD CONSTRAINT `control_calidad_lab_ibfk_3` FOREIGN KEY (`aprobado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `cuenta_hospitalaria`
--
ALTER TABLE `cuenta_hospitalaria`
  ADD CONSTRAINT `cuenta_hospitalaria_ibfk_1` FOREIGN KEY (`id_encamamiento`) REFERENCES `encamamientos` (`id_encamamiento`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD CONSTRAINT `detalle_ventas_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_ventas_ibfk_2` FOREIGN KEY (`id_inventario`) REFERENCES `inventario` (`id_inventario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `encamamientos`
--
ALTER TABLE `encamamientos`
  ADD CONSTRAINT `encamamientos_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `historial_clinico` (`id_paciente`) ON DELETE RESTRICT,
  ADD CONSTRAINT `encamamientos_ibfk_2` FOREIGN KEY (`id_cama`) REFERENCES `camas` (`id_cama`) ON DELETE RESTRICT,
  ADD CONSTRAINT `encamamientos_ibfk_3` FOREIGN KEY (`id_doctor`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  ADD CONSTRAINT `encamamientos_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `evoluciones_medicas`
--
ALTER TABLE `evoluciones_medicas`
  ADD CONSTRAINT `evoluciones_medicas_ibfk_1` FOREIGN KEY (`id_encamamiento`) REFERENCES `encamamientos` (`id_encamamiento`) ON DELETE CASCADE,
  ADD CONSTRAINT `evoluciones_medicas_ibfk_2` FOREIGN KEY (`id_doctor`) REFERENCES `usuarios` (`idUsuario`) ON DELETE RESTRICT;

--
-- Filtros para la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  ADD CONSTRAINT `historial_clinico_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ordenes_laboratorio`
--
ALTER TABLE `ordenes_laboratorio`
  ADD CONSTRAINT `ordenes_laboratorio_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `historial_clinico` (`id_paciente`) ON DELETE RESTRICT,
  ADD CONSTRAINT `ordenes_laboratorio_ibfk_2` FOREIGN KEY (`id_doctor`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  ADD CONSTRAINT `ordenes_laboratorio_ibfk_3` FOREIGN KEY (`id_encamamiento`) REFERENCES `encamamientos` (`id_encamamiento`) ON DELETE SET NULL,
  ADD CONSTRAINT `ordenes_laboratorio_ibfk_4` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `orden_pruebas`
--
ALTER TABLE `orden_pruebas`
  ADD CONSTRAINT `orden_pruebas_ibfk_1` FOREIGN KEY (`id_orden`) REFERENCES `ordenes_laboratorio` (`id_orden`) ON DELETE CASCADE,
  ADD CONSTRAINT `orden_pruebas_ibfk_2` FOREIGN KEY (`id_prueba`) REFERENCES `catalogo_pruebas` (`id_prueba`) ON DELETE RESTRICT,
  ADD CONSTRAINT `orden_pruebas_ibfk_3` FOREIGN KEY (`procesado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  ADD CONSTRAINT `orden_pruebas_ibfk_4` FOREIGN KEY (`validado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `parametros_pruebas`
--
ALTER TABLE `parametros_pruebas`
  ADD CONSTRAINT `parametros_pruebas_ibfk_1` FOREIGN KEY (`id_prueba`) REFERENCES `catalogo_pruebas` (`id_prueba`) ON DELETE CASCADE;

--
-- Filtros para la tabla `purchase_headers`
--
ALTER TABLE `purchase_headers`
  ADD CONSTRAINT `purchase_headers_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD CONSTRAINT `purchase_items_ibfk_1` FOREIGN KEY (`purchase_header_id`) REFERENCES `purchase_headers` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `purchase_payments`
--
ALTER TABLE `purchase_payments`
  ADD CONSTRAINT `purchase_payments_ibfk_1` FOREIGN KEY (`purchase_header_id`) REFERENCES `purchase_headers` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `reactivos_laboratorio`
--
ALTER TABLE `reactivos_laboratorio`
  ADD CONSTRAINT `reactivos_laboratorio_ibfk_1` FOREIGN KEY (`ingresado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `resultados_laboratorio`
--
ALTER TABLE `resultados_laboratorio`
  ADD CONSTRAINT `resultados_laboratorio_ibfk_1` FOREIGN KEY (`id_orden_prueba`) REFERENCES `orden_pruebas` (`id_orden_prueba`) ON DELETE CASCADE,
  ADD CONSTRAINT `resultados_laboratorio_ibfk_2` FOREIGN KEY (`id_parametro`) REFERENCES `parametros_pruebas` (`id_parametro`) ON DELETE RESTRICT,
  ADD CONSTRAINT `resultados_laboratorio_ibfk_3` FOREIGN KEY (`procesado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  ADD CONSTRAINT `resultados_laboratorio_ibfk_4` FOREIGN KEY (`validado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `signos_vitales`
--
ALTER TABLE `signos_vitales`
  ADD CONSTRAINT `signos_vitales_ibfk_1` FOREIGN KEY (`id_encamamiento`) REFERENCES `encamamientos` (`id_encamamiento`) ON DELETE CASCADE,
  ADD CONSTRAINT `signos_vitales_ibfk_2` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
