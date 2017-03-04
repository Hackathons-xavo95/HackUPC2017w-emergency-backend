DROP FUNCTION admins_register(
  email TEXT, username TEXT, password TEXT
);
CREATE OR REPLACE FUNCTION admins_register(
  p_email TEXT, p_username TEXT, p_password TEXT
)
RETURNS INTEGER
AS $$
DECLARE

  new_admins_id INTEGER;

BEGIN

  IF exists(SELECT 1
            FROM admins
            WHERE username = p_username) THEN
    RAISE EXCEPTION 'User already exists';
  END IF;

  INSERT INTO admins
    (id, email, username, password)
  VALUES
    (DEFAULT, p_email, p_username, p_password)
  RETURNING id INTO new_admins_id;

  RETURN 1;

END;
$$ LANGUAGE plpgsql;