SELECT synthetix.insert_rates((SELECT max(block_time) FROM synthetix.rates)) ;

SELECT synthetix.insert_symbols((SELECT max(block_time) FROM synthetix.symbols)) ;

SELECT synthetix.insert_synths((SELECT max(block_time) FROM synthetix.synths)) ;

SELECT synthetix.insert_trades((SELECT max(block_time) FROM synthetix.trades)) ;
