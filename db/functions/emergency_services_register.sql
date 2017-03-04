DROP FUNCTION emergency_services_register(
  email TEXT, username TEXT, password TEXT
);
CREATE OR REPLACE FUNCTION emergency_services_register(
  p_email TEXT, p_username TEXT, p_password TEXT
)
RETURNS INTEGER
AS $$
DECLARE

  new_emergency_service_id INTEGER;

BEGIN

  IF exists(SELECT 1
            FROM emergency_services
            WHERE username = p_username) THEN
    RAISE EXCEPTION 'User already exists';
  END IF;

  INSERT INTO emergency_services
    (id, email, username, password)
  VALUES
    (DEFAULT, p_email, p_username, p_password)
  RETURNING id INTO new_emergency_service_id;

  RETURN 1;

END;
$$ LANGUAGE plpgsql;