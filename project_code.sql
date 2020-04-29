create database if not exists Library_database13;

use Library_database13;


-- ALL THE TABLES ARE HERE

CREATE TABLE if not exists Employee  
(  
EmployeeID int not null primary key,  
FirstName varchar(255) not null,  
LastName varchar(255) not null,  
Email varchar(255) not null,  
AddressLine varchar(255) not null,  
City varchar(255) not null ,
BranchID int not null
);  

CREATE TABLE if not exists Book  
(  
ISBN int not null primary key,  
Book_Title varchar(255) not null,  
AuthorID int not null,  
Price int not null
);  

CREATE TABLE if not exists Book_copies  
(  
Book_ID int not null primary key,
ISBN int not null ,  
BranchID int not null,
status_book int DEFAULT 1
); 

CREATE TABLE if not exists Author  
(    
AuthorID int not null primary key,  
FirstName varchar(255) not null,  
LastName varchar(255) not null, 
Style varchar(255) not null 
);  

CREATE TABLE if not exists  Branch 
(  
BranchID int not null primary key,  
Address varchar(255) not null,  
manager varchar(255) not null
);  

CREATE TABLE if not exists Customer  
(  
CustomerID int not null primary key,  
FirstName varchar(255) not null,  
LastName varchar(255) not null,  
Email varchar(255) not null,  
AddressLine varchar(255) not null,  
City varchar(255) not null ,
Phone_number int not null,
Valid int not null DEFAULT 0 
); 

CREATE TABLE if not exists LibCard  
(  
Cardnumber int not null primary key,
CustomerID int not null ,  
Issue_date date,
Valid_till date
); 

CREATE TABLE if not exists finelist  
(  
BorrowedID int not null,
Cardnumber int not null,
Number_of_days int not null,
fine int not null
); 

 CREATE TABLE if not exists Borrowed  
(  
BorrowedID int not null primary key,  
Cardnumber int not null,
EmployeeID int not null,
Book_ID int not null,
Date_issue  DATE not null 
); 

Create table MyLog2 (message varchar(70));

CREATE TABLE if not exists Borrowedlist  
(  
BorrowedID int not null,
Cardnumber int not null,
EmployeeID int not null,
Book_ID int not null,
updated_at date
); 

 CREATE TABLE if not exists fine  
(  
BorrowedID int not null primary key,  
Cardnumber int not null,
Number_of_days int not null,
fine int not null
); 

Create table MyLog (message varchar(70));

CREATE TABLE if not exists books_after  
(  
ISBN int ,  
Book_Title  varchar(255)  ,
AuthorID int ,
Price int,
updated_at date
); 



-- ALL THE TRIGGERS ARE HERE



DELIMITER $$
CREATE TRIGGER  books_after_insert
AFTER INSERT
   ON book FOR EACH ROW
BEGIN
    insert into  books_after
    values(
        new.ISBN, 
        new.Book_Title,
        new.AuthorID,
        new.Price,
        NOW()
    );
END;
$$


DELIMITER $$
CREATE TRIGGER  Borrow_list_create
AFTER INSERT
   ON Borrowed FOR EACH ROW
BEGIN
    insert into  Borrowedlist
    values(
        new.BorrowedID, 
        new.Cardnumber,
        new.EmployeeID,
        new.Book_ID,
        NOW()
    );
END;
$$


DELIMITER $$
CREATE TRIGGER  fine_list_create
AFTER INSERT
   ON fine FOR EACH ROW
BEGIN
    insert into  finelist
    values(
        new.BorrowedID, 
        new.Cardnumber,
        new.Number_of_days,
        new.fine        
    );
END;
$$






Delimiter $$
create trigger Addauthor 
before insert on Book
for each row
Begin
declare temp Int;
 set temp=0;
select count(*) into temp from Book, Author where
Book.AuthorID=Author.AuthorID
and Author.AuthorID=new.AuthorID;
if temp=0 then
insert into mylog values(concat("Author ",new.AuthorID, " is not in the system"));
end if;
end;
$$



Delimiter $$
create trigger Statuschange 
before insert on Customer
for each row
Begin
declare temp Int;
 set temp=0;
select count(*) into temp from Customer, LibCard where
Customer.CustomerID=LibCard.CustomerID
and LibCard.CustomerID=new.CustomerID;
if temp=0 then
insert into mylog2 values(concat("Change Valid value to 1 for ",new.CustomerID));
end if;
end;
$$

-- ALL THE DATA IS HERE

