DEFINE TABLE schedule SCHEMAFULL PERMISSIONS
  FOR select, create, update, delete WHERE owner = $auth.id;

DEFINE FIELD name      ON TABLE schedule TYPE string;
DEFINE FIELD timezone  ON TABLE schedule TYPE string  DEFAULT 'UTC';
DEFINE FIELD isDefault ON TABLE schedule TYPE bool    DEFAULT false;
DEFINE FIELD owner     ON TABLE schedule TYPE record<user>;
DEFINE FIELD createdAt ON TABLE schedule TYPE datetime DEFAULT time::now();
DEFINE FIELD updatedAt ON TABLE schedule TYPE datetime VALUE time::now();
