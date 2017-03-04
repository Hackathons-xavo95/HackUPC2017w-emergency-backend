DROP FUNCTION set_incident_location(
  id TEXT, lat DOUBLE PRECISION, lng DOUBLE PRECISION, radius DOUBLE PRECISION
);

CREATE OR REPLACE FUNCTION set_incident_location(
  p_name TEXT, p_lat DOUBLE PRECISION, p_lng DOUBLE PRECISION, p_radius DOUBLE PRECISION
)
RETURNS INTEGER
AS $$
DECLARE

BEGIN

  IF exists(SELECT 1
            FROM incidents
            WHERE id = p_name) THEN
    UPDATE incidents SET lat = p_lat, lng = p_lng, radius = p_radius WHERE id = p_name;
  ELSE
    INSERT INTO incidents (id, lat, lng, radius) VALUES (p_name, p_lat, p_lng, p_radius);
  END IF;

  RETURN 1;

END;
$$ LANGUAGE plpgsql;