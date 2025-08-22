
-- Car Rental Platform

--------------------------------
CREATE SCHEMA bhavy_3150320_as3_c

SET SCHEMA 'bhavy_3150320_as3_c';  


-- Table and Constraint Declarations
-----------------------------------------------------------------------------
CREATE TABLE AppUser (
    UserID Varchar PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL
);

CREATE TABLE Renter (
    UserID varchar PRIMARY KEY REFERENCES AppUser(UserID) ON DELETE CASCADE,
    PayoutInterval VARCHAR(20) NOT NULL,
    PayoutPreference VARCHAR(20) NOT NULL
);

CREATE TABLE Lessee (
    UserID varchar PRIMARY KEY REFERENCES AppUser(UserID) ON DELETE CASCADE
);

CREATE TABLE PaymentMethod (
    PaymentMethodID INT PRIMARY KEY,
    UserID varchar NOT NULL REFERENCES AppUser(UserID) ON DELETE CASCADE
);

CREATE TABLE ETransfer (
    PaymentMethodID INT PRIMARY KEY REFERENCES PaymentMethod(PaymentMethodID) ON DELETE CASCADE,
    AccountNumber VARCHAR(20) NOT NULL,
    InstitutionNumber VARCHAR(20) NOT NULL,
    TransitNumber VARCHAR(20) NOT NULL
);

CREATE TABLE CreditCard (
    PaymentMethodID INT PRIMARY KEY REFERENCES PaymentMethod(PaymentMethodID) ON DELETE CASCADE,
    CardNumber VARCHAR(20) NOT NULL,
    Expiry DATE,
    CVC INT
);

CREATE TABLE Payment (
    PaymentNumber INT PRIMARY KEY,
    PaymentDate DATE NOT NULL,
    PaymentAmount DECIMAL(10,2) NOT NULL,
    AgreementNumber INT NOT NULL,
    LesseeID INT NOT NULL,
    PaymentMethodID INT NOT NULL,
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID) ON DELETE CASCADE,
    FOREIGN KEY (AgreementNumber) REFERENCES RentalAgreement(AgreementNumber) ON DELETE CASCADE
);

CREATE TABLE Item (
    ItemNumber INT PRIMARY KEY,
    ItemName VARCHAR(100) NOT NULL,
    ItemDesc TEXT,
    UserID varchar NOT NULL,
    FOREIGN KEY (UserID) REFERENCES AppUser(UserID) ON DELETE CASCADE
);

CREATE TABLE Tool (
    ItemNumber INT PRIMARY KEY REFERENCES Item(ItemNumber) ON DELETE CASCADE
);

CREATE TABLE Electronics (
    ItemNumber INT PRIMARY KEY REFERENCES Item(ItemNumber) ON DELETE CASCADE
);

CREATE TABLE RentedItem (
    AgreementNumber INT NOT NULL,
    ItemNumber INT NOT NULL,
    DaysRented INT NOT NULL,
    RentalFeeCharge DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (AgreementNumber, ItemNumber),
    FOREIGN KEY (AgreementNumber) REFERENCES RentalAgreement(AgreementNumber) ON DELETE CASCADE,
    FOREIGN KEY (ItemNumber) REFERENCES Item(ItemNumber) ON DELETE CASCADE
);
CREATE TABLE RentalAgreement (
    AgreementNumber INT PRIMARY KEY,
    RentalDate DATE NOT NULL,
    RenterID varchar NOT NULL REFERENCES Renter(UserID) ON DELETE CASCADE,
    LesseeID varchar NOT NULL REFERENCES Lessee(UserID) ON DELETE CASCADE
);


-- Data Insert Statements
-----------------------------------------------------------------------------
INSERT INTO AppUser VALUES 
('cjoyal', 'cjl', 'Claude.Joyal@gmail.com', 'Claude', 'Joyal'),
('srobins', 'srb', 'selina.robins@hotmail.com', 'Selina', 'Robins');

INSERT INTO Renter VALUES 
('cjoyal', 'Monthly', 'Cheque'),
('srobins', 'Weekly', 'Direct Deposit');

INSERT INTO PaymentMethod VALUES 
(87, 'cjoyal'),
(88, 'cjoyal' ),
(65, 'srobins');

INSERT INTO Etransfer Values
(87, '1000507', '097', '50198'),
(65, '10889746', '003', '84752');

INSERT INTO CreditCard Values
(88, '45000080000581163', '2024-09-02', 887);

INSERT INTO Payment Values
(8899, '2024-02-14', 80.50, 7465, srobins, 87);

INSERT INTO lessee values
('srobins');
INSERT INTO RentalAgreement Values
(7465, '2024-02-13', 'cjoyal', 'srobins');

INSERT INTO ITEM Values
(1348,'PS5', 'Playstation5', 'cjoyal');

INSERT INTO ITEM Values
(1349, 'Cordless Drill', '9V Dewalt', 'cjoyal');

INSERT INTO RentedItem Values
(7465, 1348, 1, 40.50),
(7465, 1349, 1, 40.00);
