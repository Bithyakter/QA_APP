--USE [master]
--GO
--CREATE DATABASE [QAAppDB]
--GO

--USE [QAAppDB]
--GO

----===================== TABLE ===============================
--CREATE TABLE [dbo].[Users](
--	[UserID] INT IDENTITY(1,1) PRIMARY KEY,
--	[UserName] VARCHAR(100) NOT NULL,
--	[Email] VARCHAR(100) NULL,
--	[Password] VARCHAR(200) NULL,
--	CreatedDate SMALLDATETIME NULL
--);


--CREATE TABLE [dbo].[Categories](
--	[CategoryID] INT IDENTITY(1,1) PRIMARY KEY,
--	[CategoryName] VARCHAR(255) NOT NULL
--);

--CREATE TABLE [dbo].[Tags](
--	[TagID] INT IDENTITY(1,1) PRIMARY KEY,
--	[TagName] VARCHAR(255) NOT NULL
--);

--CREATE TABLE [dbo].[Questions](
--	[QuestionID] INT IDENTITY(1,1) PRIMARY KEY,
--	[Title] NVARCHAR(255) NOT NULL,	
--	[Question] NVARCHAR(MAX) NOT NULL,	
--	[Description] NVARCHAR(MAX) NULL,
--	[CategoryID] INT NOT NULL,
--	[TagID] INT NULL,
--	[VoteCount] INT NULL,
--	[CreatedBy] INT NOT NULL,
--	[CreatedDate] SMALLDATETIME NOT NULL
--);

--CREATE TABLE [dbo].[Answers](
--	[AnswerID] INT IDENTITY(1,1) PRIMARY KEY,
--	[QuestionID] INT NOT NULL,
--	[Answer] NVARCHAR(MAX) NOT NULL,
--	[Description] NVARCHAR(MAX) NULL,
--	[CreatedBy] INT NOT NULL,
--	[CreatedDate] SMALLDATETIME NOT NULL,
--	[AnswerAcceptedBy] NVARCHAR(255) NULL,
--	[AcceptedDate] SMALLDATETIME NULL
--);

--CREATE TABLE [dbo].[Comments](
--	[CommentID] INT IDENTITY(1,1) PRIMARY KEY,
--	[QuestionID] INT NOT NULL,
--	[Description] NVARCHAR(MAX) NULL,
--	[CreatedBy] INT NOT NULL,
--	[CreatedDate] SMALLDATETIME NOT NULL
--);

--GO

----===================== STORE PROCEDURE ===============================

--CREATE PROCEDURE [dbo].[CreateUser]
--	@UserName NVARCHAR(200),
--	@Email NVARCHAR(100),
--	@Password NVARCHAR(50),
--	@CreatedDate DATETIME
--AS
--	INSERT INTO Users(UserName, Email, Password)
--	VALUES(@UserName,@Email, @Password, @CreatedDate);

--GO

--CREATE PROCEDURE [dbo].[sp_GetUsers]
--	@UserName NVARCHAR(100),
--	@Password NVARCHAR(100)
--AS 
--	SELECT 
--		UserID, UserName, Password 
--	FROM 
--		Users
--	WHERE 
--		UserName = @UserName AND Password = @Password
--GO

--CREATE PROCEDURE [dbo].[sp_CreateQuestion]
--	@Title NVARCHAR(255),
--	@Question  NVARCHAR(MAX),
--	@Description NVARCHAR(MAX),
--    @CategoryID INT,
--	@TagID INT,
--    @VoteCount INT,
--    @CreatedBy INT,
--    @CreatedDate SMALLDATETIME
--AS
--BEGIN
--	INSERT INTO Questions(Title, Question, Description, CategoryID, TagID, VoteCount, CreatedBy, CreatedDate)
--	VALUES(@Title, @Question, @Description, @CategoryID, @TagID, @VoteCount, @CreatedBy, @CreatedDate);
--END
--GO

--CREATE PROCEDURE [dbo].[sp_CreateAnswer]
--	@QuestionID INT,
--	@Answer NVARCHAR(MAX),
--    @Description NVARCHAR(MAX),
--    @CreatedBy INT,
--    @CreatedDate SMALLDATETIME,
--	@AnswerAcceptedBy NVARCHAR(100)= NULL,
--	@AcceptedDate SMALLDATETIME = NULL
--AS
--BEGIN
--	INSERT INTO Answers (QuestionID, Answer, Description, CreatedBy, CreatedDate, AnswerAcceptedBy, AcceptedDate)
--	VALUES(@QuestionID, @Answer, @Description, @CreatedBy, @CreatedDate,  @AnswerAcceptedBy,@AcceptedDate);
--END

