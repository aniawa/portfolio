/* Create tables */


DROP TABLE IF EXISTS `Cities`;
CREATE TABLE `Cities` (
  `CityID` int NOT NULL AUTO_INCREMENT,
  `City` varchar(30) NOT NULL,
  `ZIP` varchar(5) NOT NULL,
  PRIMARY KEY (`CityID`),
  KEY `City_idx` (`City`),
  KEY `ZIP_idx` (`ZIP`)
);

LOCK TABLES `Cities` WRITE;
INSERT INTO `Cities` VALUES (1,'Carpentersville','60110'),(2,'East Dundee','60118'),(3,'Sleepy Hollow','60118'),(4,'West Dundee','60110');
UNLOCK TABLES;


DROP TABLE IF EXISTS `Genres`;
CREATE TABLE `Genres` (
  `GenreID` int NOT NULL AUTO_INCREMENT,
  `Genre` varchar(30) NOT NULL,
  PRIMARY KEY (`GenreID`),
  UNIQUE KEY `Genre_UNIQUE` (`Genre`)
);

LOCK TABLES `Genres` WRITE;
INSERT INTO `Genres` VALUES (4,'adventure'),(7,'autobiography'),(12,'contemporary realistic'),(10,'cookbook'),(11,'fantasy'),(1,'fiction'),(8,'history'),(5,'horror'),(2,'nonfiction'),(3,'novel'),(9,'popular science'),(6,'psychological');
UNLOCK TABLES;


DROP TABLE IF EXISTS `Addresses`;
CREATE TABLE `Addresses` (
  `AddressID` int NOT NULL AUTO_INCREMENT,
  `Address` varchar(50) NOT NULL,
  `CityID` int NOT NULL,
  PRIMARY KEY (`AddressID`),
  UNIQUE KEY `Address_UNIQUE` (`Address`),
  KEY `CityID_idx` (`CityID`),
  CONSTRAINT `CityID` FOREIGN KEY (`CityID`) REFERENCES `Cities` (`CityID`) ON DELETE CASCADE ON UPDATE CASCADE
);

LOCK TABLES `Addresses` WRITE;
INSERT INTO `Addresses` VALUES (1,'10772 Berry Ct',1),(2,'504 Strawberry Ln, Apt.2',2),(3,'3 Plum Rd',3),(4,'99 Apple St, Apt.8',4);
UNLOCK TABLES;


DROP TABLE IF EXISTS `Authors`;
CREATE TABLE `Authors` (
  `AuthorID` int NOT NULL AUTO_INCREMENT,
  `LastName` varchar(50) NOT NULL,
  `FirstName` varchar(30) NOT NULL,
  `Country` varchar(30) NOT NULL DEFAULT 'USA',
  `YearOfBirth` year DEFAULT NULL,
  `YearOfDeath` year DEFAULT NULL,
  PRIMARY KEY (`AuthorID`),
  KEY `Author_last_name_idx` (`LastName`),
  KEY `Author_first_last_idx` (`FirstName`,`LastName`),
  KEY `Author_last_first_idx` (`LastName`,`FirstName`)
);

LOCK TABLES `Authors` WRITE;
INSERT INTO `Authors` VALUES (1,'Page','Karen','USA',NULL,NULL),(2,'Hadfield','Chris','Canada',1959,NULL),(3,'Singh','Simon','UK',1964,NULL),(4,'Roberts','Gregory David','Australia',1952,NULL),(5,'King','Stephen','USA',1947,NULL),(6,'Przybylek','Agata','Poland',NULL,NULL),(7,'Rogozinski','Alek','Poland',NULL,NULL),(8,'Adams','Fred','USA',NULL,NULL),(9,'Laughlin','Greg','USA',NULL,NULL);
UNLOCK TABLES;


DROP TABLE IF EXISTS `Locations`;
CREATE TABLE `Locations` (
  `LocationID` int NOT NULL AUTO_INCREMENT,
  `Location` varchar(20) NOT NULL DEFAULT 'main',
  PRIMARY KEY (`LocationID`),
  UNIQUE KEY `Location_UNIQUE` (`Location`)
);

LOCK TABLES `Locations` WRITE;
INSERT INTO `Locations` VALUES (2,'branch'),(1,'main');
UNLOCK TABLES;


