-- View: public.top10_sellers_by_orders

-- DROP VIEW public.top10_sellers_by_orders;

CREATE OR REPLACE VIEW public.top10_sellers_by_orders
 AS
 SELECT s.seller_id,
    concat(initcap(s.seller_city::text), ', ', s.seller_state, ' (', "right"(s.seller_id::text, 4), ')') AS seller_label,
    count(DISTINCT oi.order_id) AS total_orders
   FROM sellers s
     JOIN order_items oi ON s.seller_id::text = oi.seller_id::text
     JOIN orders o ON oi.order_id::text = o.order_id::text
  WHERE o.order_status::text <> 'canceled'::text
  GROUP BY s.seller_id, s.seller_city, s.seller_state
  ORDER BY (count(DISTINCT oi.order_id)) DESC
 LIMIT 10;

ALTER TABLE public.top10_sellers_by_orders
    OWNER TO postgres;

