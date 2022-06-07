REFRESH MATERIALIZED VIEW CONCURRENTLY balancer_v1.view_liquidity ;

REFRESH MATERIALIZED VIEW CONCURRENTLY balancer_v2.view_liquidity ;

REFRESH MATERIALIZED VIEW CONCURRENTLY balancer_v2.view_bpt_prices ;

REFRESH MATERIALIZED VIEW CONCURRENTLY balancer.view_balances ;

SELECT balancer.insert_trades(
        (SELECT max(block_time) - interval '1 days' FROM balancer.view_trades WHERE project='Balancer'),
        (SELECT now() - interval '20 minutes'),
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM balancer.view_trades WHERE project='Balancer')),
        max_block_number_lt(now() - interval '20 minutes')
);
