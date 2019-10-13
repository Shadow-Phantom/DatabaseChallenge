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
,   Surname     NVARCHAR(100)
,   GivenName   NVARCHAR(100)
,   Gender      NVARCHAR(1)
,   PRIMARY KEY(ClientID)
);

CREATE TABLE Event(
    TourName    NVARCHAR(100)
,   EventMonth  NVARCHAR(3)
,   EventDay    INT
,   EventYear   INT
,   EventFee    Money
,   PRIMARY KEY(TourName, EventMonth, EventDay, EventYear)
,   FOREIGN KEY(TourName) REFERENCES Tour
);

CREATE TABLE Booking(
    Clientid    INT FOREIGN KEY REFERENCES Client
,   TourName    NVARCHAR(100)
,   EventMonth  NVARCHAR(3)
,   EventDay    INT
,   EventYear   INT
,   Payment     Money
,   DateBooked  DATE
,   PRIMARY KEY (TourName, EventMonth, EventDay, EventYear)
,   FOREIGN KEY (TourName, EventMonth, EventDay, EventYear) REFERENCES Event
);

