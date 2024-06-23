-- case happened on 15 Jan 2018, in SQL city and murder case,

SELECT
    *
FROM
    crime_scene_reports
WHERE
    City LIKE 'SQL City' AND Type LIKE 'murder' AND Date LIKE '2018-01-15%';



-- first witness
SELECT
    *
from
    persons
WHERE
    Address_Street_Name LIKE 'Northwestern%'
ORDER BY
    Address_Number DESC;
-- name = Morty Schaprio,id = 14887, license id = 118009


-- second witness
SELECT
    *
FROM
    persons
WHERE
    Name LIKE 'Anna%' AND Address_Street_Name LIKE 'Franklin%'
-- id = 16371, license id = 490173

-- check interviews
SELECT
    *
FROM
    interviews
WHERE person_id IN (14887, 16371)
-- two transcript: 1. Git Fit Now Gym, membership no started with 48Z, gold members,
-- a plate that included "H42W" 2. she works on Jan 9.

-- check get_fit_now_member
SELECT
    *
FROM
    memberships
WHERE Id LIKE '48Z%' AND Membership_Status = 'gold';
-- two suspects 1. Jeremy Bowers id=67318 membershipId=48Z55, 2. Jow Germuska id=28819 MembershipID = 48Z7A

-- check checkins time
SELECT
    *
FROM
    membership_checkins
WHERE
    Check_In_Date LIKE '2018-01-09' AND Membership_ID LIKE '48Z%';


-- check plate number
SELECT
    persons.Name
FROM
    drivers_licenses
JOIN persons ON drivers_licenses.Id = persons.License_Id 
WHERE
    Plate_Number LIKE '%H42W%'
    

