-- Use this table to 
-- compute view_binary for the 30 day window after the test_start_date
-- for the test named item_test_2

SELECT 
view_binary.test_assignment,
COUNT(distinct view_binary.item_id) as order_numbers,
SUM(view_binary.test_assignment) as sum_view_bin_30d
FROM
  (select 
    assignments.item_id,
    MAX(CASE WHEN (views.event_time > assignments.test_start_date AND 
                  date_part('day',views.event_time - assignments.test_start_date) <= 30) 
                  THEN 1 ELSE 0 END) AS view_binary,
    assignments.test_assignment
  FROM
    dsv1069.final_assignments AS assignments
  LEFT JOIN
    dsv1069.view_item_events AS views
  ON 
    assignments.item_id = views.item_id
  WHERE
    assignments.test_number = 'item_test_2'
  GROUP BY
    assignments.item_id,
    assignments.test_assignment) AS view_binary
GROUP BY
view_binary.test_assignment
