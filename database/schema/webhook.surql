DEFINE TABLE webhook SCHEMAFULL PERMISSIONS
  FOR select, create, update, delete WHERE owner = $auth.id;

DEFINE FIELD owner     ON TABLE webhook TYPE record<user>;
DEFINE FIELD event     ON TABLE webhook TYPE option<record<event>>;  -- null = global
DEFINE FIELD url       ON TABLE webhook TYPE string;
DEFINE FIELD secret    ON TABLE webhook TYPE option<string>;
DEFINE FIELD triggers  ON TABLE webhook TYPE array<string>;
DEFINE FIELD active    ON TABLE webhook TYPE bool DEFAULT true;
DEFINE FIELD createdAt ON TABLE webhook TYPE datetime DEFAULT time::now();
