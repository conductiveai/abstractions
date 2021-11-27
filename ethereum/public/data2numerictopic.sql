CREATE OR REPLACE FUNCTION public.data2numerictopic(data BYTEA, topic INT, decimals INT) RETURNS FLOAT AS $$
BEGIN
RETURN bytea2numeric(decode(SUBSTRING(ENCODE("data",'hex'),(9+(64*"topic")),64),'hex'))/POWER(10, "decimals");
END; $$
LANGUAGE PLPGSQL;