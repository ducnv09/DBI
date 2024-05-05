USE [master]
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'PE_DBI202_FA2023')
BEGIN
	ALTER DATABASE PE_DBI202_FA2023 SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE PE_DBI202_FA2023 SET ONLINE;
	DROP DATABASE PE_DBI202_FA2023;
END

GO

CREATE DATABASE PE_DBI202_FA2023
GO

USE PE_DBI202_FA2023
GO

/*******************************************************************************
	Drop tables if exists
*******************************************************************************/
DECLARE @sql nvarchar(MAX) 
SET @sql = N'' 

SELECT @sql = @sql + N'ALTER TABLE ' + QUOTENAME(KCU1.TABLE_SCHEMA) 
    + N'.' + QUOTENAME(KCU1.TABLE_NAME) 
    + N' DROP CONSTRAINT ' -- + QUOTENAME(rc.CONSTRAINT_SCHEMA)  + N'.'  -- not in MS-SQL
    + QUOTENAME(rc.CONSTRAINT_NAME) + N'; ' + CHAR(13) + CHAR(10) 
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC 

INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KCU1 
    ON KCU1.CONSTRAINT_CATALOG = RC.CONSTRAINT_CATALOG  
    AND KCU1.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA 
    AND KCU1.CONSTRAINT_NAME = RC.CONSTRAINT_NAME 

EXECUTE(@sql) 

GO
DECLARE @sql2 NVARCHAR(max)=''

SELECT @sql2 += ' Drop table ' + QUOTENAME(TABLE_SCHEMA) + '.'+ QUOTENAME(TABLE_NAME) + '; '
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_TYPE = 'BASE TABLE'

Exec Sp_executesql @sql2 
GO 

---------------------- Create tables ------------------
create table Category (
ID int primary key,
Label varchar(255),
Description varchar(255)
)
 
 create table Cars(
 ID int primary key,
 Description varchar(255),
 Model varchar(255),
 Brand varchar(255),
 Color varchar(255),
 Purchase_Date date,
 Category_ID int,
 FOREIGN KEY (Category_ID) REFERENCES Category(ID)
 )
  
 create table Customers(
 ID int primary key,
 SSN int,
 First_Name varchar(255),
 Last_Name varchar(255),
 Email varchar(255),
 Mobile_phone varchar(255),
 State varchar(255),
 Country varchar(255)
 );
 
 create table Location(
 ID int primary key,
 Street varchar(255),
 Street_Number int,
 City varchar(255),
 State varchar(255),
 Country varchar(255)
 );
 
 create table Location_Phone_Number(
 ID int  primary key,
 Phone_Number varchar(255),
 Location_ID int NOT NULL,
 Is_MainPhone bit,
 FOREIGN KEY (Location_ID) REFERENCES Location(ID)
 );

 
 create table Rentals(
 Reservation_Number int  primary key,
 Amount float,
 Pick_up_date date,
 Return_date date,
 CarID int  NOT NULL,
 Customer_ID int NOT NULL,
 Pick_up_location int NOT NULL,
 Return_location int NOT NULL,
 FOREIGN KEY (CarID) REFERENCES Cars(ID),
 FOREIGN KEY (Customer_ID) REFERENCES Customers(ID),
 FOREIGN KEY (Pick_up_location) REFERENCES Location(ID),
 FOREIGN KEY (Return_location) REFERENCES Location(ID)
 );


 --------------------------------- insert data -----------------------------
 insert into Category (ID, Label, Description)
 values (1, 'luxury','Easier, safer, smarter – have fun in our stylish, 3-door city car with premium-class technologies.' ),
 (2, 'compact','Medium-sized, hatchback,  good for four people for a shorter trip - and two or three people for a longer trip.' ),
 (3, 'economy','Great fuel economy. Brilliant technology. Low taxation and running costs. All key features in our wide range of award-winning business vehicles.' ),
 (4, 'convertible','Perfect for the big city with their tight turning circles, light steering and penchant for painless parking.' );
 
 insert into Cars (ID, Description, Brand, Model, Color, Purchase_Date, Category_ID)
 values (1,'Economical fun and reliable automobile','Ford', 'Fiesta','Black', '2009/10/10', 3),
 (2,'Filled with features including Keyless Entry, Rain Sensing Wipers & Cruise Control','Ford', 'Ka','Red', '2011/8/9', 2),