--GO

--CREATE PROCEDURE [dbo].[sp_GetAllUsers]
--AS
--	SELECT * FROM Users;
--GO

--CREATE PROCEDURE [dbo].[sp_GetQuestions]
--AS
--	SELECT * FROM Questions;
--GO

--CREATE PROCEDURE [dbo].[sp_GetCategories]
--AS
--	SELECT * FROM Categories;
--GO

--CREATE PROCEDURE [dbo].[sp_GetTages]
--AS
--	SELECT * FROM Tags;
--GO

--CREATE PROCEDURE [dbo].[sp_GetAllQuestions]
--AS
--	SELECT 
--		qs.QuestionID, 
--		qs.CategoryID, 
--		qs.TagID,
--		qs.Title, 
--		qs.Question, 
--		qs.Description, 
--		qs.VoteCount,
--		u.UserName,
--		qs.CreatedDate,
--		(SELECT COUNT(*) FROM Answers WHERE Answers.QuestionID = qs.QuestionID) AS TotalAnswer
--FROM 
--	Questions qs
--	INNER JOIN Users u ON qs.CreatedBy = u.UserID
--GO

--GO
--CREATE PROCEDURE [dbo].[sp_GetQuestionByID]
--	@QuestionID INT 
--AS
--	SELECT 
--		qes.QuestionID, qes.Title,  qes.CategoryID,  ISNULL(qes.TagID, '') AS TagID, qes.Question,
--		ISNULL(qes.Description, '') AS [Description], ISNULL(VoteCount, '') AS VoteCount,
--		u.UserName, qes.CreatedDate
--	FROM 
--		Questions qes
--		INNER JOIN Users u ON qes.CreatedBy = u.UserID
--	WHERE 
--		qes.QuestionID = @QuestionID;
--GO

--CREATE PROCEDURE [dbo].[sp_GetAnswerByQuestionID]
--	@QuestionID INT 
--AS
--BEGIN
--	SELECT 
--        an.AnswerID,
--        an.QuestionID,
--        an.Answer,
--        an.Description,
--        u.UserName,	--MAKE BY
--        an.CreatedDate,     
--        ISNULL(AnswerAcceptedBy, '') AS AnswerAcceptedBy,
--        ISNULL(AcceptedDate, '') AS AcceptedDate 
--    FROM  
--		Answers an
--		INNER JOIN Users u ON an.CreatedBy = u.UserID
--    WHERE 
--        QuestionID = @QuestionID
--END;

--GO
--CREATE PROCEDURE [dbo].[sp_GetQuestionsByUserID]
--    @UserID INT
--AS
--BEGIN
--    SELECT 
--        qs.QuestionID,
--        qs.Title,
--		qs.Question,
--		qs.Description,
--		qs.VoteCount,
--        qs.CategoryID,
--		qs.TagID,
--		u.UserName,
--        qs.CreatedDate       
--    FROM 
--        Questions qs JOIN Users u ON qs.CreatedBy = u.UserID
--    WHERE qs.CreatedBy = @UserID;
--END;
--GO


USE [master];
GO

CREATE DATABASE [QAAppDB];
GO

USE [QAAppDB];
GO

--===================== TABLES ===============================

CREATE TABLE [dbo].[Users](
    [UserID] INT IDENTITY(1,1) PRIMARY KEY,
    [UserName] VARCHAR(100) NOT NULL,
    [Email] VARCHAR(100) NULL,
    [Password] VARCHAR(200) NULL,
    [CreatedDate] SMALLDATETIME NULL
);

CREATE TABLE [dbo].[Categories](
    [CategoryID] INT IDENTITY(1,1) PRIMARY KEY,
    [CategoryName] VARCHAR(255) NOT NULL
);

CREATE TABLE [dbo].[Tags](
    [TagID] INT IDENTITY(1,1) PRIMARY KEY,
    [TagName] VARCHAR(255) NOT NULL
);

CREATE TABLE [dbo].[Questions](
    [QuestionID] INT IDENTITY(1,1) PRIMARY KEY,
    [Title] NVARCHAR(255) NOT NULL,
    [Question] NVARCHAR(MAX) NOT NULL,
    [Description] NVARCHAR(MAX) NULL,
    [CategoryID] INT NOT NULL,
    [TagID] INT NULL,
    [VoteCount] INT NULL,
    [CreatedBy] INT NOT NULL,
    [CreatedDate] SMALLDATETIME NOT NULL,
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (TagID) REFERENCES Tags(TagID)
);

