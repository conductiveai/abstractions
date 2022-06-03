INSERT INTO labels.labels(address, name, type, author, source)
SELECT
    trader_a AS address,
    lower(project) || ' user' AS label,
    'dapp usage' AS type,
    'hagaetc' AS author,
    'ethereum_mainnet_dex_traders' AS source
FROM
    dex.trades
UNION
SELECT
    trader_b AS address,
    lower(project) || ' user' AS label,
    'dapp usage' AS type,
    'hagaetc' AS author,
    'ethereum_mainnet_dex_traders' AS source
FROM
    dex.trades
WHERE
    trader_b IS NOT NULL
ON CONFLICT DO NOTHING ;
