WITH curve_trade_pools AS (
    SELECT
        DISTINCT exchange_contract_address AS pool_addr,
        CASE WHEN version IS NULL THEN '1' ELSE version END AS version
    FROM curvefi.view_trades
),
last_label_entries AS (
    SELECT
        DISTINCT ON (address)
        address,
        updated_at,
        name
    FROM labels.labels
    WHERE 
        type = 'contract_name'
        AND 
        EXISTS (SELECT * FROM curve_trade_pools WHERE pool_addr = address)
    ORDER BY address, updated_at DESC
)
INSERT INTO labels.labels(address, name, type, author, source)
SELECT
    pool_addr AS address,
    LOWER(CONCAT('Curve v', version, ' LP ', REPLACE(name, '_swap', ''))) AS label,
    'lp_pool_name' AS type,
    'masquot' AS author,
    'ethereum_mainnet_curve_pools' AS source
FROM curve_trade_pools p
LEFT JOIN last_label_entries ON pool_addr = address
ON CONFLICT DO NOTHING ;
