INSERT INTO labels.labels(address, name, type, author, source)
SELECT
    buyer AS address,
    LOWER(platform) || ' user' AS label,
    'dapp usage' AS type,
    'masquot' AS author,
    'ethereum_mainnet_nft_users' AS source
FROM nft.trades
WHERE
    buyer IS NOT NULL
UNION
SELECT
    seller AS address,
    LOWER(platform) || ' user' AS label,
    'dapp usage' AS type,
    'masquot' AS author,
    'ethereum_mainnet_nft_users' AS source
FROM nft.trades
WHERE
    seller IS NOT NULL
ON CONFLICT DO NOTHING ;
