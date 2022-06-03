from datetime import datetime, date, timedelta

from airflow import models
from airflow.providers.postgres.operators.postgres import PostgresOperator

default_args = {
    "start_date": datetime(2022, 5, 25),
    "depends_on_past": True
}

with models.DAG(
    dag_id='label_updater',
    default_args=default_args,
    schedule_interval=timedelta(days=1),
    catchup=False,
    max_active_runs=1
) as dag:
    activity_type = PostgresOperator(
        task_id='activity-type-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/activity_type.sql'
    )

    balancer_arbitrage = PostgresOperator(
        task_id='balancer-arbitrage-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/balancer_arbitrage.sql'
    )

    balancer_pools = PostgresOperator(
        task_id='balancer-pools-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/balancer_pools.sql'
    )

    balancer_pools_general_format = PostgresOperator(
        task_id='balancer-pools-general_format-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/balancer_pools_general_format.sql'
    )

    balancer_v2_pools = PostgresOperator(
        task_id='balancer-v2-pools-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/balancer_v2_pools.sql'
    )

    bancor_pools = PostgresOperator(
        task_id='bancor-pools-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/bancor_pools.sql'
    )

    contracts = PostgresOperator(
        task_id='contracts-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/contracts.sql'
    )

    curve_pools = PostgresOperator(
        task_id='curve-pools-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/curve_pools.sql'
    )

    dex_traders = PostgresOperator(
        task_id='dex-traders-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/dex_traders.sql'
    )

    ens_name_reverse = PostgresOperator(
        task_id='ens-name-reverse-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/ens_name_reverse.sql'
    )

    ens_names = PostgresOperator(
        task_id='ens-names-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/ens_names.sql'
    )

    eth2_depositor = PostgresOperator(
        task_id='eth2-depositor-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/eth2_depositor.sql'
    )

    lending_users = PostgresOperator(
        task_id='lending-users-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/lending_users.sql'
    )

    mooniswap_and_1inch_pools = PostgresOperator(
        task_id='mooniswap-1inch-pools-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/mooniswap_and_1inch_pools.sql'
    )

    nft_activity_type = PostgresOperator(
        task_id='nft-activity_type-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/nft_activity_type.sql'
    )

    nft_users = PostgresOperator(
        task_id='nft-users-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/nft_users.sql'
    )

    nft_users_collections = PostgresOperator(
        task_id='nft-users-collections-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/nft_users_collections_traded.sql'
    )

    sushiswap_pools = PostgresOperator(
        task_id='sushiswap-pools-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/sushiswap_pools.sql'
    )

    uniswap_pools = PostgresOperator(
        task_id='uniswap-pools-task',
        postgres_conn_id='analytics-pg', 
        sql='sql/uniswap_pools.sql'
    )

    activity_type >> balancer_arbitrage >> balancer_pools >> balancer_pools_general_format >> balancer_v2_pools >> bancor_pools >> contracts >> curve_pools >> dex_traders >> ens_name_reverse >> ens_names >> eth2_depositor >> lending_users >> mooniswap_and_1inch_pools >> nft_activity_type >> nft_users >> nft_users_collections >> sushiswap_pools >> uniswap_pools
