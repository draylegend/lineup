DEFINE TABLE event SCHEMAFULL PERMISSIONS
  FOR select WHERE isPublic = true OR owner = $auth.id OR owner IN (SELECT VALUE out FROM member WHERE in = $auth.id AND accepted = true)
  FOR create WHERE $auth.id != NONE
  FOR update WHERE owner = $auth.id OR owner IN (SELECT VALUE out FROM member WHERE in = $auth.id AND role IN ['owner', 'admin'] AND accepted = true)
  FOR delete WHERE owner = $auth.id OR owner IN (SELECT VALUE out FROM member WHERE in = $auth.id AND role = 'owner' AND accepted = true);

DEFINE FIELD slug                 ON TABLE event TYPE string;
DEFINE FIELD title                ON TABLE event TYPE string;
DEFINE FIELD description          ON TABLE event TYPE option<string>;
DEFINE FIELD duration             ON TABLE event TYPE int;  -- minutes
DEFINE FIELD isPublic             ON TABLE event TYPE bool DEFAULT true;
DEFINE FIELD requiresConfirmation ON TABLE event TYPE bool DEFAULT false;
DEFINE FIELD locationType         ON TABLE event TYPE 'zoom' | 'meet' | 'phone' | 'inPerson' | 'custom';
DEFINE FIELD locationValue        ON TABLE event TYPE option<string>;
DEFINE FIELD schedulingType       ON TABLE event TYPE option<'roundRobin' | 'collective'>;
DEFINE FIELD beforeBuffer         ON TABLE event TYPE int DEFAULT 0;  -- minutes
DEFINE FIELD afterBuffer          ON TABLE event TYPE int DEFAULT 0;  -- minutes
DEFINE FIELD slotInterval         ON TABLE event TYPE option<int>;    -- null = use duration
DEFINE FIELD minimumNotice        ON TABLE event TYPE int DEFAULT 0;  -- minutes
DEFINE FIELD maxPerDay            ON TABLE event TYPE option<int>;
DEFINE FIELD owner                ON TABLE event TYPE record;         -- record<user> | record<team>
DEFINE FIELD schedule             ON TABLE event TYPE option<record<schedule>>;
DEFINE FIELD createdAt            ON TABLE event TYPE datetime DEFAULT time::now();
DEFINE FIELD updatedAt            ON TABLE event TYPE datetime VALUE time::now();
