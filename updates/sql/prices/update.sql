SELECT prices.insert_prices_from_dex_data(
        date_trunc('hour', now()) - interval '3 days',
        date_trunc('hour', now()));
