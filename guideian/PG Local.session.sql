-- Create Users Table
CREATE TABLE Users (
    FirstName VARCHAR(30),
    Surname VARCHAR(30),
    DateOfBirth DATE,
    Age INT,
    Gender VARCHAR(6),
    Email VARCHAR(50) PRIMARY KEY,
    Password VARCHAR(20),
    PhoneNumber VARCHAR(10),
    Subscription VARCHAR(20)
);

-- Create Courses Table
CREATE TABLE Courses (
    CourseID VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(50),
    InstitutionName VARCHAR(50),
    Duration INT,
    Requirements VARCHAR(255),
    CareerOptions VARCHAR(255),
    TuitionFee DECIMAL(10, 2)
);

-- Create Applications Table
CREATE TABLE Applications (
    ApplicationID VARCHAR(10) PRIMARY KEY,
    UserEmail VARCHAR(50),
    CourseID VARCHAR(10),
    ApplicationDate DATE,
    Status VARCHAR(15),
    FOREIGN KEY (UserEmail) REFERENCES Users(Email),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create Mentorship Table
CREATE TABLE Mentorship (
    MentorID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(50),
    Expertise VARCHAR(100),
    ContactDetails VARCHAR(50),
    Availability BOOLEAN
);

-- Create Reviews Table
CREATE TABLE Reviews (
    ReviewID VARCHAR(10) PRIMARY KEY,
    UserEmail VARCHAR(50),
    CourseID VARCHAR(10),
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewComment VARCHAR(255),
    FOREIGN KEY (UserEmail) REFERENCES Users(Email),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);