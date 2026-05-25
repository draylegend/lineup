DEFINE TABLE invite SCHEMAFULL PERMISSIONS
  FOR select WHERE email = $auth.email OR team IN (SELECT VALUE out FROM member WHERE in = $auth.id AND role IN ['owner', 'admin'] AND accepted = true)
  FOR create WHERE team IN (SELECT VALUE out FROM member WHERE in = $auth.id AND role IN ['owner', 'admin'] AND accepted = true)
  FOR update NONE
  FOR delete WHERE email = $auth.email OR team IN (SELECT VALUE out FROM member WHERE in = $auth.id AND role IN ['owner', 'admin'] AND accepted = true);

DEFINE FIELD team      ON TABLE invite TYPE record<team>;
DEFINE FIELD email     ON TABLE invite TYPE string   ASSERT string::is_email($value);
DEFINE FIELD role      ON TABLE invite TYPE 'admin' | 'member' DEFAULT 'member';
DEFINE FIELD token     ON TABLE invite TYPE string;
DEFINE FIELD expiresAt ON TABLE invite TYPE datetime;
DEFINE FIELD invitedBy ON TABLE invite TYPE record<user>;
DEFINE FIELD createdAt ON TABLE invite TYPE datetime DEFAULT time::now();

DEFINE INDEX uniqueToken ON TABLE invite COLUMNS token UNIQUE;
