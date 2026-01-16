<br />
<b>Deprecated</b>:  PDO::quote(): Passing null to parameter #1 ($string) of type string is deprecated in <b>/Users/samuelrm/Library/Mobile Documents/com~apple~CloudDocs/Programas/versiones/cmhs/php/dashboard/export_database.php</b> on line <b>32</b><br />
<br />
<b>Deprecated</b>:  PDO::quote(): Passing null to parameter #1 ($string) of type string is deprecated in <b>/Users/samuelrm/Library/Mobile Documents/com~apple~CloudDocs/Programas/versiones/cmhs/php/dashboard/export_database.php</b> on line <b>32</b><br />
<br />
<b>Deprecated</b>:  PDO::quote(): Passing null to parameter #1 ($string) of type string is deprecated in <b>/Users/samuelrm/Library/Mobile Documents/com~apple~CloudDocs/Programas/versiones/cmhs/php/dashboard/export_database.php</b> on line <b>32</b><br />
<br />
<b>Warning</b>:  Undefined array key "Create Table" in <b>/Users/samuelrm/Library/Mobile Documents/com~apple~CloudDocs/Programas/versiones/cmhs/php/dashboard/export_database.php</b> on line <b>24</b><br />
<br />
<b>Deprecated</b>:  PDO::quote(): Passing null to parameter #1 ($string) of type string is deprecated in <b>/Users/samuelrm/Library/Mobile Documents/com~apple~CloudDocs/Programas/versiones/cmhs/php/dashboard/export_database.php</b> on line <b>32</b><br />
<br />
<b>Deprecated</b>:  PDO::quote(): Passing null to parameter #1 ($string) of type string is deprecated in <b>/Users/samuelrm/Library/Mobile Documents/com~apple~CloudDocs/Programas/versiones/cmhs/php/dashboard/export_database.php</b> on line <b>32</b><br />
<br />
<b>Deprecated</b>:  PDO::quote(): Passing null to parameter #1 ($string) of type string is deprecated in <b>/Users/samuelrm/Library/Mobile Documents/com~apple~CloudDocs/Programas/versiones/cmhs/php/dashboard/export_database.php</b> on line <b>32</b><br />
<br />
<b>Deprecated</b>:  PDO::quote(): Passing null to parameter #1 ($string) of type string is deprecated in <b>/Users/samuelrm/Library/Mobile Documents/com~apple~CloudDocs/Programas/versiones/cmhs/php/dashboard/export_database.php</b> on line <b>32</b><br />
<br />
<b>Deprecated</b>:  PDO::quote(): Passing null to parameter #1 ($string) of type string is deprecated in <b>/Users/samuelrm/Library/Mobile Documents/com~apple~CloudDocs/Programas/versiones/cmhs/php/dashboard/export_database.php</b> on line <b>32</b><br />
<br />
<b>Deprecated</b>:  PDO::quote(): Passing null to parameter #1 ($string) of type string is deprecated in <b>/Users/samuelrm/Library/Mobile Documents/com~apple~CloudDocs/Programas/versiones/cmhs/php/dashboard/export_database.php</b> on line <b>32</b><br />
-- Exportación de base de datos
-- Fecha: 2026-01-15 09:36:37


