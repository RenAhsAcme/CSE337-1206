USE TPCH;

SELECT n.name AS nation_name,
       COUNT(DISTINCT s.suppkey) AS supplier_count,
       COUNT(DISTINCT ps.partkey) AS part_kind_count,
       SUM(ps.availqty) AS total_availqty,
       AVG(ps.supplycost) AS avg_supplycost
FROM Nation AS n
JOIN Supplier AS s ON s.nationkey = n.nationkey
LEFT JOIN PartSupp AS ps ON ps.suppkey = s.suppkey
GROUP BY n.nationkey, n.name
HAVING SUM(ps.availqty) > 500
ORDER BY n.nationkey;
