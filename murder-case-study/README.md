# Introduction

There's been a Murder in SQL City! The SQL Murder Mystery is designed to be both a self-directed lesson to learn SQL concepts and commands and a fun game for experienced SQL users to solve an intriguing crime.

# Background

A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database. 

Thanks to https://mystery.knightlab.com/.

# Analysis
### Step 1.
The murder case was happened on Jan 15, 2018 in SQL city. 

```sql
    SELECT
        *
    FROM
        crime_scene_reports
    WHERE
        City LIKE 'SQL City' AND Type LIKE 'murder' AND Date LIKE '2018-01-15%';
```
The query found that `Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave"`. Therefore, we have to follow the trace of two witness.

### Step 2.
First witness lives the last on Northwestern Dr. Therefore I filtered the street_name `Northwestern%` and order by DESC.

```sql
    SELECT
        *
    from
        persons
    WHERE
        Address_Street_Name LIKE 'Northwestern%'
    ORDER BY
        Address_Number DESC;
```
**The first witness is Morty Schaprio, person_id = 14887, license_id = 118009.**

### Step 3.
Second witness called Annabel, lives somewhere on Franklin Ave.

```sql
    SELECT
        *
    FROM
        persons
    WHERE
        Name LIKE 'Anna%' AND Address_Street_Name LIKE 'Franklin%'
```
**The second witnessm person_id 16371, license_id = 490173.**

### Step 4.
After finding the details about two witness, I checked the interview what they were saying.
```sql
    SELECT
        *
    FROM
        interviews
    WHERE person_id IN (14887, 16371)
```
- Morty Schaprio said `I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W"`.
- Annabel said `I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th`.

### Step 5.
And then I checked the Get Fit Now member who is gold and number starts with 48Z.
```sql
    SELECT
        *
    FROM
        memberships
    WHERE Id LIKE '48Z%' AND Membership_Status = 'gold';
```
I found two suspects
- Jeremy Bowsers: person_id = 67318, membershipId =48Z55
- Joe Germuska: person_id = 28819, MembershipID =48Z7A

### Step 6.
To confirm the suspects, I followed the trace of Annabel saying.

```sql
    SELECT
        *
    FROM
        membership_checkins
    WHERE
        Check_In_Date LIKE '2018-01-09' AND Membership_ID LIKE '48Z%';
```

I found two suspects
- MembershipID: 48Z7A, 48Z55. The query found the same as Morty Schaprio saying.

We have only one clue for the plate number. 

### Step 7.
Find the name who has plate number included with `H42W`.
```sql
    SELECT
        persons.Name
    FROM
        drivers_licenses
    JOIN persons ON drivers_licenses.Id = persons.License_Id 
    WHERE
        Plate_Number LIKE '%H42W%'
```
The Query found that 3 suspects
- Tushar Chandra
- Jeremy Bowers
- Maxine Whitely

# Conclusion
When compared the latest two findings, 

**The killer is Jeremy Bowsers.**