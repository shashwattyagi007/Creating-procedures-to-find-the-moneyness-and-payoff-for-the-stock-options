

drop table spec;
Call Specify("MSFT",110,"Call","2018-01-19");
DROP procedure Specify;
DELIMITER $
CREATE PROCEDURE specify (In Tic varchar(20),In k DOUBLE, In opt varchar(20), In Exp DATE)
BEGIN



if (Tic = "MSFT" && opt = "Call") then

Create Table Spec (Ticker VARCHAR(20),Strike DOUBLE, Option_Type VARCHAR(20),Expiration DATE, MONEYNESS VARCHAR(20),PAYOFF DOUBLE);
INSERT INTO Spec
SELECT Ticker,Strike,Option_Type,Expiration,MONEYNESS,PAYOFF FROM MSFT_CALL
WHERE Strike = k && Expiration = Exp;

elseif(Tic = "MSFT" && opt = "Put") then

Create Table Spec (Ticker VARCHAR(20),Strike DOUBLE, Option_Type VARCHAR(20),Expiration DATE, MONEYNESS VARCHAR(20),PAYOFF DOUBLE);
INSERT INTO Spec
SELECT Ticker,Strike,Option_Type,Expiration,MONEYNESS,PAYOFF FROM MSFT_PUT
WHERE Strike = k && Expiration = Exp;

elseif (Tic = "GOOGL" && opt = "Call") then

Create Table Spec (Ticker VARCHAR(20),Strike DOUBLE, Option_Type VARCHAR(20),Expiration DATE, MONEYNESS VARCHAR(20),PAYOFF DOUBLE);
INSERT INTO Spec
SELECT Ticker,Strike,Option_Type,Expiration,MONEYNESS,PAYOFF FROM GOOGL_CALL
WHERE Strike = k && Expiration = Exp;

elseif (Tic = "GOOGL" && opt = "Put") then

Create Table Spec (Ticker VARCHAR(20),Strike DOUBLE, Option_Type VARCHAR(20),Expiration DATE, MONEYNESS VARCHAR(20),PAYOFF DOUBLE);

INSERT INTO Spec
SELECT Ticker,Strike,Option_Type,Expiration,MONEYNESS,PAYOFF FROM GOOGL_PUT
WHERE Strike = k && Expiration = Exp;

End if; 

SELECT*FROM Spec;

END $
DELIMITER ;

