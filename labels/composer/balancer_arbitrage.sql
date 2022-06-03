CREATE MATERIALIZED VIEW IF NOT EXISTS labels.view_dex_balancer_data AS
  SELECT DISTINCT (t1.tx_hash)::TEXT AS tx_hash
  FROM dex.trades t1
  INNER JOIN dex.trades t2 ON t1.tx_hash = t2.tx_hash AND t1.token_a_address = t2.token_b_address AND t1.token_b_address = t2.token_a_address
    AND ((t1.project = 'Balancer' AND t2.project = ANY(ARRAY['Uniswap','Sushiswap'])) OR (t1.project = ANY(ARRAY['Uniswap','Sushiswap']) AND t2.project = 'Balancer'))
WITH NO DATA ;

REFRESH MATERIALIZED VIEW labels.view_dex_balancer_data ;

INSERT INTO labels.labels(address, name, type, author, source)
SELECT
    DISTINCT(t.to) AS address,
    'arbitrage bot' AS name,
    'dapp usage' AS type,
    'balancerlabs' AS author,
    'ethereum_mainnet_balancer_arbitrage' AS source
FROM labels.view_dex_balancer_data
INNER JOIN ethereum.transactions t ON t.hash = tx_hash AND t.to <> ANY(ARRAY(select address from labels.labels where author = 'balancerlabs' and type = 'balancer_source'))
ON CONFLICT DO NOTHING ;

DROP MATERIALIZED VIEW labels.view_dex_balancer_data ;
