DEFINE TABLE booking SCHEMAFULL PERMISSIONS
  FOR select WHERE host = $auth.id OR id IN (SELECT VALUE booking FROM attendee WHERE email = $auth.email)
  FOR create WHERE $auth.id != NONE
  FOR update WHERE host = $auth.id
  FOR delete NONE;  -- use status = 'cancelled' instead

DEFINE FIELD uid          ON TABLE booking TYPE string;
DEFINE FIELD status       ON TABLE booking TYPE 'pending' | 'confirmed' | 'cancelled' | 'noShow' DEFAULT 'pending';
DEFINE FIELD startAt      ON TABLE booking TYPE datetime;
DEFINE FIELD endAt        ON TABLE booking TYPE datetime;
DEFINE FIELD title        ON TABLE booking TYPE string;
DEFINE FIELD description  ON TABLE booking TYPE option<string>;
DEFINE FIELD location     ON TABLE booking TYPE option<string>;
DEFINE FIELD cancelReason ON TABLE booking TYPE option<string>;
DEFINE FIELD event        ON TABLE booking TYPE record<event>;
DEFINE FIELD host         ON TABLE booking TYPE record<user>;
DEFINE FIELD createdAt    ON TABLE booking TYPE datetime DEFAULT time::now();
DEFINE FIELD updatedAt    ON TABLE booking TYPE datetime VALUE time::now();

DEFINE INDEX uniqueUid ON TABLE booking COLUMNS uid UNIQUE;
