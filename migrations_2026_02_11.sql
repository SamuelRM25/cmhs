-- Migración: Cambios en el sistema de inventario y cobros
-- 1. Agregar precio de noche para medicamentos de hospital
ALTER TABLE `inventario` ADD COLUMN `precio_noche` decimal(10,2) DEFAULT '0.00' AFTER `stock_hospital`;

-- 2. Agregar tipo de pago a electrocardiogramas
ALTER TABLE `electrocardiogramas` ADD COLUMN `tipo_pago` varchar(50) DEFAULT 'Efectivo' AFTER `estado_pago`;
