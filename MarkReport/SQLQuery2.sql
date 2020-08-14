USE master;
GO

CREATE DATABASE MarkReport;
GO

USE MarkReport;
GO

CREATE TABLE tblStudent
    (
      code VARCHAR(20) PRIMARY KEY ,
      firstName NVARCHAR(30) NOT NULL ,
      lastName NVARCHAR(30) NOT NULL ,
      dateOfBirth DATE NOT NULL ,
      sex BIT NOT NULL ,
      classCode VARCHAR(10) NOT NULL ,
    );
GO

CREATE TABLE tblCourse
    (
      code VARCHAR(10) PRIMARY KEY ,
      name NVARCHAR(20) NOT NULL
    );
GO

CREATE TABLE tblMarkReport
    (
      studentCode VARCHAR(20) NOT NULL ,
      courseCode VARCHAR(10) NOT NULL ,
      mark1 FLOAT NOT NULL ,
      mark2 FLOAT NOT NULL
    );
GO

-- INSERT STUDENT
INSERT  INTO dbo.tblStudent
        ( code ,
          firstName ,
          lastName ,
          dateOfBirth ,
          sex ,
          classCode 
        )
VALUES  ( 'SE1' , -- code - varchar(20)
          N'Nguyễn' , -- firstName - nvarchar(30)
          N'Hoàng' , -- lastName - nvarchar(30)
          '01/01/1999' , -- dateOfBirth - date
          1 , -- sex - bit 0 - female, 1 - male
          'PRF123'  -- classCode - varchar(10)
        );

INSERT  INTO dbo.tblStudent
        ( code ,
          firstName ,
          lastName ,
          dateOfBirth ,
          sex ,
          classCode 
        )
VALUES  ( 'SE2' , -- code - varchar(20)
          N'Ngô' , -- firstName - nvarchar(30)
          N'Lợi' , -- lastName - nvarchar(30)
          '02/01/1999' , -- dateOfBirth - date
          1 , -- sex - bit 0 - female, 1 - male
          'PRF123'  -- classCode - varchar(10)
        );

INSERT  INTO dbo.tblStudent
        ( code ,
          firstName ,
          lastName ,
          dateOfBirth ,
          sex ,
          classCode 
        )
VALUES  ( 'SE3' , -- code - varchar(20)
          N'Lý' , -- firstName - nvarchar(30)
          N'Hoàng' , -- lastName - nvarchar(30)
          '03/01/1999' , -- dateOfBirth - date
          1 , -- sex - bit 0 - female, 1 - male
          'PRF123'  -- classCode - varchar(10)
        );

INSERT  INTO dbo.tblStudent
        ( code ,
          firstName ,
          lastName ,
          dateOfBirth ,
          sex ,
          classCode 
        )
VALUES  ( 'SE4' , -- code - varchar(20)
          N'Trần' , -- firstName - nvarchar(30)
          N'Quốc' , -- lastName - nvarchar(30)
          '04/01/1999' , -- dateOfBirth - date
          1 , -- sex - bit 0 - female, 1 - male
          'PRF123'  -- classCode - varchar(10)
        );

-- INSERT COURSE
INSERT  INTO dbo.tblCourse
        ( code, name )
VALUES  ( 'C1', -- code - varchar(10)
          N'PRN'  -- name - nvarchar(20)
          );

INSERT  INTO dbo.tblCourse
        ( code, name )
VALUES  ( 'C2', -- code - varchar(10)
          N'CSD'  -- name - nvarchar(20)
          );

-- INSERT MARK
-- SE1 mark
INSERT  INTO dbo.tblMarkReport
        ( studentCode ,
          courseCode ,
          mark1 ,
          mark2
        )
VALUES  ( 'SE1' , -- studentCode - varchar(20)
          'C1' , -- courseCode - varchar(10)
          7.5 , -- mark1 - float
          6  -- mark2 - float
        );

INSERT  INTO dbo.tblMarkReport
        ( studentCode ,
          courseCode ,
          mark1 ,
          mark2
        )
VALUES  ( 'SE1' , -- studentCode - varchar(20)
          'C2' , -- courseCode - varchar(10)
          8.5 , -- mark1 - float
          9  -- mark2 - float
        );

-- SE2 mark
INSERT  INTO dbo.tblMarkReport
        ( studentCode ,
          courseCode ,
          mark1 ,
          mark2
        )
VALUES  ( 'SE2' , -- studentCode - varchar(20)
          'C1' , -- courseCode - varchar(10)
          8 , -- mark1 - float
          9  -- mark2 - float
        );

INSERT  INTO dbo.tblMarkReport
        ( studentCode ,
          courseCode ,
          mark1 ,
          mark2
        )
VALUES  ( 'SE2' , -- studentCode - varchar(20)
          'C2' , -- courseCode - varchar(10)
          10 , -- mark1 - float
          8.5  -- mark2 - float
        );

-- SE3 mark
INSERT  INTO dbo.tblMarkReport
        ( studentCode ,
          courseCode ,
          mark1 ,
          mark2
        )
VALUES  ( 'SE3' , -- studentCode - varchar(20)
          'C1' , -- courseCode - varchar(10)
          7 , -- mark1 - float
          10  -- mark2 - float
        );

INSERT  INTO dbo.tblMarkReport
        ( studentCode ,
          courseCode ,
          mark1 ,
          mark2
        )
VALUES  ( 'SE3' , -- studentCode - varchar(20)
          'C2' , -- courseCode - varchar(10)
          7.5 , -- mark1 - float
          10  -- mark2 - float
        );

		-- SE4 mark
INSERT  INTO dbo.tblMarkReport
        ( studentCode ,
          courseCode ,
          mark1 ,
          mark2
        )
VALUES  ( 'SE4' , -- studentCode - varchar(20)
          'C1' , -- courseCode - varchar(10)
          10 , -- mark1 - float
          8.5  -- mark2 - float
        );

INSERT  INTO dbo.tblMarkReport
        ( studentCode ,
          courseCode ,
          mark1 ,
          mark2
        )
VALUES  ( 'SE4' , -- studentCode - varchar(20)
          'C2' , -- courseCode - varchar(10)
          7 , -- mark1 - float
          8.5  -- mark2 - float
        );

-- EXECUTE
SELECT  *
FROM    dbo.tblStudent;
SELECT  *
FROM    dbo.tblCourse;
SELECT  *
FROM    dbo.tblMarkReport;

SELECT  tblMark.courseCode ,
        tblCourse.name ,
        tblMark.mark1 ,
        tblMark.mark2 ,
        tblMark.avgMark
FROM    ( SELECT    courseCode ,
                    mark1 ,
                    mark2 ,
                    ( mark1 + mark2 ) / 2 AS avgMark
          FROM      dbo.tblMarkReport
          WHERE     studentCode = 'SE1'
        ) AS tblMark
        JOIN dbo.tblCourse ON dbo.tblCourse.code = tblMark.courseCode; 

SELECT  firstName ,
        lastName ,
        dateOfBirth ,
        sex ,
        classCode ,
        tblAvg.avgMark
FROM    ( SELECT    studentCode ,
                    AVG(( mark1 + mark2 ) / 2) AS avgMark
          FROM      dbo.tblMarkReport
          WHERE     studentCode = 'SE1'
          GROUP BY  studentCode
        ) tblAvg
        LEFT JOIN dbo.tblStudent ON tblAvg.studentCode = dbo.tblStudent.code;

SELECT  *
FROM    dbo.tblStudent;



    
	
	