-- Given an IMPRESSIONS table with product_id, click (an indicator that the product was clicked), and date, write a
-- query that will tell you the click-through-rate of each product by month

SELECT
  DATE_TRUNC('month',date) AS month,
  product_id,
  sum(case when click is true then 1 else 0 end)/count(*)
FROM impressions
GROUP BY 1, 2

--Given the above tables write a query that depict the top 3 performing categories in terms of click through rate.
SELECT
  category_id,
  sum(case when click is true then 1 else 0 end)/count(*) AS ctr
FROM impressions imp
LEFT JOIN products pr ON pr.product_id = imp.product_id
GROUP BY 1, 2
ORDER BY ctr DESC
LIMIT 3

--Click-through-rate by price tier (0-5, 5-10, 10-15, >15)
SELECT
  CASE
    WHEN pr.price BETWEEN 0 AND 5 THEN '0-5'
    WHEN pr.price BETWEEN 5 AND 10 THEN '5-10'
    WHEN pr.price BETWEEN 10 AND 15 THEN '10-15'
    WHEN pr.price > 15 THEN  '>15'
  END AS price_tier,
  sum(case when click is true then 1 else 0 end)/count(*) AS ctr
FROM impressions imp
LEFT JOIN products pr ON pr.product_id = imp.product_id
GROUP BY 1, 2
ORDER BY ctr DESC

