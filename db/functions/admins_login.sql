DROP FUNCTION admins_login(
  p_username TEXT, p_password TEXT
);

CREATE OR REPLACE FUNCTION admins_login(
  p_username TEXT, p_password TEXT
)
  RETURNS TEXT
AS $$
DECLARE

BEGIN

  IF NOT exists(SELECT 1
                FROM admins
                WHERE 1 = 1
                AND admins.username = p_username
                AND admins.password = p_password)
  THEN
    RAISE EXCEPTION 'Incorrect login';
  END IF;

  RETURN 1;

END;
$$ LANGUAGE plpgsql;

SELECT *
FROM admins;
