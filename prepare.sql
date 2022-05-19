CREATE OR REPLACE FUNCTION labels.GET(address_ BYTEA, type_ TEXT)
RETURNS TEXT[]
STRICT IMMUTABLE LANGUAGE plpgsql AS
$$
DECLARE
  names TEXT[];
BEGIN
  SELECT ARRAY_AGG("name") INTO names
  FROM labels.labels
  WHERE address = address_ AND "type" = type_;
  RETURN names;
END;
$$;

CREATE OR REPLACE FUNCTION JARRAY2HEX(txt TEXT)
RETURNS TEXT
AS $$
    return '0x' + ''.join([format(int(c, 10), '02x') for c in txt.strip("[] ").split(",")])
$$ LANGUAGE plpython3u IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION TO_INTS(txt TEXT)
RETURNS INTEGER[]
STRICT IMMUTABLE LANGUAGE plpgsql AS
$$
BEGIN
  IF LEFT(txt, 1) = '{' THEN
      RETURN txt::INTEGER[];
	ELSE
      RETURN STRING_TO_ARRAY(txt, ',')::INTEGER[];
	END IF;
END;
$$;

CREATE OR REPLACE FUNCTION public.MAX_BLOCK_NUMBER_LT(block_timestamp TIMESTAMPTZ)
RETURNS BIGINT
STRICT IMMUTABLE LANGUAGE plpgsql AS
$$
DECLARE
  block_number BIGINT := 0;
  ts TIMESTAMP := block_timestamp;
BEGIN
  SELECT "number" INTO block_number
  FROM public.blocks
  WHERE "timestamp" < ts
  ORDER BY "timestamp" DESC
  LIMIT 1;
  RETURN block_number;
END;
$$;

CREATE OR REPLACE FUNCTION public.MAX_BLOCK_NUMBER_LE(block_timestamp TIMESTAMPTZ)
RETURNS BIGINT
STRICT IMMUTABLE LANGUAGE plpgsql AS
$$
DECLARE
  block_number BIGINT := 0;
  ts TIMESTAMP := block_timestamp;
BEGIN
  SELECT "number" INTO block_number
  FROM public.blocks
  WHERE "timestamp" <= ts
  ORDER BY "timestamp" DESC
  LIMIT 1;
  RETURN block_number;
END;
$$;

CREATE OR REPLACE FUNCTION public.TO_TEXT(bytes BYTEA)
RETURNS TEXT
STRICT IMMUTABLE LANGUAGE plpgsql AS
$$
BEGIN
  RETURN '0x' || ENCODE(bytes, 'hex');
END;
$$;

CREATE OR REPLACE FUNCTION public.TO_BYTEA(txt TEXT)
RETURNS BYTEA
STRICT IMMUTABLE LANGUAGE plpgsql AS
$$
BEGIN
  RETURN DECODE(SUBSTR(txt, 3), 'hex');
END;
$$;

DO $$ BEGIN
    CREATE CAST (BYTEA AS TEXT) WITH FUNCTION public.TO_TEXT(BYTEA) AS IMPLICIT;
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE CAST (BYTEA AS VARCHAR) WITH FUNCTION public.TO_TEXT(BYTEA) AS IMPLICIT;
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE CAST (TEXT AS BYTEA) WITH FUNCTION public.TO_BYTEA(TEXT) AS IMPLICIT;
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;
DO $$ BEGIN
    CREATE CAST (VARCHAR AS BYTEA) WITH FUNCTION public.TO_BYTEA(TEXT) AS IMPLICIT;
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

CREATE SCHEMA IF NOT EXISTS "ethereum";

CREATE OR REPLACE VIEW ethereum.blocks AS
  SELECT "timestamp" AS "time", "number", hash, base_fee_per_gas FROM public.blocks;

CREATE OR REPLACE VIEW ethereum.transactions AS
  SELECT hash, from_address AS "from", to_address AS "to", "value", transaction_index AS "index", DECODE(SUBSTRING("input", 3), 'hex')::BYTEA AS data, block_timestamp AS block_time, block_number, gas_price, receipt_status::INT::BOOL AS success, receipt_gas_used AS gas_used FROM public.transactions;

CREATE OR REPLACE VIEW ethereum.logs AS
  SELECT log_index AS "index", transaction_hash AS tx_hash, address AS contract_address, DECODE(SUBSTRING(topic0, 3), 'hex')::BYTEA AS topic1, DECODE(SUBSTRING(topic1, 3), 'hex')::BYTEA AS topic2, DECODE(SUBSTRING(topic2, 3), 'hex')::BYTEA AS topic3, DECODE(SUBSTRING(topic3, 3), 'hex')::BYTEA AS topic4, DECODE(SUBSTRING("data", 3), 'hex')::BYTEA AS "data", block_timestamp AS block_time, block_number FROM public.logs;

CREATE OR REPLACE VIEW ethereum.traces AS
  SELECT transaction_hash AS tx_hash, block_number, block_timestamp AS block_time, from_address AS "from", to_address AS "to", value, DECODE(SUBSTRING(input, 3), 'hex') AS input, TO_INTS(trace_address::text) AS trace_address, call_type, trace_type AS type, status::BOOLEAN AS success, gas_used, subtraces::INTEGER AS sub_traces FROM public.traces;

CREATE OR REPLACE FUNCTION public.numeric2bytea_old(a numeric)
  RETURNS bytea
AS $$
  return int(a).to_bytes(32, byteorder='big')
$$ LANGUAGE plpython3u IMMUTABLE STRICT;

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

CREATE SCHEMA IF NOT EXISTS "nft";
CREATE SCHEMA IF NOT EXISTS "dex";
CREATE SCHEMA IF NOT EXISTS "setprotocol_v2";
CREATE SCHEMA IF NOT EXISTS "rari_capital";
CREATE SCHEMA IF NOT EXISTS "uniswap_merkle";
CREATE SCHEMA IF NOT EXISTS "index";
CREATE SCHEMA IF NOT EXISTS "indexed_finance";
CREATE SCHEMA IF NOT EXISTS "integral_size";
CREATE SCHEMA IF NOT EXISTS "balancer_v1";
CREATE SCHEMA IF NOT EXISTS "token_balances";
CREATE SCHEMA IF NOT EXISTS "erasure_bay";
CREATE SCHEMA IF NOT EXISTS "stablecoin";
CREATE SCHEMA IF NOT EXISTS "erasure_quant";
CREATE SCHEMA IF NOT EXISTS "uniswap_v1";
CREATE SCHEMA IF NOT EXISTS "lending";
CREATE SCHEMA IF NOT EXISTS "erasure_numerai";

CREATE UNIQUE INDEX IF NOT EXISTS uniqe_job ON cron.job USING btree (command);
CREATE UNIQUE INDEX IF NOT EXISTS unique_command ON cron.job USING btree (command);
CREATE UNIQUE INDEX IF NOT EXISTS jobname_username_uniq ON cron.job USING btree (jobname, username);

CREATE OR REPLACE FUNCTION public.hex_to_int(hexval TEXT)
RETURNS INTEGER AS $$
DECLARE result int;
BEGIN
  EXECUTE 'SELECT x' || quote_literal(hexval) || '::int' INTO result;
  RETURN result;
END;
$$
LANGUAGE PLPGSQL;
