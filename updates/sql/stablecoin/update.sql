SELECT stablecoin.insert_burn(
  (SELECT max(block_time) - interval '2 days' FROM stablecoin.burn),
  now(),
  max_block_number_lt((SELECT max(block_time) - interval '2 days' FROM stablecoin.burn)),
  (SELECT MAX(number) FROM ethereum.blocks)
);

SELECT stablecoin.insert_mint(
  (SELECT max(block_time) - interval '2 days' FROM stablecoin.mint),
  now(),
  max_block_number_lt((SELECT max(block_time) - interval '2 days' FROM stablecoin.mint)),
  (SELECT MAX(number) FROM ethereum.blocks)
);

SELECT stablecoin.insert_transfer(
  (SELECT max(block_time) - interval '2 days' FROM stablecoin.transfer),
  now(),
  max_block_number_lt((SELECT max(block_time) - interval '2 days' FROM stablecoin.transfer)),
  (SELECT MAX(number) FROM ethereum.blocks)
);
