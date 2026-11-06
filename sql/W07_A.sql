SELECT VERSION(), CURRENT_USER();
SELECT User, Host FROM mysql.user WHERE User IN ('auditor', 'audit_user');

CREATE ROLE 'auditor'@'localhost';
GRANT SELECT ON TPCH.* TO 'audit'@'localhost';

CREATE USER 'audit_user'@'localhost' IDENTIFIED BY RANDOM PASSWORD;


