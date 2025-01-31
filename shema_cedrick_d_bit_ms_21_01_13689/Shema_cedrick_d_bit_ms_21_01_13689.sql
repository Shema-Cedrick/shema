create database blood_donation_system;
USE blood_donation_system;
CREATE TABLE Donors (
    Donor_ID INT auto_increment KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Date_of_Birth DATE,
    Gender VARCHAR(10),
    Blood_Type VARCHAR(5),
    Address VARCHAR(50),
    Phone int(10),
    Email VARCHAR(100),
    Donor_Status VARCHAR(100),
    Last_Donation_Date DATE
);
CREATE TABLE Donations (
    Donation_ID INT auto_increment PRIMARY KEY,
    Donor_ID INT,
    Donation_Date DATE,
    Blood_Type VARCHAR(10),
    Quantity INT,
    Donation_Type VARCHAR(20),
    Health_Status VARCHAR(100),
    Donation_Center VARCHAR(50),
    FOREIGN KEY (Donor_ID) REFERENCES Donors(Donor_ID)
);
CREATE TABLE Blood_inventory (Inventory_ID INT AUTO_INCREMENT PRIMARY KEY,
    Blood_Type VARCHAR(5) NOT NULL,               
    Quantity_Stored VARCHAR(20) NOT NULL,         
    Expiry_Date DATE NOT NULL,                    
    Storage_Location VARCHAR(10),                
    Donation_Date DATE NOT NULL                   
);

    CREATE TABLE Blood_request (
    Request_ID INT AUTO_INCREMENT PRIMARY KEY, 
    Blood_Type VARCHAR(5) NOT NULL,             
    Quantity_Required INT NOT NULL,             
    Request_Date DATE NOT NULL,                 
    Request_Status VARCHAR(50),                 
    Hospital_Name VARCHAR(100),                 
    Contact_Person VARCHAR(100)                 
);
CREATE TABLE Transfusions (
    Transfusion_ID INT AUTO_INCREMENT PRIMARY KEY,  
    Donation_ID INT,                                
    Request_ID INT,                                 
    Transfusion_Date DATE NOT NULL,                 
    Transfusion_Amount INT NOT NULL,                
    Transfusion_Status VARCHAR(100),                
    FOREIGN KEY (Donation_ID) REFERENCES Donations(Donation_ID),  
    FOREIGN KEY (Request_ID) REFERENCES Blood_request(Request_ID) 
);
/*CRUD after creating insert,retrieve,update,delete
*/
use blood_donation_system;
insert into Donors(
    First_Name,
    Last_Name,
    Date_of_Birth,
    Gender,
    Blood_Type,
    Address,
    Phone,
    Email,
    Donor_Status,
    Last_Donation_Date
) 
VALUES (
    'kalisa',           --
    'Doe', 
    '2025-01-20', 
    'MALE',
    'O+',            
    '123 Main St, City', 
    123-456-7890,   
    'kalisadoe@email.com',
    'Active',         
    '2025-01-25'     
);
select* from Donors;
insert into Donations(Donor_ID,
    Donation_Date,
    Blood_Type,
    Quantity,
    Donation_Type,
    Health_Status,
    Donation_Center
) 
VALUES (
    1,                        
    '2025-01-28',           
    'O+',                    
    5,                      
    'Whole Blood',           
    'Healthy',               
    'chuk'        
);
select* from Donations;
INSERT INTO Blood_inventory(Blood_Type,
    Quantity_Stored,
    Expiry_Date,
    Storage_Location,
    Donation_Date
)
VALUES (
    'O+',                   
    '20lt',            
    '2025-07-15',        
    'Freezer',              
    '2025-01-25'            
);
select* from Blood_inventory;

insert into Blood_request (
    Blood_Type,             
    Quantity_Required,             
    Request_Date,                 
    Request_Status,                 
    Hospital_Name,                 
    Contact_Person
    )
    values
    ('O+',3,'2025-02-01','BAD CONDITION','ruhengeri hospital',0788888888);
    insert into Transfusions( Donation_ID,                                
    Request_ID,                                 
    Transfusion_Date,                 
    Transfusion_Amount,                
    Transfusion_Status )
    VALUES
    (1,1,'2025-01-10',50,'SUCCESFULL');
    select* from Transfusions;
    update Donors
    set First_Name="shema"
    where Donor_ID=1;
     update Donations
    set Blood_Type="A"
    where Donation_ID=1;
     update Transfusions
    set Transfusion_Amount=20
    where Transfusion_ID=1;
     update Blood_inventory
    set Blood_Type="A"
    where Inventory_ID=1;
     update Blood_request
    set Hospital_Name="CHUK"
    where Request_ID=1;
    /*sum,average*/
    SELECT SUM(Quantity) AS Total_Donated_Blood
FROM Donations;
  SELECT SUM(Quantity_Stored) AS Total_Inventory
FROM Blood_Inventory;
  SELECT SUM(Quantity_Required) AS Total_Required_Blood
FROM Blood_Request;
  SELECT SUM(Transfusion_Amount) AS Total_Amounts
FROM Transfusion;
   /* --- average*/
    SELECT AVG(Quantity) AS Average_Donated_Blood
FROM Donations;
    SELECT AVG(Quantity_Stored) AS Average_Donated_Blood
FROM Blood_Inventory;
    SELECT AVG(Quantity_Required) AS Average_Donated_Blood
