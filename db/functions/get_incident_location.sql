DROP FUNCTION get_incident_location();

CREATE FUNCTION get_incident_location() RETURNS SETOF incidents as 'SELECT *
                FROM incidents;' language 'sql';