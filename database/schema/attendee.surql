DEFINE TABLE attendee SCHEMAFULL PERMISSIONS
  FOR select WHERE email = $auth.email OR booking.host = $auth.id
  FOR create WHERE $auth.id != NONE
  FOR update NONE
  FOR delete WHERE booking.host = $auth.id;

DEFINE FIELD booking  ON TABLE attendee TYPE record<booking>;
DEFINE FIELD name     ON TABLE attendee TYPE string;
DEFINE FIELD email    ON TABLE attendee TYPE string ASSERT string::is_email($value);
DEFINE FIELD timezone ON TABLE attendee TYPE option<string>;
DEFINE FIELD isHost   ON TABLE attendee TYPE bool DEFAULT false;
