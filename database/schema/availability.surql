DEFINE TABLE availability SCHEMAFULL PERMISSIONS
  FOR select, create, update, delete WHERE schedule.owner = $auth.id;

DEFINE FIELD schedule            ON TABLE availability TYPE record<schedule>;
DEFINE FIELD dayOfWeek           ON TABLE availability TYPE int ASSERT $value >= 0 AND $value <= 6;
DEFINE FIELD ranges              ON TABLE availability TYPE array<object>;
DEFINE FIELD ranges.*.startTime ON TABLE availability TYPE string;
DEFINE FIELD ranges.*.endTime   ON TABLE availability TYPE string;
