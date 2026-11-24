-- View: public.revenue_per_state

-- DROP VIEW public.revenue_per_state;

CREATE OR REPLACE VIEW public.revenue_per_state
 AS
 SELECT c.customer_state AS state,
    sum(oi.price) AS revenue
   FROM customers c
     JOIN orders o ON o.customer_id::text = c.customer_id::text
     JOIN order_items oi ON oi.order_id::text = o.order_id::text
  WHERE o.order_status::text <> 'canceled'::text
  GROUP BY c.customer_state
  ORDER BY (sum(oi.price)) DESC;

ALTER TABLE public.revenue_per_state
    OWNER TO postgres;

