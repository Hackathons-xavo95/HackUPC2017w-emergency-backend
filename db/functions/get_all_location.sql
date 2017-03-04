DROP FUNCTION get_all_location();

CREATE FUNCTION get_all_location() RETURNS SETOF incidents as 'SELECT id, lat, lng, NULL AS radius
                FROM devices UNION SELECT * FROM incidents;' language 'sql';