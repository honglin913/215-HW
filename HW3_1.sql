-- Table: Transaction
CREATE TABLE Transaction (
    TRID INT PRIMARY KEY AUTO_INCREMENT,
    Time TIME NOT NULL,
    Date DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL
);

-- Table: Employee
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY 
);

-- Table: Revenue
CREATE TABLE Revenue (
    TRID INT PRIMARY KEY,          -- Foreign key to Transaction
    EmpID INT NOT NULL,            -- Foreign key to Employee
    FOREIGN KEY (TRID) REFERENCES Transaction(TRID),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);

-- Table: Expenditure
CREATE TABLE Expenditure (
    TRID INT PRIMARY KEY,          -- Foreign key to Transaction
    EmpID INT NOT NULL,            -- Foreign key to Employee
    FOREIGN KEY (TRID) REFERENCES Transaction(TRID),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);

-- Table: BankAccount
CREATE TABLE BankAccount (
    AccID INT PRIMARY KEY
);

-- Table: AccountRevenue
CREATE TABLE AccountRevenue (
    TRID INT,          -- Foreign key to Revenue (and to Transaction)
    AccID INT,         -- Foreign key to BankAccount
    Amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (TRID, AccID),
    FOREIGN KEY (TRID) REFERENCES Revenue(TRID),
    FOREIGN KEY (AccID) REFERENCES BankAccount(AccID),
    CONSTRAINT chk_acc_revenue CHECK (TRID >= 10000000)
);

-- Table: AccountExpenditure
CREATE TABLE AccountExpenditure (
    TRID INT,          -- Foreign key to Expenditure (and to Transaction)
    AccID INT,         -- Foreign key to BankAccount
    Amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (TRID, AccID),
    FOREIGN KEY (TRID) REFERENCES Expenditure(TRID),
    FOREIGN KEY (AccID) REFERENCES BankAccount(AccID),
    CONSTRAINT chk_acc_expenditure CHECK (TRID < 10000000)
);

-- Table: Vendor
CREATE TABLE Vendor (
    VendorID INT PRIMARY KEY NOT NULL
);

-- Table: Bill
CREATE TABLE Bill (
    BillID INT PRIMARY KEY NOT NULL,
    VendorID INT NOT NULL,      -- Foreign key to Vendor
    Amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID)
);

-- Table: ExpenditurePays
CREATE TABLE ExpenditurePays (
    TRID INT NOT NULL,          -- Foreign key to Expenditure (and to Transaction)
    BillID INT NOT NULL,        -- Foreign key to Bill
    Amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (TRID, BillID),
    FOREIGN KEY (TRID) REFERENCES Expenditure(TRID),
    FOREIGN KEY (BillID) REFERENCES Bill(BillID),
    CONSTRAINT chk_expenditure_pays CHECK (TRID < 10000000)  -- Only expenditures can pay bills
);

-- Table: Customer
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY NOT NULL
);

-- Table: Purchase
CREATE TABLE Purchase (
    PurchaseID INT PRIMARY KEY NOT NULL,
    CustomerID INT NOT NULL,    -- Foreign key to Customer
    TRID INT NOT NULL,          -- Foreign key to Revenue (and to Transaction)
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (TRID) REFERENCES Revenue(TRID),
    CONSTRAINT chk_purchase_trid CHECK (TRID >= 10000000)  -- Only revenues can be used for purchases
);

-- Table: Tips
CREATE TABLE Tips (
    TRID INT NOT NULL,          -- Foreign key to Revenue (and to Transaction)
    CustomerID INT NOT NULL,    -- Foreign key to Customer
    Amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (TRID, CustomerID),
    FOREIGN KEY (TRID) REFERENCES Revenue(TRID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    CONSTRAINT chk_tips_trid CHECK (TRID >= 10000000)  -- Only revenues can generate tips
);

-- Table: InventoryItem
CREATE TABLE InventoryItem (
    InvID INT PRIMARY KEY NOT NULL,
    PurchaseID INT,             -- Nullable Foreign key to Purchase
    FOREIGN KEY (PurchaseID) REFERENCES Purchase(PurchaseID)
);

-- Table: Donor
CREATE TABLE Donor (
    DonorID INT PRIMARY KEY NOT NULL
);

-- Table: Donations
CREATE TABLE Donations (
    DonorID INT NOT NULL,      -- Foreign key to Donor
    TRID INT NOT NULL,         -- Foreign key to Revenue (and to Transaction)
    Amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (DonorID, TRID),
    FOREIGN KEY (DonorID) REFERENCES Donor(DonorID),
    FOREIGN KEY (TRID) REFERENCES Revenue(TRID),
    CONSTRAINT chk_donations_trid CHECK (TRID >= 10000000)  -- Only revenues can be donations
);
