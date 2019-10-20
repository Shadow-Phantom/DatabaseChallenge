/* 
102909073

Tour (TourName, Description)
Primary Key(TourName)

Event(EventYear, EventMonth, EventDay, Fee, Tourname)
Primary Key(EventYear, EventMonth, EventDay)
Foreign Key(TourName) References Tour

Booking(DateBooked, Payment, TourName, EventYear, EventMonth, EventDay, ClientID)
Foreign Key(TourName, EventYear, EventMonth, EventDay) References Event
Foreign Key (ClientID) References Client

Client(ClientID, Surname, GivenName, Gender)
PrimaryKey(ClientID)
*/
DROP TABLE IF EXISTS dbo.Booking
DROP TABLE IF EXISTS dbo.Event
DROP TABLE IF EXISTS dbo.Tour
DROP TABLE IF EXISTS dbo.Client

CREATE TABLE Tour(
    TourName    NVARCHAR(100)
,   Description NVARCHAR(500)
,   PRIMARY Key(TourName)
);

CREATE TABLE Client(
    Clientid    INT
,   Surname     NVARCHAR(100) NOT NULL
,   GivenName   NVARCHAR(100) NOT NULL
,   Gender      NVARCHAR(1) CHECK(Gender = 'M' OR Gender = 'F' OR Gender = 'I')
,   PRIMARY KEY(ClientID)
);

CREATE TABLE Event(
    TourName    NVARCHAR(100)
,   EventMonth  NVARCHAR(3) CHECK (EventMonth = 'Jan' OR EventMonth = 'Feb' OR EventMonth = 'Mar' OR EventMonth = 'Apr' OR EventMonth = 'May' OR EventMonth = 'Jun' OR EventMonth = 'Jul' OR EventMonth = 'Aug' OR EventMonth = 'Sep' OR EventMonth = 'Oct' OR EventMonth = 'Nov' OR EventMonth = 'Dec')
,   EventDay    INT CHECK (EventDay >= 1 OR EventDay <= 31)
,   EventYear   INT CHECK (Len(EventYear) = 4)
,   EventFee    Money NOT NULL CHECK (EventFee > 0)
,   PRIMARY KEY(TourName, EventMonth, EventDay, EventYear)
,   FOREIGN KEY(TourName) REFERENCES Tour
);

CREATE TABLE Booking(
    Clientid    INT FOREIGN KEY REFERENCES Client
,   TourName    NVARCHAR(100)
,   EventMonth  NVARCHAR(3) CHECK (EventMonth = 'Jan' OR EventMonth = 'Feb' OR EventMonth = 'Mar' OR EventMonth = 'Apr' OR EventMonth = 'May' OR EventMonth = 'Jun' OR EventMonth = 'Jul' OR EventMonth = 'Aug' OR EventMonth = 'Sep' OR EventMonth = 'Oct' OR EventMonth = 'Nov' OR EventMonth = 'Dec')
,   EventDay    INT CHECK (EventDay >= 1 OR EventDay <= 31)
,   EventYear   INT CHECK (Len(EventYear) = 4)
,   Payment     Money CHECK (Payment > 0)
,   DateBooked  DATE NOT NULL
,   PRIMARY KEY (Clientid, TourName, EventMonth, EventDay, EventYear)
,   FOREIGN KEY (TourName, EventMonth, EventDay, EventYear) REFERENCES Event
);

INSERT INTO Tour (TourName, Description) VALUES ('North', 'Tour of wineries and outlets of the Bedigo and Castlemaine region');
INSERT INTO Tour (TourName, Description) VALUES ('South', 'Tour of wineries and outlets of Mornington Penisula');
INSERT INTO Tour (TourName, Description) VALUES ('West', 'Tour of wineries and outlets of the Geelong and Otways region');

INSERT INTO Client (Clientid, Surname, GivenName, Gender) VALUES (1, 'Price', 'Taylor', 'M');
INSERT INTO Client (Clientid, Surname, GivenName, Gender) VALUES (2, 'Gamble', 'Ellyse', 'F');
INSERT INTO Client (Clientid, Surname, GivenName, Gender) VALUES (3, 'Tan', 'Tilly', 'F');

INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES ('North', 'Jan', 9, 2016, 200);
INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES ('North', 'Feb', 13, 2016, 225);
INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES ('South', 'Jan', 9, 2016, 200);
INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES ('South', 'Jan', 16, 2016, 200);
INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES ('West', 'Jan', 29, 2016, 225);

INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (1, 'North', 'Jan', 9, 2016, 200, '2015-12-10');
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (2, 'North', 'Jan', 9, 2016, 200, '2015-12-16');
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (1, 'North', 'Feb', 13, 2016, 225, '2016-01-08');
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (2, 'North', 'Feb', 13, 2016, 125, '2016-01-14');
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (3, 'North', 'Feb', 13, 2016, 225, '2016-02-03');
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (1, 'South', 'Jan', 9, 2016, 200, '2015-12-10');
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (2, 'South', 'Jan', 16, 2016, 200, '2015-12-18');
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (3, 'South', 'Jan', 16, 2016, 200, '2016-01-09');
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (2, 'West', 'Jan', 29, 2016, 225, '2015-12-17');
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (3, 'West', 'Jan', 29, 2016, 200, '2015-12-18');

Select * from Client;

Select C.GivenName, C.Surname, T.TourName, T.Description, E.EventYear, E.EventMonth, E.EventDay, E.EventFee, B.DateBooked, B.Payment
From Client C, Tour T, Event E, Booking B;

Select EventMonth, TourName, COUNT(*) as 'Num Bookings'
From Booking
Group By TourName, EventMonth;

Select *
From Booking
Where Payment > (SELECT AVG(Payment) FROM Booking)
Order By Payment ASC;

CREATE VIEW Task_5 AS
Select * from Client;

Select *
From Booking
Where Payment < (SELECT AVG(Payment) FROM Booking)
Order By Payment ASC;
/* by checking smaller than average instead of bigger than
it proves that there is 1 smaller than which is 125 and 
there is 3 bigger which all are 225 with nothing in between showing */

Select EventMonth, TourName, DateBooked
From Booking
WHERE TourName = 'North';
/* by there being 5 results for north, proves that the count for bookings is
correct because it says there is a total of 5 results within 2 months times */


Select C.GivenName, C.ClientID, B.ClientID as 'bookings client id'
From Client C
INNER JOIN Booking B
ON B.ClientID = C.ClientID;
/* this proves the client ID is correct as it is the same in Bookings */
