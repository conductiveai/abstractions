SELECT dex.backfill_usd_amount(now() - interval '3 days', now() - interval '20 minutes') ;

REFRESH MATERIALIZED VIEW CONCURRENTLY dex.view_token_prices ;
