-- View: public.product_analysis

-- DROP VIEW public.product_analysis;

CREATE OR REPLACE VIEW public.product_analysis
 AS
 SELECT p.product_category_name AS category,
    count(DISTINCT oi.order_id) AS total_orders_sold,
    count(oi.order_item_id) AS total_items_sold,
    round(sum(oi.price), 2) AS revenue,
    round(avg(oi.price), 2) AS avg_product_price,
    round(sum(oi.price) * 100::numeric / sum(sum(oi.price)) OVER (), 2) AS revenue_percentage
   FROM order_items oi
     JOIN products p ON p.product_id::text = oi.product_id::text
     JOIN orders o ON o.order_id::text = oi.order_id::text
  WHERE o.order_status::text <> 'canceled'::text
  GROUP BY p.product_category_name
  ORDER BY (round(sum(oi.price), 2)) DESC;

ALTER TABLE public.product_analysis
    OWNER TO postgres;

