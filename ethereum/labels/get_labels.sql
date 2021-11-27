CREATE OR REPLACE FUNCTION labels."get"(_address BYTEA, _type TEXT)
RETURNS TEXT[]
LANGUAGE plpgsql AS
$$
DECLARE r TEXT[];
BEGIN
  SELECT array_agg(name) INTO r
  FROM labels.labels
  WHERE ((SELECT _type IS NULL) AND (address=_address)) OR ((SELECT _type IS NOT NULL) AND (type = _type) AND (address=_address));
  RETURN r;
END;
$$;
