-- DELETE FROM gnosis_protocol_v2.trades WHERE block_time >= (SELECT DATE_TRUNC('day', now()) - INTERVAL '3 months');
SELECT gnosis_protocol_v2.insert_trades((SELECT max(block_time) - interval '6 hours' FROM gnosis_protocol_v2.trades)) ;

--DELETE FROM gnosis_protocol_v2.batches WHERE block_time >= (SELECT DATE_TRUNC('day', now()) - INTERVAL '6 months');
SELECT gnosis_protocol_v2.insert_batches((SELECT max(block_time) - interval '6 hours' FROM gnosis_protocol_v2.batches)) ;

REFRESH MATERIALIZED VIEW CONCURRENTLY gnosis_protocol.view_tokens ;

REFRESH MATERIALIZED VIEW CONCURRENTLY gnosis_protocol.view_trades ;

REFRESH MATERIALIZED VIEW CONCURRENTLY gnosis_protocol.view_movement ;

REFRESH MATERIALIZED VIEW CONCURRENTLY gnosis_protocol.view_balances ;

REFRESH MATERIALIZED VIEW CONCURRENTLY gnosis_protocol.view_price_batch ;

REFRESH MATERIALIZED VIEW CONCURRENTLY gnosis_protocol.view_daily_average_prices ;

REFRESH MATERIALIZED VIEW CONCURRENTLY gnosis_protocol.view_trade_stats ;

-- REFRESH MATERIALIZED VIEW CONCURRENTLY gnosis_safe.view_safes ;

REFRESH MATERIALIZED VIEW CONCURRENTLY gnosis_protocol_v2.view_solvers ;

-- REFRESH MATERIALIZED VIEW CONCURRENTLY gnosis_protocol_v2.view_batches ;
