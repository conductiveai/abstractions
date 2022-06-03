INSERT INTO labels.labels(address, name, type, author, source)
SELECT
    owner AS address,
    lower(name) AS label,
    'ens name' AS type,
    'hagaetc' AS author,
    'ethereum_mainnet_ens_names' AS source
FROM
    ethereumnameservice."ETHRegistrarController_1_evt_NameRegistered"
UNION
SELECT
    owner AS address,
    lower(name) AS label,
    'ens name' AS type,
    'hagaetc' AS author,
    'ethereum_mainnet_ens_names' AS source
FROM
    ethereumnameservice."ETHRegistrarController_2_evt_NameRegistered"
UNION
SELECT
    owner AS address,
    lower(name) AS label,
    'ens name' AS type,
    'hagaetc' AS author,
    'ethereum_mainnet_ens_names' AS source
FROM
    ethereumnameservice."ETHRegistrarController_3_evt_NameRegistered"
WHERE
    LENGTH(name) < 10000
ON CONFLICT DO NOTHING ;
