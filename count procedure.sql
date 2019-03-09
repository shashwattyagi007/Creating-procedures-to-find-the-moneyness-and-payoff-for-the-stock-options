Set @ticker_1 = "GOOGL";
Set @Option_type_1 = "Put";
Set @MONEYNESS_1 = "NTM";

drop table number_table;

Call count_1 (@ticker_1,@Option_type_1,@MONEYNESS_1);

drop PROCEDURE count_1;

DELIMITER $
CREATE PROCEDURE count_1 (In tic varchar(20), In opt varchar(20), In MONEYNESS_1 varchar(20))
BEGIN

if (tic =(select Ticker from msft_call  limit 1 )) && (opt = (select Option_Type from msft_call limit 1  )) && ((MONEYNESS_1 = (select MONEYNESS from msft_call where MONEYNESS = "ITM" limit 1)) or 
(MONEYNESS_1 = (select MONEYNESS from msft_call where MONEYNESS = "NTM" limit 1)) or (MONEYNESS_1 = (select MONEYNESS from msft_call where MONEYNESS = "OTM" limit 1)))
  then
  create table number_table (ticker varchar(20), Options varchar (20), total double , money_type varchar (20));
  insert into number_table
  select Ticker,  Option_Type, count(MONEYNESS), MONEYNESS from msft_call where MONEYNESS = MONEYNESS_1 limit 1;
  
elseif (tic =(select Ticker from msft_put  limit 1 )) && (opt = (select Option_Type from msft_put limit 1 )) && ((MONEYNESS_1 = (select MONEYNESS from msft_put where MONEYNESS = "ITM" limit 1)) or 
(MONEYNESS_1 = (select MONEYNESS from msft_put where MONEYNESS = "NTM" limit 1)) or (MONEYNESS_1 = (select MONEYNESS from msft_put where MONEYNESS = "OTM" limit 1)))
 then
 create table number_table (ticker varchar(20), Options varchar (20), total double , money_type varchar (20));
 insert into number_table
 select ticker, Option_Type, count(MONEYNESS), MONEYNESS from msft_put where MONEYNESS = MONEYNESS_1 limit 1;
  
elseif (tic =(select Ticker from googl_put limit 1)) && (opt = (select Option_Type from googl_put limit 1  )) && ((MONEYNESS_1 = (select MONEYNESS from googl_put where MONEYNESS = "ITM" limit 1)) or 
(MONEYNESS_1 = (select MONEYNESS from googl_put where MONEYNESS = "NTM" limit 1)) or (MONEYNESS_1 = (select MONEYNESS from googl_put where MONEYNESS = "OTM" limit 1)))
then 
create table number_table (ticker varchar(20), Options varchar (20), total double, money_type varchar (20));
 insert into number_table
  select Ticker, Option_Type, count(MONEYNESS), MONEYNESS from googl_put where MONEYNESS = MONEYNESS_1 limit 1;
  
  elseif (tic =(select Ticker from googl_call  limit 1 )) && (opt = (select Option_Type from googl_call  limit 1 )) && ((MONEYNESS_1 = (select MONEYNESS from googl_call where MONEYNESS = "ITM" limit 1)) or 
(MONEYNESS_1 = (select MONEYNESS from googl_call where MONEYNESS = "NTM" limit 1)) or (MONEYNESS_1 = (select MONEYNESS from googl_call where MONEYNESS = "OTM" limit 1)))
  then
 create table number_table (ticker varchar(20), Options varchar (20), total double, money_type varchar (20));
 insert into number_table
  select Ticker, Option_Type, count(MONEYNESS), MONEYNESS from googl_call where MONEYNESS = MONEYNESS_1 limit 1 ;
  
   
end if;

select * from number_table;

END $
DELIMITER ;

select * from number_table;

select MONEYNESS from msft_call limit 1;