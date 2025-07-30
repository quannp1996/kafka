-- Tạo database mẫu
CREATE DATABASE IF NOT EXISTS demo_db;
USE demo_db;

-- Tạo 3 user và cấp quyền
CREATE USER IF NOT EXISTS 'user1'@'%' IDENTIFIED BY 'pass1';
GRANT ALL PRIVILEGES ON demo_db.* TO 'user1'@'%';

CREATE USER IF NOT EXISTS 'user2'@'%' IDENTIFIED BY 'pass2';
GRANT SELECT, INSERT ON demo_db.* TO 'user2'@'%';

CREATE USER IF NOT EXISTS 'user3'@'%' IDENTIFIED BY 'pass3';
GRANT SELECT ON demo_db.* TO 'user3'@'%';

-- Tạo bảng users
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    gender ENUM('male', 'female', 'other') DEFAULT 'other',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tạo bảng accounts
CREATE TABLE IF NOT EXISTS accounts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    balance DECIMAL(15, 2) DEFAULT 0,
    status ENUM('active', 'suspended') DEFAULT 'active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Tạo stored procedure để insert nhanh 1 triệu users
DELIMITER $$

CREATE PROCEDURE populate_users()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE g ENUM('male', 'female', 'other');

    WHILE i <= 1000000 DO
        -- Sinh giới tính ngẫu nhiên
        SET g = ELT(1 + FLOOR(RAND() * 3), 'male', 'female', 'other');

        INSERT INTO users(name, email, gender) 
        VALUES (
            CONCAT('User ', i),
            CONCAT('user', i, '@example.com'),
            g
        );

        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

-- Gọi procedure để tạo dữ liệu (nếu bạn dùng trong init.sql sẽ bị timeout khi khởi động docker)
-- CALL populate_users();
-- Chèn 5 bản ghi vào bảng accounts (liên kết với user_id từ 1 đến 5)
INSERT INTO accounts(user_id, balance, status)
VALUES 
    (1, 1000.00, 'active'),
    (2, 500.00, 'active'),
    (3, 750.50, 'suspended'),
    (4, 0.00, 'active'),
    (5, 320.75, 'active');
