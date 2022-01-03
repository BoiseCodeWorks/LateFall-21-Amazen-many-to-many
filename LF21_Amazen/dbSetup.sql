CREATE TABLE IF NOT EXISTS accounts(
  id VARCHAR(255) NOT NULL primary key COMMENT 'primary key',
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Time Created',
  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Update',
  name varchar(255) COMMENT 'User Name',
  email varchar(255) COMMENT 'User Email',
  picture varchar(255) COMMENT 'User Picture'
) default charset utf8 COMMENT '';
SELECT
  *
FROM
  accounts;
CREATE TABLE IF NOT EXISTS merchants(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name TEXT NOT NULL,
    creatorId VARCHAR(255) NOT NULL,
    category TEXT NOT NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Time Created',
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Update',
    FOREIGN KEY (creatorId) REFERENCES accounts(id) ON DELETE CASCADE
  ) default charset utf8 COMMENT '';
INSERT INTO
  merchantz (name, category, creatorId)
VALUES
  (
    'Jeff-Books.com',
    'Books',
    '60d3560eceb6bbdfae388576'
  );
SELECT
  *
FROM
  merchants;
-- CREATE TABLE IF NOT EXISTS merchantz(
  --   id INT AUTO_INCREMENT PRIMARY KEY,
  --   name TEXT NOT NULL,
  --   creatorId VARCHAR(255) NOT NULL,
  --   category TEXT NOT NULL,
  --   createdAt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Time Created',
  --   updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Update',
  --   FOREIGN KEY (creatorId) REFERENCES accounts(id) ON DELETE CASCADE
  -- ) default charset utf8 COMMENT '';
  CREATE TABLE IF NOT EXISTS productz(
    id INT AUTO_INCREMENT PRIMARY KEY,
    merchantId INT NOT NULL,
    creatorId VARCHAR(255) NOT NULL,
    name TEXT NOT NULL,
    price DOUBLE NOT NULL,
    inStock TINYINT NOT NULL,
    onSale BOOLEAN NOT NULL,
    FOREIGN KEY (merchantId) REFERENCES merchantz (id) ON DELETE CASCADE,
    FOREIGN KEY (creatorId) REFERENCES accounts (id) ON DELETE CASCADE
  ) default charset utf8 COMMENT '';
CREATE TABLE IF NOT EXISTS favoriteProduct(
    id INT AUTO_INCREMENT PRIMARY KEY,
    productId INT NOT NULL,
    accountId VARCHAR(255) NOT NULL,
    FOREIGN KEY (productId) REFERENCES productz(id) ON DELETE CASCADE,
    FOREIGN KEY (accountId) REFERENCES accounts(id) ON DELETE CASCADE
  ) default charset utf8 COMMENT '';
INSERT INTO
  favoriteProduct (productId, accountId)
VALUES
  (2, '60d3560eceb6bbdfae388576');
DROP TABLE productz;
INSERT INTO
  productz (merchantId, creatorId, name, price, inStock)
VALUES
  (
    1,
    '60d3560eceb6bbdfae388576',
    'How to Build Amazen',
    12.99,
    1
  );
SELECT
  *
FROM
  productz;
-- NOTE HOW TO ALTER A TABLE
ALTER TABLE
  productz
MODIFY
  onSale BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE
  productz
ADD
  COLUMN stock INT NOT NULL DEFAULT 10;
ALTER TABLE
  productz DROP COLUMN rating;
SELECT
  p.*,
  m.name AS merchantName,
  m.id as merchantId
FROM
  productz p
  JOIN merchantz m ON p.merchantId = m.id;
SELECT
  p.name AS productName,
  p.id AS productId,
  a.name AS accoutnName,
  a.id AS accountId,
  fp.id
FROM
  favoriteProduct fp
  JOIN productz p ON fp.productId = p.id
  JOIN accounts a ON fp.accountId = a.id
WHERE
  fp.accountId = '618d6d7f62431202751b51e7'