INSERT INTO author
VALUES ("1","Ben","Red","Romance");
INSERT INTO author
VALUES ("2","Dave","Ford","Fiction");
INSERT INTO author
VALUES ("3","Tony","Gupta","Horror");
INSERT INTO author
VALUES ("4","Deep","Dan","Fiction");
INSERT INTO author
VALUES ("5","Sam","Red","Romance");
INSERT INTO author
VALUES ("6","John","Ford","Fiction");
INSERT INTO author
VALUES ("7","Stella","Gupta","Horror");
INSERT INTO author
VALUES ("8","Navi","Dan","Fiction");


INSERT INTO book
VALUES ("0001","Hello part1","1","125");
INSERT INTO book
VALUES ("0002","Hello world 2","8","215");
INSERT INTO book
VALUES ("0003","Hello","3","25");
INSERT INTO book
VALUES ("0004","Hello world 1","8","215");
INSERT INTO book
VALUES ("0005","Hello part2","1","125");
INSERT INTO book
VALUES ("0006","Hello world 3","4","215");
INSERT INTO book
VALUES ("0007","Hello","6","25");
INSERT INTO book
VALUES ("0008","Hello world 1","20","215");
INSERT INTO book
VALUES ("0009","Hello world 7","21","215");
INSERT INTO book
VALUES ("0010","Hello world 5","8","215");

INSERT INTO book_copies
VALUES ("1","0008","1","1");
INSERT INTO book_copies
VALUES ("2","0007","2","1");
INSERT INTO book_copies
VALUES ("3","0005","1","1");
INSERT INTO book_copies
VALUES ("4","0005","2","1");
INSERT INTO book_copies
VALUES ("5","0003","1","1");
INSERT INTO book_copies
VALUES ("6","0003","2","1");
INSERT INTO book_copies
VALUES ("7","0006","1","1");
INSERT INTO book_copies
VALUES ("8","0001","2","1");
INSERT INTO book_copies
VALUES ("9","0002","1","1");
INSERT INTO book_copies
VALUES ("10","005","2","1");


INSERT INTO Borrowed
VALUES ("1","1","1","1",STR_TO_DATE('1-01-2020', '%d-%m-%Y'));
INSERT INTO Borrowed
VALUES ("2","2","3","2",STR_TO_DATE('1-01-2020', '%d-%m-%Y'));
INSERT INTO Borrowed
VALUES ("3","3","2","8",STR_TO_DATE('1-01-2020', '%d-%m-%Y'));
INSERT INTO Borrowed
VALUES ("4","5","3","5",STR_TO_DATE('1-01-2020', '%d-%m-%Y'));

INSERT INTO branch
VALUES ("1","Richard street,VA","DAN");
INSERT INTO branch
VALUES ("2","Red street,DC","DON");


INSERT INTO customer
VALUES ("1","DON","Dyne","sakjsajkj@gmail.com","Red street,DC","JC","123491","0");
INSERT INTO customer
VALUES ("2","John","Dyne","sajkj@gmail.com","blue street,DC","JC","12332291","0");
INSERT INTO customer
VALUES ("3","DON","Dyne","sakjsadgbaksajkj@gmail.com","green street,DC","JC","123333","0");
INSERT INTO customer
VALUES ("4","John","Dyne","sajkj@gmail.com","Richard street,VA","VC","1233291","0");
INSERT INTO customer
VALUES ("5","DON","Dyne","sakjsajkj@gmail.com","Red street,DC","JC","1234567","0");
INSERT INTO customer
VALUES ("6","John","Dyne","sajkj@gmail.com","blue street,DC","JC","12332291","0");
INSERT INTO customer
VALUES ("7","DON","Dyne","sakjsadgbaksajkj@gmail.com","green street,DC","JC","123333","0");
INSERT INTO customer
VALUES ("8","John","Dyne","sajkj@gmail.com","Richard street,VA","VC","123321","0");



INSERT INTO fine
VALUES ("1","1","2","20");
INSERT INTO fine
VALUES ("3","3","10","100");

INSERT INTO libcard
VALUES ("1","2",STR_TO_DATE('1-01-2020', '%d-%m-%Y'),STR_TO_DATE('1-01-2021', '%d-%m-%Y'));
INSERT INTO libcard
VALUES ("2","1",STR_TO_DATE('1-11-2020', '%d-%m-%Y'),STR_TO_DATE('1-11-2021', '%d-%m-%Y'));
INSERT INTO libcard
VALUES ("3","6",STR_TO_DATE('1-01-2020', '%d-%m-%Y'),STR_TO_DATE('1-01-2021', '%d-%m-%Y'));
INSERT INTO libcard
VALUES ("4","7",STR_TO_DATE('1-11-2020', '%d-%m-%Y'),STR_TO_DATE('1-11-2021', '%d-%m-%Y'));
INSERT INTO libcard
VALUES ("5","8",STR_TO_DATE('1-11-2020', '%d-%m-%Y'),STR_TO_DATE('1-11-2021', '%d-%m-%Y'));


