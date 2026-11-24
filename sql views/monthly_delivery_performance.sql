-- View: public.monthly_delivery_performance

-- DROP VIEW public.monthly_delivery_performance;

CREATE OR REPLACE VIEW public.monthly_delivery_performance
 AS
 SELECT date_trunc('month'::text, order_purchase_timestamp)::date AS month,
    avg(order_delivered_customer_date - order_purchase_timestamp) AS avg_delivery_time
   FROM orders o
  WHERE order_status::text <> 'canceled'::text AND order_delivered_customer_date IS NOT NULL
  GROUP BY (date_trunc('month'::text, order_purchase_timestamp)::date)
  ORDER BY (date_trunc('month'::text, order_purchase_timestamp)::date);

ALTER TABLE public.monthly_delivery_performance
    OWNER TO postgres;

