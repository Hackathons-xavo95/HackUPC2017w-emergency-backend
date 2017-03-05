DROP FUNCTION get_device_location_by_id(id TEXT);

CREATE FUNCTION get_device_location_by_id(p_id TEXT) RETURNS SETOF devices as 'SELECT *
                FROM devices WHERE id = p_id;' language 'sql';