-- Graph edge: user -> event (which users host a given event)
DEFINE TABLE host SCHEMAFULL TYPE RELATION FROM user TO event PERMISSIONS
  FOR select WHERE in = $auth.id OR out.owner = $auth.id
  FOR create, update, delete WHERE out.owner = $auth.id;

DEFINE FIELD isFixed ON TABLE host TYPE bool DEFAULT false;
