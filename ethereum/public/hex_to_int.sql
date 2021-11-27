CREATE OR REPLACE FUNCTION public.hex_to_int(hexval TEXT)
RETURNS INTEGER AS $$
DECLARE result int;
BEGIN
  EXECUTE 'SELECT x' || quote_literal(hexval) || '::int' INTO result;
  RETURN result;
END;
$$
LANGUAGE PLPGSQL;
