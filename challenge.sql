/* 
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

DROP TABLE IF EXISTS dbo.Tour
DROP TABLE IF EXISTS dbo.Client
DROP TABLE IF EXISTS dbo.Event
DROP TABLE IF EXISTS dbo.Booking