DROP FUNCTION get_device_location();

CREATE FUNCTION get_device_location() RETURNS SETOF devices as 'SELECT *
                FROM devices;' language 'sql';