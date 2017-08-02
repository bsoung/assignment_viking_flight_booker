 TABLE users (
    id integer NOT NULL,
    city_id integer NOT NULL,
    state_id integer NOT NULL,
    username character varying NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    email character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

 TABLE states (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

SELECT first_name, last_name
	FROM users JOIN states ON users.state_id = states.id
	WHERE name = 'California';

SELECT long_name
FROM airports JOIN cities ON city_id = cities.id
WHERE cities.name = 'Lake Ashley';

SELECT payment_method
FROM itineraries JOIN users ON users.id = itineraries.user_id
WHERE email = 'hansen.lawson@marvin.io';

SELECT price
FROM airports JOIN flights ON origin_id = airports.id
WHERE long_name = 'Matildechester Probably International Airport';

SELECT long_name, code
FROM airports JOIN flights ON flights.origin_id = airports.id
WHERE flights.destination_id = (
  SELECT airports.id
  FROM airports JOIN flights ON flights.destination_id = airports.id
  WHERE airports.code = 'PHL'
  GROUP BY airports.id
);

SELECT long_name, code
FROM airports JOIN flights ON flights.destination_id = airports.id
WHERE flights.origin_id = (
  SELECT airports.id
  FROM airports JOIN flights ON flights.origin_id = airports.id
  WHERE airports.code = 'PHL'
  GROUP BY airports.id
);

-- Find a list of all Airport names and codes which connect to the airport coded LYT.

-- //flight.origin_id = PHL(num) get destination_id (airport name)
-- //flight.destination_id = PHL(num) get origin_id (airport name)

-- Get a list of all airports visited by user Zackery Adams after January 1, 2012. 
-- (Hint, see if you can get a list of all ticket IDs first).


-- NESTED --

-- SELECT long_name 
--   FROM airports JOIN flights
--   WHERE airports.id = (
--     SELECT destination_id
--     FROM flights JOIN tickets ON tickets.id = tickets.flight_id

--     WHERE tickets.itinerary_id = (
--       SELECT itineraries.id
--       FROM itineraries JOIN users ON user_id = users.id
--       WHERE first_name = 'Zackery' AND last_name = 'Adams'
--     )
--   );

SELECT DISTINCT airports.long_name AS airport, CONCAT(users.first_name, ' ', users.last_name) AS user FROM airports
  JOIN flights origin ON airports.id = origin.origin_id
  JOIN flights destination ON airports.id = destination.destination_id
  JOIN tickets ON origin.id = tickets.flight_id
  JOIN itineraries ON itineraries.id = tickets.itinerary_id
  JOIN users ON users.id = itineraries.user_id
  WHERE users.first_name = 'Zackery'
  AND users.last_name = 'Adams'
  AND origin.departure_time > '2012-1-1';



-- FROM itineraries JOIN tickets ON id 
--   JOIN flights ON 
--   JOIN airports
--     -- link to airport with both origin and dest id
-- WHERE first_name = 'Zackery' AND last_name = 'Adams'












