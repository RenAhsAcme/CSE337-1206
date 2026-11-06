USE TPCH;

-- INSERT INTO Region (regionkey, name, comment) VALUES (1, 'DUPLICATE', 'PK test');

-- INSERT INTO Nation (nationkey, name, regionkey, comment)
-- VALUES (99, 'INVALID NATION', 999, 'FK insert test');

START TRANSACTION;
INSERT INTO Region (regionkey, name, comment) VALUES (90, 'TEST REGION', 'Temporary');
INSERT INTO Nation (nationkey, name, regionkey, comment) VALUES (90, 'TEST NATION', 90, 'Temporary');

-- DELETE FROM Region WHERE regionkey = 90;

SELECT * FROM Region WHERE regionkey = 90;
SELECT * FROM Nation WHERE nationkey = 90;
ROLLBACK;
SELECT COUNT(*) AS remaining_test_region FROM Region WHERE regionkey = 90;
SELECT COUNT(*) AS remaining_test_nation FROM Nation WHERE nationkey = 90;

-- INSERT INTO Part (partkey, name, retailprice) VALUES (99, 'InvalidPrice', 0.00);

INSERT INTO PartSupp (partkey, suppkey, availqty, supplycost, comment)
VALUES (5, 1, -1, 100.00, 'Invalid quantity');
