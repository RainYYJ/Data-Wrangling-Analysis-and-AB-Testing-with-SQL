-- Use this table to 
-- compute order_binary for the 30 day window after the test_start_date
-- for the test named item_test_2

SELECT 
order_binary.test_assignment,
COUNT(distinct order_binary.item_id) as order_numbers,
SUM(order_binary) as order_bin_30d
FROM
  (select 
    assignments.item_id,
    MAX(CASE WHEN (orders.created_at > assignments.test_start_date AND 
                  date_part('day',orders.created_at - assignments.test_start_date) <= 30) 
                  THEN 1 ELSE 0 END) AS order_binary,
    assignments.test_assignment
  FROM
    dsv1069.final_assignments AS assignments
  LEFT JOIN
    dsv1069.orders AS orders
  ON 
    assignments.item_id = orders.item_id
  WHERE
    assignments.test_number = 'item_test_2'
  GROUP BY
    assignments.item_id,
    assignments.test_assignment) AS order_binary
GROUP BY
order_binary.test_assignment



  
