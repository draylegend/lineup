DEFINE ACCESS user ON DATABASE TYPE RECORD
  SIGNUP (
    CREATE user SET
      email     = $email,
      password  = crypto::argon2::generate($password),
      username  = $username,
      firstName = $firstName,
      lastName  = $lastName,
      timezone  = $timezone OR 'UTC',
      locale    = $locale OR 'en'
  )
  SIGNIN (
    SELECT * FROM user
    WHERE email = $email
    AND crypto::argon2::compare(password, $password)
  )
  WITH REFRESH
  DURATION FOR GRANT 30d, FOR TOKEN 15m, FOR SESSION 12h;
