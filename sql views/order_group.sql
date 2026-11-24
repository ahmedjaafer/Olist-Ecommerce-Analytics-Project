-- View: public.order_group

-- DROP VIEW public.order_group;

CREATE OR REPLACE VIEW public.order_group
 AS
 WITH customer_orders AS (
         SELECT c.customer_unique_id,
            count(DISTINCT o.order_id) AS order_count
           FROM customers c
             JOIN orders o ON c.customer_id::text = o.customer_id::text
          WHERE o.order_status::text <> 'canceled'::text
          GROUP BY c.customer_unique_id
        ), customer_distribution AS (
         SELECT
                CASE
                    WHEN customer_orders.order_count = 1 THEN '1 order'::text
                    WHEN customer_orders.order_count = 2 THEN '2 orders'::text
                    ELSE '3+ orders'::text
                END AS order_group,
            count(*) AS customers
           FROM customer_orders
          GROUP BY (
                CASE
                    WHEN customer_orders.order_count = 1 THEN '1 order'::text
                    WHEN customer_orders.order_count = 2 THEN '2 orders'::text
                    ELSE '3+ orders'::text
                END)
        )
 SELECT order_group,
    customers,
    sum(customers) OVER () AS total_customers,
    round(customers::numeric * 100.0 / sum(customers) OVER (), 2) AS percentage_of_customers
   FROM customer_distribution
  ORDER BY (
        CASE order_group
            WHEN '1 order'::text THEN 1
            WHEN '2 orders'::text THEN 2
            WHEN '3+ orders'::text THEN 3
            ELSE NULL::integer
        END);

ALTER TABLE public.order_group
    OWNER TO postgres;

