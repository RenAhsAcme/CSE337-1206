USE TPCH;
SELECT c.name AS customer, oc.order_count
FROM Customer AS c
JOIN (
    SELECT custkey, COUNT(*) AS order_count
    FROM Orders
    GROUP BY custkey
) AS oc ON oc.custkey = c.custkey
WHERE oc.order_count > 1
ORDER BY c.custkey;
