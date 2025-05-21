-- Script généré par WINDEV Suite SaaS le 02/05/2025 15:31:25
-- Tables de l'analyse gestion_magasin_v3.wda
-- pour MySQL

-- Création de la table customers
CREATE TABLE `customers` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `person_id` BIGINT NOT NULL DEFAULT 0,
    `company_name` NVARCHAR(191),
    `account_number` NVARCHAR(191),
    `points` INTEGERDEFAULT 0,
    `date` TIMESTAMP NOT NULL DEFAULT {ts '0000-01-01 00:00:00.000'},
    `user_id` BIGINT NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP);
CREATE INDEX `WDIDX_customers_person_id` ON `customers` (`person_id`);
CREATE INDEX `WDIDX_customers_user_id` ON `customers` (`user_id`);

-- Création de la table inventories
CREATE TABLE `inventories` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `trans_items` BIGINT,
    `trans_location` BIGINT,
    `trans_user_id` BIGINT,
    `trans_date` TIMESTAMP,
    `comment` NVARCHAR(191),
    `created_at` TIMESTAMP);
CREATE INDEX `WDIDX_inventories_trans_items` ON `inventories` (`trans_items`);
CREATE INDEX `WDIDX_inventories_trans_location` ON `inventories` (`trans_location`);
CREATE INDEX `WDIDX_inventories_trans_user_id` ON `inventories` (`trans_user_id`);

-- Création de la table item_kits
CREATE TABLE `item_kits` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `item_kit_number` NVARCHAR(191),
    `name` NVARCHAR(191) NOT NULL,
    `kit_discount` NUMERIC(15,2) NOT NULL DEFAULT 0,
    `kit_discount_type` NVARCHAR(191) NOT NULL,
    `price_option` NVARCHAR(191) NOT NULL,
    `print_option` NVARCHAR(191) NOT NULL,
    `description` NVARCHAR(191),
    `created_at` TIMESTAMP);

-- Création de la table item_quantities
CREATE TABLE `item_quantities` (
    `item_id` BIGINT NOT NULL DEFAULT 0,
    `location_id` BIGINT NOT NULL DEFAULT 0,
    `quantity` NUMERIC(15,3) NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP,
    `updated_at` TIMESTAMP);
CREATE INDEX `WDIDX_item_quantities_item_id` ON `item_quantities` (`item_id`);
CREATE INDEX `WDIDX_item_quantities_location_id` ON `item_quantities` (`location_id`);
CREATE UNIQUE INDEX `WDIDX_item_quantities_PRIMARY` ON `item_quantities` (`item_id`,`location_id`);

-- Création de la table items
CREATE TABLE `items` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `item_number` NVARCHAR(191) NOT NULL,
    `name` NVARCHAR(191) NOT NULL,
    `category` NVARCHAR(191) NOT NULL,
    `item_type` TINYINT NOT NULL DEFAULT 0,
    `cost_price` NUMERIC(15,2) NOT NULL DEFAULT 0,
    `unit_price` NUMERIC(15,2) NOT NULL DEFAULT 0,
    `description` LONGTEXT CHARACTER SET ucs2,
    `pictures` LONGBLOB,
    `stock_type` NVARCHAR(191) NOT NULL DEFAULT 'inventaire',
    `created_at` TIMESTAMP);

-- Création de la table payment_type
CREATE TABLE `payment_type` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `payment_type` NVARCHAR(191) NOT NULL,
    `payment_amount` NUMERIC(24,6) NOT NULL DEFAULT 0,
    `receivings_id` BIGINT NOT NULL DEFAULT 0,
    `date_cheque` DATE,
    `created_at` TIMESTAMP);
CREATE INDEX `WDIDX_payment_type_receivings_id` ON `payment_type` (`receivings_id`);

-- Création de la table people
CREATE TABLE `people` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `first_name` NVARCHAR(191) NOT NULL,
    `last_name` NVARCHAR(191) NOT NULL,
    `gender` NVARCHAR(191) NOT NULL,
    `phone_number` NVARCHAR(191) NOT NULL,
    `email` NVARCHAR(191) NOT NULL UNIQUE,
    `address_1` NVARCHAR(191),
    `city` NVARCHAR(191),
    `country` NVARCHAR(191),
    `created_at` TIMESTAMP);

