CREATE OR REPLACE FUNCTION public.numeric2bytea_old(a numeric)
  RETURNS bytea
AS $$
  return int(a).to_bytes(32, byteorder='big')
$$ LANGUAGE plpython3u IMMUTABLE STRICT;
