CREATE OR REPLACE FUNCTION public.bytea2numericpy(a bytea)
    RETURNS numeric
AS $$
    return int.from_bytes(a, byteorder='big')
$$ LANGUAGE plpython3u IMMUTABLE STRICT;
