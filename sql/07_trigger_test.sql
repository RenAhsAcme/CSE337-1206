USE TPCH;

CREATE TABLE StockAlert_Log (
    alert_id INT NOT NULL AUTO_INCREMENT,
    partkey INT NOT NULL,
    suppkey INT NOT NULL,
    alert_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_StockAlert_Log PRIMARY KEY (alert_id)
) ENGINE=InnoDB;

CREATE TRIGGER trg_partsupp_lowstock
AFTER UPDATE ON PartSupp
FOR EACH ROW
BEGIN
    IF NEW.availqty < 10 AND OLD.availqty >= 10 THEN
        INSERT INTO StockAlert_Log (partkey, suppkey)
        VALUES (NEW.partkey, NEW.suppkey);
    END IF;
END;

SHOW CREATE TRIGGER trg_partsupp_lowstock;
SELECT * FROM StockAlert_Log ORDER BY alert_id;

SELECT * FROM PartSupp WHERE partkey = 1 AND suppkey = 1;
SELECT COUNT(*) AS alerts_before_a FROM StockAlert_Log;
UPDATE PartSupp SET availqty = 5 WHERE partkey = 1 AND suppkey = 1;
SELECT * FROM PartSupp WHERE partkey = 1 AND suppkey = 1;
SELECT * FROM StockAlert_Log ORDER BY alert_id;

SELECT * FROM PartSupp WHERE partkey = 2 AND suppkey = 1;
SELECT COUNT(*) AS alerts_before_b FROM StockAlert_Log;
UPDATE PartSupp SET availqty = 12 WHERE partkey = 2 AND suppkey = 1;
SELECT * FROM PartSupp WHERE partkey = 2 AND suppkey = 1;
SELECT * FROM StockAlert_Log ORDER BY alert_id;