CREATE TABLE [dbo].[Answers](
    [AnswerID] INT IDENTITY(1,1) PRIMARY KEY,
    [QuestionID] INT NOT NULL,
    [Answer] NVARCHAR(MAX) NOT NULL,
    [Description] NVARCHAR(MAX) NULL,
    [CreatedBy] INT NOT NULL,
    [CreatedDate] SMALLDATETIME NOT NULL,
    [AnswerAcceptedBy] NVARCHAR(255) NULL,
    [AcceptedDate] SMALLDATETIME NULL,
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

CREATE TABLE [dbo].[Comments](
    [CommentID] INT IDENTITY(1,1) PRIMARY KEY,
    [QuestionID] INT NOT NULL,
    [Description] NVARCHAR(MAX) NULL,
    [CreatedBy] INT NOT NULL,
    [CreatedDate] SMALLDATETIME NOT NULL,
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);
GO

--===================== STORED PROCEDURES ===============================

-- Create a new user
CREATE PROCEDURE [dbo].[CreateUser]
    @UserName NVARCHAR(200),
    @Email NVARCHAR(100),
    @Password NVARCHAR(50),
    @CreatedDate DATETIME
AS
BEGIN
    INSERT INTO Users(UserName, Email, Password, CreatedDate)
    VALUES (@UserName, @Email, @Password, @CreatedDate);
END;
GO

-- Get a user by username and password
CREATE PROCEDURE [dbo].[sp_GetUsers]
    @UserName NVARCHAR(100),
    @Password NVARCHAR(100)
AS
BEGIN
    SELECT UserID, UserName, Password
    FROM Users
    WHERE UserName = @UserName AND Password = @Password;
END;
GO

-- Update user
CREATE PROCEDURE [dbo].[sp_UpdateUser]
    @UserID INT,
    @UserName NVARCHAR(100),
    @Email NVARCHAR(100),
    @Password NVARCHAR(200)
AS
BEGIN
    UPDATE Users
    SET UserName = @UserName, Email = @Email, Password = @Password
    WHERE UserID = @UserID;
END;
GO

-- Delete user
CREATE PROCEDURE [dbo].[sp_DeleteUser]
    @UserID INT
AS
BEGIN
    DELETE FROM Users
    WHERE UserID = @UserID;
END;
GO

-- Create a new question
CREATE PROCEDURE [dbo].[sp_CreateQuestion]
    @Title NVARCHAR(255),
    @Question NVARCHAR(MAX),
    @Description NVARCHAR(MAX),
    @CategoryID INT,
    @TagID INT,
    @VoteCount INT,
    @CreatedBy INT,
    @CreatedDate SMALLDATETIME
AS
BEGIN
    INSERT INTO Questions(Title, Question, Description, CategoryID, TagID, VoteCount, CreatedBy, CreatedDate)
    VALUES (@Title, @Question, @Description, @CategoryID, @TagID, @VoteCount, @CreatedBy, @CreatedDate);
END;
GO

-- Update Question
CREATE PROCEDURE [dbo].[sp_UpdateQuestion]
    @QuestionID INT,
    @Title NVARCHAR(255),
    @Question NVARCHAR(MAX),
    @Description NVARCHAR(MAX),
    @CategoryID INT,
    @TagID INT,
    @VoteCount INT
AS
BEGIN
    UPDATE Questions
    SET Title = @Title, Question = @Question, Description = @Description, 
        CategoryID = @CategoryID, TagID = @TagID, VoteCount = @VoteCount
    WHERE QuestionID = @QuestionID;
END;
GO

-- Delete Question
CREATE PROCEDURE [dbo].[sp_DeleteQuestion]
    @QuestionID INT
AS
BEGIN
    DELETE FROM Questions
    WHERE QuestionID = @QuestionID;
END;
GO

-- Create a new answer
CREATE PROCEDURE [dbo].[sp_CreateAnswer]
    @QuestionID INT,
    @Answer NVARCHAR(MAX),
    @Description NVARCHAR(MAX),
    @CreatedBy INT,
    @CreatedDate SMALLDATETIME,
    @AnswerAcceptedBy NVARCHAR(100) = NULL,
    @AcceptedDate SMALLDATETIME = NULL
AS
BEGIN
    INSERT INTO Answers (QuestionID, Answer, Description, CreatedBy, CreatedDate, AnswerAcceptedBy, AcceptedDate)
    VALUES (@QuestionID, @Answer, @Description, @CreatedBy, @CreatedDate, @AnswerAcceptedBy, @AcceptedDate);
END;
GO

-- Delete Answer
CREATE PROCEDURE [dbo].[sp_DeleteAnswer]
    @AnswerID INT
AS
BEGIN
    DELETE FROM Answers
    WHERE AnswerID = @AnswerID;
END;
GO


-- Get all users
CREATE PROCEDURE [dbo].[sp_GetAllUsers]
AS
BEGIN
    SELECT * FROM Users;
END;
GO

-- Get all questions
CREATE PROCEDURE [dbo].[sp_GetQuestions]
AS
BEGIN
    SELECT * FROM Questions;
END;
GO

-- Get all categories
CREATE PROCEDURE [dbo].[sp_GetCategories]
AS
BEGIN
    SELECT * FROM Categories;
END;
GO

-- Get all tags
CREATE PROCEDURE [dbo].[sp_GetTags]
AS
BEGIN
    SELECT * FROM Tags;
END;
GO

-- Get all questions with additional details
CREATE PROCEDURE [dbo].[sp_GetAllQuestions]
AS
BEGIN
    SELECT 
        qs.QuestionID,
        qs.CategoryID,
        qs.TagID,
        qs.Title,
        qs.Question,
        qs.Description,
        qs.VoteCount,
        u.UserName,
        qs.CreatedDate,
        (SELECT COUNT(*) FROM Answers WHERE Answers.QuestionID = qs.QuestionID) AS TotalAnswer
    FROM 
        Questions qs
    INNER JOIN Users u ON qs.CreatedBy = u.UserID;
END;
GO

-- Get a question by ID
CREATE PROCEDURE [dbo].[sp_GetQuestionByID]
    @QuestionID INT
AS
BEGIN
    SELECT 
        qes.QuestionID,
        qes.Title,
        qes.CategoryID,
        ISNULL(qes.TagID, '') AS TagID,
        qes.Question,
        ISNULL(qes.Description, '') AS Description,
        ISNULL(VoteCount, '') AS VoteCount,
        u.UserName,
        qes.CreatedDate
    FROM 
        Questions qes
    INNER JOIN Users u ON qes.CreatedBy = u.UserID
    WHERE 
        qes.QuestionID = @QuestionID;
END;
GO

-- Get answers by question ID
CREATE PROCEDURE [dbo].[sp_GetAnswerByQuestionID]
    @QuestionID INT
AS
BEGIN
    SELECT 
        an.AnswerID,
        an.QuestionID,
        an.Answer,
        an.Description,
        u.UserName, -- Created by
        an.CreatedDate,
        ISNULL(an.AnswerAcceptedBy, '') AS AnswerAcceptedBy,
        ISNULL(an.AcceptedDate, '') AS AcceptedDate
    FROM 
        Answers an
    INNER JOIN Users u ON an.CreatedBy = u.UserID
    WHERE 
        an.QuestionID = @QuestionID;
END;
GO

-- Get questions by user ID
CREATE PROCEDURE [dbo].[sp_GetQuestionsByUserID]
    @UserID INT
AS
BEGIN
    SELECT 
        qs.QuestionID,
        qs.Title,
        qs.Question,
        qs.Description,
        qs.VoteCount,
        qs.CategoryID,
        qs.TagID,
        u.UserName,
        qs.CreatedDate
    FROM 
        Questions qs
    INNER JOIN Users u ON qs.CreatedBy = u.UserID
    WHERE 
        qs.CreatedBy = @UserID;
END;
GO

-- Add new Comment
CREATE PROCEDURE [dbo].[sp_AddComment]
    @QuestionID INT,
    @Description NVARCHAR(MAX),
    @CreatedBy INT,
    @CreatedDate SMALLDATETIME
AS
BEGIN
    INSERT INTO Comments (QuestionID, Description, CreatedBy, CreatedDate)
    VALUES (@QuestionID, @Description, @CreatedBy, @CreatedDate);
END;
GO

--Vote on a Question
CREATE PROCEDURE [dbo].[sp_VoteQuestion]
    @QuestionID INT,
    @VoteCount INT
AS
BEGIN
    UPDATE Questions
    SET VoteCount = VoteCount + @VoteCount
    WHERE QuestionID = @QuestionID;
END;
GO