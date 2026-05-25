DEFINE TABLE user SCHEMAFULL PERMISSIONS
  FOR select WHERE id = $auth.id
  FOR create NONE  -- via DEFINE ACCESS signup only
  FOR update WHERE id = $auth.id
  FOR delete NONE;

DEFINE FIELD email     ON TABLE user TYPE string  ASSERT string::is_email($value);
DEFINE FIELD username  ON TABLE user TYPE string;
DEFINE FIELD firstName ON TABLE user TYPE string;
DEFINE FIELD lastName  ON TABLE user TYPE string;
DEFINE FIELD password  ON TABLE user TYPE option<string>;
DEFINE FIELD avatar    ON TABLE user TYPE option<string>;
DEFINE FIELD timezone  ON TABLE user TYPE string  DEFAULT 'UTC';
DEFINE FIELD locale    ON TABLE user TYPE string  DEFAULT 'en';
DEFINE FIELD createdAt ON TABLE user TYPE datetime DEFAULT time::now();
DEFINE FIELD updatedAt ON TABLE user TYPE datetime VALUE time::now();

DEFINE INDEX uniqueEmail    ON TABLE user COLUMNS email    UNIQUE;
DEFINE INDEX uniqueUsername ON TABLE user COLUMNS username UNIQUE;
