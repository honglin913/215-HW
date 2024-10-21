-- Create the Transaction table
CREATE TABLE Transaction (
    TRID INT PRIMARY KEY, -- Transaction ID as primary key
    Time TIME NOT NULL, -- Transaction time
    Date DATE NOT NULL, -- Transaction date
    Amount DECIMAL(10, 2) NOT NULL, -- Amount with 2 decimal places
    EmpID INT, -- Foreign key referencing Employee
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);

-- Create the Employee table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY, -- Employee ID as primary key
    Name VARCHAR(100) NOT NULL -- Employee name
);

-- Create the Revenue table
CREATE TABLE Revenue (
    TRID INT PRIMARY KEY, -- Transaction ID as primary key
    FOREIGN KEY (TRID) REFERENCES Transaction(TRID) -- Foreign key referencing Transaction
);

-- Create the Expenditure table
CREATE TABLE Expenditure (
    TRID INT PRIMARY KEY, -- Transaction ID as primary key
    FOREIGN KEY (TRID) REFERENCES Transaction(TRID) -- Foreign key referencing Transaction
);

-- Create the BankAccount table
CREATE TABLE BankAccount (
    AccID INT PRIMARY KEY -- Account ID as primary key
);

-- Create the Deposits table
CREATE TABLE Deposits (
    TRID INT, -- Foreign key referencing Transaction
    AccID INT, -- Foreign key referencing BankAccount
    Amount DECIMAL(10, 2) NOT NULL, -- Amount of deposit
    PRIMARY KEY (TRID, AccID), -- Composite primary key (TRID, AccID)
    FOREIGN KEY (TRID) REFERENCES Transaction(TRID),
    FOREIGN KEY (AccID) REFERENCES BankAccount(AccID)
);

-- Create the Withdraws table
CREATE TABLE Withdraws (
    TRID INT, -- Foreign key referencing Transaction
    AccID INT, -- Foreign key referencing BankAccount
    Amount DECIMAL(10, 2) NOT NULL, -- Amount of withdrawal
    PRIMARY KEY (TRID, AccID), -- Composite primary key (TRID, AccID)
    FOREIGN KEY (TRID) REFERENCES Transaction(TRID),
    FOREIGN KEY (AccID) REFERENCES BankAccount(AccID)
);

-- Create the Pays table
CREATE TABLE Pays (
    TRID INT, -- Foreign key referencing Transaction
    BillID INT, -- Foreign key referencing Bill/Invoice
    Amount DECIMAL(10, 2) NOT NULL, -- Amount paid
    PRIMARY KEY (TRID, BillID), -- Composite primary key (TRID, BillID)
    FOREIGN KEY (TRID) REFERENCES Transaction(TRID),
    FOREIGN KEY (BillID) REFERENCES Bill(BillID)
);

-- Create the Bill/Invoice table
CREATE TABLE Bill (
    BillID INT PRIMARY KEY, -- Bill/Invoice ID as primary key
    VendorID INT, -- Foreign key referencing Vendor
    Amount DECIMAL(10, 2) NOT NULL, -- Amount of the bill
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID)
);

-- Create the Vendor table
CREATE TABLE Vendor (
    VendorID INT PRIMARY KEY -- Vendor ID as primary key
);

-- Create the Purchase table
CREATE TABLE Purchase (
    PurchaseID INT PRIMARY KEY, -- Purchase ID as primary key
    CustomerID INT, -- Foreign key referencing Customer
    TRID INT, -- Foreign key referencing Transaction
    Amount DECIMAL(10, 2) NOT NULL, -- Purchase amount
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (TRID) REFERENCES Transaction(TRID)
);

-- Create the Tips table
CREATE TABLE Tips (
    TRID INT, -- Foreign key referencing Transaction
    CustomerID INT, -- Foreign key referencing Customer
    Amount DECIMAL(10, 2) NOT NULL, -- Tip amount
    PRIMARY KEY (TRID, CustomerID), -- Composite primary key (TRID, CustomerID)
    FOREIGN KEY (TRID) REFERENCES Transaction(TRID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create the InventoryItem table
CREATE TABLE InventoryItem (
    InvID INT PRIMARY KEY, -- Inventory item ID as primary key
    PurchaseID INT, -- Foreign key referencing Purchase
    FOREIGN KEY (PurchaseID) REFERENCES Purchase(PurchaseID)
);

-- Create the Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY -- Customer ID as primary key
);

-- Create the Donor table
CREATE TABLE Donor (
    DonorID INT PRIMARY KEY, -- Donor ID as primary key
    Name VARCHAR(100) NOT NULL -- Donor name
);

-- Create the Donations table
CREATE TABLE Donations (
    DonorID INT, -- Foreign key referencing Donor
    TRID INT, -- Foreign key referencing Transaction
    Amount DECIMAL(10, 2) NOT NULL, -- Donation amount
    PRIMARY KEY (DonorID, TRID), -- Composite primary key (DonorID, TRID)
    FOREIGN KEY (DonorID) REFERENCES Donor(DonorID),
    FOREIGN KEY (TRID) REFERENCES Transaction(TRID),
    CHECK (Amount > 0) -- Check constraint to ensure donation amount is positive
);

-- Explanation of the CHECK constraint:
-- The CHECK constraint in the Donations table ensures that the donation amount is always positive,
-- preventing negative values from being entered into the Amount column.
-- This constraint enforces a business rule that donations cannot have negative values.
