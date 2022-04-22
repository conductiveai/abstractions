CREATE SCHEMA IF NOT EXISTS "erc20";

CREATE TABLE IF NOT EXISTS "erc20"."token_balances" (
  "timestamp" TIMESTAMP WITH TIME ZONE NOT NULL,
  "wallet_address" BYTEA NOT NULL,
  "token_address" BYTEA NOT NULL,
  "token_symbol" TEXT,
  "amount_raw" NUMERIC,
  "amount" NUMERIC,
  PRIMARY KEY("timestamp", wallet_address, token_address)
);

CREATE INDEX IF NOT EXISTS token_balances_wallet_address_token_address_idx ON erc20.token_balances USING btree (wallet_address, token_address);
CREATE INDEX IF NOT EXISTS token_balances_wallet_address_token_address_timestamp_desc_idx ON erc20.token_balances USING btree (wallet_address, token_address, "timestamp" DESC) INCLUDE (amount);
CREATE INDEX IF NOT EXISTS token_balances_timestamp_idx ON erc20.token_balances USING btree ("timestamp");
CREATE INDEX IF NOT EXISTS token_balances_token_address_wallet_address_idx ON erc20.token_balances USING btree (token_address, wallet_address);
