SELECT yearn.insert_yearn_transactions(
        (SELECT MAX(evt_block_time) - interval '1 days' FROM yearn.transactions),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT MAX(evt_block_time) - interval '1 days' FROM yearn.transactions)),
        max_block_number_lt(now() - interval '20 minutes')
);
