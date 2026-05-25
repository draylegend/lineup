DEFINE TABLE integration SCHEMAFULL PERMISSIONS
  FOR select, create, update, delete WHERE owner = $auth.id;

DEFINE FIELD type         ON TABLE integration TYPE 'googleCalendar' | 'outlook' | 'zoom' | 'googleMeet' | 'teams';
DEFINE FIELD owner        ON TABLE integration TYPE record<user>;
DEFINE FIELD accessToken  ON TABLE integration TYPE string;
DEFINE FIELD refreshToken ON TABLE integration TYPE option<string>;
DEFINE FIELD expiresAt    ON TABLE integration TYPE option<datetime>;
DEFINE FIELD metadata     ON TABLE integration TYPE option<object>;
DEFINE FIELD createdAt    ON TABLE integration TYPE datetime DEFAULT time::now();
DEFINE FIELD updatedAt    ON TABLE integration TYPE datetime VALUE time::now();
