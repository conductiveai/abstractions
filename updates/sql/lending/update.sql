SELECT lending.insert_borrow((SELECT max(block_time) - interval '2 days' FROM lending.borrow), now() - interval '20 minutes', max_block_number_lt((SELECT max(block_time) - interval '2 days' FROM lending.borrow)), max_block_number_lt(now() - interval '20 minutes'));

SELECT lending.insert_collateral_changes((SELECT max(block_time) - interval '2 days' FROM lending.collateral_change), now() - interval '20 minutes', max_block_number_lt((SELECT max(block_time) - interval '2 days' FROM lending.collateral_change)), max_block_number_lt(now() - interval '20 minutes'));

SELECT lending.insert_liquidation((SELECT max(block_time) - interval '2 days' FROM lending.liquidation), now() - interval '20 minutes', max_block_number_lt((SELECT max(block_time) - interval '2 days' FROM lending.liquidation)), max_block_number_lt(now() - interval '20 minutes'));

SELECT lending.insert_repays((SELECT max(block_time) - interval '2 days' FROM lending.repay), now() - interval '20 minutes', max_block_number_lt((SELECT max(block_time) - interval '2 days' FROM lending.repay)), max_block_number_lt(now() - interval '20 minutes'));
