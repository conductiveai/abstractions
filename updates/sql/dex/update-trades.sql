    SELECT dex.insert_airswap(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='airswap'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='airswap')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_loopring(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Loopring'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Loopring')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_integral_size(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Integral'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Integral')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_indexed_finance(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Indexed Finance'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Indexed Finance')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_gnosis_protocol(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Gnosis Protocol'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Gnosis Protocol')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_futureswap(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Futureswap'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Futureswap')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_dfx_finance(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='DFX Finance'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='DFX Finance')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_defiplaza(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='DefiPlaza'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='DefiPlaza')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_ddex(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='DDEX'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='DDEX')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_convergence(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Convergence' AND version = '1'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Convergence' AND version = '1')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_cofix(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Cofix'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Cofix')),
        max_block_number_lt(now() - interval '20 minutes'));

--    SELECT dex.insert_1inch(
--        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='1inch'),
--        now() - interval '20 minutes',
--        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='1inch')),
--        max_block_number_lt(now() - interval '20 minutes'));

--    SELECT dex.insert_hashflow(
--        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='hashflow'),
--        now() - interval '20 minutes',
--        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='hashflow')),
--        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_1inch_lp(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='1inch LP'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='1inch LP')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_clipper(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Clipper'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Clipper')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_dodo(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='DODO'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='DODO')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_dydx(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='dYdX'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='dYdX')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_defi_swap(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Defi Swap'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Defi Swap')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_curve(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Curve'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Curve')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_mistx(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='mistX'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='mistX')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_linkswap(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='LINKSWAP'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='LINKSWAP')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_luaswap(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='LuaSwap'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='LuaSwap')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_kyber(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Kyber'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Kyber')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_mstable(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='mStable'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='mStable')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_saddle(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Saddle'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Saddle')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_mooniswap(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Mooniswap'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Mooniswap')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_powerindex(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='PowerIndex'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='PowerIndex')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_oasis(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Oasis'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Oasis')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_sfinance(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='S.finance'),
        (SELECT now()),
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='S.finance')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_sakeswap(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Sakeswap'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Sakeswap')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_shell(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Shell'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Shell')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_smoothy_finance(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Smoothy Finance'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Smoothy Finance')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_swapr(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='swapr'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='swapr')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_unifi(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Unifi'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Unifi')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_xsigma(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='xSigma'),
        (SELECT now()),
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='xSigma')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_paraswap(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Paraswap'),
        (SELECT now()),
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Paraswap')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_bancor(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Bancor Network'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Bancor Network')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_tokenlon_dex(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project = 'Tokenlon'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project = 'Tokenlon')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_shibaswap(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Shibaswap'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Shibaswap')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_uniswap_v1(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Uniswap' AND version = '1'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Uniswap' AND version = '1')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_uniswap_v2(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Uniswap' AND version = '2'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Uniswap' AND version = '2')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_uniswap_v3(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Uniswap' AND version = '3'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Uniswap' AND version = '3')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_synthetix(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Synthetix'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Synthetix')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_balancer(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Balancer'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Balancer')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_idex(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='IDEX'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='IDEX')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_sushi(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Sushiswap'),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project='Sushiswap')),
        max_block_number_lt(now() - interval '20 minutes'));

    SELECT dex.insert_zeroex(
        (SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project IN ('0x Native', '0x API', 'Matcha')),
        now() - interval '20 minutes',
        max_block_number_lt((SELECT max(block_time) - interval '1 days' FROM dex.trades WHERE project IN ('0x Native', '0x API', 'Matcha'))),
        max_block_number_lt(now() - interval '20 minutes'));
