SELECT aave.insert_aave_tokens(
        NOW() - interval '3 days',
        NOW());

SELECT aave.insert_aave_daily_interest_rates(
        DATE_TRUNC('day',NOW()) - interval '3 days',
        DATE_TRUNC('day',NOW()) );

SELECT aave.insert_aave_daily_atoken_balances(
        DATE_TRUNC('day',NOW()) - interval '3 days',
        DATE_TRUNC('day',NOW()) );

SELECT aave.insert_aave_daily_liquidity_mining_rates(
        DATE_TRUNC('day',NOW()) - interval '3 days',
        DATE_TRUNC('day',NOW()) );

SELECT aave.insert_aave_daily_treasury_fees(
        DATE_TRUNC('day',NOW()) - interval '3 days',
        DATE_TRUNC('day',NOW()) );

SELECT aave.insert_aave_daily_treasury_events(
        DATE_TRUNC('day',NOW()) - interval '3 days',
        DATE_TRUNC('day',NOW()) );
