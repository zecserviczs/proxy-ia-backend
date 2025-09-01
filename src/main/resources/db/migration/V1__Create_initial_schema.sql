-- Migration Flyway V1: Création du schéma initial
-- Création des tables pour Proxi-IA Commerce

-- Table des fournisseurs
CREATE TABLE IF NOT EXISTS suppliers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    contact_person VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    address TEXT,
    city VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    website VARCHAR(255),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Table des produits
CREATE TABLE IF NOT EXISTS products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sku VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    brand VARCHAR(100),
    category_id VARCHAR(100),
    price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    tax_rate DECIMAL(5,2),
    status VARCHAR(50),
    image_url TEXT,
    barcode VARCHAR(100),
    unit VARCHAR(50),
    weight DECIMAL(8,3),
    weight_unit VARCHAR(20),
    dimensions VARCHAR(100),
    supplier_id UUID REFERENCES suppliers(id),
    supplier_sku VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    tags TEXT,
    attributes TEXT,
    popularity_score DECIMAL(3,2),
    margin_target DECIMAL(5,2),
    pricing_strategy VARCHAR(100),
    discontinued BOOLEAN DEFAULT FALSE,
    active BOOLEAN DEFAULT TRUE
);

-- Table de l'inventaire
CREATE TABLE IF NOT EXISTS inventory (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    sku VARCHAR(100) NOT NULL,
    quantity INTEGER NOT NULL,
    reserved_quantity INTEGER NOT NULL,
    available_quantity INTEGER NOT NULL,
    reorder_point INTEGER NOT NULL,
    max_stock INTEGER NOT NULL,
    location VARCHAR(255),
    warehouse_code VARCHAR(100),
    last_updated TIMESTAMP,
    last_stock_take TIMESTAMP,
    expiry_date TIMESTAMP,
    unit_cost DECIMAL(10,2),
    total_value DECIMAL(10,2),
    status VARCHAR(50),
    notes TEXT
);