(3,'Economical, fun and reliable automobile.','Ford', 'Fiesta','White', '2014/11/25', 3),
  (4,'Small, Connected,  10 standard airbags, a high-strength steel safety cage and available advanced active safety features.','Chevrolet', 'Spark','Green', '2008/12/3', 4),
  (5,'Remarkable technology and fuel efficiency, along with tons of personalization possibilities.','Chevrolet', 'Sonic','Grey', '2015/8/25', 2),
  (6,'Chevy’s latest technology with dramatic style. Impressive safety with seamless connectivity. It’s the midsize car that strikes the perfect balance.','Chevrolet', 'Malibu','Blue', '2012/4/30', 1),
 (7,'Contemporary design, captivating lines, comfort and technology, guaranteed as standard.','Fiat', 'Tipo','Pink', '2010/3/21', 1),
  (8,'The supermini that''s fun, convenient, eco-friendly.','Fiat', 'Punto','Yellow', '2013/2/28',3),
 (9,'The ultimate icon of city cars. Now even bolder and more seductive. Uconnect Radio with 4 speakers, DRL daytime running lights with LED technology,7 airbags.','Fiat', '500','White', '2016/1/30', 4),
 (10,'Its bold colour range, energetic lines and stylish features don’t just ensure a stress-free and comfortable driving experience, its natural flair can turn an ordinary trip into a journey packed with energy and vigour','Toyota', 'Yaris','Black', '2016/6/5', 4),
 (11,'Refined, distinctive and connected, AYGO is well-equipped to meet your needs.','Toyota', 'Augo','Brown', '2015/7/5', 3);

INSERT INTO  Customers (ID,SSN, First_Name, Last_Name, Email, Mobile_phone, State, Country)
VALUES (1,124649087,'Eleftheria', 'Apostolaki', 'eleftheria.apostolaki@gmail.com', 6987664532, 'Attiki', 'Greece');
INSERT INTO  Customers (ID,SSN, First_Name, Last_Name, Email, Mobile_phone, State, Country)
VALUES (2,23678903, 'Matilda', 'Tsaka', 'matilda.tsaka@gmail.com', 6969223478, 'Attiki', 'Greece');
INSERT INTO  Customers (ID,SSN, First_Name, Last_Name, Email, Mobile_phone, State, Country)
VALUES (3,123895678,'Maria', 'Papadopoulou' ,'maria.papadopoulou@yahoo.com', 6958762345, 'Brussels', 'Belgium');
INSERT INTO  Customers (ID,SSN, First_Name, Last_Name, Email, Mobile_phone, State, Country)
VALUES (4,967854369, 'Aris', 'Tsalikis','aris.tsalikis@hotmail.com', 6975329795, 'Paris', 'France');
INSERT INTO  Customers (ID,SSN, First_Name, Last_Name, Email, Mobile_phone, State, Country)
VALUES (5,967854369,'Giorgos', 'Alexopoulos', 'giorgos.alexopoulos@yahoo.com', 6967890456, 'Berlin', 'Germany');
INSERT INTO  Customers (ID,SSN, First_Name, Last_Name, Email, Mobile_phone, State, Country)
VALUES (6,998764569, 'Aggelos', 'Kostopoulos', 'aggelos.kost@gmail.com', 6967899077, 'Rome', 'Italy');
INSERT INTO  Customers (ID,SSN, First_Name, Last_Name, Email, Mobile_phone, State, Country)
VALUES (7,924567890, 'James', 'Brown','james.br@hotmail.com', +356789907761, 'Sydney', 'Australia');
INSERT INTO  Customers (ID,SSN, First_Name, Last_Name, Email, Mobile_phone, State, Country)
VALUES (8,167844560, 'John', 'Milton', 'milton.j@hotmail.com', 6935667345, 'Nicosia', 'Cyprus');
INSERT INTO  Customers (ID,SSN, First_Name, Last_Name, Email, Mobile_phone, State, Country)
VALUES (9,234512677,'Jane', 'Jones', 'jane.jones@gmail.com', 6994567891, 'Bern', 'Switzerland');
INSERT INTO  Customers (ID,SSN, First_Name, Last_Name, Email, Mobile_phone, State, Country)
VALUES (10,234512677, 'Mary', 'Hamilton','mary.hamilton@yahoo.com', 6987664532, 'Crete', 'Greece');

