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

--dropping if mess up
IF OBJECT_ID('Event') IS NOT NULL
DROP TABLE Event;

IF OBJECT_ID('Booking') IS NOT NULL
DROP TABLE Booking;

IF OBJECT_ID('Tour') IS NOT NULL
DROP TABLE Tour;

IF OBJECT_ID('Client') IS NOT NULL
DROP TABLE Client;

--Creating tables
GO;

CREATE TABLE Client (
    ClientId    INT
,   Surname     NVARCHAR(100) NOT NULL
,   GivenName   NVARCHAR(100) NOT NULL
,   Gender      NVARCHAR(1) CHECK (Gender IN ('M','F','I')) NULL
, PRIMARY KEY (ClientId)
);

CREATE TABLE Tour (
    TourName     NVARCHAR(100)
,   Description  NVARCHAR(500) 
, PRIMARY KEY (TourName)
);

CREATE TABLE Event (
    TourName     NVARCHAR(100)
,   EventDay    INT CHECK (EventDay >=1 and EventDay <= 31)
,   EventMonth  NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May','Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
,   EventYear   INT CHECK (len(EventYear) = 4)
,   EventFee    MONEY NOT NULL check (EventFee > 0)
, PRIMARY KEY (TourName, EventDay, EventMonth, EventYear)
, FOREIGN KEY (TourName) REFERENCES Tour
);

CREATE TABLE Booking (
    ClientId    INT
,   TourName     NVARCHAR(100)
,   EventDay    INT CHECK (EventDay >=1 and EventDay <= 31)
,   EventMonth  NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May','Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
,   EventYear   INT CHECK (len(EventYear) = 4)
,   Payment     MONEY CHECK (Payment > 0) 
,   DateBooked  DATE NOT NULL
, PRIMARY KEY (ClientID, TourName, EventDay, EventMonth, EventYear)
, FOREIGN KEY (TourName, EventDay, EventMonth, EventYear) REFERENCES Event
, FOREIGN KEY (ClientID) REFERENCES Client
);

GO;

select *
from  sys.tables