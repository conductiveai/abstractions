CREATE OR REPLACE FUNCTION public.bytea2numeric(a bytea, signed boolean = true, byteorder text = 'big')
    RETURNS numeric
AS $$
    return int.from_bytes(a, byteorder=byteorder, signed=signed)
$$ LANGUAGE plpython3u IMMUTABLE STRICT;