-- Création de la table permissions
CREATE TABLE `permissions` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` NVARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP);

-- Création de la table receivings
CREATE TABLE `receivings` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `receiving_time` TIMESTAMP NOT NULL DEFAULT {ts '2024-06-24 14:46:00.000'},
    `supplier_id` BIGINT,
    `user_id` BIGINT NOT NULL DEFAULT 0,
    `comment` LONGTEXT CHARACTER SET ucs2,
    `reference` NVARCHAR(32),
    `receiving_type` NVARCHAR(191),
    `stock_source` INTEGER,
    `stock_destination` INTEGER,
    `receivingPayment_status` LONGTEXT CHARACTER SET ucs2 NOT NULL,
    `created_at` TIMESTAMP);
CREATE INDEX `WDIDX_receivings_supplier_id` ON `receivings` (`supplier_id`);
CREATE INDEX `WDIDX_receivings_user_id` ON `receivings` (`user_id`);

-- Création de la table receivings_items
CREATE TABLE `receivings_items` (
    `receiving_id` BIGINT NOT NULL DEFAULT 0,
    `item_id` BIGINT NOT NULL DEFAULT 0,
    `description` NVARCHAR(191),
    `serialnumber` NVARCHAR(191),
    `quantity_purchased` NUMERIC(15,3) NOT NULL DEFAULT 0,
    `item_cost_price` NUMERIC(15,2),
    `item_unit_price` NUMERIC(15,2),
    `item_location` BIGINT NOT NULL DEFAULT 0,
    `receiving_quantity` NUMERIC(15,3) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP);
CREATE INDEX `WDIDX_receivings_items_receiving_id` ON `receivings_items` (`receiving_id`);
CREATE INDEX `WDIDX_receivings_items_item_id` ON `receivings_items` (`item_id`);
CREATE INDEX `WDIDX_receivings_items_item_location` ON `receivings_items` (`item_location`);
CREATE UNIQUE INDEX `WDIDX_receivings_items_PRIMARY` ON `receivings_items` (`receiving_id`,`item_id`);

-- Création de la table role_has_permissions
CREATE TABLE `role_has_permissions` (
    `permission_id` BIGINT NOT NULL DEFAULT 0,
    `role_id` BIGINT NOT NULL DEFAULT 0);
CREATE INDEX `WDIDX_role_has_permissions_permission_id` ON `role_has_permissions` (`permission_id`);
CREATE INDEX `WDIDX_role_has_permissions_role_id` ON `role_has_permissions` (`role_id`);
CREATE UNIQUE INDEX `WDIDX_role_has_permissions_PRIMARY` ON `role_has_permissions` (`permission_id`,`role_id`);

-- Création de la table roles
CREATE TABLE `roles` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` NVARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP);

-- Création de la table sales
CREATE TABLE `sales` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `sale_time` TIMESTAMP NOT NULL DEFAULT {ts '0000-01-01 00:00:00.000'},
    `customer_id` BIGINT NOT NULL DEFAULT 0,
    `comment` LONGTEXT CHARACTER SET ucs2,
    `invoice_number` NVARCHAR(191) NOT NULL,
    `sale_status` TINYINT NOT NULL DEFAULT 0,
    `location_id` BIGINT NOT NULL DEFAULT 0,
    `salePayment_status` LONGTEXT CHARACTER SET ucs2 NOT NULL,
    `created_at` TIMESTAMP,
    `user_id` BIGINT);
CREATE INDEX `WDIDX_sales_customer_id` ON `sales` (`customer_id`);
CREATE INDEX `WDIDX_sales_location_id` ON `sales` (`location_id`);
CREATE INDEX `WDIDX_sales_user_id` ON `sales` (`user_id`);

-- Création de la table sales_items
CREATE TABLE `sales_items` (
    `sale_id` BIGINT NOT NULL DEFAULT 0,
    `item_id` BIGINT NOT NULL DEFAULT 0,
    `description` NVARCHAR(191),
    `serialnumber` NVARCHAR(191),
    `quantity_purchased` NUMERIC(15,3) NOT NULL DEFAULT 0,
    `item_cost_price` NUMERIC(15,2) NOT NULL DEFAULT 0,
    `item_unit_price` NUMERIC(15,2) NOT NULL DEFAULT 0,
    `item_location` BIGINT NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP);
CREATE INDEX `WDIDX_sales_items_sale_id` ON `sales_items` (`sale_id`);
CREATE INDEX `WDIDX_sales_items_item_id` ON `sales_items` (`item_id`);
CREATE INDEX `WDIDX_sales_items_item_location` ON `sales_items` (`item_location`);
CREATE UNIQUE INDEX `WDIDX_sales_items_PRIMARY` ON `sales_items` (`sale_id`,`item_id`);

