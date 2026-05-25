DEFINE TABLE team SCHEMAFULL PERMISSIONS
  FOR select WHERE id IN (SELECT VALUE out FROM member WHERE in = $auth.id AND accepted = true)
  FOR create WHERE $auth.id != NONE
  FOR update WHERE id IN (SELECT VALUE out FROM member WHERE in = $auth.id AND role IN ['owner', 'admin'] AND accepted = true)
  FOR delete WHERE id IN (SELECT VALUE out FROM member WHERE in = $auth.id AND role = 'owner' AND accepted = true);

DEFINE FIELD slug      ON TABLE team TYPE string;
DEFINE FIELD name      ON TABLE team TYPE string;
DEFINE FIELD logo      ON TABLE team TYPE option<string>;
DEFINE FIELD bio       ON TABLE team TYPE option<string>;
DEFINE FIELD createdAt ON TABLE team TYPE datetime DEFAULT time::now();
DEFINE FIELD updatedAt ON TABLE team TYPE datetime VALUE time::now();

DEFINE INDEX uniqueSlug ON TABLE team COLUMNS slug UNIQUE;
