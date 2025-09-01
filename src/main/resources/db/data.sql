-- Script de chargement des données pour Proxi-IA Commerce
-- Ce script insère des données de test dans la base de données

-- Nettoyage des tables existantes (dans l'ordre inverse des dépendances)
DELETE FROM sales;
DELETE FROM inventory;
DELETE FROM purchase_orders;
DELETE FROM products;
DELETE FROM suppliers;

-- Réinitialisation des séquences
ALTER SEQUENCE products_id_seq RESTART WITH 1;
ALTER SEQUENCE suppliers_id_seq RESTART WITH 1;
ALTER SEQUENCE inventory_id_seq RESTART WITH 1;
ALTER SEQUENCE sales_id_seq RESTART WITH 1;
ALTER SEQUENCE purchase_orders_id_seq RESTART WITH 1;

-- Insertion des fournisseurs
INSERT INTO suppliers (name, email, phone, address, category, rating, created_at, updated_at) VALUES
('Apple Inc.', 'contact@apple.com', '+1-800-275-2273', '1 Apple Park Way, Cupertino, CA 95014', 'Electronics', 4.8, NOW(), NOW()),
('Samsung Electronics', 'info@samsung.com', '+82-2-2255-0114', '129 Samsung-ro, Yeongtong-gu, Suwon-si, Gyeonggi-do', 'Electronics', 4.6, NOW(), NOW()),
('Microsoft Corporation', 'support@microsoft.com', '+1-425-882-8080', 'One Microsoft Way, Redmond, WA 98052', 'Software', 4.7, NOW(), NOW()),
('Dell Technologies', 'sales@dell.com', '+1-800-999-3355', 'One Dell Way, Round Rock, TX 78682', 'Computers', 4.5, NOW(), NOW()),
('HP Inc.', 'info@hp.com', '+1-650-857-1501', '1501 Page Mill Road, Palo Alto, CA 94304', 'Computers', 4.4, NOW(), NOW()),
('Lenovo Group', 'contact@lenovo.com', '+86-10-5888-8888', '6 Chuangye Road, Haidian District, Beijing', 'Computers', 4.3, NOW(), NOW()),
('ASUS', 'support@asus.com', '+886-2-2894-3447', '4F, No. 150, Li-Te Road, Peitou, Taipei', 'Electronics', 4.2, NOW(), NOW()),
('Logitech', 'info@logitech.com', '+41-41-375-03-03', 'EPFL - Quartier de l\'Innovation, Daniel Borel Innovation Center', 'Accessories', 4.1, NOW(), NOW()),
('Canon Inc.', 'contact@canon.com', '+81-3-5482-1111', '30-2, Shimomaruko 3-chome, Ohta-ku, Tokyo', 'Imaging', 4.0, NOW(), NOW()),
('Sony Corporation', 'info@sony.com', '+81-3-6748-2111', '1-7-1 Konan, Minato-ku, Tokyo', 'Electronics', 4.5, NOW(), NOW());

-- Insertion des produits
INSERT INTO products (name, description, price, category, brand, sku, created_at, updated_at) VALUES
('iPhone 15 Pro', 'Smartphone Apple avec puce A17 Pro, appareil photo 48MP, écran 6.1" Super Retina XDR', 1199.99, 'Smartphones', 'Apple', 'IPH15PRO-128', NOW(), NOW()),
('iPhone 15 Pro Max', 'Smartphone Apple premium avec puce A17 Pro, appareil photo 48MP, écran 6.7" Super Retina XDR', 1399.99, 'Smartphones', 'Apple', 'IPH15PROMAX-256', NOW(), NOW()),
('Samsung Galaxy S24 Ultra', 'Smartphone Samsung avec S Pen intégré, appareil photo 200MP, écran 6.8" Dynamic AMOLED 2X', 1299.99, 'Smartphones', 'Samsung', 'SGS24ULTRA-512', NOW(), NOW()),
('MacBook Pro 14" M3', 'Ordinateur portable Apple avec puce M3, 14" Liquid Retina XDR, jusqu\'à 22h d\'autonomie', 1999.99, 'Ordinateurs', 'Apple', 'MBP14-M3-512', NOW(), NOW()),
('MacBook Pro 16" M3 Pro', 'Ordinateur portable Apple professionnel avec puce M3 Pro, 16" Liquid Retina XDR', 2499.99, 'Ordinateurs', 'Apple', 'MBP16-M3PRO-1TB', NOW(), NOW()),
('Dell XPS 13 Plus', 'Ordinateur portable Dell ultra-fin avec processeur Intel 13e génération, écran 13.4" 4K', 1499.99, 'Ordinateurs', 'Dell', 'XPS13PLUS-512', NOW(), NOW()),
('HP Spectre x360', 'Ordinateur portable convertible HP avec processeur Intel, écran 13.5" 3K2K OLED', 1299.99, 'Ordinateurs', 'HP', 'SPECTRE-X360-512', NOW(), NOW()),
('iPad Pro 12.9" M2', 'Tablette Apple professionnelle avec puce M2, écran 12.9" Liquid Retina XDR, support Apple Pencil', 1099.99, 'Tablettes', 'Apple', 'IPADPRO12-M2-256', NOW(), NOW()),
('Samsung Galaxy Tab S9 Ultra', 'Tablette Android Samsung avec processeur Snapdragon 8 Gen 2, écran 14.6" AMOLED', 999.99, 'Tablettes', 'Samsung', 'SGTAB9ULTRA-256', NOW(), NOW()),
('AirPods Pro 2', 'Écouteurs sans fil Apple avec réduction de bruit active, audio spatial, résistance à l\'eau', 249.99, 'Accessoires', 'Apple', 'AIRPODSPRO2', NOW(), NOW()),
('Samsung Galaxy Watch 6', 'Montre connectée Samsung avec écran AMOLED 1.5", suivi santé avancé, résistance à l\'eau', 349.99, 'Accessoires', 'Samsung', 'SGWATCH6-44MM', NOW(), NOW()),
('Microsoft Surface Pro 9', 'Tablette hybride Microsoft avec processeur Intel 12e génération, clavier détachable', 1099.99, 'Ordinateurs', 'Microsoft', 'SURFACEPRO9-256', NOW(), NOW()),
('Canon EOS R6 Mark II', 'Appareil photo hybride Canon avec capteur 24.2MP, vidéo 4K 60p, stabilisation 5 axes', 2499.99, 'Imaging', 'Canon', 'EOSR6MKII', NOW(), NOW()),
('Sony WH-1000XM5', 'Casque sans fil Sony avec réduction de bruit active, audio haute résolution, 30h d\'autonomie', 399.99, 'Accessoires', 'Sony', 'WH1000XM5', NOW(), NOW()),
('Logitech MX Master 3S', 'Souris sans fil Logitech avec capteur 8000 DPI, défilement MagSpeed, 70 jours d\'autonomie', 99.99, 'Accessoires', 'Logitech', 'MXMASTER3S', NOW(), NOW());

-- Insertion de l'inventaire
INSERT INTO inventory (product_id, quantity, min_quantity, location, last_updated, created_at, updated_at) VALUES
(1, 45, 10, 'Entrepôt A - Zone 1', NOW(), NOW(), NOW()),
(2, 32, 8, 'Entrepôt A - Zone 1', NOW(), NOW(), NOW()),
(3, 28, 12, 'Entrepôt A - Zone 2', NOW(), NOW(), NOW()),
(4, 18, 5, 'Entrepôt B - Zone 1', NOW(), NOW(), NOW()),
(5, 12, 3, 'Entrepôt B - Zone 1', NOW(), NOW(), NOW()),
(6, 25, 8, 'Entrepôt B - Zone 2', NOW(), NOW(), NOW()),
(7, 22, 6, 'Entrepôt B - Zone 2', NOW(), NOW(), NOW()),
(8, 35, 10, 'Entrepôt C - Zone 1', NOW(), NOW(), NOW()),
(9, 19, 7, 'Entrepôt C - Zone 1', NOW(), NOW(), NOW()),
(10, 67, 15, 'Entrepôt C - Zone 2', NOW(), NOW(), NOW()),
(11, 41, 12, 'Entrepôt C - Zone 2', NOW(), NOW(), NOW()),
(12, 15, 4, 'Entrepôt B - Zone 3', NOW(), NOW(), NOW()),
(13, 8, 2, 'Entrepôt A - Zone 3', NOW(), NOW(), NOW()),
(14, 23, 6, 'Entrepôt C - Zone 3', NOW(), NOW(), NOW()),
(15, 31, 8, 'Entrepôt A - Zone 4', NOW(), NOW(), NOW());

-- Insertion des ventes
INSERT INTO sales (product_id, customer_name, quantity, unit_price, total_amount, date, status, created_at, updated_at) VALUES
(1, 'Jean Dupont', 1, 1199.99, 1199.99, NOW() - INTERVAL '2 days', 'completed', NOW(), NOW()),
(2, 'Marie Martin', 1, 1399.99, 1399.99, NOW() - INTERVAL '3 days', 'completed', NOW(), NOW()),
(3, 'Pierre Durand', 1, 1299.99, 1299.99, NOW() - INTERVAL '1 day', 'completed', NOW(), NOW()),
(4, 'Sophie Bernard', 1, 1999.99, 1999.99, NOW() - INTERVAL '4 days', 'completed', NOW(), NOW()),
(5, 'Lucas Petit', 1, 2499.99, 2499.99, NOW() - INTERVAL '5 days', 'completed', NOW(), NOW()),
(6, 'Emma Roux', 1, 1499.99, 1499.99, NOW() - INTERVAL '6 days', 'completed', NOW(), NOW()),
(7, 'Hugo Moreau', 1, 1299.99, 1299.99, NOW() - INTERVAL '7 days', 'completed', NOW(), NOW()),
(8, 'Léa Simon', 1, 1099.99, 1099.99, NOW() - INTERVAL '8 days', 'completed', NOW(), NOW()),
(9, 'Jules Michel', 1, 999.99, 999.99, NOW() - INTERVAL '9 days', 'completed', NOW(), NOW()),
(10, 'Chloé Garcia', 1, 249.99, 249.99, NOW() - INTERVAL '10 days', 'completed', NOW(), NOW()),
(11, 'Adam Rodriguez', 1, 349.99, 349.99, NOW() - INTERVAL '11 days', 'completed', NOW(), NOW()),
(12, 'Eva Lopez', 1, 1099.99, 1099.99, NOW() - INTERVAL '12 days', 'completed', NOW(), NOW()),
(13, 'Noah Gonzalez', 1, 2499.99, 2499.99, NOW() - INTERVAL '13 days', 'completed', NOW(), NOW()),
(14, 'Mia Wilson', 1, 399.99, 399.99, NOW() - INTERVAL '14 days', 'completed', NOW(), NOW()),
(15, 'Liam Anderson', 1, 99.99, 99.99, NOW() - INTERVAL '15 days', 'completed', NOW(), NOW()),
(1, 'Sarah Taylor', 1, 1199.99, 1199.99, NOW() - INTERVAL '16 days', 'completed', NOW(), NOW()),
(2, 'David Brown', 1, 1399.99, 1399.99, NOW() - INTERVAL '17 days', 'completed', NOW(), NOW()),
(3, 'Lisa Davis', 1, 1299.99, 1299.99, NOW() - INTERVAL '18 days', 'completed', NOW(), NOW()),
(4, 'Michael Miller', 1, 1999.99, 1999.99, NOW() - INTERVAL '19 days', 'completed', NOW(), NOW()),
(5, 'Jennifer Wilson', 1, 2499.99, 2499.99, NOW() - INTERVAL '20 days', 'completed', NOW(), NOW());

-- Insertion des commandes d'achat
INSERT INTO purchase_orders (supplier_id, supplier_name, product_name, quantity, unit_price, total_amount, date, expected_delivery, status, created_at, updated_at) VALUES
(1, 'Apple Inc.', 'iPhone 15 Pro', 50, 1000.00, 50000.00, NOW() - INTERVAL '5 days', NOW() + INTERVAL '10 days', 'confirmed', NOW(), NOW()),
(2, 'Samsung Electronics', 'Galaxy S24 Ultra', 40, 1100.00, 44000.00, NOW() - INTERVAL '6 days', NOW() + INTERVAL '12 days', 'confirmed', NOW(), NOW()),
(3, 'Microsoft Corporation', 'Surface Pro 9', 25, 900.00, 22500.00, NOW() - INTERVAL '7 days', NOW() + INTERVAL '15 days', 'shipped', NOW(), NOW()),
(4, 'Dell Technologies', 'XPS 13 Plus', 30, 1200.00, 36000.00, NOW() - INTERVAL '8 days', NOW() + INTERVAL '18 days', 'sent', NOW(), NOW()),
(5, 'HP Inc.', 'Spectre x360', 35, 1000.00, 35000.00, NOW() - INTERVAL '9 days', NOW() + INTERVAL '20 days', 'draft', NOW(), NOW()),
(6, 'Lenovo Group', 'ThinkPad X1 Carbon', 20, 1300.00, 26000.00, NOW() - INTERVAL '10 days', NOW() + INTERVAL '22 days', 'draft', NOW(), NOW()),
(7, 'ASUS', 'ROG Zephyrus', 15, 1500.00, 22500.00, NOW() - INTERVAL '11 days', NOW() + INTERVAL '25 days', 'draft', NOW(), NOW()),
(8, 'Logitech', 'MX Master 3S', 100, 70.00, 7000.00, NOW() - INTERVAL '12 days', NOW() + INTERVAL '28 days', 'draft', NOW(), NOW()),
(9, 'Canon Inc.', 'EOS R6 Mark II', 12, 2000.00, 24000.00, NOW() - INTERVAL '13 days', NOW() + INTERVAL '30 days', 'draft', NOW(), NOW()),
(10, 'Sony Corporation', 'WH-1000XM5', 80, 300.00, 24000.00, NOW() - INTERVAL '14 days', NOW() + INTERVAL '32 days', 'draft', NOW(), NOW());

-- Mise à jour des timestamps
UPDATE products SET created_at = NOW(), updated_at = NOW();
UPDATE suppliers SET created_at = NOW(), updated_at = NOW();
UPDATE inventory SET created_at = NOW(), updated_at = NOW();
UPDATE sales SET created_at = NOW(), updated_at = NOW();
UPDATE purchase_orders SET created_at = NOW(), updated_at = NOW();

-- Affichage des statistiques
SELECT 'Données chargées avec succès!' as message;
SELECT 'Produits:' as category, COUNT(*) as count FROM products
UNION ALL
SELECT 'Fournisseurs:' as category, COUNT(*) as count FROM suppliers
UNION ALL
SELECT 'Inventaire:' as category, COUNT(*) as count FROM inventory
UNION ALL
SELECT 'Ventes:' as category, COUNT(*) as count FROM sales
UNION ALL
SELECT 'Commandes:' as category, COUNT(*) as count FROM purchase_orders;
