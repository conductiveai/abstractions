SELECT aave.insert_aave_tokens(
        (SELECT NOW() - interval '1 year'),
        (SELECT NOW()));

SELECT aave.insert_aave_daily_interest_rates(
        (SELECT DATE_TRUNC('day',NOW()) - interval '3 days'),
        (SELECT DATE_TRUNC('day',NOW()) ));

SELECT aave.insert_aave_daily_atoken_balances(
        (SELECT DATE_TRUNC('day',NOW()) - interval '3 days'),
        (SELECT DATE_TRUNC('day',NOW()) ));

SELECT aave.insert_aave_daily_liquidity_mining_rates(
        (SELECT DATE_TRUNC('day',NOW()) - interval '3 days'),
        (SELECT DATE_TRUNC('day',NOW()) ));

SELECT aave.insert_aave_daily_treasury_fees(
        (SELECT DATE_TRUNC('day',NOW()) - interval '3 days'),
        (SELECT DATE_TRUNC('day',NOW()) ));

SELECT aave.insert_aave_daily_treasury_events(
        (SELECT DATE_TRUNC('day',NOW()) - interval '3 days'),
        (SELECT DATE_TRUNC('day',NOW()) ));
