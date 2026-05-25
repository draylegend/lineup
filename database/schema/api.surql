DEFINE TABLE api SCHEMAFULL PERMISSIONS
  FOR select, create, update, delete WHERE owner = $auth.id;

DEFINE FIELD owner     ON TABLE api TYPE record<user>;
DEFINE FIELD key       ON TABLE api TYPE string;
DEFINE FIELD label     ON TABLE api TYPE string;
DEFINE FIELD expiresAt ON TABLE api TYPE option<datetime>;
DEFINE FIELD createdAt ON TABLE api TYPE datetime DEFAULT time::now();

DEFINE INDEX uniqueKey ON TABLE api COLUMNS key UNIQUE;
