INSERT INTO labels.labels(address, name, type, author, source)
SELECT
    borrower AS address,
    lower(project) || ' user' AS label,
    'dapp usage' AS type,
    'hagaetc' AS author,
    'ethereum_mainnet_lending_users' AS source
FROM
    lending.borrow
UNION
SELECT
    borrower AS address,
    lower(project) || ' user' AS label,
    'dapp usage' AS type,
    'hagaetc' AS author,
    'ethereum_mainnet_lending_users' AS source
FROM
    lending.collateral_change
ON CONFLICT DO NOTHING ;
