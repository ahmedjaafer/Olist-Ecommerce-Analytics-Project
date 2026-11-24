-- View: public.monthly_time_analysis

-- DROP VIEW public.monthly_time_analysis;

CREATE OR REPLACE VIEW public.monthly_time_analysis
 AS
 WITH monthly_metrics AS (
         SELECT date_trunc('month'::text, o.order_purchase_timestamp)::date AS month,
            count(DISTINCT o.order_id) AS order_count,
            sum(oi.price) AS monthly_revenue
           FROM orders o
             JOIN order_items oi ON o.order_id::text = oi.order_id::text
          WHERE o.order_status::text <> 'canceled'::text
          GROUP BY (date_trunc('month'::text, o.order_purchase_timestamp)::date)
        )
 SELECT month,
    order_count,
    round(monthly_revenue, 2) AS monthly_revenue,
    round(monthly_revenue / NULLIF(order_count, 0)::numeric, 2) AS aov
   FROM monthly_metrics
  ORDER BY month;

ALTER TABLE public.monthly_time_analysis
    OWNER TO postgres;

