Set @ticker = "GOOGL";
Set @Option_type = "Call";
Set @moneyness = "ITM";

drop table conclude;

Call General(@ticker,@Option_type,@moneyness);

drop PROCEDURE General;

DELIMITER $
CREATE PROCEDURE General(In tic varchar(20), In opt varchar(20), In moneyness varchar(20))
BEGIN

if (tic =(select Ticker from msft_call  limit 1 )) && (opt = (select Option_Type from msft_call limit 1  )) && ((moneyness = (select MONEYNESS from msft_call where MONEYNESS = "ITM" limit 1)) 
or (moneyness = (select MONEYNESS from msft_call where MONEYNESS = "NTM" limit 1)) or (moneyness = (select MONEYNESS from msft_call where MONEYNESS = "OTM" limit 1)))
  then
  create table conclude (ticker varchar(20), Strike double, Options varchar (20), Expiration Date, money_type varchar (20), payoff double);
  insert into conclude
  select ticker, Strike, Option_Type, Expiration, MONEYNESS, payoff from msft_call;
  
 elseif (tic =(select Ticker from msft_put  limit 1 )) && (opt = (select Option_Type from msft_put limit 1 )) && ((moneyness = (select MONEYNESS from msft_put where MONEYNESS = "ITM" limit 1)) or 
(moneyness = (select MONEYNESS from msft_put where MONEYNESS = "NTM" limit 1)) or (moneyness = (select MONEYNESS from msft_put where MONEYNESS = "OTM" limit 1)))
 then
 create table conclude (ticker varchar(20), Strike double, Options varchar (20), Expiration Date, money_type varchar (20), payoff double);
 insert into conclude
  select ticker, Strike, Option_Type, Expiration, MONEYNESS, payoff from msft_put;
  
elseif (tic =(select Ticker from googl_put limit 1)) && (opt = (select Option_Type from googl_put limit 1  )) && ((moneyness = (select MONEYNESS from googl_put where MONEYNESS = "ITM" limit 1)) or 
(moneyness = (select MONEYNESS from googl_put where MONEYNESS = "NTM" limit 1)) or (moneyness = (select MONEYNESS from googl_put where MONEYNESS = "OTM" limit 1)))
then 
create table conclude (ticker varchar(20), Strike double, Options varchar (20), Expiration Date, money_type varchar (20), payoff double);
 insert into conclude
  select ticker, Strike, Option_Type, Expiration, MONEYNESS, payoff from googl_put;
  
  elseif (tic =(select Ticker from googl_call  limit 1 )) && (opt = (select Option_Type from googl_call  limit 1 )) && ((moneyness = (select MONEYNESS from googl_call where MONEYNESS = "ITM" limit 1)) or 
(moneyness = (select MONEYNESS from googl_call where MONEYNESS = "NTM" limit 1)) or (moneyness = (select MONEYNESS from googl_call where MONEYNESS = "OTM" limit 1)))
  then 
  create table conclude (ticker varchar(20),Strike double, Options varchar (20), Expiration Date, money_type varchar (20), payoff double);
 insert into conclude
  select ticker, Strike, Option_Type, Expiration, MONEYNESS, payoff from googl_call;
end if;

select * from conclude;

END $
DELIMITER ;

select * from conclude;