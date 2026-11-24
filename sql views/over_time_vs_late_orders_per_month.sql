-- View: public.over_time_vs_late_orders_per_month

-- DROP VIEW public.over_time_vs_late_orders_per_month;

CREATE OR REPLACE VIEW public.over_time_vs_late_orders_per_month
 AS
 SELECT date_trunc('month'::text, order_purchase_timestamp)::date AS month,
    count(*) FILTER (WHERE order_delivered_customer_date <= order_estimated_delivery_date) AS on_time_orders,
    count(*) FILTER (WHERE order_delivered_customer_date > order_estimated_delivery_date) AS late_orders,
    round(count(*) FILTER (WHERE order_delivered_customer_date <= order_estimated_delivery_date)::numeric * 100.0 / count(*)::numeric, 2) AS on_time_percentage,
    round(count(*) FILTER (WHERE order_delivered_customer_date > order_estimated_delivery_date)::numeric * 100.0 / count(*)::numeric, 2) AS late_percentage
   FROM orders
  WHERE order_status::text <> 'canceled'::text AND order_delivered_customer_date IS NOT NULL AND order_estimated_delivery_date IS NOT NULL
  GROUP BY (date_trunc('month'::text, order_purchase_timestamp)::date)
  ORDER BY (date_trunc('month'::text, order_purchase_timestamp)::date);

ALTER TABLE public.over_time_vs_late_orders_per_month
    OWNER TO postgres;

