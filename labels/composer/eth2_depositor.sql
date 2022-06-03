INSERT INTO labels.labels(address, name, type, author, source)
SELECT DISTINCT
    "from" AS address,
    'eth2 depositor' AS label,
    'eth2 actions' AS type,
    'hagaetc' AS author,
    'ethereum_mainnet_eth2_depositor' AS source
FROM
    ethereum."traces"
WHERE block_number >= 11182202
AND "to" = '0x00000000219ab540356cbb839cbe05303d7705fa'
AND success
ON CONFLICT DO NOTHING ;