-- --------------------------------------------------------
-- Estructura de tabla `administracion_medicamentos`
-- --------------------------------------------------------
CREATE TABLE `administracion_medicamentos` (
  `id_administracion` int NOT NULL AUTO_INCREMENT,
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
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_administracion`),
  KEY `id_medicamento` (`id_medicamento`),
  KEY `indicado_por` (`indicado_por`),
  KEY `administrado_por` (`administrado_por`),
  KEY `idx_encamamiento` (`id_encamamiento`),
  KEY `idx_estado` (`estado`),
  KEY `idx_fecha_admin` (`fecha_administracion`),
  CONSTRAINT `administracion_medicamentos_ibfk_1` FOREIGN KEY (`id_encamamiento`) REFERENCES `encamamientos` (`id_encamamiento`) ON DELETE CASCADE,
  CONSTRAINT `administracion_medicamentos_ibfk_2` FOREIGN KEY (`id_medicamento`) REFERENCES `inventario` (`id_inventario`) ON DELETE SET NULL,
  CONSTRAINT `administracion_medicamentos_ibfk_3` FOREIGN KEY (`indicado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  CONSTRAINT `administracion_medicamentos_ibfk_4` FOREIGN KEY (`administrado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `camas`
-- --------------------------------------------------------
CREATE TABLE `camas` (
  `id_cama` int NOT NULL AUTO_INCREMENT,
  `id_habitacion` int NOT NULL,
  `numero_cama` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` enum('Disponible','Ocupada','Mantenimiento','Reservada') COLLATE utf8mb4_unicode_ci DEFAULT 'Disponible',
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cama`),
  UNIQUE KEY `unique_cama` (`id_habitacion`,`numero_cama`),
  KEY `idx_estado` (`estado`),
  CONSTRAINT `camas_ibfk_1` FOREIGN KEY (`id_habitacion`) REFERENCES `habitaciones` (`id_habitacion`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `cargos_hospitalarios`
-- --------------------------------------------------------
CREATE TABLE `cargos_hospitalarios` (
  `id_cargo` int NOT NULL AUTO_INCREMENT,
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
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cargo`),
  KEY `registrado_por` (`registrado_por`),
  KEY `idx_cuenta` (`id_cuenta`),
  KEY `idx_tipo_cargo` (`tipo_cargo`),
  KEY `idx_fecha_cargo` (`fecha_cargo`),
  KEY `idx_cancelado` (`cancelado`),
  CONSTRAINT `cargos_hospitalarios_ibfk_1` FOREIGN KEY (`id_cuenta`) REFERENCES `cuenta_hospitalaria` (`id_cuenta`) ON DELETE CASCADE,
  CONSTRAINT `cargos_hospitalarios_ibfk_2` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `catalogo_pruebas`
-- --------------------------------------------------------
CREATE TABLE `catalogo_pruebas` (
  `id_prueba` int NOT NULL AUTO_INCREMENT,
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
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_prueba`),
  UNIQUE KEY `codigo_prueba` (`codigo_prueba`),
  KEY `idx_codigo` (`codigo_prueba`),
  KEY `idx_estado` (`estado`),
  KEY `idx_categoria` (`categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `citas`
-- --------------------------------------------------------
CREATE TABLE `citas` (
  `id_cita` int NOT NULL AUTO_INCREMENT,
  `nombre_pac` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apellido_pac` varchar(50) NOT NULL,
  `num_cita` int NOT NULL,
  `fecha_cita` date NOT NULL,
  `hora_cita` time NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `historial_id` int DEFAULT NULL,
  `id_doctor` int DEFAULT NULL,
  PRIMARY KEY (`id_cita`),
  KEY `fk_doctor_cita` (`id_doctor`),
  CONSTRAINT `fk_doctor_cita` FOREIGN KEY (`id_doctor`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcado de datos para la tabla `citas`
INSERT INTO `citas` VALUES ('1','Samuel','Ramirez','1','2026-01-10','08:00:00','39029076','','3');
INSERT INTO `citas` VALUES ('2','Samuel','Ramirez','2','2026-01-12','12:00:00','','1','');
INSERT INTO `citas` VALUES ('3','Juan ','Matias','3','2026-01-13','15:15:00','6485268756','','3');


-- --------------------------------------------------------
-- Estructura de tabla `cobros`
-- --------------------------------------------------------
CREATE TABLE `cobros` (
  `in_cobro` int NOT NULL AUTO_INCREMENT,
  `paciente_cobro` int NOT NULL,
  `cantidad_consulta` int NOT NULL,
  `fecha_consulta` date NOT NULL,
  PRIMARY KEY (`in_cobro`),
  KEY `paciente_cobro` (`paciente_cobro`),
  CONSTRAINT `paciente_cobro` FOREIGN KEY (`paciente_cobro`) REFERENCES `pacientes` (`id_paciente`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------
-- Estructura de tabla `compras`
-- --------------------------------------------------------
CREATE TABLE `compras` (
  `id_compras` int NOT NULL AUTO_INCREMENT,
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
  `estado_compra` enum('Pendiente','Abonado','Completo','') NOT NULL,
  PRIMARY KEY (`id_compras`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------
-- Estructura de tabla `control_calidad_lab`
-- --------------------------------------------------------
CREATE TABLE `control_calidad_lab` (
  `id_control` int NOT NULL AUTO_INCREMENT,
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
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_control`),
  KEY `realizado_por` (`realizado_por`),
  KEY `aprobado_por` (`aprobado_por`),
  KEY `idx_prueba` (`id_prueba`),
  KEY `idx_fecha` (`fecha_control`),
  KEY `idx_estado` (`estado`),
  CONSTRAINT `control_calidad_lab_ibfk_1` FOREIGN KEY (`id_prueba`) REFERENCES `catalogo_pruebas` (`id_prueba`) ON DELETE CASCADE,
  CONSTRAINT `control_calidad_lab_ibfk_2` FOREIGN KEY (`realizado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  CONSTRAINT `control_calidad_lab_ibfk_3` FOREIGN KEY (`aprobado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `cuenta_hospitalaria`
-- --------------------------------------------------------
CREATE TABLE `cuenta_hospitalaria` (
  `id_cuenta` int NOT NULL AUTO_INCREMENT,
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
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cuenta`),
  UNIQUE KEY `id_encamamiento` (`id_encamamiento`),
  KEY `idx_estado_pago` (`estado_pago`),
  CONSTRAINT `cuenta_hospitalaria_ibfk_1` FOREIGN KEY (`id_encamamiento`) REFERENCES `encamamientos` (`id_encamamiento`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `detalle_ventas`
-- --------------------------------------------------------
CREATE TABLE `detalle_ventas` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_venta` int DEFAULT NULL,
  `id_inventario` int DEFAULT NULL,
  `cantidad_vendida` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS ((`cantidad_vendida` * `precio_unitario`)) STORED,
  PRIMARY KEY (`id_detalle`),
  KEY `id_venta` (`id_venta`),
  KEY `id_inventario` (`id_inventario`),
  CONSTRAINT `detalle_ventas_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE,
  CONSTRAINT `detalle_ventas_ibfk_2` FOREIGN KEY (`id_inventario`) REFERENCES `inventario` (`id_inventario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------
-- Estructura de tabla `encamamientos`
-- --------------------------------------------------------
CREATE TABLE `encamamientos` (
  `id_encamamiento` int NOT NULL AUTO_INCREMENT,
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
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_encamamiento`),
  KEY `id_cama` (`id_cama`),
  KEY `created_by` (`created_by`),
  KEY `idx_paciente` (`id_paciente`),
  KEY `idx_estado` (`estado`),
  KEY `idx_fecha_ingreso` (`fecha_ingreso`),
  KEY `idx_doctor` (`id_doctor`),
  CONSTRAINT `encamamientos_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `historial_clinico` (`id_paciente`) ON DELETE RESTRICT,
  CONSTRAINT `encamamientos_ibfk_2` FOREIGN KEY (`id_cama`) REFERENCES `camas` (`id_cama`) ON DELETE RESTRICT,
  CONSTRAINT `encamamientos_ibfk_3` FOREIGN KEY (`id_doctor`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  CONSTRAINT `encamamientos_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `encamamientos_con_dias`
-- --------------------------------------------------------
;


-- --------------------------------------------------------
-- Estructura de tabla `evoluciones_medicas`
-- --------------------------------------------------------
CREATE TABLE `evoluciones_medicas` (
  `id_evolucion` int NOT NULL AUTO_INCREMENT,
  `id_encamamiento` int NOT NULL,
  `fecha_evolucion` datetime NOT NULL,
  `id_doctor` int NOT NULL,
  `subjetivo` text COLLATE utf8mb4_unicode_ci COMMENT 'SOAP: Subjetivo',
  `objetivo` text COLLATE utf8mb4_unicode_ci COMMENT 'SOAP: Objetivo',
  `evaluacion` text COLLATE utf8mb4_unicode_ci COMMENT 'SOAP: Evaluación/Assessment',
  `plan_tratamiento` text COLLATE utf8mb4_unicode_ci COMMENT 'SOAP: Plan',
  `notas_adicionales` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_evolucion`),
  KEY `idx_encamamiento` (`id_encamamiento`),
  KEY `idx_fecha` (`fecha_evolucion`),
  KEY `idx_doctor` (`id_doctor`),
  CONSTRAINT `evoluciones_medicas_ibfk_1` FOREIGN KEY (`id_encamamiento`) REFERENCES `encamamientos` (`id_encamamiento`) ON DELETE CASCADE,
  CONSTRAINT `evoluciones_medicas_ibfk_2` FOREIGN KEY (`id_doctor`) REFERENCES `usuarios` (`idUsuario`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `examenes_realizados`
-- --------------------------------------------------------
CREATE TABLE `examenes_realizados` (
  `id_examen_realizado` int DEFAULT NULL,
  `id_paciente` int NOT NULL,
  `nombre_paciente` varchar(255) NOT NULL,
  `tipo_examen` varchar(255) NOT NULL COMMENT 'Nombre del examen (ej. Electrocardiograma, Ultrasonido)',
  `cobro` decimal(10,2) NOT NULL,
  `fecha_examen` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(255) DEFAULT NULL,
  UNIQUE KEY `id_examen_realizado` (`id_examen_realizado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------
-- Estructura de tabla `habitaciones`
-- --------------------------------------------------------
CREATE TABLE `habitaciones` (
  `id_habitacion` int NOT NULL AUTO_INCREMENT,
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
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_habitacion`),
  UNIQUE KEY `numero_habitacion` (`numero_habitacion`),
  KEY `idx_estado` (`estado`),
  KEY `idx_tipo` (`tipo_habitacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `historial_clinico`
-- --------------------------------------------------------
CREATE TABLE `historial_clinico` (
  `id_historial` int NOT NULL AUTO_INCREMENT,
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
  `examen_fisico` text,
  PRIMARY KEY (`id_historial`),
  KEY `id_paciente` (`id_paciente`),
  CONSTRAINT `historial_clinico_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcado de datos para la tabla `historial_clinico`
INSERT INTO `historial_clinico` VALUES ('1','1','2026-01-11 01:56:32','Prueba','Prueba','Prueba','Prueba','Prueba','Prueba','Prueba','Prueba','Prueba','','2026-01-12','Doctor De Pruebas 2','Ingeniero en Sistemas','12:00:00','Prueba');


-- --------------------------------------------------------
-- Estructura de tabla `inventario`
-- --------------------------------------------------------
CREATE TABLE `inventario` (
  `id_inventario` int NOT NULL AUTO_INCREMENT,
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
  `precio_venta` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id_inventario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------
-- Estructura de tabla `orden_pruebas`
-- --------------------------------------------------------
CREATE TABLE `orden_pruebas` (
  `id_orden_prueba` int NOT NULL AUTO_INCREMENT,
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
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_orden_prueba`),
  KEY `procesado_por` (`procesado_por`),
  KEY `validado_por` (`validado_por`),
  KEY `idx_orden` (`id_orden`),
  KEY `idx_prueba` (`id_prueba`),
  KEY `idx_estado` (`estado`),
  CONSTRAINT `orden_pruebas_ibfk_1` FOREIGN KEY (`id_orden`) REFERENCES `ordenes_laboratorio` (`id_orden`) ON DELETE CASCADE,
  CONSTRAINT `orden_pruebas_ibfk_2` FOREIGN KEY (`id_prueba`) REFERENCES `catalogo_pruebas` (`id_prueba`) ON DELETE RESTRICT,
  CONSTRAINT `orden_pruebas_ibfk_3` FOREIGN KEY (`procesado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  CONSTRAINT `orden_pruebas_ibfk_4` FOREIGN KEY (`validado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `ordenes_laboratorio`
-- --------------------------------------------------------
CREATE TABLE `ordenes_laboratorio` (
  `id_orden` int NOT NULL AUTO_INCREMENT,
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
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_orden`),
  UNIQUE KEY `numero_orden` (`numero_orden`),
  KEY `id_doctor` (`id_doctor`),
  KEY `id_encamamiento` (`id_encamamiento`),
  KEY `creado_por` (`creado_por`),
  KEY `idx_numero_orden` (`numero_orden`),
  KEY `idx_paciente` (`id_paciente`),
  KEY `idx_estado` (`estado`),
  KEY `idx_fecha_orden` (`fecha_orden`),
  KEY `idx_prioridad` (`prioridad`),
  CONSTRAINT `ordenes_laboratorio_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `historial_clinico` (`id_paciente`) ON DELETE RESTRICT,
  CONSTRAINT `ordenes_laboratorio_ibfk_2` FOREIGN KEY (`id_doctor`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  CONSTRAINT `ordenes_laboratorio_ibfk_3` FOREIGN KEY (`id_encamamiento`) REFERENCES `encamamientos` (`id_encamamiento`) ON DELETE SET NULL,
  CONSTRAINT `ordenes_laboratorio_ibfk_4` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `pacientes`
-- --------------------------------------------------------
CREATE TABLE `pacientes` (
  `id_paciente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `genero` enum('Masculino','Femenino') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_paciente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcado de datos para la tabla `pacientes`
INSERT INTO `pacientes` VALUES ('1','Samuel','Ramirez','2000-08-25','Masculino','','','','2026-01-11 01:55:44');
INSERT INTO `pacientes` VALUES ('2','Héctor ','Pineda ','1982-04-23','Masculino','','','','2026-01-15 03:34:04');


-- --------------------------------------------------------
-- Estructura de tabla `parametros_pruebas`
-- --------------------------------------------------------
CREATE TABLE `parametros_pruebas` (
  `id_parametro` int NOT NULL AUTO_INCREMENT,
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
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_parametro`),
  KEY `idx_prueba` (`id_prueba`),
  KEY `idx_orden` (`orden_visualizacion`),
  CONSTRAINT `parametros_pruebas_ibfk_1` FOREIGN KEY (`id_prueba`) REFERENCES `catalogo_pruebas` (`id_prueba`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `procedimientos_menores`
-- --------------------------------------------------------
CREATE TABLE `procedimientos_menores` (
  `id_procedimiento` int DEFAULT NULL,
  `id_paciente` int NOT NULL,
  `nombre_paciente` varchar(255) NOT NULL,
  `procedimiento` varchar(255) NOT NULL COMMENT 'Nombre del procedimiento (ej. Sutura, Curación)',
  `cobro` decimal(10,2) NOT NULL,
  `fecha_procedimiento` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(255) DEFAULT NULL,
  UNIQUE KEY `id_procedimiento` (`id_procedimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcado de datos para la tabla `procedimientos_menores`
INSERT INTO `procedimientos_menores` VALUES ('','2','Héctor  Pineda ','Retiro de puntos','200.00','2026-01-14 21:34:00','Usuario');
INSERT INTO `procedimientos_menores` VALUES ('','1','Samuel Ramirez','Sutura de herida, Drenaje de absceso, Retiro de puntos, Lavado de oídos','1500.00','2026-01-14 21:35:00','Usuario');
INSERT INTO `procedimientos_menores` VALUES ('','1','Samuel Ramirez','Sutura de herida, Cauterización','150.00','2026-01-15 09:15:00','Samuel');
INSERT INTO `procedimientos_menores` VALUES ('','2','Héctor  Pineda ','Sutura de herida, Cauterización','200.00','2026-01-15 09:16:00','Samuel');
INSERT INTO `procedimientos_menores` VALUES ('','1','Samuel Ramirez','Sutura de herida, Curación de herida','150.00','2026-01-15 09:28:00','Samuel');


-- --------------------------------------------------------
-- Estructura de tabla `purchase_headers`
-- --------------------------------------------------------
CREATE TABLE `purchase_headers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `document_type` enum('Factura','Nota de Envío','Consumidor Final') NOT NULL,
  `document_number` varchar(50) DEFAULT NULL,
  `provider_name` varchar(100) DEFAULT NULL,
  `purchase_date` date NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('Pendiente','Completado') DEFAULT 'Pendiente',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `paid_amount` decimal(10,2) DEFAULT '0.00',
  `payment_status` enum('Pendiente','Parcial','Pagado') DEFAULT 'Pendiente',
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `purchase_headers_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- --------------------------------------------------------
-- Estructura de tabla `purchase_items`
-- --------------------------------------------------------
CREATE TABLE `purchase_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `purchase_header_id` int NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `presentation` varchar(100) DEFAULT NULL,
  `molecule` varchar(100) DEFAULT NULL,
  `pharmaceutical_house` varchar(100) DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_cost` decimal(10,2) NOT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `status` enum('Pendiente','Recibido') DEFAULT 'Pendiente',
  PRIMARY KEY (`id`),
  KEY `purchase_header_id` (`purchase_header_id`),
  CONSTRAINT `purchase_items_ibfk_1` FOREIGN KEY (`purchase_header_id`) REFERENCES `purchase_headers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- --------------------------------------------------------
-- Estructura de tabla `purchase_payments`
-- --------------------------------------------------------
CREATE TABLE `purchase_payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `purchase_header_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` date NOT NULL,
  `payment_method` varchar(50) DEFAULT 'Efectivo',
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `purchase_header_id` (`purchase_header_id`),
  CONSTRAINT `purchase_payments_ibfk_1` FOREIGN KEY (`purchase_header_id`) REFERENCES `purchase_headers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- --------------------------------------------------------
-- Estructura de tabla `reactivos_laboratorio`
-- --------------------------------------------------------
CREATE TABLE `reactivos_laboratorio` (
  `id_reactivo` int NOT NULL AUTO_INCREMENT,
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
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_reactivo`),
  UNIQUE KEY `codigo_reactivo` (`codigo_reactivo`),
  KEY `ingresado_por` (`ingresado_por`),
  KEY `idx_codigo` (`codigo_reactivo`),
  KEY `idx_estado` (`estado`),
  KEY `idx_vencimiento` (`fecha_vencimiento`),
  CONSTRAINT `reactivos_laboratorio_ibfk_1` FOREIGN KEY (`ingresado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `reportes_estadisticas`
-- --------------------------------------------------------
CREATE TABLE `reportes_estadisticas` (
  `id_reporte` int NOT NULL AUTO_INCREMENT,
  `tipo_reporte` varchar(50) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `datos` json NOT NULL,
  `fecha_generacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_generacion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_reporte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------
-- Estructura de tabla `reservas_inventario`
-- --------------------------------------------------------
CREATE TABLE `reservas_inventario` (
  `id_reserva` int NOT NULL AUTO_INCREMENT,
  `id_inventario` int NOT NULL,
  `cantidad` int NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `fecha_reserva` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_reserva`),
  KEY `id_inventario` (`id_inventario`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- --------------------------------------------------------
-- Estructura de tabla `resultados_laboratorio`
-- --------------------------------------------------------
CREATE TABLE `resultados_laboratorio` (
  `id_resultado` int NOT NULL AUTO_INCREMENT,
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
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_resultado`),
  KEY `procesado_por` (`procesado_por`),
  KEY `validado_por` (`validado_por`),
  KEY `idx_orden_prueba` (`id_orden_prueba`),
  KEY `idx_parametro` (`id_parametro`),
  KEY `idx_validado` (`validado`),
  KEY `idx_fuera_rango` (`fuera_rango`),
  CONSTRAINT `resultados_laboratorio_ibfk_1` FOREIGN KEY (`id_orden_prueba`) REFERENCES `orden_pruebas` (`id_orden_prueba`) ON DELETE CASCADE,
  CONSTRAINT `resultados_laboratorio_ibfk_2` FOREIGN KEY (`id_parametro`) REFERENCES `parametros_pruebas` (`id_parametro`) ON DELETE RESTRICT,
  CONSTRAINT `resultados_laboratorio_ibfk_3` FOREIGN KEY (`procesado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL,
  CONSTRAINT `resultados_laboratorio_ibfk_4` FOREIGN KEY (`validado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `signos_vitales`
-- --------------------------------------------------------
CREATE TABLE `signos_vitales` (
  `id_signo` int NOT NULL AUTO_INCREMENT,
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
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_signo`),
  KEY `registrado_por` (`registrado_por`),
  KEY `idx_encamamiento` (`id_encamamiento`),
  KEY `idx_fecha` (`fecha_registro`),
  CONSTRAINT `signos_vitales_ibfk_1` FOREIGN KEY (`id_encamamiento`) REFERENCES `encamamientos` (`id_encamamiento`) ON DELETE CASCADE,
  CONSTRAINT `signos_vitales_ibfk_2` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`idUsuario`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Estructura de tabla `usuarios`
-- --------------------------------------------------------
CREATE TABLE `usuarios` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(255) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `especialidad` varchar(255) DEFAULT NULL,
  `tipoUsuario` enum('admin','doc','user','') NOT NULL,
  `clinica` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `permisos_modulos` text,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `usuario` (`usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Volcado de datos para la tabla `usuarios`
INSERT INTO `usuarios` VALUES ('1','admin','admin','Samuel','Ramirez','Ingeniero en Sistemas','admin','Pruebas','49617032','samuel.ramirez25prs@gmail.com','{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}');
INSERT INTO `usuarios` VALUES ('2','janya','password','Usuario','Administrador','Ingreso de Medicamentos','admin','Pruebas','46232418','na','{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": false, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}');
INSERT INTO `usuarios` VALUES ('3','enrique','password','Usuario','Administrador','Ingreso de Medicamentos','admin','Pruebas','46232418','correo@example.com','{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": true, \"inventory\": false, \"billing\": false, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": false}');
INSERT INTO `usuarios` VALUES ('4','jeim','password','Usuario','Administrador','Ingreso de Medicamentos','admin','Pruebas','46232418','example@gmail.com','{\"hospitalization\": true, \"laboratory\": false, \"hospitalization_admin\": false, \"laboratory_admin\": false, \"view_all_patients\": false, \"inventory\": false, \"billing\": false, \"reports\": false, \"appointments\": true, \"patients\": true, \"medications\": false, \"settings\": false}');
INSERT INTO `usuarios` VALUES ('5','servicio','password','Usuario','De Servicio','Usuario de Servicio','user','Pruebas','46232418','','{\"hospitalization\": true, \"laboratory\": true, \"hospitalization_admin\": true, \"laboratory_admin\": true, \"view_all_patients\": true, \"inventory\": true, \"billing\": true, \"reports\": true, \"appointments\": true, \"patients\": true, \"medications\": true, \"settings\": true}');


-- --------------------------------------------------------
-- Estructura de tabla `ventas`
-- --------------------------------------------------------
CREATE TABLE `ventas` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `fecha_venta` datetime DEFAULT CURRENT_TIMESTAMP,
  `nombre_cliente` varchar(100) DEFAULT NULL,
  `tipo_pago` enum('Efectivo','Tarjeta','Seguro Médico') DEFAULT NULL,
  `total` decimal(10,2) DEFAULT '0.00',
  `estado` enum('Pendiente','Pagado','Cancelado') DEFAULT NULL,
  PRIMARY KEY (`id_venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

