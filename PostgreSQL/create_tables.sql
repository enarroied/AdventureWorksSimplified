---------------------------------------------
--- With PostgreSQL 14                     --
--- Creates 1 fact table and 3 dimensions  --
--- from AdventureWorks DW                 --
---------------------------------------------
SET
    lc_monetary = 'en_US.UTF-8';

-- Drop tables if they already exist
DROP TABLE IF EXISTS factinternetsales;

DROP TABLE IF EXISTS dimcustomer;

DROP TABLE IF EXISTS dimproduct;

DROP TABLE IF EXISTS dimdate;

-- Create tables
CREATE TABLE
    factinternetsales (
        productkey INT NOT NULL,
        orderdatekey INT NOT NULL,
        duedatekey INT NOT NULL,
        shipdatekey INT NOT NULL,
        customerkey INT NOT NULL,
        promotionkey INT NOT NULL,
        currencykey INT NOT NULL,
        salesterritorykey INT NOT NULL,
        salesordernumber VARCHAR(20) NOT NULL,
        salesorderlinenumber SMALLINT NOT NULL,
        revisionnumber SMALLINT NOT NULL,
        orderquantity SMALLINT NOT NULL,
        unitprice NUMERIC(19, 4) NOT NULL,
        extendedamount NUMERIC(19, 4) NOT NULL,
        unitpricediscountpct FLOAT NOT NULL,
        discountamount FLOAT NOT NULL,
        productstandardcost NUMERIC(19, 4) NOT NULL,
        totalproductcost NUMERIC(19, 4) NOT NULL,
        salesamount NUMERIC(19, 4) NOT NULL,
        taxamt NUMERIC(19, 4) NOT NULL,
        freight NUMERIC(19, 4) NOT NULL,
        carriertrackingnumber VARCHAR(25),
        customerponumber VARCHAR(25),
        orderdate TIMESTAMP,
        duedate TIMESTAMP,
        shipdate TIMESTAMP
    );

CREATE TABLE
    dimcustomer (
        customerkey SERIAL PRIMARY KEY,
        geographykey INT,
        customeralternatekey VARCHAR(15) NOT NULL,
        title VARCHAR(8),
        firstname VARCHAR(50),
        middlename VARCHAR(50),
        lastname VARCHAR(50),
        namestyle BOOLEAN,
        birthdate DATE,
        maritalstatus CHAR(1),
        suffix VARCHAR(10),
        gender VARCHAR(1),
        emailaddress VARCHAR(50),
        yearlyincome NUMERIC,
        totalchildren SMALLINT,
        numberchildrenathome SMALLINT,
        englisheducation VARCHAR(40),
        spanisheducation VARCHAR(40),
        frencheducation VARCHAR(40),
        englishoccupation VARCHAR(100),
        spanishoccupation VARCHAR(100),
        frenchoccupation VARCHAR(100),
        houseownerflag CHAR(1),
        numbercarsowned SMALLINT,
        addressline1 VARCHAR(120),
        addressline2 VARCHAR(120),
        phone VARCHAR(20),
        datefirstpurchase DATE,
        commutedistance VARCHAR(15)
    );

CREATE TABLE
    dimproduct (
        productkey SERIAL PRIMARY KEY,
        productalternatekey VARCHAR(25),
        productsubcategorykey INT,
        weightunitmeasurecode CHAR(3),
        sizeunitmeasurecode CHAR(3),
        englishproductname VARCHAR(50) NOT NULL,
        spanishproductname VARCHAR(50),
        frenchproductname VARCHAR(50),
        standardcost NUMERIC,
        finishedgoodsflag BOOLEAN NOT NULL,
        color VARCHAR(15) NOT NULL,
        safetystocklevel SMALLINT,
        reorderpoint SMALLINT,
        listprice NUMERIC,
        size VARCHAR(50),
        sizerange VARCHAR(50),
        weight FLOAT,
        daystomanufacture INT,
        productline CHAR(2),
        dealerprice NUMERIC,
        class CHAR(2),
        style CHAR(2),
        modelname VARCHAR(50),
        largephoto BYTEA,
        englishdescription VARCHAR(400),
        frenchedescription VARCHAR(400),
        chinesedescription VARCHAR(400),
        arabicdescription VARCHAR(400),
        hebrewdescription VARCHAR(400),
        thaidescription VARCHAR(400),
        germandescription VARCHAR(400),
        japanesedescription VARCHAR(400),
        turkishdescription VARCHAR(400),
        startdate TIMESTAMP,
        enddate TIMESTAMP,
        status VARCHAR(7)
    );

CREATE TABLE
    dimdate (
        datekey INT PRIMARY KEY,
        fulldatealternatekey DATE NOT NULL,
        daynumberofweek SMALLINT NOT NULL,
        englishdaynameofweek VARCHAR(10) NOT NULL,
        spanishdaynameofweek VARCHAR(10) NOT NULL,
        frenchdaynameofweek VARCHAR(10) NOT NULL,
        daynumberofmonth SMALLINT NOT NULL,
        daynumberofyear SMALLINT NOT NULL,
        weeknumberofyear SMALLINT NOT NULL,
        englishmonthname VARCHAR(10) NOT NULL,
        spanishmonthname VARCHAR(10) NOT NULL,
        frenchmonthname VARCHAR(10) NOT NULL,
        monthnumberofyear SMALLINT NOT NULL,
        calendarquarter SMALLINT NOT NULL,
        calendaryear SMALLINT NOT NULL,
        calendarsemester SMALLINT NOT NULL,
        fiscalquarter SMALLINT NOT NULL,
        fiscalyear SMALLINT NOT NULL,
        fiscalsemester SMALLINT NOT NULL
    );

-- Add foreign key constraints
ALTER TABLE factinternetsales ADD CONSTRAINT fk_product FOREIGN KEY (productkey) REFERENCES dimproduct (productkey);

ALTER TABLE factinternetsales ADD CONSTRAINT fk_customer FOREIGN KEY (customerkey) REFERENCES dimcustomer (customerkey);

ALTER TABLE factinternetsales ADD CONSTRAINT fk_order_date FOREIGN KEY (orderdatekey) REFERENCES dimdate (datekey);

ALTER TABLE factinternetsales ADD CONSTRAINT fk_due_date FOREIGN KEY (duedatekey) REFERENCES dimdate (datekey);

ALTER TABLE factinternetsales ADD CONSTRAINT fk_ship_date FOREIGN KEY (shipdatekey) REFERENCES dimdate (datekey);