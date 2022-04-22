CREATE SCHEMA IF NOT EXISTS "prices";

CREATE TABLE IF NOT EXISTS "prices"."layer1_usd" (
  "minute" TIMESTAMP WITH TIME ZONE NOT NULL,
  "price" DOUBLE PRECISION NOT NULL,
  "symbol" TEXT NOT NULL,
  PRIMARY KEY(symbol, minute)
);

CREATE INDEX IF NOT EXISTS l1_asset_time ON prices.layer1_usd USING btree (symbol, minute DESC) INCLUDE (price);
CREATE INDEX IF NOT EXISTS l1_time ON prices.layer1_usd USING btree (minute DESC, symbol) INCLUDE (price);

CREATE TABLE IF NOT EXISTS "prices"."usd" (
  "minute" TIMESTAMP WITH TIME ZONE NOT NULL,
  "price" DOUBLE PRECISION NOT NULL,
  "decimals" SMALLINT NOT NULL,
  "contract_address" BYTEA NOT NULL,
  "symbol" TEXT NOT NULL,
  PRIMARY KEY(contract_address, minute)
);

CREATE INDEX IF NOT EXISTS usd_address_time ON prices.usd USING btree (contract_address, minute DESC) INCLUDE (price);
CREATE INDEX IF NOT EXISTS usd_symbol_time ON prices.usd USING btree (symbol, minute DESC);
CREATE INDEX IF NOT EXISTS usd_time ON prices.usd USING btree (minute DESC, contract_address) INCLUDE (price);
