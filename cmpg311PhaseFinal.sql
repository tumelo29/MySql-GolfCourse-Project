--Drop Tables--
DROP TABLE BookingPlayer CASCADE CONSTRAINTS;
DROP TABLE CaddieAssignment CASCADE CONSTRAINTS;
DROP TABLE EquipmentRental CASCADE CONSTRAINTS;
DROP TABLE Sale CASCADE CONSTRAINTS;
DROP TABLE Lesson CASCADE CONSTRAINTS;
DROP TABLE Hole CASCADE CONSTRAINTS;
DROP TABLE MaintenanceLog CASCADE CONSTRAINTS;
DROP TABLE TeeTimeBooking CASCADE CONSTRAINTS;
DROP TABLE Equipment CASCADE CONSTRAINTS;
DROP TABLE Instructor CASCADE CONSTRAINTS;
DROP TABLE Caddie CASCADE CONSTRAINTS;
DROP TABLE Member CASCADE CONSTRAINTS;
DROP TABLE MembershipTier CASCADE CONSTRAINTS;
DROP TABLE ProShopItem CASCADE CONSTRAINTS;
DROP TABLE GolfCourse CASCADE CONSTRAINTS;

--Drop Sequences--
DROP SEQUENCE seq_tierid;
DROP SEQUENCE seq_memberid;
DROP SEQUENCE seq_bookingid;
DROP SEQUENCE seq_equipmentid;
DROP SEQUENCE seq_instructorid;
DROP SEQUENCE seq_lessonid;
DROP SEQUENCE seq_courseid;
DROP SEQUENCE seq_holeid;
DROP SEQUENCE seq_logid;
DROP SEQUENCE seq_itemid;
DROP SEQUENCE seq_saleid;
DROP SEQUENCE seq_caddieid;

--Creation of Tables
CREATE TABLE MembershipTier (
    TierID NUMBER PRIMARY KEY,
    TierName VARCHAR2(50) NOT NULL,
    TierPrivileges VARCHAR2(100)
);

CREATE TABLE Member (
    MemberID NUMBER PRIMARY KEY,
    TierID NUMBER,
    Name VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    Phone VARCHAR2(15),
    FOREIGN KEY (TierID) REFERENCES MembershipTier(TierID)
);

CREATE TABLE TeeTimeBooking (
    BookingID NUMBER PRIMARY KEY,
    BookingDate DATE,
    TimeSlot VARCHAR2(20)
);

CREATE TABLE BookingPlayer (
    MemberID NUMBER,
    BookingID NUMBER,
    PRIMARY KEY (MemberID, BookingID),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (BookingID) REFERENCES TeeTimeBooking(BookingID)
);

CREATE TABLE Equipment (
    EquipmentID NUMBER PRIMARY KEY,
    EquipmentName VARCHAR2(50) NOT NULL,
    Price NUMBER(10,2),
    EquipmentDescription VARCHAR2(100)
);

CREATE TABLE EquipmentRental (
    MemberID NUMBER,
    EquipmentID NUMBER,
    RentalDate DATE,
    ReturnDate DATE,
    PRIMARY KEY (MemberID, EquipmentID, RentalDate),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);

CREATE TABLE Instructor (
    InstructorID NUMBER PRIMARY KEY,
    FullName VARCHAR2(100),
    Specialty VARCHAR2(50),
    ExperienceYears NUMBER
);

