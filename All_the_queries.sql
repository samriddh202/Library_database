-- Selecting  names of books who's author style is Romance
select * from Library_database13.author;
Select * from Library_database13.book;

select Book_title 
from Library_database13.book, Library_database13.author
where  Library_database13.book.AuthorID=Library_database13.author.AuthorID
AND Library_database13.author.Style="Romance" ;


-- Selection Total number of Author in each style

select * from Library_database13.author;
select Style,count(Style)
from Library_database13.author
group by style;

-- Select all the names of people who have borrowed a book

select * from Library_database13.customer;
select * from Library_database13.libcard;
select * from Library_database13.borrowed;


select FirstName,Lastname 
from Library_database13.customer
where CustomerID in
(select CustomerID 
	from Library_database13.libcard
	where cardnumber in 
	(select Cardnumber 
    from Library_database13.borrowed)
    ); 
    
-- Interst a table in author

insert into Library_database13.author values(20,"Sam","Gupta","Horror");
insert into Library_database13.author values(11,"Sam","Gupta","Comedy");
insert into Library_database13.author values(12,"jane","Nay","Comedy");
insert into Library_database13.author values(13,"sony","sha","Comedy");
select * from Library_database13.author;

-- delete a fine for paid customer
select * from Library_database13.borrowed;

delete from Library_database13.borrowed
where Library_database13.borrowed.BorrowedID in
(select BorrowedID from   Library_database13.fine
where BorrowedID="3" );

select * from Library_database13.borrowed;

-- Updating  all comedy style to funny style
select * from Library_database13.author;
update Library_database13.author
set Style="Funny"
where Style="Comedy";
select * from Library_database13.author;

-- Update the fine for the table
select * from Library_database13.fine;

update Library_database13.fine
set fine= number_of_days *5;

select * from Library_database13.fine;

-- View employee who issue books

create view book_issue_by as
select * from  Library_database13.employee
where EmployeeID in
(select EmployeeID from Library_database13.borrowed );

select * from book_issue_by;

-- view all books where style is Horror
create view Horror_Club as
select * from  Library_database13.author
where Style="Horror";

select * from Horror_Club;

-- All the trigger results

select * from Library_database13.mylog; 
select * from Library_database13.mylog2;
select * from Library_database13.books_after;
select * from Library_database13.borrowedlist;
select * from Library_database13.finelist;

-- Update the status of book who are borrowed
select * from  Library_database13.book_copies;
Update Library_database13.book_copies
set status_book=0
where Library_database13.book_copies.Book_ID in 
(select Book_ID from Library_database13.borrowed);
select * from  Library_database13.book_copies;


-- Update the validation of customer
select * from  Library_database13.customer;
Update Library_database13.customer
set Valid=1
where Library_database13.customer.CustomerID in 
(select CustomerID from Library_database13.libcard);
select * from  Library_database13.customer;

