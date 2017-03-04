DROP FUNCTION emergency_services_login(
  p_username TEXT, p_password TEXT
);

CREATE OR REPLACE FUNCTION emergency_services_login(
  p_username TEXT, p_password TEXT
)
  RETURNS TEXT
AS $$
DECLARE

BEGIN

  IF NOT exists(SELECT 1
                FROM emergency_services
                WHERE 1 = 1
                AND emergency_services.username = p_username
                AND emergency_services.password = p_password)
  THEN
    RAISE EXCEPTION 'Incorrect login';
  END IF;

  RETURN 1;

END;
$$ LANGUAGE plpgsql;

SELECT *
FROM emergency_services;
