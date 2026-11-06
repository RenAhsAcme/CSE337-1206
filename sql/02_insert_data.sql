USE TPCH;
START TRANSACTION;

INSERT INTO Region (regionkey, name, comment) VALUES
(1, 'ASIA', 'Asia region'),
(2, 'EUROPE', 'Europe region'),
(3, 'AMERICA', 'America region');

INSERT INTO Nation (nationkey, name, regionkey, comment) VALUES
(1, 'CHINA', 1, 'China'),
(2, 'GERMANY', 2, 'Germany'),
(3, 'UNITED STATES', 3, 'United States');

INSERT INTO Part (partkey, name, mfgr, brand, type, size, container, retailprice, comment) VALUES
(1, 'Bolt', 'Factory1', 'Brand1', 'STEEL', 10, 'BOX', 150.00, 'Part 1'),
(2, 'Nut', 'Factory1', 'Brand1', 'STEEL', 20, 'BOX', 250.00, 'Part 2'),
(3, 'Bearing', 'Factory2', 'Brand2', 'BRASS', 30, 'BAG', 350.00, 'Part 3'),
(4, 'Gear', 'Factory2', 'Brand2', 'STEEL', 40, 'BOX', 450.00, 'Part 4'),
(5, 'Shaft', 'Factory3', 'Brand3', 'IRON', 50, 'CASE', 550.00, 'Part 5');

INSERT INTO Supplier (suppkey, name, address, nationkey, phone, acctbal, comment) VALUES
(1, 'Supplier_CN_A', 'Guangzhou', 1, '86-020-1001', 1000.00, 'China A'),
(2, 'Supplier_CN_B', 'Shenzhen', 1, '86-0755-1002', 2000.00, 'China B'),
(3, 'Supplier_DE_A', 'Berlin', 2, '49-030-1003', 3000.00, 'Germany A'),
(4, 'Supplier_DE_B', 'Munich', 2, '49-089-1004', 4000.00, 'Germany B'),
(5, 'Supplier_US_A', 'Boston', 3, '1-617-1005', 5000.00, 'US A');

INSERT INTO PartSupp (partkey, suppkey, availqty, supplycost, comment) VALUES
(1, 1, 50, 100.00, 'Trigger test A'),
(1, 2, 600, 110.00, 'Second supplier for part 1'),
(2, 1, 15, 200.00, 'Trigger test B'),
(2, 3, 300, 180.00, 'Germany stock'),
(3, 3, 400, 300.00, 'Germany stock'),
(3, 4, 8, 310.00, 'Initially below threshold'),
(4, 5, 500, 400.00, 'US stock'),
(5, 5, 100, 500.00, 'US stock');

INSERT INTO Customer (custkey, name, address, nationkey, phone, acctbal, mktsegment, comment) VALUES
(1, 'Alice', 'Guangzhou', 1, '86-020-2001', 1000.00, 'BUILDING', 'China lower balance'),
(2, 'Bob', 'Shenzhen', 1, '86-0755-2002', 3000.00, 'AUTOMOBILE', 'China higher balance'),
(3, 'Clara', 'Berlin', 2, '49-030-2003', 2000.00, 'BUILDING', 'Germany lower balance'),
(4, 'David', 'Munich', 2, '49-089-2004', 6000.00, 'MACHINERY', 'Germany higher balance'),
(5, 'Eve', 'Boston', 3, '1-617-2005', 5000.00, 'HOUSEHOLD', 'Only customer in US');

INSERT INTO Orders (orderkey, custkey, orderstatus, totalprice, orderdate, orderpriority, clerk, shippriority, comment) VALUES
(1, 1, 'O', 300.00, '2026-10-01', '1-URGENT', 'Clerk1', 0, 'Alice first order'),
(2, 1, 'O', 250.00, '2026-10-02', '2-HIGH', 'Clerk1', 0, 'Alice second order'),
(3, 3, 'F', 350.00, '2026-10-03', '3-MEDIUM', 'Clerk2', 0, 'Clara first order'),
(4, 3, 'O', 450.00, '2026-10-04', '3-MEDIUM', 'Clerk2', 0, 'Clara second order'),
(5, 4, 'O', 550.00, '2026-10-05', '4-NOT SPECIFIED', 'Clerk3', 0, 'David order');

INSERT INTO Lineitem (orderkey, partkey, suppkey, linenumber, quantity, extendedprice, discount, tax, returnflag, linestatus, shipdate, commitdate, receiptdate, shipinstruct, shipmode, comment) VALUES
(1, 1, 1, 1, 1, 150.00, 0.00, 0.00, 'N', 'O', '2026-10-06', '2026-10-07', '2026-10-08', 'DELIVER IN PERSON', 'AIR', 'First line'),
(1, 1, 2, 2, 1, 150.00, 0.00, 0.00, 'N', 'O', '2026-10-06', '2026-10-07', '2026-10-08', 'DELIVER IN PERSON', 'AIR', 'Second line'),
(2, 2, 3, 1, 1, 250.00, 0.00, 0.00, 'N', 'O', '2026-10-07', '2026-10-08', '2026-10-09', 'TAKE BACK RETURN', 'SHIP', 'Order 2'),
(3, 3, 3, 1, 1, 350.00, 0.00, 0.00, 'N', 'F', '2026-10-08', '2026-10-09', '2026-10-10', 'DELIVER IN PERSON', 'AIR', 'Order 3'),
(4, 4, 5, 1, 1, 450.00, 0.00, 0.00, 'N', 'O', '2026-10-09', '2026-10-10', '2026-10-11', 'DELIVER IN PERSON', 'RAIL', 'Order 4'),
(5, 5, 5, 1, 1, 550.00, 0.00, 0.00, 'N', 'O', '2026-10-10', '2026-10-11', '2026-10-12', 'DELIVER IN PERSON', 'TRUCK', 'Order 5');

COMMIT;

SELECT 'Region' AS table_name, COUNT(*) AS row_count FROM Region
UNION ALL SELECT 'Nation', COUNT(*) FROM Nation
UNION ALL SELECT 'Part', COUNT(*) FROM Part
UNION ALL SELECT 'Supplier', COUNT(*) FROM Supplier
UNION ALL SELECT 'PartSupp', COUNT(*) FROM PartSupp
UNION ALL SELECT 'Customer', COUNT(*) FROM Customer
UNION ALL SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL SELECT 'Lineitem', COUNT(*) FROM Lineitem;

SELECT * FROM PartSupp ORDER BY partkey, suppkey;
SELECT custkey, COUNT(*) AS order_count FROM Orders
GROUP BY custkey HAVING COUNT(*) > 1;
SELECT partkey, COUNT(DISTINCT suppkey) AS supplier_count FROM PartSupp
GROUP BY partkey HAVING COUNT(DISTINCT suppkey) > 1;
