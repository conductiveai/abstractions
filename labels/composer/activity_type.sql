INSERT INTO labels.labels(address, name, type, author, source)
SELECT
    borrower AS address,
    'borrower' AS label,
    'activity' AS type,
    'hagaetc' AS author,
    'ethereum_mainnet_activity_type' AS source
FROM
    lending.borrow
UNION
SELECT
    borrower AS address,
    'loan collateral supplier' AS label,
    'activity' AS type,
    'hagaetc' AS author,
    'ethereum_mainnet_activity_type' AS source
FROM
    lending.collateral_change
UNION
SELECT
    trader_a AS address,
    'dex trader' AS label,
    'activity' AS type,
    'hagaetc' AS author,
    'ethereum_mainnet_activity_type' AS source
FROM
    dex.trades
UNION
SELECT
    trader_b AS address,
    'dex trader' AS label,
    'activity' AS type,
    'hagaetc' AS author,
    'ethereum_mainnet_activity_type' AS source
FROM
    dex.trades
WHERE
    trader_b IS NOT NULL
ON CONFLICT DO NOTHING ;
