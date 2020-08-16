--Matthew Jester
--103219809

-- Tour (TourName, Description)
-- PK(TourName)

-- Client (ClientID, Surname, GivenName, Gender)
-- PK (ClientID)

-- Event (TourName, EventDay, EventMonth, EventYear, Fee)
-- PK (TourName, EventDay, EventMonth, EventYear)
-- FK (TourName) References Tour

-- Booking (TourName, EventDay, EventMonth, EventYear, ClientID, DateBooked, Payment)
-- PK (ClientID, TourName, EventDay, EventMonth, EventYear)
-- FK (TourName, EventDay, EventMonth, EventYear) References Event
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

-- select *
-- from  sys.tables

INSERT INTO Client (ClientId, Surname, GivenName, Gender) VALUES 
(1	,'Taylor'	,'Price',	'M') 
,(2	,'Ellyse',	'Gamble',	'F')
,(3	,'Tilly',	'Tan',	'F')
,(103219809, 'Jester', 'Matthew', 'M')
;

INSERT INTO Tour (TourName, Description) VALUES
('North', 'Tour of wineries and outlets of the Bedigo and Castlemaine region')
,('South', 'Tour of wineries and outlets of Mornington Penisula')
,('West', 'Tour of wineries and outlets of the Geelong and Otways region')
;

INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES
('North',	'Jan'	,9	,2016,	200)
,('North',	'Feb'	,13	,2016,	225)
,('South',	'Jan'	,9	,2016,	200)
,('South',	'Jan'	,16	,2016,	200)
,('West',	'Jan'	,29	,2016,	225)
;

INSERT INTO Booking (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES
(1,	'North',	'Jan',	9,	2016,200,	'2015-12-10')
,(2,	'North',	'Jan',	9,	2016,200,	'2015-12-16')
,(1,	'North',	'Feb',	13,	2016,225, '2016-01-08')
,(2,	'North',	'Feb',	13,	2016,125,	'2016-01-14')
,(3,	'North',	'Feb',	13,	2016,225,	'2016-02-3')
,(1,	'South',	'Jan',	9,	2016,200,	'2015-12-10')
,(2,	'South',	'Jan',	16,	2016,200,	'2015-12-18')
,(3,	'South',	'Jan',	16,	2016,200,	'2016-01-09')
,(2,	'West',	'Jan',	29,	2016,	225,	'2015-12-17')
,(3,	'West',	'Jan',	29,	2016,	200, '2015-12-18')
;

select *
from Client

select B.GivenName, B.Surname, A.TourName, C.Description, A.EventYear, A.EventMonth, A.EventDay, D.EventFee
from Booking A
LEFT JOIN Client B on A.ClientId = B.ClientId
LEFT JOIN Tour C on A.TourName = C.TourName
LEFT JOIN Event D on A.TourName = D.TourName 

--corrected version of task 4 query 1
--Question V
--Write a query that shows the client first name and surname, the tour name and description,
--the tour event year, month, day and fee, the booking date and the fee paid for the booking.
select C.GivenName, C.Surname, E.TourName, T.Description, B.EventYear, B.EventMonth, B.EventDay, E.EventFee, B.DateBooked, B.Payment
from Booking B
left join Event E 
on B.TourName = E.TourName 
and B.EventYear = E.EventYear
and B.EventMonth = E.EventMonth
and B.EventDay = E.EventDay
LEFT Join Tour T ON
E.TourName = T.TourName
left join Client C 
on B.ClientId = C.ClientId



Select EventMonth, TourName, Count(EventMonth) as NumBooking
from Booking
group by EventMonth, TourName

Select *
from Booking
where Payment > (select AVG(Payment) from Booking)

CREATE VIEW Tom AS
Select *
from Booking
where Payment > (select AVG(Payment) from Booking)

select * 
FROM Tom

--selecting all the amounts to show not missing data
select Payment
from Booking
-- showing the avg
select AVG(Payment)
from Booking
-- showing the avg is lower then the values
select Payment
from Booking 
where Payment > 200