DROP TABLE IF EXISTS `Publishers`;
CREATE TABLE `Publishers` (
  `PublisherID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`PublisherID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
);

LOCK TABLES `Publishers` WRITE;
INSERT INTO `Publishers` VALUES (6,'Czwarta Strona'),(4,'Fourth Estate'),(1,'Little, Brown and Company'),(2,'Pocket Books'),(3,'Skarpa Warszawska'),(5,"St.Martin's Griffin"),(7,'The Free Press');
UNLOCK TABLES;


DROP TABLE IF EXISTS `Titles`;
CREATE TABLE `Titles` (
  `TitleID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(50) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  `PublisherID` int NOT NULL,
  `PublishYear` year NOT NULL,
  `Language` varchar(20) NOT NULL DEFAULT 'English',
  `Synopsis` varchar(255) DEFAULT NULL,
  `Pages` int DEFAULT NULL,
  PRIMARY KEY (`TitleID`),
  UNIQUE KEY `ISBN_UNIQUE` (`ISBN`),
  KEY `PublisherID_idx` (`PublisherID`),
  KEY `Title_idx` (`Title`),
  KEY `Language_idx` (`Language`),
  CONSTRAINT `PublisherID_Titles` FOREIGN KEY (`PublisherID`) REFERENCES `Publishers` (`PublisherID`) ON DELETE CASCADE ON UPDATE CASCADE
);

LOCK TABLES `Titles` WRITE;
INSERT INTO `Titles` VALUES (1,'Zlap mnie, jesli umiesz','978-83-66644-80-9',3,2021,'Polish','Male miastecko na Podlasiu, opuszczony dworek, a w nim...',300),(2,'Milosc i inne nieszczescia','978-83-66278-48-6',6,2019,'Polish',NULL,386),(3,'The girl who loved Tom Gordon','0-671-04285-8',2,2000,'English','On a six-mile hike on the Maine-New Hampshire branch of the Appalachian Trail, nine-year-old Trisha quickly tires of the constant bickering between her older brother and her recently divorced mother.',264),(4,'Shantaram','0-312-33053-7',5,2005,'English',NULL,936),(5,'The code book','1-85702-879-1',4,1999,'English',NULL,NULL),(6,"An astronaut\'s guide to life on Earth",'978-0-316-25301-7',1,2013,'English','Col.Chris Hadfield has spent decades training as an astronaut and has logged nearly four thousand hours in space.',NULL),(7,'The vegetarian flavor bible','978-0-316-24418-3',1,2014,'English',NULL,NULL),(8,'The five ages of the Universe','0-684-85422-8',7,1999,'English',NULL,251);
UNLOCK TABLES;


DROP TABLE IF EXISTS `Books`;
CREATE TABLE `Books` (
  `BookID` int NOT NULL AUTO_INCREMENT,
  `TitleID` int NOT NULL,
  `LocationID` int NOT NULL,
  PRIMARY KEY (`BookID`),
  KEY `TitleID_idx` (`TitleID`),
  KEY `LocationID_idx` (`LocationID`),
  CONSTRAINT `LocationID_Books` FOREIGN KEY (`LocationID`) REFERENCES `Locations` (`LocationID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `TitleID_Books` FOREIGN KEY (`TitleID`) REFERENCES `Titles` (`TitleID`) ON DELETE CASCADE ON UPDATE CASCADE
);

LOCK TABLES `Books` WRITE;
INSERT INTO `Books` VALUES (1,1,1),(2,1,2),(3,2,2),(4,3,1),(5,3,2),(6,4,1),(7,5,1),(8,6,1),(9,6,2),(10,6,1),(11,7,1),(12,7,2),(13,8,1);
UNLOCK TABLES;


DROP TABLE IF EXISTS `Phones`;
CREATE TABLE `Phones` (
  `PhoneID` int NOT NULL AUTO_INCREMENT,
  `Phone` varchar(7) NOT NULL,
  PRIMARY KEY (`PhoneID`),
  UNIQUE KEY `Phone_UNIQUE` (`Phone`)
);

LOCK TABLES `Phones` WRITE;
INSERT INTO `Phones` VALUES (1,'5551234'),(2,'5551235'),(3,'5551236'),(4,'5551237');
UNLOCK TABLES;


