USE TPCH;

SELECT c.name AS customer_name, n.name AS nation_name, c.acctbal
FROM Customer AS c
JOIN Nation AS n ON n.nationkey = c.nationkey
WHERE c.acctbal > (
    SELECT AVG(c2.acctbal)
    FROM Customer AS c2
    WHERE c2.nationkey = c.nationkey
)
ORDER BY c.custkey;

SELECT c.custkey, c.name AS customer_name, n.name AS nation_name
FROM Customer AS c
JOIN Nation AS n ON n.nationkey = c.nationkey
WHERE NOT EXISTS (
    SELECT 1 FROM Orders AS o WHERE o.custkey = c.custkey
)
ORDER BY c.custkey;