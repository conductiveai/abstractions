SELECT nft.insert_cryptopunks(
        (SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='LarvaLabs Contract'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='LarvaLabs Contract')),
        max_block_number_lt(now() - interval '20 minutes'));

SELECT nft.insert_foundation(
        (SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='Foundation'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='Foundation')),
        max_block_number_lt(now() - interval '20 minutes'));

SELECT nft.insert_rarible(
        (SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='Rarible'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='Rarible')),
        max_block_number_lt(now() - interval '20 minutes'));

SELECT nft.insert_superrare(
        (SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='SuperRare'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='SuperRare')),
        max_block_number_lt(now() - interval '20 minutes'));

SELECT nft.insert_looksrare(
        (SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='LooksRare'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='LooksRare')),
        max_block_number_lt(now() - interval '20 minutes'));

SELECT nft.insert_nftx(
        (SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='NFTX'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='NFTX')),
        max_block_number_lt(now() - interval '20 minutes'));

SELECT nft.insert_opensea(
        (SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='OpenSea'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '6 hours' FROM nft.trades WHERE platform='OpenSea')),
        max_block_number_lt(now() - interval '20 minutes'));
