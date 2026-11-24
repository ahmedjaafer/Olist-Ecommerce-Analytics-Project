-- View: public.review_score_distribution

-- DROP VIEW public.review_score_distribution;

CREATE OR REPLACE VIEW public.review_score_distribution
 AS
 SELECT review_score,
    count(*) AS review_count,
    round(count(*)::numeric / sum(count(*)) OVER () * 100::numeric, 2) AS review_percentage
   FROM reviews
  WHERE review_score >= 1 AND review_score <= 5
  GROUP BY review_score
  ORDER BY review_score;

ALTER TABLE public.review_score_distribution
    OWNER TO postgres;

