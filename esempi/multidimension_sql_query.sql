CREATE TABLE tbl_Employees
(
	EmpID INT
	,EmpName CHARACTER VARYING
	,EmpDepartment CHARACTER VARYING
	,JoiningDate TIMESTAMP WITHOUT TIME ZONE
);

 
INSERT INTO tbl_Employees
VALUES 
(1,'Anvesh','Database','2012-09-06')
,(2,'Roy','Animation','2012-10-08')
,(3,'Martin','JAVA','2013-12-25')
,(4,'Eric','JAVA','2014-01-26')
,(5,'Jenny','JAVA','2014-05-20')
,(6,'Kavita','Database','2014-12-12')
,(7,'Marlin','SQL','2015-08-08')
,(8,'Mahesh','PHP','2016-06-16');

--Count of Employee, Group By Department column:
SELECT EmpDepartment
	,COUNT(1) AS EmployeeCount
FROM tbl_Employees 
GROUP BY EmpDepartment;

--Count of Employee, Group By Joining Year:
SELECT 
	EXTRACT(YEAR FROM JoiningDate) AS JoiningYear
	,COUNT(1) AS EmployeeCount
FROM tbl_Employees 
GROUP BY EXTRACT(YEAR FROM JoiningDate);

--GROUP BY above two queries using GROUPING SETS:
SELECT 
	EmpDepartment
	,EXTRACT(YEAR FROM JoiningDate) AS JoiningYear
	,COUNT(1) AS EmployeeCount
FROM tbl_Employees
GROUP BY GROUPING SETS (EmpDepartment,EXTRACT(YEAR FROM JoiningDate));