-- Création de la table sales_payments
CREATE TABLE `sales_payments` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `sale_id` BIGINT NOT NULL DEFAULT 0,
    `payment_type` NVARCHAR(40) NOT NULL,
    `payment_amount` NUMERIC(15,2) NOT NULL DEFAULT 0,
    `cash_refund` NUMERIC(15,2) NOT NULL DEFAULT 0,
    `cash_adjustment` TINYINT NOT NULL DEFAULT 0,
    `user_id` BIGINT,
    `payment_time` TIMESTAMP NOT NULL DEFAULT {ts '0000-01-01 00:00:00.000'},
    `date_cheque` DATE,
    `created_at` TIMESTAMP);
CREATE INDEX `WDIDX_sales_payments_sale_id` ON `sales_payments` (`sale_id`);
CREATE INDEX `WDIDX_sales_payments_user_id` ON `sales_payments` (`user_id`);

-- Création de la table stock_location
CREATE TABLE `stock_location` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `location_name` NVARCHAR(191),
    `created_at` TIMESTAMP);

-- Création de la table supplier
CREATE TABLE `supplier` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `person_id` BIGINT NOT NULL DEFAULT 0,
    `company_name` NVARCHAR(191),
    `agency_name` NVARCHAR(191),
    `account_number` NVARCHAR(191),
    `category` NVARCHAR(191),
    `created_at` TIMESTAMP);
CREATE INDEX `WDIDX_supplier_person_id` ON `supplier` (`person_id`);

-- Création de la table transfers
CREATE TABLE `transfers` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `amount_cash` NUMERIC(15,2),
    `cash_up` BIGINT,
    `created_at` TIMESTAMP);
CREATE INDEX `WDIDX_transfers_cash_up` ON `transfers` (`cash_up`);

-- Création de la table users
CREATE TABLE `users` (
    `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` NVARCHAR(191) NOT NULL,
    `email` NVARCHAR(191) NOT NULL UNIQUE,
    `password` NVARCHAR(191) NOT NULL,
    `profile_photo` LONGBLOB,
    `created_at` TIMESTAMP,
    `person_id` BIGINT);
CREATE INDEX `WDIDX_users_person_id` ON `users` (`person_id`);
-- Contraintes d'intégrité
ALTER TABLE `customers` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
ALTER TABLE `inventories` ADD FOREIGN KEY (`trans_user_id`) REFERENCES `users` (`id`);
ALTER TABLE `customers` ADD FOREIGN KEY (`person_id`) REFERENCES `people` (`id`);
ALTER TABLE `receivings_items` ADD FOREIGN KEY (`receiving_id`) REFERENCES `receivings` (`id`);
ALTER TABLE `role_has_permissions` ADD FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
ALTER TABLE `receivings` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
ALTER TABLE `sales_items` ADD FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`);
ALTER TABLE `inventories` ADD FOREIGN KEY (`trans_items`) REFERENCES `items` (`id`);
ALTER TABLE `payment_type` ADD FOREIGN KEY (`receivings_id`) REFERENCES `receivings` (`id`);
ALTER TABLE `sales` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);
ALTER TABLE `sales_payments` ADD FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`);
ALTER TABLE `sales` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
ALTER TABLE `item_quantities` ADD FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);
ALTER TABLE `receivings` ADD FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`);
ALTER TABLE `receivings_items` ADD FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);
ALTER TABLE `sales` ADD FOREIGN KEY (`location_id`) REFERENCES `stock_location` (`id`);
ALTER TABLE `sales_items` ADD FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);
ALTER TABLE `sales_items` ADD FOREIGN KEY (`item_location`) REFERENCES `stock_location` (`id`);
ALTER TABLE `supplier` ADD FOREIGN KEY (`person_id`) REFERENCES `people` (`id`);
ALTER TABLE `receivings_items` ADD FOREIGN KEY (`item_location`) REFERENCES `stock_location` (`id`);
ALTER TABLE `users` ADD FOREIGN KEY (`person_id`) REFERENCES `people` (`id`);
ALTER TABLE `inventories` ADD FOREIGN KEY (`trans_location`) REFERENCES `stock_location` (`id`);
ALTER TABLE `role_has_permissions` ADD FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`);
ALTER TABLE `item_quantities` ADD FOREIGN KEY (`location_id`) REFERENCES `stock_location` (`id`);
