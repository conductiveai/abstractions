from datetime import datetime, date, timedelta

from airflow import models
from airflow.providers.postgres.operators.postgres import PostgresOperator

default_args = {
    "start_date": datetime(2022, 6, 7),
    "depends_on_past": True
}

with models.DAG(
    dag_id='abstractions_updater',
    default_args=default_args,
    schedule_interval='@daily',
    catchup=False,
    max_active_runs=1
) as dag:
    aave_update = PostgresOperator(
        task_id='aave-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/aave/update.sql',
        dag=dag
    )
    async_art_v2_update = PostgresOperator(
        task_id='async_art_v2-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/async_art_v2/update.sql',
        dag=dag
    )
    balancer_update = PostgresOperator(
        task_id='balancer-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/balancer/update.sql',
        dag=dag
    )
    erc20_update = PostgresOperator(
        task_id='erc20-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/erc20/update.sql',
        dag=dag
    )
    gnosis_update = PostgresOperator(
        task_id='gnosis-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/gnosis/update.sql',
        dag=dag
    )
    lending_update = PostgresOperator(
        task_id='lending-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/lending/update.sql',
        dag=dag
    )
    nft_update_trades = PostgresOperator(
        task_id='nft-update-trades-task',
        postgres_conn_id='analytics-pg',
        sql='sql/nft/update-trades.sql',
        dag=dag
    )
    nft_update = PostgresOperator(
        task_id='nft-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/nft/update.sql',
        dag=dag
    )
    dex_prices_update = PostgresOperator(
        task_id='dex-prices-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/prices/update.sql',
        dag=dag
    )
    setprotocol_v2_update = PostgresOperator(
        task_id='setprotocol_v2-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/setprotocol_v2/update.sql',
        dag=dag
    )
    stablecoin_update = PostgresOperator(
        task_id='stablecoin-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/stablecoin/update.sql',
        dag=dag
    )
    synthetix_update = PostgresOperator(
        task_id='synthetix-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/synthetix/update.sql',
        dag=dag
    )
    token_balances_update = PostgresOperator(
        task_id='token_balances-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/token_balances/update.sql',
        dag=dag
    )
    yearn_update = PostgresOperator(
        task_id='yearn-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/yearn/update.sql',
        dag=dag
    )
    zeroex_update = PostgresOperator(
        task_id='zeroex-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/zeroex/update.sql',
        dag=dag
    )
    dex_update_trades = PostgresOperator(
        task_id='dex-update-trades-task',
        postgres_conn_id='analytics-pg',
        sql='sql/dex/update-trades.sql',
        dag=dag
    )
    dex_update = PostgresOperator(
        task_id='dex-update-task',
        postgres_conn_id='analytics-pg',
        sql='sql/dex/update.sql',
        dag=dag
    )

    dex_update_trades.set_upstream([balancer_update, gnosis_update, synthetix_update, zeroex_update])
    dex_update.set_upstream(dex_update_trades)
    dex_prices_update.set_upstream(dex_update_trades)
    nft_update.set_upstream(nft_update_trades)
