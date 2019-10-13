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
,   Gender      NVARCHAR(1) CHECK(Gender = "M" OR Gender = "G" OR Gender = "I")
,   PRIMARY KEY(ClientID)
);

CREATE TABLE Event(
    TourName    NVARCHAR(100)
,   EventMonth  NVARCHAR(3) CHECK (EventMonth = "Jan" OR EventMonth = "Feb" OR EventMonth = "Mar" OR EventMonth = "Apr" OR EventMonth = "May" OR EventMonth = "Jun" OR EventMonth = "Jul" OR EventMonth = "Aug" OR EventMonth = "Sep" OR EventMonth = "Oct" OR EventMonth = "Nov" OR EventMonth = "Dec")
,   EventDay    INT CHECK (EventDay >= 1 OR EventDay <= 31)
,   EventYear   INT CHECK (Len(EventYear) = 4)
,   EventFee    Money NOT NULL CHECK (EventFee > 0)
,   PRIMARY KEY(TourName, EventMonth, EventDay, EventYear)
,   FOREIGN KEY(TourName) REFERENCES Tour
);

CREATE TABLE Booking(
    Clientid    INT FOREIGN KEY REFERENCES Client
,   TourName    NVARCHAR(100)
,   EventMonth  NVARCHAR(3) CHECK (EventMonth = "Jan" OR EventMonth = "Feb" OR EventMonth = "Mar" OR EventMonth = "Apr" OR EventMonth = "May" OR EventMonth = "Jun" OR EventMonth = "Jul" OR EventMonth = "Aug" OR EventMonth = "Sep" OR EventMonth = "Oct" OR EventMonth = "Nov" OR EventMonth = "Dec")
,   EventDay    INT CHECK (EventDay >= 1 OR EventDay <= 31)
,   EventYear   INT CHECK (Len(EventYear) = 4)
,   Payment     Money CHECK (EventFee > 0)
,   DateBooked  DATE NOT NULL
,   PRIMARY KEY (TourName, EventMonth, EventDay, EventYear)
,   FOREIGN KEY (TourName, EventMonth, EventDay, EventYear) REFERENCES Event
);

INSERT INTO Tour (TourName, Description) VALUES (North, "Tour of wineries and outlets of the Bedigo and Castlemaine region");
INSERT INTO Tour (TourName, Description) VALUES (South, "Tour of wineries and outlets of Mornington Penisula");
INSERT INTO Tour (TourName, Description) VALUES (West, "Tour of wineries and outlets of the Geelong and Otways region");

INSERT INTO Client (Clientid, Surname, GivenName, Gender) VALUES (1, "Price", "Taylor", "M");
INSERT INTO Client (Clientid, Surname, GivenName, Gender) VALUES (2, "Gamble", "Ellyse", "F");
INSERT INTO Client (Clientid, Surname, GivenName, Gender) VALUES (3, "Tan", "Tilly", "F");

INSERT INTO Event (TourName, EventMonth, EventDay, EventFee) VALUES ("North", "Jan", 9, 2016, 200);
INSERT INTO Event (TourName, EventMonth, EventDay, EventFee) VALUES ("North", "Feb", 13, 2016, 225);
INSERT INTO Event (TourName, EventMonth, EventDay, EventFee) VALUES ("South", "Jan", 9, 2016, 200);
INSERT INTO Event (TourName, EventMonth, EventDay, EventFee) VALUES ("South", "Jan", 16, 2016, 200);
INSERT INTO Event (TourName, EventMonth, EventDay, EventFee) VALUES ("West", "Jan", 29, 2016, 225);

INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (1, "North", "Jan", 9, 2016, 200, 10/12/2015);
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (2, "North", "Jan", 9, 2016, 200, 16/12/2015);
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (1, "North", "Feb", 13, 2016, 225, 8/01/2016);
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (2, "North", "Feb", 13, 2016, 125, 14/01/2016);
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (3, "North", "Feb", 13, 2016, 225, 3/02/2016);
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (1, "South", "Jan", 9, 2016, 200, 10/12/2015);
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (2, "South", "Jan", 16, 2016, 200, 18/12/2015);
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (3, "South", "Jan", 16, 2016, 200, 9/01/2016);
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (2, "West", "Jan", 29, 2016, 225, 17/12/2015);
INSERT INTO Booking (Clientid, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (3, "West", "Jan", 29, 2016, 200, 18/12/2015);

