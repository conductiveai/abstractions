SELECT erc20.insert_weth_balance_changes(
        (SELECT max(hour) FROM erc20.weth_hourly_balance_changes) - interval '36 hours',
        date_trunc('hour', now()));

SELECT erc20.insert_weth_balances(
        date_trunc('hour', now()) - interval '36 hours');
