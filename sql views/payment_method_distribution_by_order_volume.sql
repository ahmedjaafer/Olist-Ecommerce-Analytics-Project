-- View: public.payment_method_distribution_by_order_volume

-- DROP VIEW public.payment_method_distribution_by_order_volume;

CREATE OR REPLACE VIEW public.payment_method_distribution_by_order_volume
 AS
 SELECT payment_type,
    count(DISTINCT order_id) AS orders,
    round(count(DISTINCT order_id)::numeric * 100.0 / sum(count(DISTINCT order_id)) OVER (), 2) AS percentage_of_orders
   FROM payments
  GROUP BY payment_type
  ORDER BY (count(DISTINCT order_id)) DESC;

ALTER TABLE public.payment_method_distribution_by_order_volume
    OWNER TO postgres;

