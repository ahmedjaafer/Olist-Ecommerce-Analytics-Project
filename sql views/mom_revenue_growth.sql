-- View: public.mom_revenue_growth

-- DROP VIEW public.mom_revenue_growth;

CREATE OR REPLACE VIEW public.mom_revenue_growth
 AS
 WITH monthly_revenue AS (
         SELECT date_trunc('month'::text, o.order_purchase_timestamp) AS month,
            sum(p.payment_value) AS revenue
           FROM orders o
             JOIN payments p ON o.order_id::text = p.order_id::text
          WHERE o.order_status::text <> 'canceled'::text
          GROUP BY (date_trunc('month'::text, o.order_purchase_timestamp))
        )
 SELECT month,
    revenue,
    round((revenue - lag(revenue) OVER (ORDER BY month)) / NULLIF(lag(revenue) OVER (ORDER BY month), 0::numeric) * 100::numeric, 2) AS revenue_growth_pct
   FROM monthly_revenue
  ORDER BY month;

ALTER TABLE public.mom_revenue_growth
    OWNER TO postgres;

