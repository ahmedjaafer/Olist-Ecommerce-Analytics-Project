-- View: public.category_revenue_by_state

-- DROP VIEW public.category_revenue_by_state;

CREATE OR REPLACE VIEW public.category_revenue_by_state
 AS
 SELECT c.customer_state,
    p.product_category_name,
    count(DISTINCT o.order_id) AS order_count,
    count(DISTINCT c.customer_unique_id) AS customer_count,
    count(*) AS items_sold,
    round(sum(oi.price), 2) AS product_revenue,
    round(sum(oi.freight_value), 2) AS total_freight
   FROM orders o
     JOIN customers c ON o.customer_id::text = c.customer_id::text
     JOIN order_items oi ON o.order_id::text = oi.order_id::text
     JOIN products p ON oi.product_id::text = p.product_id::text
  WHERE o.order_status::text <> 'canceled'::text AND p.product_category_name IS NOT NULL
  GROUP BY c.customer_state, p.product_category_name
  ORDER BY (round(sum(oi.price), 2)) DESC;

ALTER TABLE public.category_revenue_by_state
    OWNER TO postgres;

