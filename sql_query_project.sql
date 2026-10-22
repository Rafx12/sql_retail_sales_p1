SELECT *
FROM retail_sales

SELECT * FROM
(

SELECT EXTRACT (year FROM sale_date) as year,
		EXTRACT(MONTH FROM sale_date) as month,
		AVG(total_sale) as AVG_sale,
		RANK() OVER (PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC) AS RANK
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,3 DESC
) AS T1
WHERE RANK = 1

WITH hourly_sale as (
SELECT *, 
	CASE
		WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
FROM retail_sales
)

SELECT shift,COUNT(*) AS  total_orders FROM hourly_sale
GROUP BY shift

--End of project
