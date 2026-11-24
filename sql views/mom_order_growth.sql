-- View: public.mom_order_growth

-- DROP VIEW public.mom_order_growth;

CREATE OR REPLACE VIEW public.mom_order_growth
 AS
 WITH monthly_orders AS (
         SELECT date_trunc('month'::text, orders.order_purchase_timestamp) AS month,
            count(DISTINCT orders.order_id) AS order_count
           FROM orders
          GROUP BY (date_trunc('month'::text, orders.order_purchase_timestamp))
        )
 SELECT month,
    order_count,
    round((order_count - lag(order_count) OVER (ORDER BY month))::numeric / NULLIF(lag(order_count) OVER (ORDER BY month), 0)::numeric * 100::numeric, 2) AS order_growth_pct
   FROM monthly_orders
  ORDER BY month;

ALTER TABLE public.mom_order_growth
    OWNER TO postgres;