INSERT INTO  Location (ID,Street, Street_Number, City, State, Country)
VALUES (1,'Woodsman Street', 49, 'Brooklyn', 'NY', 'United States');
INSERT INTO  Location (ID,Street, Street_Number, City, State, Country)
VALUES (2,'Arnold Street', 25, 'Brooklyn', 'NY', 'United States');
INSERT INTO  Location (ID,Street, Street_Number, City, State, Country)
VALUES (3,'Grove Drive', 40, 'Corona', 'NY', 'United States');
INSERT INTO  Location (ID,Street, Street_Number, City, State, Country)
VALUES (4,'South Gates Avenue', 9625, 'Jamaica', 'NY', 'United States');
INSERT INTO  Location (ID,Street, Street_Number, City, State, Country)
VALUES (5,'Mount Street Newark', 853, 'Newark', 'NJ', 'United States');
INSERT INTO  Location (ID,Street, Street_Number, City, State, Country)
VALUES (6,'Drummond Street', 991, 'Newark', 'NJ', 'United States');
INSERT INTO  Location (ID,Street, Street_Number, City, State, Country)
VALUES (7,'Watson Street', 2648, 'Penns Neck', 'NJ', 'United States');
 INSERT INTO  Location (ID,Street, Street_Number, City, State, Country)
VALUES (8,'Main St', 68, 'Punnichy', 'CA', 'Canada');
INSERT INTO  Location (ID,Street, Street_Number, City, State, Country)
VALUES (9,'Russell Avenue', 3777, 'White Rock', 'CA', 'Canada');
 INSERT INTO  Location (ID,Street, Street_Number, City, State, Country)
VALUES (10,'Main St', 68, 'Punnichy', 'CA', 'Canada');
INSERT INTO  Location (ID,Street, Street_Number, City, State, Country)
VALUES (11,'St. John Street', 3066 , 'Alvena', 'CA', 'Canada');
INSERT INTO  Location (ID,Street, Street_Number, City, State, Country)
VALUES (12,'Carlson Road', 2905 , 'Prince George', 'BC', 'Belgium');

INSERT INTO  Location_Phone_Number (ID,Phone_Number, Location_ID, Is_MainPhone)
VALUES (1,2810100715,  5,1),
(2,2810233791,  5,0),
(3,2108995679,  1,1),
(4,2129078656,  2,1),
(5,2139034566,  3,1),
(6,2138999081,  3,0),
(7,2129234566, 4,1),
(8,2129004566, 4,0),
(9,2129112344, 4,0),
(10,2810567892, 6,1),
(11,2410898772, 7,1),
(12,2611456773, 8,1),
(13,2910339013, 9,1),
(14,2915907653, 10,1),
(15,2510566712, 11,1),
(16,2310566712, 12,1),
(17,2310677823, 12,0);

INSERT INTO Rentals (Reservation_Number,Amount, Pick_up_date, Return_date, CarID, Customer_ID, Pick_up_location, Return_location)
VALUES (1,120, '2014/05/04', '2014/05/14', 3, 5, 1, 1),
(2,45, '2014/05/15', '2014/05/20', 4, 1, 5, 4),
(3,35, '2014/05/20', '2014/05/25', 3, 7, 8, 12),
(4,98, '2014/06/06', '2014/08/08', 9, 2, 10, 10),
(5,110, '2014/06/10', '2014/06/17', 8, 3, 4, 2),
(6,55, '2014/06/27', '2014/06/30', 6, 8, 7, 5),
(7,30, '2014/10/08', '2014/10/09', 2, 6, 2, 6),
(8,600, '2014/10/18', '2014/10/26', 11, 4, 6, 6),
(9,350, '2014/10/21', '2014/10/31', 7, 9, 3, 8),
(10,280, '2015/5/20', '2015/05/27', 5, 10, 9, 7),
(11,85, '2015/5/20', '2015/05/22', 1, 1, 1, 9),
(12,180, '2015/5/20', '2015/05/30', 10, 4, 8, 6),
(13,125, '2015/6/7', '2015/6/14', 3, 8, 7, 4),
(14,80, '2015/6/15', '2015/6/18', 2, 9, 6, 3),
(15,75, '2015/6/26', '2015/6/28', 6, 5, 2, 5),
(16,300, '2015/10/2', '2015/10/12', 7, 2, 4, 1),
(17,45, '2015/10/18', '2015/10/19', 10, 7, 5, 12),
(18,190, '2015/10/31', '2015/11/5', 9, 1, 10, 8);