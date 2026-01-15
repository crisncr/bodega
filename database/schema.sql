-- Script de Creación de Tablas para el Sistema de Compra JDE

-- 1. Tabla de Requisiciones (Encabezado)
CREATE TABLE IF NOT EXISTS purchases (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    document_number SERIAL,
    total_items INTEGER DEFAULT 0,
    status TEXT DEFAULT 'pending', -- 'pending', 'processed', 'cancelled'
    descripcion TEXT, -- Motivo de la compra
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Tabla de Items de la Requisición (Detalle)
CREATE TABLE IF NOT EXISTS purchase_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    purchase_id UUID REFERENCES purchases(id) ON DELETE CASCADE,
    item_id NUMERIC NOT NULL, -- Short Item Number (ITM)
    litm TEXT NOT NULL,       -- Second Item Number (LITM / COLITM)
    dsci TEXT,               -- Descripción del producto
    cantidad INTEGER NOT NULL,
    procesada BOOLEAN DEFAULT false, -- Indica si ya se ejecutó la lógica de stock en JDE
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    stock_jde_inicial NUMERIC -- Stock PQOH total al momento de la solicitud
);

-- Notas para TI:
-- - Si usan Supabase local, estas tablas deben crearse en el esquema 'public'.
-- - Si usan una base de datos PostgreSQL estándar, asegúrense de tener activada la extensión 'pgcrypto' para gen_random_uuid().
--   Comando: CREATE EXTENSION IF NOT EXISTS "pgcrypto";
