USE TPCH;
SELECT n.nationkey, n.name AS nation_name, COUNT(s.suppkey) AS supplier_count
FROM Nation AS n
LEFT JOIN Supplier AS s ON s.nationkey = n.nationkey
GROUP BY n.nationkey, n.name
ORDER BY n.nationkey;
