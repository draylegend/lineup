-- Graph edge: user -> team
DEFINE TABLE member SCHEMAFULL TYPE RELATION FROM user TO team PERMISSIONS
  FOR select WHERE in = $auth.id OR out IN (SELECT VALUE out FROM member WHERE in = $auth.id AND accepted = true)
  FOR create WHERE out IN (SELECT VALUE out FROM member WHERE in = $auth.id AND role IN ['owner', 'admin'] AND accepted = true)
  FOR update WHERE out IN (SELECT VALUE out FROM member WHERE in = $auth.id AND role IN ['owner', 'admin'] AND accepted = true)
  FOR delete WHERE in = $auth.id OR out IN (SELECT VALUE out FROM member WHERE in = $auth.id AND role IN ['owner', 'admin'] AND accepted = true);

DEFINE FIELD role      ON TABLE member TYPE 'owner' | 'admin' | 'member' DEFAULT 'member';
DEFINE FIELD accepted  ON TABLE member TYPE bool     DEFAULT false;
DEFINE FIELD createdAt ON TABLE member TYPE datetime DEFAULT time::now();
