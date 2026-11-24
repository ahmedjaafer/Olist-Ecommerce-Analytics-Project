-- View: public.vw_category_revenue_vs_satisfaction

-- DROP VIEW public.vw_category_revenue_vs_satisfaction;

CREATE OR REPLACE VIEW public.vw_category_revenue_vs_satisfaction
 AS
 WITH category_revenue AS (
         SELECT p.product_category_name,
            sum(oi.price) AS product_revenue,
            count(DISTINCT oi.order_id) AS order_count
           FROM order_items oi
             JOIN orders o ON oi.order_id::text = o.order_id::text
             JOIN products p ON oi.product_id::text = p.product_id::text
          WHERE o.order_status::text <> 'canceled'::text AND p.product_category_name IS NOT NULL
          GROUP BY p.product_category_name
        ), category_reviews AS (
         SELECT p.product_category_name,
            r.order_id,
            avg(r.review_score) AS order_review_score
           FROM reviews r
             JOIN order_items oi ON r.order_id::text = oi.order_id::text
             JOIN products p ON oi.product_id::text = p.product_id::text
             JOIN orders o ON r.order_id::text = o.order_id::text
          WHERE o.order_status::text <> 'canceled'::text AND p.product_category_name IS NOT NULL AND r.review_score >= 1 AND r.review_score <= 5
          GROUP BY p.product_category_name, r.order_id
        ), category_satisfaction AS (
         SELECT category_reviews.product_category_name,
            count(*) AS reviewed_orders,
            avg(category_reviews.order_review_score) AS avg_review_score,
            count(*) FILTER (WHERE category_reviews.order_review_score <= 2::numeric) AS low_review_orders,
            count(*) FILTER (WHERE category_reviews.order_review_score >= 4::numeric) AS positive_review_orders
           FROM category_reviews
          GROUP BY category_reviews.product_category_name
        )
 SELECT cr.product_category_name,
    round(cr.product_revenue, 2) AS product_revenue,
    cr.order_count,
    COALESCE(cs.reviewed_orders, 0::bigint) AS reviewed_orders,
    round(cs.avg_review_score, 2) AS avg_review_score,
    round(cs.low_review_orders::numeric / NULLIF(cs.reviewed_orders, 0)::numeric * 100::numeric, 2) AS low_review_rate_pct,
    round(cs.positive_review_orders::numeric / NULLIF(cs.reviewed_orders, 0)::numeric * 100::numeric, 2) AS positive_review_rate_pct
   FROM category_revenue cr
     LEFT JOIN category_satisfaction cs ON cr.product_category_name::text = cs.product_category_name::text
  ORDER BY (round(cr.product_revenue, 2)) DESC;

ALTER TABLE public.vw_category_revenue_vs_satisfaction
    OWNER TO postgres;