DROP TABLE IF EXISTS `Patrons`;
CREATE TABLE `Patrons` (
  `PatronID` int NOT NULL AUTO_INCREMENT,
  `LastName` varchar(50) NOT NULL,
  `FirstName` varchar(30) NOT NULL,
  `DateOfBirth` date NOT NULL,
  `AddressID` int NOT NULL,
  `PhoneID` int NOT NULL,
  PRIMARY KEY (`PatronID`),
  KEY `AddressID_idx` (`AddressID`),
  KEY `PhoneID_idx` (`PhoneID`),
  KEY `Patron_last_idx` (`LastName`),
  KEY `Patron_last_first_idx` (`LastName`,`FirstName`),
  KEY `Patron_first_last_idx` (`FirstName`,`LastName`),
  CONSTRAINT `AddressID_Patrons` FOREIGN KEY (`AddressID`) REFERENCES `Addresses` (`AddressID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PhoneID_Patrons` FOREIGN KEY (`PhoneID`) REFERENCES `Phones` (`PhoneID`) ON DELETE CASCADE ON UPDATE CASCADE
);

LOCK TABLES `Patrons` WRITE;
INSERT INTO `Patrons` VALUES (1,'Smith','John','1951-06-25',1,1),(2,'Smith','Mary','1950-08-01',1,1),(3,'Smith','Margaret','1993-02-25',1,2),(4,'Brown','Julia','2003-02-12',2,2),(5,'Page','Chris','2000-06-04',3,3),(6,'Nowak','Dorota','1988-11-27',4,4);
UNLOCK TABLES;


DROP TABLE IF EXISTS `Loans`;
CREATE TABLE `Loans` (
  `LoanID` int NOT NULL AUTO_INCREMENT,
  `BookID` int NOT NULL,
  `PatronID` int NOT NULL,
  `CheckOutDate` datetime NOT NULL,
  `DueDate` datetime NOT NULL,
  `ReturnDate` datetime DEFAULT NULL,
  PRIMARY KEY (`LoanID`),
  KEY `BookID_idx` (`BookID`),
  KEY `PatronID_idx` (`PatronID`),
  CONSTRAINT `BookID_Loans` FOREIGN KEY (`BookID`) REFERENCES `Books` (`BookID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PatronID_Loans` FOREIGN KEY (`PatronID`) REFERENCES `Patrons` (`PatronID`) ON DELETE CASCADE ON UPDATE CASCADE
);

LOCK TABLES `Loans` WRITE;
INSERT INTO `Loans` VALUES (1,1,1,'2022-02-01 00:00:00','2022-02-15 00:00:00','2022-02-14 00:00:00'),(2,2,2,'2022-02-02 00:00:00','2022-02-16 00:00:00',NULL),(3,4,4,'2022-02-28 00:00:00','2022-03-07 00:00:00',NULL),(4,5,1,'2022-02-16 00:00:00','2022-03-02 00:00:00','2022-03-02 00:00:00'),(5,6,6,'2022-03-07 00:00:00','2022-03-21 00:00:00',NULL),(6,8,5,'2022-02-15 00:00:00','2022-03-01 00:00:00',NULL);
UNLOCK TABLES;


DROP TABLE IF EXISTS `TitleAuthors`;
CREATE TABLE `TitleAuthors` (
  `TitleID` int NOT NULL,
  `AuthorID` int NOT NULL,
  PRIMARY KEY (`TitleID`,`AuthorID`),
  KEY `AuthorID_idx` (`AuthorID`),
  KEY `Title_idx` (`TitleID`),
  CONSTRAINT `AuthorID_TitleAuthors` FOREIGN KEY (`AuthorID`) REFERENCES `Authors` (`AuthorID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `TitleID_TitleAuthors` FOREIGN KEY (`TitleID`) REFERENCES `Titles` (`TitleID`) ON DELETE CASCADE ON UPDATE CASCADE
);

LOCK TABLES `TitleAuthors` WRITE;
INSERT INTO `TitleAuthors` VALUES (7,1),(6,2),(5,3),(4,4),(3,5),(2,6),(1,7),(8,8),(8,9);
UNLOCK TABLES;


DROP TABLE IF EXISTS `TitleGenres`;
CREATE TABLE `TitleGenres` (
  `TitleID` int NOT NULL,
  `GenreID` int NOT NULL,
  PRIMARY KEY (`TitleID`,`GenreID`),
  KEY `GenreID_idx` (`GenreID`),
  KEY `TitleID_idx` (`TitleID`),
  CONSTRAINT `GenreID` FOREIGN KEY (`GenreID`) REFERENCES `Genres` (`GenreID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `TitleID` FOREIGN KEY (`TitleID`) REFERENCES `Titles` (`TitleID`) ON DELETE CASCADE ON UPDATE CASCADE
);

LOCK TABLES `TitleGenres` WRITE;
INSERT INTO `TitleGenres` VALUES (1,1),(2,1),(3,1),(4,1),(5,2),(6,2),(7,2),(8,2),(1,3),(2,3),(3,3),(4,3),(1,4),(4,4),(3,5),(3,6),(4,7),(6,7),(5,8),(5,9),(8,9),(7,10),(2,12);
UNLOCK TABLES;


-- Change data types in 'Loans' table for better presentation
ALTER TABLE `Loans`
MODIFY COLUMN `DueDate` DATE,
MODIFY COLUMN `ReturnDate` DATE,
MODIFY COLUMN `CheckOutDate` DATE;




/* Create views */

CREATE VIEW `authors_by_bookid` AS
    SELECT 
        `books`.`BookID` AS `BookID`,
        GROUP_CONCAT(`authors`.`LastName`
            SEPARATOR ',') AS `Author`
    FROM
        (((`books`
        LEFT JOIN `titles` ON ((`titles`.`TitleID` = `books`.`TitleID`)))
        LEFT JOIN `titleauthors` ON ((`titles`.`TitleID` = `titleauthors`.`TitleID`)))
        LEFT JOIN `authors` ON ((`authors`.`AuthorID` = `titleauthors`.`AuthorID`)))
    GROUP BY `books`.`BookID`;


CREATE VIEW `available_books_for_mar_07_22` AS
    SELECT DISTINCT
        `books`.`BookID` AS `BookID`,
        `titles`.`Title` AS `Title`,
        `locations`.`Location` AS `Location`
    FROM
        (((((`titles`
        LEFT JOIN `titleauthors` ON ((`titles`.`TitleID` = `titleauthors`.`TitleID`)))
        LEFT JOIN `authors` ON ((`authors`.`AuthorID` = `titleauthors`.`AuthorID`)))
        LEFT JOIN `books` ON ((`titles`.`TitleID` = `books`.`TitleID`)))
        LEFT JOIN `locations` ON ((`locations`.`LocationID` = `books`.`LocationID`)))
        LEFT JOIN `loans` ON ((`loans`.`BookID` = `books`.`BookID`)))
    WHERE
        `books`.`BookID` IN (SELECT 
                `books`.`BookID`
            FROM
                (((((`titles`
                LEFT JOIN `titleauthors` ON ((`titles`.`TitleID` = `titleauthors`.`TitleID`)))
                LEFT JOIN `authors` ON ((`authors`.`AuthorID` = `titleauthors`.`AuthorID`)))
                LEFT JOIN `books` ON ((`titles`.`TitleID` = `books`.`TitleID`)))
                LEFT JOIN `locations` ON ((`locations`.`LocationID` = `books`.`LocationID`)))
                LEFT JOIN `loans` ON ((`loans`.`BookID` = `books`.`BookID`)))
            WHERE
                ((`loans`.`CheckOutDate` IS NOT NULL)
                    AND (`loans`.`ReturnDate` IS NULL)))
            IS FALSE
    ORDER BY `locations`.`Location` DESC , `books`.`BookID`;


CREATE VIEW `blocked_patrons_for_mar_07_22` AS
    SELECT 
        `patrons`.`LastName` AS `Last Name`,
        `patrons`.`FirstName` AS `First Name`,
        `phones`.`Phone` AS `Phone`,
        `cities`.`City` AS `City`
    FROM
        ((((((`patrons`
        JOIN `phones`)
        JOIN `loans`)
        JOIN `addresses`)
        JOIN `cities`)
        JOIN `books`)
        JOIN `titles`)
    WHERE
        ((`cities`.`CityID` = `addresses`.`CityID`)
            AND (`addresses`.`AddressID` = `patrons`.`AddressID`)
            AND (`phones`.`PhoneID` = `patrons`.`PhoneID`)
            AND (`loans`.`PatronID` = `patrons`.`PatronID`)
            AND (`loans`.`BookID` = `books`.`BookID`)
            AND (`books`.`TitleID` = `titles`.`TitleID`)
            AND (`loans`.`ReturnDate` IS NULL)
            AND (`loans`.`DueDate` < DATE '2022-03-07'));


CREATE VIEW `bookid_author_title` AS
    SELECT 
        `authors_by_bookid`.`BookID` AS `BookID`,
        `authors_by_bookid`.`Author` AS `Author`,
        `titles`.`Title` AS `Title`
    FROM
        ((`authors_by_bookid`
        LEFT JOIN `books` ON ((`authors_by_bookid`.`BookID` = `books`.`BookID`)))
        LEFT JOIN `titles` ON ((`books`.`TitleID` = `titles`.`TitleID`)))
    ORDER BY `authors_by_bookid`.`BookID`;
SELECT * FROM `bookid_author_title`;


CREATE VIEW `catalog` AS
    SELECT 
        `bookid_author_title`.`BookID` AS `BookID`,
        `bookid_author_title`.`Author` AS `Author`,
        `bookid_author_title`.`Title` AS `Title`,
        `locations`.`Location` AS `Location`
    FROM
        ((`bookid_author_title`
        LEFT JOIN `books` ON ((`books`.`BookID` = `bookid_author_title`.`BookID`)))
        LEFT JOIN `locations` ON ((`books`.`LocationID` = `locations`.`LocationID`)))
    ORDER BY `books`.`BookID`;


CREATE VIEW `catalog_available_by_author` AS
    SELECT 
        `catalog`.`BookID` AS `BookID`,
        `catalog`.`Author` AS `Author`,
        `catalog`.`Title` AS `Title`,
        `catalog`.`Location` AS `Location`
    FROM
        (`catalog`
        LEFT JOIN `loans` ON ((`loans`.`BookID` = `catalog`.`BookID`)))
    WHERE
        (((`loans`.`CheckOutDate` IS NOT NULL)
            AND (`loans`.`ReturnDate` IS NULL))
            IS FALSE)
    ORDER BY `catalog`.`Author`;


CREATE VIEW `catalog_available_for_mar07` AS
    SELECT 
        `catalog`.`BookID` AS `BookID`,
        `catalog`.`Author` AS `Author`,
        `catalog`.`Title` AS `Title`,
        `catalog`.`Location` AS `Location`
    FROM
        (`catalog`
        LEFT JOIN `loans` ON ((`loans`.`BookID` = `catalog`.`BookID`)))
    WHERE
        (((`loans`.`CheckOutDate` IS NOT NULL)
            AND (`loans`.`ReturnDate` IS NULL))
            IS FALSE);


CREATE VIEW `catalog_full` AS
    SELECT 
        `authors_by_bookid`.`BookID` AS `BookID`,
        `authors_by_bookid`.`Author` AS `Author`,
        `titles`.`Title` AS `Title`,
        `locations`.`Location` AS `Location`
    FROM
        (((`authors_by_bookid`
        LEFT JOIN `books` ON ((`authors_by_bookid`.`BookID` = `books`.`BookID`)))
        LEFT JOIN `titles` ON ((`books`.`TitleID` = `titles`.`TitleID`)))
        LEFT JOIN `locations` ON ((`books`.`LocationID` = `locations`.`LocationID`)))
    ORDER BY `authors_by_bookid`.`BookID`;


CREATE VIEW `city_where_adventure_book_is` AS
    SELECT 
        `books`.`BookID` AS `BookID`,
        `titles`.`Title` AS `Title`,
        `genres`.`Genre` AS `Genre`,
        `cities`.`City` AS `City`
    FROM
        (((((((`genres`
        JOIN `titlegenres`)
        JOIN `titles`)
        JOIN `books`)
        JOIN `loans`)
        JOIN `patrons`)
        JOIN `addresses`)
        JOIN `cities`)
    WHERE
        ((`genres`.`GenreID` = `titlegenres`.`GenreID`)
            AND (`titlegenres`.`TitleID` = `titles`.`TitleID`)
            AND (`titles`.`TitleID` = `books`.`TitleID`)
            AND (`books`.`BookID` = `loans`.`BookID`)
            AND (`loans`.`PatronID` = `patrons`.`PatronID`)
            AND (`patrons`.`AddressID` = `addresses`.`AddressID`)
            AND (`addresses`.`CityID` = `cities`.`CityID`)
            AND (`genres`.`Genre` = 'adventure'));
SELECT * FROM `city_where_adventure_book_is`;

CREATE VIEW `fiction_books` AS
    SELECT 
        `authors`.`LastName` AS `LastName`,
        `authors`.`FirstName` AS `FirstName`,
        `titles`.`Title` AS `Title`,
        `publishers`.`Name` AS `Publisher`
    FROM
        (((((`authors`
        JOIN `titlegenres`)
        JOIN `titles`)
        JOIN `publishers`)
        JOIN `titleauthors`)
        JOIN `genres`)
    WHERE
        ((`genres`.`GenreID` = `titlegenres`.`GenreID`)
            AND (`titlegenres`.`TitleID` = `titles`.`TitleID`)
            AND (`titles`.`PublisherID` = `publishers`.`PublisherID`)
            AND (`titles`.`TitleID` = `titleauthors`.`TitleID`)
            AND (`titleauthors`.`AuthorID` = `authors`.`AuthorID`)
            AND (`genres`.`Genre` = 'fiction'))
    ORDER BY `authors`.`LastName`;


CREATE VIEW `number_of_books_by_branch` AS
    SELECT 
        COUNT(`books`.`BookID`) AS `Number of books`,
        `locations`.`Location` AS `Location`
    FROM
        (`books`
        JOIN `locations`)
    WHERE
        (`books`.`LocationID` = `locations`.`LocationID`)
    GROUP BY `locations`.`Location`
    ORDER BY `locations`.`Location` DESC;


CREATE VIEW `number_of_fiction_and_nonfiction_by_branch` AS
    SELECT 
        `genres`.`Genre` AS `Genre`,
        COUNT(`books`.`BookID`) AS `Number of books`,
        `locations`.`Location` AS `Location`
    FROM
        ((((`genres`
        JOIN `titlegenres`)
        JOIN `titles`)
        JOIN `books`)
        JOIN `locations`)
    WHERE
        ((`genres`.`GenreID` = `titlegenres`.`GenreID`)
            AND (`titlegenres`.`TitleID` = `titles`.`TitleID`)
            AND (`titles`.`TitleID` = `books`.`TitleID`)
            AND (`books`.`LocationID` = `locations`.`LocationID`)
            AND ((`genres`.`GenreID` = 1)
            OR (`genres`.`GenreID` = 2)))
    GROUP BY `locations`.`Location` , `genres`.`GenreID`
    ORDER BY `locations`.`Location` DESC;


CREATE VIEW `unavailable_books_for_mar_7_22` AS
    SELECT 
        `books`.`BookID` AS `BookID`,
        `authors`.`LastName` AS `LastName`,
        `authors`.`FirstName` AS `FirstName`,
        `titles`.`Title` AS `Title`,
        `locations`.`Location` AS `Location`
    FROM
        (((((`titles`
        LEFT JOIN `titleauthors` ON ((`titles`.`TitleID` = `titleauthors`.`TitleID`)))
        LEFT JOIN `authors` ON ((`authors`.`AuthorID` = `titleauthors`.`AuthorID`)))
        LEFT JOIN `books` ON ((`titles`.`TitleID` = `books`.`TitleID`)))
        LEFT JOIN `locations` ON ((`locations`.`LocationID` = `books`.`LocationID`)))
        LEFT JOIN `loans` ON ((`loans`.`BookID` = `books`.`BookID`)))
    WHERE
        ((`loans`.`CheckOutDate` IS NOT NULL)
            AND (`loans`.`ReturnDate` IS NULL))
    ORDER BY `locations`.`Location` DESC , `authors`.`LastName`;

