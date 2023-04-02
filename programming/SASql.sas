/*
This is is an demonstration of both SAS and SAS's implementation of SQL. 

It is titled "SASql" because SAS's SQL is not identical to normal SQL syntax, but more of a hybrid between SAS syntax and SQL syntax; 
this differs from other programming languages where you call SQL through a function and pass through native SQL syntax.
*/ 


/*Minimal example*/
proc sql; /*Begins the SQL implementation, normal SAS syntax (procs, datasteps, etc.) cannot be used until this is quit*/
select /*what columns it will bring*/
*      /*The "*" is a wildcard which brings all columns*/
from 
libname.TableName /*use whatever library and table desired*/
;      /*While they can be long, the "select ..." is a single query and that query is terminated in a semicolon*/
       /*More queries could go here*/
quit;  /*Exit proc sql*/


/*Simple example: This will likely be how most queries will work as you're developing skills*/
proc sql;
create table NewTableName as/*Create table will return a SAS dataset instead of just printing the results*/
select
UniqueColumn             /*Here we bring in a specified column, this is not best practice because it is ambiguous and does not reference where the column is coming from*/
,T1.ColumnName    /*This is not ambigious and is much more appropriate*/
,T1.FA0BASE    as FaceAmount    /*Here we are changing what the output column will be titled*/
,ifn(TableName.FA0BASE>9000,1,0) as Over9000 /*Here is an if-statement that returns a NUMERIC (ifn) result. 1 will be returned if the face amount is over 9000*/
,ifc(calculated Over9000 = 1,"There is no way it can be that high","")  as Remark /*Here is an if statement that returns a CHARACTER (ifc). The "calculated" prefix before "over9000" indicates that we calculated this value and it is not on the source tables. If Over9000 does not exist, it will return an empty/null string*/
from TableName as T1 /*Here we made an Alias "T1" for the TableName, this allows us to have smaller prefixes in the above code and better document*/
where SomeColumn eq "Somecondition" /*here we are limiting the INPUT dataset (TableName) so that only rows where that condition is satisfied are processed*/
;
quit;