-- Table des ventes
CREATE TABLE IF NOT EXISTS sales (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE SET NULL,
    sku VARCHAR(100) NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    tax_rate DECIMAL(5,2),
    tax_amount DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    customer_id VARCHAR(100),
    order_id VARCHAR(100),
    sale_date TIMESTAMP,
    payment_method VARCHAR(100),
    status VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

-- Table des commandes d'achat
CREATE TABLE IF NOT EXISTS purchase_orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    supplier_id UUID REFERENCES suppliers(id) ON DELETE SET NULL,
    supplier_name VARCHAR(255),
    product_name VARCHAR(255),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expected_delivery TIMESTAMP,
    status VARCHAR(50) DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index pour améliorer les performances (seulement ceux qui correspondent aux colonnes existantes)
CREATE INDEX IF NOT EXISTS idx_products_category_id ON products(category_id);
CREATE INDEX IF NOT EXISTS idx_products_brand ON products(brand);
CREATE INDEX IF NOT EXISTS idx_products_sku ON products(sku);
CREATE INDEX IF NOT EXISTS idx_products_status ON products(status);
CREATE INDEX IF NOT EXISTS idx_products_active ON products(active);
CREATE INDEX IF NOT EXISTS idx_products_supplier_id ON products(supplier_id);
CREATE INDEX IF NOT EXISTS idx_inventory_product_id ON inventory(product_id);
CREATE INDEX IF NOT EXISTS idx_inventory_sku ON inventory(sku);
CREATE INDEX IF NOT EXISTS idx_inventory_quantity ON inventory(quantity);
CREATE INDEX IF NOT EXISTS idx_inventory_status ON inventory(status);
CREATE INDEX IF NOT EXISTS idx_sales_product_id ON sales(product_id);
CREATE INDEX IF NOT EXISTS idx_sales_sku ON sales(sku);
CREATE INDEX IF NOT EXISTS idx_sales_status ON sales(status);
CREATE INDEX IF NOT EXISTS idx_sales_sale_date ON sales(sale_date);
CREATE INDEX IF NOT EXISTS idx_purchase_orders_supplier_id ON purchase_orders(supplier_id);
CREATE INDEX IF NOT EXISTS idx_purchase_orders_status ON purchase_orders(status);
CREATE INDEX IF NOT EXISTS idx_suppliers_status ON suppliers(status);

-- Contraintes de validation
ALTER TABLE products ADD CONSTRAINT chk_price_positive CHECK (price > 0 OR price IS NULL);
ALTER TABLE inventory ADD CONSTRAINT chk_quantity_non_negative CHECK (quantity >= 0);
ALTER TABLE inventory ADD CONSTRAINT chk_reserved_quantity_non_negative CHECK (reserved_quantity >= 0);
ALTER TABLE inventory ADD CONSTRAINT chk_available_quantity_non_negative CHECK (available_quantity >= 0);
ALTER TABLE sales ADD CONSTRAINT chk_sales_quantity_positive CHECK (quantity > 0);
ALTER TABLE sales ADD CONSTRAINT chk_sales_unit_price_positive CHECK (unit_price > 0);
ALTER TABLE sales ADD CONSTRAINT chk_sales_total_amount_positive CHECK (total_amount > 0);
ALTER TABLE purchase_orders ADD CONSTRAINT chk_po_quantity_positive CHECK (quantity > 0);
ALTER TABLE purchase_orders ADD CONSTRAINT chk_po_unit_price_positive CHECK (unit_price > 0);
ALTER TABLE purchase_orders ADD CONSTRAINT chk_po_total_amount_positive CHECK (total_amount > 0);

-- Fonction pour mettre à jour automatiquement updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers pour mettre à jour automatiquement updated_at
CREATE TRIGGER update_suppliers_updated_at BEFORE UPDATE ON suppliers
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON products
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_sales_updated_at BEFORE UPDATE ON sales
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_purchase_orders_updated_at BEFORE UPDATE ON purchase_orders
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Vues utiles pour les rapports
CREATE OR REPLACE VIEW product_inventory_summary AS
SELECT 
    p.id,
    p.name,
    p.category_id,
    p.brand,
    p.price,
    COALESCE(i.quantity, 0) as stock_quantity,
    i.reorder_point,
    i.location,
    CASE 
        WHEN COALESCE(i.quantity, 0) = 0 THEN 'Rupture'
        WHEN COALESCE(i.quantity, 0) <= i.reorder_point THEN 'Stock faible'
        ELSE 'En stock'
    END as stock_status
FROM products p
LEFT JOIN inventory i ON p.id = i.product_id;

CREATE OR REPLACE VIEW sales_summary AS
SELECT 
    DATE_TRUNC('month', s.sale_date) as month,
    COUNT(*) as total_sales,
    SUM(s.total_amount) as total_revenue,
    AVG(s.total_amount) as average_order_value
FROM sales s
WHERE s.status = 'completed'
GROUP BY DATE_TRUNC('month', s.sale_date)
ORDER BY month DESC;

CREATE OR REPLACE VIEW low_stock_products AS
SELECT 
    p.name,
    p.category_id,
    p.brand,
    i.quantity,
    i.reorder_point,
    i.location
FROM products p
JOIN inventory i ON p.id = i.product_id
WHERE i.quantity <= i.reorder_point
ORDER BY i.quantity ASC;

-- Commentaires sur les tables
COMMENT ON TABLE suppliers IS 'Table des fournisseurs de produits';
COMMENT ON TABLE products IS 'Table des produits du catalogue';
COMMENT ON TABLE inventory IS 'Table de gestion des stocks';
COMMENT ON TABLE sales IS 'Table des ventes réalisées';
COMMENT ON TABLE purchase_orders IS 'Table des commandes d''achat auprès des fournisseurs';

COMMENT ON COLUMN products.sku IS 'Code produit unique (Stock Keeping Unit)';
COMMENT ON COLUMN products.category_id IS 'Identifiant de la catégorie du produit';
COMMENT ON COLUMN inventory.reorder_point IS 'Quantité minimale avant alerte de réapprovisionnement';
COMMENT ON COLUMN sales.status IS 'Statut de la vente: pending, completed, cancelled';
COMMENT ON COLUMN purchase_orders.status IS 'Statut de la commande: draft, sent, confirmed, shipped, received';
