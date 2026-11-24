-- View: public.payment_installments_order_percentage_and_avg_order_value

-- DROP VIEW public.payment_installments_order_percentage_and_avg_order_value;

CREATE OR REPLACE VIEW public.payment_installments_order_percentage_and_avg_order_value
 AS
 SELECT p.payment_installments,
    count(DISTINCT p.order_id) AS orders,
    round(count(DISTINCT p.order_id)::numeric * 100.0 / sum(count(DISTINCT p.order_id)) OVER (), 2) AS percentage_of_orders,
    round(avg(p.payment_value), 2) AS average_payment_value
   FROM payments p
     JOIN orders o ON o.order_id::text = p.order_id::text
  WHERE o.order_status::text <> 'canceled'::text
  GROUP BY p.payment_installments
  ORDER BY p.payment_installments;

ALTER TABLE public.payment_installments_order_percentage_and_avg_order_value
    OWNER TO postgres;

