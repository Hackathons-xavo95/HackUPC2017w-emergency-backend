DROP FUNCTION users_login(
  p_username TEXT, p_password TEXT
);

CREATE OR REPLACE FUNCTION users_login(
  p_username TEXT, p_password TEXT
)
  RETURNS TEXT
AS $$
DECLARE

BEGIN

  IF NOT exists(SELECT 1
                FROM users
                WHERE 1 = 1
                AND users.username = p_username
                AND users.password = p_password)
  THEN
    RAISE EXCEPTION 'Incorrect login';
  END IF;

  RETURN 1;

END;
$$ LANGUAGE plpgsql;

SELECT *
FROM users;
