CREATE OR REPLACE VIEW erc20.view_token_balances_daily AS
with days as (
    select day from generate_series('2015-01-01', date_trunc('day', NOW()), '1 day') g(day)
),
b as (
    SELECT 
    tb.wallet_address,
    tb.token_address,
    tb.amount_raw,
    date_trunc('day', timestamp) as day,
    lead(date_trunc('day', timestamp), 1, now()) OVER (PARTITION BY token_address, wallet_address ORDER BY timestamp) AS next_day 
    FROM erc20.token_balances tb
)
SELECT 
    d.day,
    b.wallet_address, 
    b.token_address, 
    b.amount_raw,
    t.symbol as token_symbol,
    amount_raw / 10^t.decimals amount,
    amount_raw / 10^t.decimals * p.price amount_usd
FROM b
INNER JOIN days d ON b.day <= d.day AND d.day < b.next_day 
left join erc20.tokens t on t.contract_address = token_address
left join prices.usd p on p.contract_address = token_address and p.minute = d.day