FROM Blood_Request;
    SELECT AVG(Transfusion_Amount) AS Average_Donated_Blood
FROM Transfusions;

-- 6 views 

CREATE VIEW Total_Blood_Donated AS
SELECT Donor_ID, SUM(Quantity) AS Total_Blood_Donated
FROM Donations
GROUP BY Donor_ID;

CREATE VIEW Donor_Info AS
SELECT Donor_ID, First_Name, Last_Name, Blood_Type, Date_of_Birth, Donor_Status
FROM Donors;

CREATE VIEW Pending_Blood_Requests AS
SELECT Request_ID, Blood_Type, Quantity_Required, Request_Date, Request_Status, Hospital_Name
FROM Blood_request
WHERE Request_Status = 'Pending';

CREATE VIEW Blood_Inventory_Summary AS
SELECT Blood_Type, SUM(Quantity_Stored) AS Total_Stored, MAX(Expiry_Date) AS Expiry_Date
FROM Blood_inventory
GROUP BY Blood_Type;

CREATE VIEW Transfusions_By_Date AS
SELECT Transfusion_ID, Donation_ID, Request_ID, Transfusion_Date, Transfusion_Amount
FROM Transfusions
WHERE Transfusion_Date = '2025-01-25';  -- Adjust this date as needed

CREATE VIEW Donation_Request_Pairing AS
SELECT d.Donation_ID, d.Donor_ID, d.Donation_Date, r.Request_ID, r.Blood_Type, r.Quantity_Required
FROM Donations d
JOIN Blood_request r ON d.Blood_Type = r.Blood_Type
WHERE r.Request_Status = 'healthy';

-- 6 stored procedure
use blood_donation_system;
CREATE PROCEDURE AddNewDonor(
    IN  First_Name VARCHAR(50),
   in Last_Name VARCHAR(50),
   in Date_of_Birth DATE,
   in Gender VARCHAR(10),
   in Blood_Type VARCHAR(5),
   in Address VARCHAR(50),
    in Phone int(10),
    in Email VARCHAR(100),
  in  Donor_Status VARCHAR(100),
   in  Last_Donation_Date DATE
)
BEGIN
    INSERT INTO Donors ( First_Name,
    Last_Name,
    Date_of_Birth,
    Gender,
    Blood_Type,
    Address,
    Phone,
    Email,
    Donor_Status,
    Last_Donation_Date)
    VALUES ( First_Name,
    Last_Name,
    Date_of_Birth,
    Gender,
    Blood_Type,
    Address,
    Phone,
    Email,
    Donor_Status,
    Last_Donation_Date)
    end;
 
 CREATE PROCEDURE RecordBloodDonation(
     Donor_ID INT,
    Donation_Date DATE,
    Blood_Type VARCHAR(10),
    Quantity INT,
    Donation_Type VARCHAR(20),
    Health_Status VARCHAR(100),
    Donation_Center VARCHAR(50)
)
BEGIN
    -- Insert the donation into the Donations table
    INSERT INTO Donations (Donor_ID,
    Donation_Date,
    Blood_Type,
    Quantity,
    Donation_Type,
    Health_Status,
    Donation_Center)
    VALUES (Donor_ID,
    Donation_Date,
    Blood_Type,
    Quantity,
    Donation_Type,
    Health_Status,
    Donation_Center)
    
   
END;


CREATE PROCEDURE CreateBloodRequest(
  in  Blood_Type VARCHAR(5) ,             
    in Quantity_Required INT ,             
   	 in Request_Date DATE,                 
    in Request_Status VARCHAR(50),                 
    in Hospital_Name VARCHAR(100),                 
    in Contact_Person VARCHAR(100) 
)
BEGIN
    INSERT INTO BloodRequests ( Blood_Type,             
    Quantity_Required,             
    Request_Date,                 
    Request_Status,                 
    Hospital_Name,                 
    Contact_Person)
    VALUES ( Blood_Type,             
    Quantity_Required,             
    Request_Date,                 
    Request_Status,                 
    Hospital_Name,                 
    Contact_Person)
END;

CREATE PROCEDURE ProcessBloodTransfusion(
   Donation_ID INT,                                
    Request_ID INT,                                 
    Transfusion_Date DATE,                 
    Transfusion_Amount INT ,                
    Transfusion_Status VARCHAR(100)
)
BEGIN
    -- Insert the transfusion record into the Transfusion table
    INSERT INTO Transfusion (Donation_ID,                                
    Request_ID,                                 
    Transfusion_Date,                 
    Transfusion_Amount,                
    Transfusion_Status )
    VALUES (Donation_ID,                                
    Request_ID,                                 
    Transfusion_Date,                 
    Transfusion_Amount,                
    Transfusion_Status )
    
    
END;

CREATE PROCEDURE UpdateBloodInventory(
     Blood_Type VARCHAR(5) ,               
    Quantity_Stored VARCHAR(20) ,         
    Expiry_Date DATE,                    
    Storage_Location VARCHAR(10),                
    Donation_Date DATE 
)
BEGIN
    -- Update the inventory by either adding (donation) or subtracting (transfusion)
    UPDATE BloodInventory
    SET Quantity_Stored = Quantity_Stored + Quantity
    WHERE Blood_type = Blood_Type
    
    
END;

CREATE PROCEDURE GetBloodInventory()
BEGIN
    SELECT 
        blood_type, 
        volume_available
    FROM Blood_Inventory
END;


