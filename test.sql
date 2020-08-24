--1. Create the database, named it MyBlog.
CREATE DATABASE MyBlog
GO
USE MyBlog
GO
--2. Create the tables
CREATE TABLE Users(
UserID int PRIMARY KEY IDENTITY,
UserName varchar(20),
Password varchar(30),
Email varchar(30) UNIQUE,
Address nvarchar(200),
)
GO
CREATE TABLE Posts(
PostID int PRIMARY KEY IDENTITY,
Title nvarchar(200),
Content nvarchar,
Tag nvarchar(100),
Status bit,
CreateTime datetime,
UpdateTime datetime,
CONSTRAINT fk_userID FOREIGN KEY (UserID) REFERENCES dbo.Users(UserID)
)
GO
CREATE TABLE Comments(
CommentID int PRIMARY KEY IDENTITY,
Content nvarchar(500),
Status Bit,
CreateTime datetime DEFAULT GETDATE(),
Author nvarchar(30),
Email varchar(50) NOT NULL,
CONSTRAINT fk_postID FOREIGN KEY (PostID) REFERENCES dbo.Posts(PostID)
)
GO
--3. Create a constraint (CHECK) to ensure value of Email column (on the Users table and the Comments table) always contain the ‘@’ character.	
ALTER TABLE dbo.Users
ADD CONSTRAINT chk_emailUsers CHECK (Email LIKE '%@%')
--4. Create an unique, none-clustered index named IX_UserName on UserName column on table Users.
CREATE NONCLUSTERED INDEX IX_UserName 
ON dbo.Users(UserName);
GO
--5. Insert into above tables at least 3 records per table.
INSERT INTO dbo.Users VALUES
('yahyeet', '694201', 'yahyeet@gamil.com', '420 sixnine street'),
('yahyet', '694401', 'yaheet@gamil.com', '440 sixnine street'),
('yaheet', '694211', 'yahyet@gamil.com', '424 sixnine street');
SELECT * FROM dbo.Users

INSERT INTO dbo.Posts VALUES
('clutches5', 'lmaook', '#bruh', 0, '2020/01/01', '2020/12/12', 1),
('clutches1', 'lamook', '#pog', 1, '2020/02/02', '2020/11/11', 3),
('clutches3', 'lmoaok', '#Social', 2, '2020/03/03', '2020/10/10', 2);
SELECT * FROM dbo.Posts

INSERT INTO dbo.Comments VALUES
('deeznutz', 1, '2020/09/09', 'pogchop', 'pog@gmail.com', 1),
('deeznut', 0, '2020/08/08', 'pigchop', 'abc@gmail.com', 2),
('deenutz', 2, '2020/07/07', 'pogchip', 'peg@gmail.com', 3);
SELECT * FROM dbo.Comments

--6. Create a query to select the postings has the ‘Social’ tag.
SELECT * FROM dbo.Posts
WHERE Tag='#Social';
--7. Create a query to select the postings that have author who has ‘abc@gmail.com’ email.
SELECT * FROM dbo.Comments
Where Email='abc@gmail.com';
SELECT * FROM dbo.Users
Where Email='abc@gmail.com';

--8. Create a query to count the total comments of the posting.
SELECT COUNT(DISTINCT CommentID) FROM dbo.Comments;