-- View: public.payment_method_distribution_by_revenue

-- DROP VIEW public.payment_method_distribution_by_revenue;

CREATE OR REPLACE VIEW public.payment_method_distribution_by_revenue
 AS
 SELECT payment_type,
    round(sum(payment_value), 2) AS total_payment_value,
    round(sum(payment_value) * 100.0 / sum(sum(payment_value)) OVER (), 2) AS percentage_of_total_value,
    round(avg(payment_value), 2) AS average_payment_value
   FROM payments
  GROUP BY payment_type
  ORDER BY (round(sum(payment_value), 2)) DESC;

ALTER TABLE public.payment_method_distribution_by_revenue
    OWNER TO postgres;

