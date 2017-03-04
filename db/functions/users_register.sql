DROP FUNCTION users_register(
  email TEXT, username TEXT, password TEXT
);
CREATE OR REPLACE FUNCTION users_register(
  p_email TEXT, p_username TEXT, p_password TEXT
)
RETURNS INTEGER
AS $$
DECLARE

  new_users_id INTEGER;

BEGIN

  IF exists(SELECT 1
            FROM users
            WHERE username = p_username) THEN
    RAISE EXCEPTION 'User already exists';
  END IF;

  INSERT INTO users
    (id, email, username, password)
  VALUES
    (DEFAULT, p_email, p_username, p_password)
  RETURNING id INTO new_users_id;

  RETURN 1;

END;
$$ LANGUAGE plpgsql;