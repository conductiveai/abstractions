WITH bancor_pools AS (
SELECT
    DISTINCT contract_address AS pool_address,
    CASE 
        WHEN "_reserveToken" = '\xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' THEN '\xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2'
        ELSE "_reserveToken"
    END AS token 
FROM bancor."StandardPoolConverter_evt_LiquidityAdded" dex
WHERE "_reserveToken" <> '\x1f573d6fb3f13d689ff844b4ce37794d79a7ff1c'
)
INSERT INTO labels.labels(address, name, type, author, source)
SELECT
    pool_address AS address,
    LOWER(CONCAT('Bancor LP ', t.symbol, ' - ', 'BNT')) AS label,
    'lp_pool_name' AS type,
    'masquot' AS author,
    'ethereum_mainnet_bancor_pools' AS source
FROM bancor_pools
INNER JOIN erc20.tokens t ON bancor_pools.token = t.contract_address
WHERE t.symbol IS NOT NULL
ON CONFLICT DO NOTHING ;
