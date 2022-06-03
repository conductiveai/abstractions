INSERT INTO labels.labels(address, name, type, author, source)
SELECT
    buyer AS address,
    'nft trader' AS label,
    'activity' AS type,
    'masquot' AS author,
    'ethereum_mainnet_nft_activity_type' AS source
FROM nft.trades
WHERE
    buyer IS NOT NULL
UNION
SELECT
    seller AS address,
    'nft trader' AS label,
    'activity' AS type,
    'masquot' AS author,
    'ethereum_mainnet_nft_activity_type' AS source
FROM nft.trades
WHERE
    seller IS NOT NULL
ON CONFLICT DO NOTHING ;
