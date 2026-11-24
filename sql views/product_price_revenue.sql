-- View: public.product_price_revenue

-- DROP VIEW public.product_price_revenue;

CREATE OR REPLACE VIEW public.product_price_revenue
 AS
 SELECT p.product_id,
    oi.price,
    sum(oi.price) AS revenue
   FROM products p
     JOIN order_items oi ON oi.product_id::text = p.product_id::text
     JOIN orders o ON o.order_id::text = oi.order_id::text
  WHERE o.order_status::text <> 'canceled'::text
  GROUP BY p.product_id, oi.price
  ORDER BY (sum(oi.price)) DESC;

ALTER TABLE public.product_price_revenue
    OWNER TO postgres;