CREATE TABLE Lesson (
    LessonID NUMBER PRIMARY KEY,
    MemberID NUMBER,
    InstructorID NUMBER,
    LessonDate DATE,
    LessonTime VARCHAR2(20),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

CREATE TABLE GolfCourse (
    CourseID NUMBER PRIMARY KEY,
    CourseName VARCHAR2(100),
    Location VARCHAR2(100)
);

CREATE TABLE Hole (
    HoleID NUMBER PRIMARY KEY,
    CourseID NUMBER,
    Par NUMBER,
    Difficulty NUMBER,
    FOREIGN KEY (CourseID) REFERENCES GolfCourse(CourseID)
);

CREATE TABLE MaintenanceLog (
    LogID NUMBER PRIMARY KEY,
    CourseID NUMBER,
    Activity VARCHAR2(100),
    MaintenanceDate DATE,
    Status VARCHAR2(50),
    FOREIGN KEY (CourseID) REFERENCES GolfCourse(CourseID)
);

CREATE TABLE ProShopItem (
    ItemID NUMBER PRIMARY KEY,
    ItemName VARCHAR2(100),
    Price NUMBER(10,2),
    StockLevel NUMBER
);

CREATE TABLE Sale (
    SaleID NUMBER PRIMARY KEY,
    MemberID NUMBER,
    ItemID NUMBER,
    DateSold DATE,
    Quantity NUMBER,
    TotalAmount NUMBER(10,2),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (ItemID) REFERENCES ProShopItem(ItemID)
);

CREATE TABLE Caddie (
    CaddieID NUMBER PRIMARY KEY,
    FullName VARCHAR2(100),
    ExperienceLevel VARCHAR2(50)
);

CREATE TABLE CaddieAssignment (
    BookingID NUMBER,
    CaddieID NUMBER,
    AssignmentTime VARCHAR2(20),
    PRIMARY KEY (BookingID, CaddieID),
    FOREIGN KEY (BookingID) REFERENCES TeeTimeBooking(BookingID),
    FOREIGN KEY (CaddieID) REFERENCES Caddie(CaddieID)
);

--Check Constraints--
ALTER TABLE Equipment ADD CONSTRAINT chk_price CHECK (Price > 0);
ALTER TABLE Hole ADD CONSTRAINT chk_par CHECK (Par BETWEEN 3 AND 5);
ALTER TABLE Sale ADD CONSTRAINT chk_quantity CHECK (Quantity > 0);

--Creation of Sequences--
CREATE SEQUENCE seq_tierid START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_memberid START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_bookingid START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_equipmentid START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_instructorid START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_lessonid START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_courseid START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_holeid START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_logid START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_itemid START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_saleid START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_caddieid START WITH 1 INCREMENT BY 1;

--Indexes--
CREATE INDEX idx_member_name ON Member(Name);


CREATE INDEX idx_booking_date ON TeeTimeBooking(BookingDate);


CREATE INDEX idx_equipment_name ON Equipment(EquipmentName);


CREATE INDEX idx_sale_date ON Sale(DateSold);


CREATE INDEX idx_lesson_date ON Lesson(LessonDate);


--Inserting Data--
--Membership Tier--
INSERT INTO MembershipTier VALUES (seq_tierid.NEXTVAL, 'Gold', 'Full Access');
INSERT INTO MembershipTier VALUES (seq_tierid.NEXTVAL, 'Silver', 'Limited Access');
INSERT INTO MembershipTier VALUES (seq_tierid.NEXTVAL, 'Bronze', 'Basic Access');

--Member--
INSERT INTO Member VALUES (seq_memberid.NEXTVAL, 1, 'Jayden Adams', 'JAdams@gmail.com', '0712345678');
INSERT INTO Member VALUES (seq_memberid.NEXTVAL, 1, 'Bill Williams', 'BillWilliams@hotmail.co.za', '0723456789');
INSERT INTO Member VALUES (seq_memberid.NEXTVAL, 2, 'Sipho Dlamini', 'sipho@mail.com', '0734567890');
INSERT INTO Member VALUES (seq_memberid.NEXTVAL, 3, 'Robert Broom', 'BroomR@icloud.com', '0818588952');

--BookingPlayer--
INSERT INTO BookingPlayer VALUES (1,1);
INSERT INTO BookingPlayer VALUES (2,1);
INSERT INTO BookingPlayer VALUES (3,1);

INSERT INTO BookingPlayer VALUES (1,2);
INSERT INTO BookingPlayer VALUES (4,2);
INSERT INTO BookingPlayer VALUES (5,2);
SELECT * FROM bookingplayer;
--TeeTimeBooking--
INSERT INTO TeeTimeBooking VALUES (seq_bookingid.NEXTVAL, SYSDATE-1, '08:00');
INSERT INTO TeeTimeBooking VALUES (seq_bookingid.NEXTVAL, SYSDATE-2, '09:00');
INSERT INTO TeeTimeBooking VALUES (seq_bookingid.NEXTVAL, SYSDATE+2, '11:00');
INSERT INTO TeeTimeBooking VALUES (seq_bookingid.NEXTVAL, SYSDATE+1, '13:00');
INSERT INTO TeeTimeBooking VALUES (seq_bookingid.NEXTVAL, SYSDATE+3, '15:30');

--Equipment--
INSERT INTO Equipment VALUES (seq_equipmentid.NEXTVAL, 'Golf Bag', 750.20, '1 Bag');
INSERT INTO Equipment VALUES (seq_equipmentid.NEXTVAL, 'Golf Sticks', 200.30, 'Pack of Sticks');
INSERT INTO Equipment VALUES (seq_equipmentid.NEXTVAL, 'Golf Gloves', 300.99, '3 Gloves');
INSERT INTO Equipment VALUES (seq_equipmentid.NEXTVAL, 'Gold Shoes', 1750.15, 'Pair of Shoes');

--EquipmentRental--
INSERT INTO EquipmentRental VALUES (1,1,SYSDATE,SYSDATE-3);
INSERT INTO EquipmentRental VALUES (2,2,SYSDATE,SYSDATE-1);
INSERT INTO EquipmentRental VALUES (3,1,SYSDATE,SYSDATE+1);
INSERT INTO EquipmentRental VALUES (4,2,SYSDATE,SYSDATE);

--Instructor--
INSERT INTO Instructor VALUES (seq_instructorid.NEXTVAL, 'Petrer Jones', 'Swing Coach', 5);
INSERT INTO Instructor VALUES (seq_instructorid.NEXTVAL, 'John Smith', 'Putting Coach', 8);
INSERT INTO Instructor VALUES (seq_instructorid.NEXTVAL, 'David Lee', 'Begginner Coach', 3);
INSERT INTO Instructor VALUES (seq_instructorid.NEXTVAL, 'Nkosikhona Bukhali', 'Short Game Coach', 1);

--Lesson--
INSERT INTO Lesson VALUES (seq_lessonid.NEXTVAL, 1, 1, SYSDATE-1, '09:00');
INSERT INTO Lesson VALUES (seq_lessonid.NEXTVAL, 1, 1, SYSDATE, '10:30');
INSERT INTO Lesson VALUES (seq_lessonid.NEXTVAL, 1, 1, SYSDATE+1, '12:00');
INSERT INTO Lesson VALUES (seq_lessonid.NEXTVAL, 1, 1, SYSDATE+2, '14:30');

--Golf Course--
INSERT INTO GolfCourse VALUES (seq_courseid.NEXTVAL, 'Elite Golf Club', 'Johannesburg South');
INSERT INTO GolfCourse VALUES (seq_courseid.NEXTVAL, 'Private Golf Club', 'Johannesburg East');
INSERT INTO GolfCourse VALUES (seq_courseid.NEXTVAL, 'Basic Golf Club', 'Johannesburg North');

--Caddie--
INSERT INTO Caddie VALUES (seq_caddieid.NEXTVAL, 'Mike Adams', 'Experienced');
INSERT INTO Caddie VALUES (seq_caddieid.NEXTVAL, 'Chris Paul', 'Intermediate');
INSERT INTO Caddie VALUES (seq_caddieid.NEXTVAL, 'James Dube', 'Beginner');

--CaddieAssignment--
INSERT INTO CaddieAssignment VALUES (1, 1, '08:00');
INSERT INTO CaddieAssignment VALUES (2, 2, '09:00');
INSERT INTO CaddieAssignment VALUES (3, 3, '11:00');
INSERT INTO CaddieAssignment VALUES (4, 2, '13:00');

--ProShop Item--
INSERT INTO ProShopItem VALUES (seq_itemid.NEXTVAL, 'Golf Balls Pack', 250, 50);
INSERT INTO ProShopItem VALUES (seq_itemid.NEXTVAL, 'Golf Shoes', 1200, 20);
INSERT INTO ProShopItem VALUES (seq_itemid.NEXTVAL, 'Golf Gloves', 300, 30);

--Sales--
INSERT INTO Sale VALUES (seq_saleid.NEXTVAL, 1, 1, SYSDATE-1, 2, 500);
INSERT INTO Sale VALUES (seq_saleid.NEXTVAL, 2, 2, SYSDATE+2, 1, 1200);
INSERT INTO Sale VALUES (seq_saleid.NEXTVAL, 3, 3, SYSDATE, 3, 900);
INSERT INTO Sale VALUES (seq_saleid.NEXTVAL, 1, 2, SYSDATE+3, 2, 500);

--Holes--
INSERT INTO Hole VALUES (seq_holeid.NEXTVAL, 1, 4, 3);
INSERT INTO Hole VALUES (seq_holeid.NEXTVAL, 1, 5, 4);
INSERT INTO Hole VALUES (seq_holeid.NEXTVAL, 1, 3, 2);
INSERT INTO Hole VALUES (seq_holeid.NEXTVAL, 1, 4, 5);

--MaintainanceLog--
INSERT INTO MaintenanceLog VALUES (seq_logid.NEXTVAL, 1, 'Grass Cutting', SYSDATE-2, 'Completed');
INSERT INTO MaintenanceLog VALUES (seq_logid.NEXTVAL, 2, 'Irrigation Check', SYSDATE+2, 'Pending');
INSERT INTO MaintenanceLog VALUES (seq_logid.NEXTVAL, 3, 'Sand Trap Repair', SYSDATE-4, 'Completed');
INSERT INTO MaintenanceLog VALUES (seq_logid.NEXTVAL, 2, 'Equipment Check', SYSDATE+3, 'Pending');
INSERT INTO MaintenanceLog VALUES (seq_logid.NEXTVAL, 3, 'Hole Check', SYSDATE+1, 'Pending');
INSERT INTO MaintenanceLog VALUES (seq_logid.NEXTVAL, 1, 'Cleaning', SYSDATE, 'Completed');

--Views--
CREATE VIEW MemberBookings AS
SELECT m.Name, b.BookingDate
FROM Member m, BookingPlayer bp, TeeTimeBooking b
WHERE m.MemberID = bp.MemberID
AND bp.BookingID = b.BookingID;

CREATE VIEW EquipmentRentalDetails AS
SELECT m.Name, e.EquipmentName, er.RentalDate, er.ReturnDate
FROM Member m, Equipment e, EquipmentRental er
WHERE m.MemberID = er.MemberID
AND e.EquipmentID = er.EquipmentID;

CREATE VIEW LessonDetails AS
SELECT m.Name AS MemberName,
       i.Name AS InstructorName,
       l.LessonDate,
       l.LessonTime
FROM Member m, Instructor i, Lesson l
WHERE m.MemberID = l.MemberID
AND i.InstructorID = l.InstructorID;

CREATE VIEW CourseMaintenance AS
SELECT g.CourseName,
       ml.Activity,
       ml.MaintenanceDate,
       ml.Status
FROM GolfCourse g, MaintenanceLog ml
WHERE g.CourseID = ml.CourseID;

--Queries--
--Limitation of Rows
SELECT *
FROM Member
WHERE ROWNUM <= 3;
SELECT m.Name,
       t.TierName
FROM Member m, MembershipTier t
WHERE m.TierID = t.TierID
AND t.TierName = 'Gold';

--Sorting--
SELECT * FROM Member ORDER BY Name;

--LIKE/AND/OR--
SELECT * FROM Member WHERE Name LIKE 'J%';

--CHARACTER fUNCTIONS--
SELECT UPPER(Name), LOWER(Email), SUBSTR(Name,1,3)
FROM Member;

--ROUND--
SELECT ROUND(Price,2) FROM Equipment;

--DATE--
SELECT MemberID,
       LessonDate,
       LessonDate + 7 AS NextLessonReminder
FROM Lesson;

--AGGREGATE--
SELECT COUNT(*) FROM Member;
SELECT * FROM member;

--GROUP BY--
SELECT TierID, COUNT(*)
FROM Member
GROUP BY TierID
HAVING COUNT(*) > 1;

 --JOIN--
 SELECT m.Name,
       e.EquipmentName,
       er.RentalDate,
       er.ReturnDate
FROM Member m
JOIN EquipmentRental er
    ON m.MemberID = er.MemberID
JOIN Equipment e
    ON er.EquipmentID = e.EquipmentID;
 
--SUB QUERY (Members who have booked or attended lessons)--
SELECT Name
FROM Member
WHERE MemberID IN (SELECT MemberID FROM Lesson);--
SELECT m.Name,
       COUNT(bp.BookingID) AS TotalBookings
FROM Member m, BookingPlayer bp
WHERE m.MemberID = bp.MemberID
GROUP BY m.Name
ORDER BY TotalBookings DESC;
