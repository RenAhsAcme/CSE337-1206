USE TPCH;
SELECT COUNT(*) AS existing_region FROM Region WHERE regionkey = 9201;
SELECT COUNT(*) AS existing_nation FROM Nation WHERE nationkey = 9201;

START TRANSACTION;
INSERT INTO Region (regionkey, name, comment) VALUES (9201, 'W2_TEST_REGION', 'Week 2 temporary');
INSERT INTO Nation (nationkey, name, regionkey, comment) VALUES (9201, 'W2_TEST_NATION', 9201, 'Week 2 temporary');
SELECT * FROM Region WHERE regionkey = 9201;
SELECT * FROM Nation WHERE nationkey = 9201;

-- DELETE FROM Region WHERE regionkey = 9201;

DELETE FROM Nation WHERE nationkey = 9201;
DELETE FROM Region WHERE regionkey = 9201;
SELECT COUNT(*) AS region_after_delete FROM Region WHERE regionkey = 9201;
SELECT COUNT(*) AS nation_after_delete FROM Nation WHERE nationkey = 9201;

ROLLBACK;
SELECT COUNT(*) AS remaining_region FROM Region WHERE regionkey = 9201;
SELECT COUNT(*) AS remaining_nation FROM Nation WHERE nationkey = 9201;
