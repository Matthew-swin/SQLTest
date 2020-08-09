--Matthew Jester
--103219809

-- Tour (TourName, Description)
-- PK(TourName)

-- Client (ClientID, Surname, GivenName, Gender)
-- PK (ClientID)

-- Event (TourName, EventDay, EventMonth, EventYear, Fee)
-- PK (TourName, EventDay, EventMonth, EventYear)
-- FK (TourName) References Tour

-- Booking (Tourname, EventDay, EventMonth, EventYear, ClientID, DateBooked, Payment)
-- PK (Tourname, EventDay, EventMonth, EventYear)
-- FK (TourName) references Tour
-- FK (EventDay, EventMonth, EventYear) References Tour
-- FK(ClientID) References Client

CREATE DATABASE Test;

SELECT *  
FROM sys.databases ;  

USE Test;
 