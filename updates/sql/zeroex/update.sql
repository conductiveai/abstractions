SELECT zeroex.insert_api_data((SELECT max(block_time) from zeroex.view_api_affiliate_data) - interval '1 day', now()) ;

SELECT zeroex.insert_fills((SELECT max("timestamp") - interval '2 days' FROM zeroex.view_fills), now() - interval '20 minutes');

SELECT zeroex.insert_0x_api_fills((SELECT max(block_time) - interval '2 days' FROM zeroex.view_0x_api_fills), now() - interval '20 minutes');
