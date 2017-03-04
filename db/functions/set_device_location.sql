DROP FUNCTION set_device_location(
  id TEXT, lat DOUBLE PRECISION, lng DOUBLE PRECISION
);
CREATE OR REPLACE FUNCTION set_device_location(
  p_id TEXT, p_lat DOUBLE PRECISION, p_lng DOUBLE PRECISION
)
RETURNS INTEGER
AS $$
DECLARE

BEGIN

  IF exists(SELECT 1
            FROM devices
            WHERE id = p_id) THEN
    UPDATE devices SET lat = p_lat, lng = p_lng WHERE id = p_id;
  ELSE
    INSERT INTO devices (id, lat, lng) VALUES (p_id, p_lat, p_lng);
  END IF;

  RETURN 1;

END;
$$ LANGUAGE plpgsql;