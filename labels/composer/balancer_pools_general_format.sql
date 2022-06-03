-- Re-use existing labels added by Balancer team
-- Add 'Balancer' and version to name 
-- Use label type 'lp_pool_name' 

-- Main Query
INSERT INTO labels.labels(address, name, type, author, source)
SELECT
    address,
    LOWER(CONCAT('Balancer v1 LP ', name)) AS label,
    'lp_pool_name' AS type,
    'masquot' AS author,
    'ethereum_mainnet_balancer_pools_general_format' AS source
FROM (SELECT * FROM labels.labels WHERE type = 'balancer_pool') b1
UNION ALL
SELECT
    address,
    LOWER(CONCAT('Balancer v2 LP ', name)) AS label,
    'lp_pool_name' AS type,
    'masquot' AS author,
    'ethereum_mainnet_balancer_pools_general_format' AS source
FROM (SELECT * FROM labels.labels WHERE type = 'balancer_v2_pool') b2
ON CONFLICT DO NOTHING ;
