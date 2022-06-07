SELECT setprotocol_v2.insert_daily_component_prices(
        date_trunc('day', now()) - interval '3 days',
        date_trunc('day', now()) + interval '1 day');
