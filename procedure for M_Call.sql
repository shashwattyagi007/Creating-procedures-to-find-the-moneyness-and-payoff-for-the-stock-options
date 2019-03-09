CREATE TABLE MSFT_Call 
	(
	Strike DOUBLE,
    Expiration varchar(255),
    Ticker varchar(100),
	Company varchar(100),
    Bid DOUBLE,
    Ask DOUBLE,
    Last DOUBLE,
    IVM DOUBLE,
    Volume INT,
    MONEYNESS VARCHAR(10),
    PAYOFF DOUBLE
	);
    
    Drop table MSFT_Call;

#create temporary table
	CREATE TABLE TEMP 
	(
	Strike DOUBLE,
	Ticker varchar(100),
    Bid DOUBLE,
    Ask DOUBLE,
    Last DOUBLE,
    IVM DOUBLE,
    Volume INT,
    Expiration Varchar (255) 
	);
DROP TABLE TEMP;
SELECT*FROM TEMP;
#Pull call data and store in temp table CHECK IF THIS EXPIRATION ALREADY EXISTS
#EVEN BETTER UNION THIS WITH THE MAIN COMPANY CALL

LOAD DATA LOCAL INFILE 'D:/Work/StevensInstituteofTechnology/SEM1/DatabaseEngineering/project/Files/NEW files/MSFT_Call_1-19-18.csv'
	INTO TABLE TEMP
    FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\r\n'
    IGNORE 2 LINES;


----------------------------------------
LOAD DATA LOCAL INFILE 'D:/Work/StevensInstituteofTechnology/SEM1/DatabaseEngineering/project/Files/NEW files/MSFT_Call_2-16-18.csv'
	INTO TABLE TEMP
    FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\r\n'
    IGNORE 2 LINES;
 

-------------------------------------------------
LOAD DATA LOCAL INFILE 'D:/Work/StevensInstituteofTechnology/SEM1/DatabaseEngineering/project/Files/NEW files/MSFT_Call_3-16-18.csv'
	INTO TABLE TEMP
    FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\r\n'
    IGNORE 2 LINES;


------------------------------------ 
 ALTER TABLE TEMP 
CHANGE COLUMN Expiration Expiration_Date 
DATE AFTER Strike;

DROP TABLE MSFT_Call;
call M_Call();
SELECT*FROM MSFT_Call;

DROP PROCEDURE M_CALL;
DELIMITER $
CREATE PROCEDURE M_CALL()
BEGIN
 
UPDATE TEMP
SET Expiration_Date = "2018-03-16" where ticker like "MSFT 3/16/18 %";
UPDATE TEMP
SET Expiration_Date = "2018-01-19" where ticker like "MSFT 1/19/18 %" ; 
UPDATE TEMP
SET Expiration_Date = "2018-02-16" where ticker like "MSFT 2/16/18 %" ; 
UPDATE TEMP
SET Ticker = "MSFT";
ALTER TABLE TEMP
ADD COLUMN Company VARCHAR(100) default "Microsoft"
AFTER Ticker;
ALTER TABLE TEMP
ADD COLUMN MONEYNESS VARCHAR(3)
AFTER Volume;

ALTER TABLE TEMP
ADD COLUMN PAYOFF DOUBLE
AFTER MONEYNESS;


 
#2018-01-19
UPDATE TEMP
SET MONEYNESS = "ITM"
WHERE Expiration_Date = "2018-01-19" && Strike < (SELECT Close FROM MSFT_EQUITY WHERE Date = "2018-01-19")
;

UPDATE TEMP
SET MONEYNESS = "OTM"
WHERE Expiration_Date = "2018-01-19" && Strike  > (SELECT Close FROM MSFT_EQUITY WHERE Date = "2018-01-19")
;

UPDATE TEMP
SET MONEYNESS = "NTM"
WHERE Expiration_Date ="2018-01-19" && (Strike BETWEEN (SELECT Close -1 FROM MSFT_EQUITY WHERE Date = "2018-01-19") AND (SELECT Close + 1 FROM MSFT_EQUITY WHERE Date = "2018-01-19"));

UPDATE TEMP
SET PAYOFF = (SELECT Close FROM MSFT_EQUITY WHERE DATE = "2018-01-19") - Strike
WHERE Expiration_Date = "2018-01-19";

UPDATE TEMP
SET PAYOFF = 0
WHERE Expiration_Date = "2018-01-19" && ((SELECT Close FROM MSFT_EQUITY WHERE DATE = "2018-01-19") - Strike) < 0;

#2018-02-16

UPDATE TEMP
SET MONEYNESS = "ITM"
WHERE Expiration_Date = "2018-02-16" && Strike  < (SELECT Close FROM MSFT_EQUITY WHERE Date = "2018-02-16");

UPDATE TEMP
SET MONEYNESS = "OTM"
WHERE Expiration_Date = "2018-02-16" && Strike > (SELECT Close FROM MSFT_EQUITY WHERE Date = "2018-02-16");

UPDATE TEMP
SET MONEYNESS = "NTM"
WHERE Expiration_Date ="2018-02-16" && (Strike BETWEEN (SELECT Close -1 FROM MSFT_EQUITY WHERE Date = "2018-02-16") AND (SELECT Close + 1 FROM MSFT_EQUITY WHERE Date = "2018-02-16"));

UPDATE TEMP
SET PAYOFF = (SELECT Close FROM MSFT_EQUITY WHERE DATE = "2018-02-16") - Strike
WHERE Expiration_Date = "2018-02-16";

UPDATE TEMP
SET PAYOFF = 0
WHERE Expiration_Date = "2018-02-16" && ((SELECT Close FROM MSFT_EQUITY WHERE DATE = "2018-02-16") - Strike) < 0;



#2018-03-16

UPDATE TEMP
SET MONEYNESS = "ITM"
WHERE Expiration_Date = "2018-03-16" && Strike < (SELECT Close FROM MSFT_EQUITY WHERE Date = "2018-03-16");

UPDATE TEMP
SET MONEYNESS = "OTM"
WHERE Expiration_Date = "2018-03-16" && Strike  > (SELECT Close FROM MSFT_EQUITY WHERE Date = "2018-03-16");

UPDATE TEMP
SET MONEYNESS = "NTM"
WHERE Expiration_Date ="2018-03-16" && (Strike BETWEEN (SELECT Close -1 FROM MSFT_EQUITY WHERE Date = "2018-03-16") AND (SELECT Close + 1 FROM MSFT_EQUITY WHERE Date = "2018-03-16"));

UPDATE TEMP
SET PAYOFF = (SELECT Close FROM MSFT_EQUITY WHERE DATE = "2018-03-16") - Strike
WHERE Expiration_Date = "2018-03-16";

UPDATE TEMP
SET PAYOFF = 0
WHERE Expiration_Date = "2018-03-16" && ((SELECT Close FROM MSFT_EQUITY WHERE DATE = "2018-03-16") - Strike) < 0;

INSERT INTO MSFT_Call
SELECT*FROM TEMP;

Alter table MSFT_Call
add column Option_Type VARCHAR(10);

UPDATE MSFT_Call
SET Option_Type = "Call";



SELECT*FROM MSFT_CALL;

END $
DELIMITER ;

SELECT*FROM MSFT_PUT;