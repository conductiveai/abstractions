INSERT INTO labels.labels(address, name, type, author, source)
SELECT
    address,
    lower(name) AS label,
    'contract_name' AS type,
    'dune' AS author,
    'ethereum_mainnet_contracts' AS source
FROM
    ethereum.contracts
WHERE
    address IS NOT NULL
UNION
SELECT
    address,
    lower(namespace) AS label,
    'project' AS type,
    'dune' AS author,
    'ethereum_mainnet_contracts' AS source
FROM
    ethereum.contracts
WHERE
    address IS NOT NULL
ON CONFLICT DO NOTHING ;
