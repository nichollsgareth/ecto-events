USE [ecto-dev]

CREATE TABLE Event (
    --EventId int NOT NULL AUTO_INCREMENT,
	EventId int IDENTITY(1,1) PRIMARY KEY,
    DisplayName varchar(255) NOT NULL,
    Latitude decimal(9,6) NOT NULL,
    Longitude decimal(9,6) NOT NULL,
	Radius decimal(5,3) NOT NULL,
	PublishDate date NOT NULL,
	IsActive bit,
	IsDeleted bit
);