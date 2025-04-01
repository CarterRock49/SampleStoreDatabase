Use master;
go
CREATE DATABASE GroupFive; --Change the database name if needed.
GO
USE GroupFive

--Creating the Person table
create table Person(
PersonID             int,
LastName             char(15),
FirstName             char(20),
HomeAddress             char(50),
City                 char(30),
HomeState                 char(2)        default 'MI',
Zipcode             char(5),
PhoneNumber         char(10),
Email				char(50),
--Constraints
--Primary key
Constraint person_personid_pk primary key(PersonID)
);

--Creating the Employee table
create table Employee(
PersonID             int,
EmployeeDOB        date        not null,
EmployeeSSN            char(9)        not null,
EmployeeDL            char(13),
EmployeeHireDate        date        not null,
EmployeeTerminatedDate    date,
--Constraints
--Primary key
constraint employee_personid_pk primary key(PersonID),
--Foreign key
constraint employee_personid_fk foreign key (PersonID) references Person(PersonID)
        on update cascade,
constraint employee_employeessn_uk unique(EmployeeSSN),
--Check Constraint
constraint employee_employeeterminateddate_ck check (employeeterminateddate < employeehiredate)
);
--Creating the Customer table
create table Customer(
PersonID             int,
CustomerSince        date        not null,
--Constraints
--Primary key
constraint customer_personid_pk primary key(PersonID),
--Foreign key
constraint customer_personid_fk foreign key (PersonID) references Person(PersonID)
        on update cascade
);

--Creating the Department table
create table Department(
DepartmentID            int,
DepartmentName        char(25)     not null,
DepartmentDescription     char(50)     not null,
--constraints
--primary key
constraint department_departmentid_pk primary key(DepartmentID)
);

--Creating the Sub_department table
create table Sub_department(
SubdepartmentID            int,
SubdepartmentName            varchar(25)     not null,
SubdepartmentDescription         varchar(50)     not null,
DepartmentID                int,
--constraints
--primary key
constraint subdepartment_subdepartmentid_pk primary key(SubdepartmentID),
--foreign key
constraint subdepartment_departmentid_fk foreign key(DepartmentID) references department(departmentid)
    on update cascade
);


--Creating the Product table
create table Product(
ProductID         int,
ProductDescription     varchar(50)        not null,
ProductSize         char(3)            not null,
ProductColor         char(25)        not null,
ProductPrice         decimal(9,2)        not null,
ProductQOH         int            not null,
SubDepartmentID     int,
--constraints
--primary key
constraint product_productid_pk primary key(ProductID),
--foreign key
constraint product_subdepartmentid_fk foreign key(SubDepartmentID) references Sub_department(subdepartmentid)
    on update cascade,
--Check Constraint
constraint product_productsize check (ProductSize in ('XS', 'S', 'M', 'L', 'XL', 'XXL', '30', '31', '32', '33', '34', '36', '0', '2', '4', '6', '8', '10'))
);


--Creating the Promotion table
create table Promotion(
PromotionID                     int,
PromotionPercentage      int,
PromotionStartDate         date,
PromotionEndDate          date,
--Constraints
--Primary Keys 
Constraint promotion_promotionid_pk primary key(PromotionID),
--Check Constraint
Constraint Promotion_PromotionEndDate_ck check (PromotionEndDate > PromotionStartDate)
);

--Creating the Order table
create table Order2(
OrderID    int,
OrderDate    date        not null,
Price        decimal(9,2)    not null,
PersonID    int        not null,
--constraints
--primary key
constraint order_orderid_pk primary key(OrderID),
--foreign key
constraint order_personid_fk foreign key(PersonID) references person(personid)
    on update cascade
);

--Creating the Employee_Order table
create table Employee_Order(
OrderID    int,
PersonID    int,
Starttime    datetime     not null,
Endtime    datetime     not null,
--Constraints
--Primary key
constraint employeeorder_orderpersonid_pk primary key(OrderID, PersonID),
 --foreign keys
constraint employeeorder_orderid_fk foreign key (OrderID) references Order2(OrderID)
        on update cascade,
constraint employeeorder_personid_fk foreign key (PersonID) references Person(PersonID),
--Check Constraint
constraint employeeorder_dateleave_ck check (endtime > starttime)
);

--Creating the Order_Detail table
create table Order_Detail(
OrderDetailID            int,
ProductID                  int,
OrderDetailQty          int,
PromotionID              int,
--Constraints
--Primary Keys
Constraint orderdetail_orderdetailproductid_pk primary key(OrderDetailID, ProductID),
--Foreign Keys
Constraint orderdetail_orderdetailid_fk foreign key(OrderDetailID) references Order2(OrderID)
		on update cascade,
Constraint orderdetail_productid_fk foreign key(ProductID) references Product(ProductID)
		on update cascade,
Constraint orderdetail_promotionid_fk foreign key(PromotionID) references Promotion(PromotionID)
		on update cascade
);


--Add data to the Person table
Insert into Person
(PersonID, LastName, FirstName, HomeAddress, City, HomeState, Zipcode, PhoneNumber, Email)
Values
(10000, 'Doe', 'John', 'Madeupname rd', 'Madeupcity', 'MI', 55555, 5555555555, 'Madeupemail@email.com'),
(10001, 'Doe', 'Jane', 'Madeupname rd', 'Madeupcity', 'MI', 55555, 5555555555, 'Madeupemail@email.com'),
(10002, 'Doe', 'Jimmy', 'Madeupname rd', 'Madeupcity', 'MI', 55555, 5555555555, 'Madeupemail@email.com'),
(10003, 'Doe', 'Joe', 'Madeupname rd', 'Madeupcity', 'MI', 55555, 5555555555, 'Madeupemail@email.com'),
(10004, 'Smith', 'John', 'Fake rd', 'Fakecity', 'OH', 55555, 5555555555, 'Fake@email.com'),
(10005, 'Wayne', 'John', 'Fake rd', 'Fakecity', 'OH', 55555, 5555555555, 'Fake@email.com'),
(10006, 'Cena', 'John', 'Fake rd', 'Fakecity', 'OH', 55555, 5555555555, 'Fake@email.com'),
(10007, 'Kennedy', 'John', 'Fake rd', 'Fakecity', 'OH', 55555, 5555555555, 'Fake@email.com'),
(10008, 'Adams', 'John', 'Fake rd', 'Fakecity', 'OH', 55555, 5555555555, 'Fake@email.com'),
(10009, 'Lennon', 'John', 'Fake rd', 'Fakecity', 'OH', 55555, 5555555555, 'Fake@email.com'),
(10010, 'Tyler', 'John', 'Fake rd', 'Fakecity', 'OH', 55555, 5555555555, 'Fake@email.com');


--Add data to the Employee tabl
Insert into Employee
(PersonID, EmployeeDOB, EmployeeSSN, EmployeeDL, EmployeeHireDate, EmployeeTerminatedDate)
Values
(10005, '1999-01-25', 555555555, 'Z555555555555', '2020-05-30', NULL),
(10006, '1999-02-01', 555555556, 'Z555555555555', '2020-06-27', NULL),
(10007, '1999-03-29', 555555557, 'Z555555555555', '2020-07-01', NULL),
(10008, '1999-04-22', 555555558, 'Z555555555555', '2020-08-03', NULL),
(10009, '1999-05-25', 555555559, 'Z555555555555', '2020-09-11', NULL),
(10010, '1999-06-20', 555555510, 'Z555555555555', '2020-12-01', NULL);

--Add data to the Customer table)
Insert into Customer
(PersonID, CustomerSince)
Values
(10000,  '2021-01-02'),
(10001,  '2020-10-15'),
(10002,  '2020-07-22'),
(10003,  '2021-03-26'),
(10004,  '2020-11-01');

--Add data to the Department table
Insert into Department
(DepartmentID, DepartmentName, DepartmentDescription)
Values
(101, 'MENS', 'MENS APPAREL'),
(102, 'WOMENS', 'WOMENS APPAREL');


--Add data to the Sub_department table
Insert into Sub_department
(SubdepartmentID, SubdepartmentName, SubdepartmentDescription, DepartmentID)
Values
(1001, 'MENS TOPS, MENS T-SHIRTS', 'KNITS, WOVENS, AND SWEATERS', 101),
(1002, 'MENS BOTTOMS, MENS JEANS', 'KHAKIS, SHORTS, AND DRESS PANTS', 101),
(1003, 'MENS OUTERWEAR', 'MENS COATS AND JACKETS', 101),
(1004, 'WOMENS TOPS', 'WOMENS T-SHIRTS, KNITS, WOVENS, AND SWEATERS', 102),
(1005, 'WOMENS BOTTOMS', 'WOMENS JEANS, DRESSES, SHORTS, DRESS PANTS', 102),
(1006, 'WOMENS OUTERWEAR', 'WOMENS COATS AND JACKETS', 102);


--Add data to the Product table
Insert into Product
(ProductID, ProductDescription, ProductSize, ProductColor, ProductPrice, ProductQOH, SubDepartmentID)
Values
  --Men's Product
(1001, 'CONTRAST PLACKET DRESS SHIRT', 'XS', 'BLACK' , 88.00, 2, 1001),
(1002, 'CONTRAST PLACKET DRESS SHIRT', 'S', 'BLACK', 88.00, 3, 1001),
(1003, 'CONTRAST PLACKET DRESS SHIRT', 'M', 'BLACK', 88.00, 5, 1001),
(1004, 'CONTRAST PLACKET DRESS SHIRT', 'L', 'BLACK', 88.00, 5, 1001),
(1005, 'CONTRAST PLACKET DRESS SHIRT', 'XL', 'BLACK', 88.00, 3, 1001),
(1006, 'CONTRAST PLACKET DRESS SHIRT', 'XXL', 'BLACK', 88.00, 2, 1001),
(1007, 'CONTRAST PLACKET DRESS SHIRT', 'XS', 'WHITE', 88.00, 2, 1001),
(1008, 'CONTRAST PLACKET DRESS SHIRT', 'S', 'WHITE', 88.00, 3, 1001),
(1009, 'CONTRAST PLACKET DRESS SHIRT', 'M', 'WHITE', 88.00, 5, 1001),
(1010, 'CONTRAST PLACKET DRESS SHIRT', 'L', 'WHITE',88.00,5,1001),
(1011, 'CONTRAST PLACKET DRESS SHIRT', 'XL', 'WHITE', 88.00, 3, 1001),
(1012, 'CONTRAST PLACKET DRESS SHIRT', 'XXL', 'WHITE', 88.00, 2, 1001),
(1013, 'CONTRAST PLACKET DRESS SHIRT', 'XS', 'RED', 88.00, 2, 1001),
(1014, 'CONTRAST PLACKET DRESS SHIRT', 'S', 'RED', 88.00, 3, 1001),
(1015, 'CONTRAST PLACKET DRESS SHIRT', 'M', 'RED', 88.00, 5, 1001),
(1016, 'CONTRAST PLACKET DRESS SHIRT', 'L', 'RED', 88.00, 5, 1001),
(1017, 'CONTRAST PLACKET DRESS SHIRT', 'XL', 'RED', 88.00, 3, 1001),
(1018, 'CONTRAST PLACKET DRESS SHIRT', 'XXL', 'RED', 88.00, 2, 1001),
(1019, 'SHORT SLEEVE SOLID DRESS SHIRT', 'XS', 'FIESTA', 78.00, 2, 1001),
(1020, 'SHORT SLEEVE SOLID DRESS SHIRT', 'S', 'FIESTA', 78.00, 3, 1001),
(1021, 'SHORT SLEEVE SOLID DRESS SHIRT', 'M', 'FIESTA', 78.00, 5, 1001),
(1022, 'SHORT SLEEVE SOLID DRESS SHIRT', 'L', 'FIESTA', 78.00, 5, 1001),
(1023, 'SHORT SLEEVE SOLID DRESS SHIRT', 'XL', 'FIESTA', 78.00, 3, 1001),
(1024, 'SHORT SLEEVE SOLID DRESS SHIRT', 'XXL', 'FIESTA', 78.00, 2, 1001),
(1025, 'SHORT SLEEVE SOLID DRESS SHIRT', 'XS', 'NICKEL', 78.00, 2, 1001),
(1026, 'SHORT SLEEVE SOLID DRESS SHIRT', 'S', 'NICKEL', 78.00, 3, 1001),
(1027, 'SHORT SLEEVE SOLID DRESS SHIRT', 'M', 'NICKEL', 78.00, 5, 1001),
(1028, 'SHORT SLEEVE SOLID DRESS SHIRT', 'L', 'NICKEL', 78.00, 5, 1001),
(1029, 'SHORT SLEEVE SOLID DRESS SHIRT', 'XL', 'NICKEL', 78.00, 3, 1001),
(1030, 'SHORT SLEEVE SOLID DRESS SHIRT', 'XXL', 'NICKEL', 78.00, 2, 1001),
(1031, 'CREPE WEAVE SHIRT', 'XS', 'BLACK', 98.00, 2, 1001),
(1032, 'CREPE WEAVE SHIRT', 'S', 'BLACK', 98.00, 3, 1001),
(1033, 'CREPE WEAVE SHIRT', 'M', 'BLACK', 98.00, 5, 1001),
(1034, 'CREPE WEAVE SHIRT', 'L', 'BLACK', 98.00, 5, 1001),
(1035, 'CREPE WEAVE SHIRT', 'XL', 'BLACK', 98.00, 3, 1001),
(1036, 'CREPE WEAVE SHIRT', 'XXL', 'BLACK', 98.00, 2, 1001),
(1037, 'CREPE WEAVE SHIRT', 'XS', 'WHITE', 98.00, 2, 1001),
(1038, 'CREPE WEAVE SHIRT', 'S', 'WHITE', 98.00, 3, 1001),
(1039, 'CREPE WEAVE SHIRT', 'M', 'WHITE', 98.00, 5, 1001),
(1040, 'CREPE WEAVE SHIRT', 'L', 'WHITE', 98.00, 5, 1001),
(1041, 'CREPE WEAVE SHIRT', 'XL', 'WHITE', 98.00, 3, 1001),
(1042, 'CREPE WEAVE SHIRT', 'XXL', 'WHITE', 98.00, 2, 1001),
(1043, 'GEO DOT PRINT SHIRT', 'XS', 'MARINE BLUE', 78.00, 2, 1001),
(1044, 'GEO DOT PRINT SHIRT', 'S', 'MARINE BLUE', 78.00, 3, 1001),
(1045, 'GEO DOT PRINT SHIRT', 'M', 'MARINE BLUE', 78.00, 5, 1001),
(1046, 'GEO DOT PRINT SHIRT', 'L', 'MARINE BLUE', 78.00, 5, 1001),
(1047, 'GEO DOT PRINT SHIRT', 'XL', 'MARINE BLUE', 78.00, 3, 1001),
(1048, 'GEO DOT PRINT SHIRT', 'XXL', 'MARINE BLUE', 78.00, 2, 1001),
(1049, 'BOLD PLAID SHIRT', 'XS', 'BOLD RED', 78.00, 2, 1001),
(1050, 'BOLD PLAID SHIRT', 'S', 'BOLD RED', 78.00, 3, 1001),
(1051, 'BOLD PLAID SHIRT', 'M', 'BOLD RED', 78.00, 5, 1001),
(1052, 'BOLD PLAID SHIRT', 'L', 'BOLD RED', 78.00, 5, 1001),
(1053, 'BOLD PLAID SHIRT', 'XL', 'BOLD RED',  78.00, 3, 1001),
(1054, 'BOLD PLAID SHIRT', 'XXL', 'BOLD RED', 78.00, 2, 1001),
(1055, 'COTTON BASIC SHIRT', 'XS', 'BLACK', 58.00, 2, 1001),
(1056, 'COTTON BASIC SHIRT', 'S', 'BLACK', 58.00, 3, 1001),
(1057, 'COTTON BASIC SHIRT', 'M', 'BLACK', 58.00, 5, 1001),
(1058, 'COTTON BASIC SHIRT', 'L' ,'BLACK', 58.00, 5, 1001),
(1059, 'COTTON BASIC SHIRT', 'XL', 'BLACK', 58.00, 3, 1001),
(1060, 'COTTON BASIC SHIRT', 'XXL', 'BLACK', 58.00, 2, 1001),
(1061, 'COTTON BASIC SHIRT', 'XS', 'WHITE', 58.00, 2, 1001),
(1062, 'COTTON BASIC SHIRT', 'S', 'WHITE', 58.00, 3, 1001),
(1063, 'COTTON BASIC SHIRT', 'M', 'WHITE', 58.00, 5, 1001),
(1064, 'COTTON BASIC SHIRT', 'L', 'WHITE', 58.00, 5, 1001),
(1065, 'COTTON BASIC SHIRT', 'XL', 'WHITE', 58.00, 3, 1001),
(1066, 'COTTON BASIC SHIRT', 'XXL', 'WHITE', 58.00, 2, 1001),
(1067, 'COTTON BASIC SHIRT', 'XS', 'MARINE BLUE', 58.00, 2, 1001),
(1068, 'COTTON BASIC SHIRT', 'S', 'MARINE BLUE', 58.00, 3, 1001),
(1069, 'COTTON BASIC SHIRT', 'M', 'MARINE BLUE', 58.00, 5, 1001),
(1070, 'COTTON BASIC SHIRT', 'L', 'MARINE BLUE', 58.00, 5, 1001),
(1071, 'COTTON BASIC SHIRT', 'XL', 'MARINE BLUE', 58.00, 3, 1001),
(1072, 'COTTON BASIC SHIRT', 'XXL', 'MARINE BLUE', 58.00, 2, 1001),
(1073, 'SMART STRIPE DRESS SHIRT', 'XS', 'WHITE', 78.00, 2, 1001),
(1074, 'SMART STRIPE DRESS SHIRT', 'S', 'WHITE', 78.00, 3, 1001),
(1075, 'SMART STRIPE DRESS SHIRT', 'M', 'WHITE', 78.00, 5, 1001),
(1076, 'SMART STRIPE DRESS SHIRT', 'L', 'WHITE', 78.00, 5, 1001),
(1077, 'SMART STRIPE DRESS SHIRT', 'XL', 'WHITE', 78.00, 3, 1001),
(1078, 'SMART STRIPE DRESS SHIRT', 'XXL', 'WHITE', 78.00, 2, 1001),
(1079, 'SLUBBY POLO', 'XS', 'BLACK', 48.00, 2, 1001),
(1080, 'SLUBBY POLO', 'S', 'BLACK', 48.00, 3, 1001),
(1081, 'SLUBBY POLO', 'M', 'BLACK', 48.00, 5, 1001),
(1082, 'SLUBBY POLO', 'L', 'BLACK', 48.00, 5, 1001),
(1083, 'SLUBBY POLO', 'XL', 'BLACK', 48.00, 3, 1001),
(1084, 'SLUBBY POLO', 'XXL', 'BLACK', 48.00, 2, 1001),
(1085, 'SLUBBY POLO', 'XS', 'WHITE', 48.00, 2, 1001),
(1086, 'SLUBBY POLO', 'S', 'WHITE', 48.00, 3, 1001),
(1087, 'SLUBBY POLO', 'M', 'WHITE', 48.00, 5, 1001),
(1088, 'SLUBBY POLO', 'L', 'WHITE', 48.00, 5, 1001),
(1089, 'SLUBBY POLO', 'XL', 'WHITE', 48.00, 3, 1001),
(1090, 'SLUBBY POLO', 'XXL', 'WHITE', 48.00, 2, 1001),
(1091, 'SLUBBY POLO', 'XS', 'MARINE BLUE', 48.00, 2, 1001),
(1092, 'SLUBBY POLO', 'S', 'MARINE BLUE', 48.00, 3, 1001),
(1093, 'SLUBBY POLO', 'M', 'MARINE BLUE', 48.00, 5, 1001),
(1094, 'SLUBBY POLO', 'L', 'MARINE BLUE', 48.00, 5, 1001),
(1095, 'SLUBBY POLO', 'XL', 'MARINE BLUE', 48.00, 3, 1001),
(1096, 'SLUBBY POLO', 'XXL', 'MARINE BLUE', 48.00, 2, 1001),
(1097, 'PIQUE POLO', 'XS', 'FIESTA', 58.00, 2, 1001),
(1098, 'PIQUE POLO', 'S', 'FIESTA', 58.00, 3, 1001),
(1099, 'PIQUE POLO', 'M', 'FIESTA', 58.00, 5, 1001),
(1100, 'PIQUE POLO', 'L', 'FIESTA', 58.00, 5, 1001),
(1101, 'PIQUE POLO', 'XL', 'FIESTA', 58.00, 3, 1001),
(1102, 'PIQUE POLO', 'XXL', 'FIESTA', 58.00, 2, 1001),
(1103, 'TIPPED SWEATER POLO', 'XS', 'NAVY', 68.00, 2, 1001),
(1104, 'TIPPED SWEATER POLO', 'S', 'NAVY', 68.00, 3, 1001),
(1105, 'TIPPED SWEATER POLO', 'M', 'NAVY', 68.00, 5, 1001),
(1106, 'TIPPED SWEATER POLO', 'L', 'NAVY', 68.00, 5, 1001),
(1107, 'TIPPED SWEATER POLO', 'XL', 'NAVY', 68.00, 3, 1001),
(1108, 'TIPPED SWEATER POLO', 'XXL', 'NAVY', 68.00, 2, 1001),
(1109, 'SPACE DYE SWEATER', 'XS', 'INDIGO', 78.00, 2, 1001),
(1110, 'SPACE DYE SWEATER', 'S', 'INDIGO', 78.00, 3, 1001),
(1111, 'SPACE DYE SWEATER', 'M', 'INDIGO', 78.00, 5, 1001),
(1112, 'SPACE DYE SWEATER', 'L', 'INDIGO', 78.00, 5, 1001),
(1113, 'SPACE DYE SWEATER', 'XL', 'INDIGO', 78.00, 3, 1001),
(1114, 'SPACE DYE SWEATER', 'XXL', 'INDIGO', 78.00, 2, 1001),
(1115, 'MESH LOGO CREW SWEATER', 'XS', 'MARINE BLUE', 78.00, 2, 1001),
(1116, 'MESH LOGO CREW SWEATER', 'S', 'MARINE BLUE', 78.00, 3, 1001),
(1117, 'MESH LOGO CREW SWEATER', 'M', 'MARINE BLUE', 78.00, 5, 1001),
(1118, 'MESH LOGO CREW SWEATER', 'L', 'MARINE BLUE', 78.00, 5, 1001),
(1119, 'MESH LOGO CREW SWEATER', 'XL', 'MARINE BLUE', 78.00, 3, 1001),
(1120, 'MESH LOGO CREW SWEATER', 'XXL', 'MARINE BLUE', 78.00, 2, 1001),
(1121, 'SELVEDGE SKINNY JEANS', '30', 'INDIGO', 98.00, 2, 1002),
(1122, 'SELVEDGE SKINNY JEANS', '31', 'INDIGO', 98.00, 3, 1002),
(1123, 'SELVEDGE SKINNY JEANS', '32', 'INDIGO', 98.00, 5, 1002),
(1124, 'SELVEDGE SKINNY JEANS', '33', 'INDIGO', 98.00, 5, 1002),
(1125, 'SELVEDGE SKINNY JEANS', '34', 'INDIGO', 98.00, 3, 1002),
(1126, 'SELVEDGE SKINNY JEANS', '36', 'INDIGO', 98.00, 2, 1002),
(1127, 'WORN GREY WASH STRAIGHT LEG JEANS', '30', 'GREY', 128.00, 2, 1002),
(1128, 'WORN GREY WASH STRAIGHT LEG JEANS', '31', 'GREY', 128.00, 3, 1002),
(1129, 'WORN GREY WASH STRAIGHT LEG JEANS', '32', 'GREY', 128.00, 5, 1002),
(1130, 'WORN GREY WASH STRAIGHT LEG JEANS', '33', 'GREY', 128.00, 5, 1002),
(1131, 'WORN GREY WASH STRAIGHT LEG JEANS', '34', 'GREY', 128.00, 3, 1002),
(1132, 'WORN GREY WASH STRAIGHT LEG JEANS', '36', 'GREY', 128.00, 2, 1002),
(1133, 'SLUBBY INDIGO STRAIGHT LEG JEANS', '30', 'INDIGO', 128.00, 2, 1002),
(1134, 'SLUBBY INDIGO STRAIGHT LEG JEANS', '31', 'INDIGO', 128.00, 3, 1002),
(1135, 'SLUBBY INDIGO STRAIGHT LEG JEANS', '32', 'INDIGO', 128.00, 5, 1002),
(1136, 'SLUBBY INDIGO STRAIGHT LEG JEANS', '33', 'INDIGO', 128.00, 5, 1002),
(1137, 'SLUBBY INDIGO STRAIGHT LEG JEANS', '34', 'INDIGO', 128.00, 3, 1002),
(1138, 'SLUBBY INDIGO STRAIGHT LEG JEANS', '36', 'INDIGO', 128.00, 2, 1002),
(1139, 'LIGHT DESTRUCTION BOOT CUT JEAN', '30', 'INDIGO', 128.00, 2, 1002),
(1140, 'LIGHT DESTRUCTION BOOT CUT JEAN', '31', 'INDIGO', 128.00, 3, 1002),
(1141, 'LIGHT DESTRUCTION BOOT CUT JEAN', '32', 'INDIGO', 128.00, 5, 1002),
(1142, 'LIGHT DESTRUCTION BOOT CUT JEAN', '33', 'INDIGO', 128.00, 5, 1002),
(1143, 'LIGHT DESTRUCTION BOOT CUT JEAN', '34', 'INDIGO', 128.00, 3, 1002),
(1144, 'LIGHT DESTRUCTION BOOT CUT JEAN', '36', 'INDIGO', 128.00, 2, 1002),
(1145, 'SLIM CARGO PANT', '30', 'BLACK', 98.00, 2, 1002),
(1146, 'SLIM CARGO PANT', '31', 'BLACK', 98.00, 3, 1002),
(1147, 'SLIM CARGO PANT', '32', 'BLACK', 98.00, 5, 1002),
(1148, 'SLIM CARGO PANT', '33', 'BLACK', 98.00, 5, 1002),
(1149, 'SLIM CARGO PANT', '34', 'BLACK', 98.00, 3, 1002),
(1150, 'SLIM CARGO PANT', '36', 'BLACK', 98.00, 2, 1002),
(1151, 'TRUCKER DENIM JACKET', 'XS', 'INDIGO', 148.00, 2, 1003),
(1152, 'TRUCKER DENIM JACKET', 'S', 'INDIGO', 148.00, 3, 1003),
(1153, 'TRUCKER DENIM JACKET', 'M', 'INDIGO', 148.00, 5, 1003),
(1154, 'TRUCKER DENIM JACKET', 'L', 'INDIGO', 148.00, 5, 1003),
(1155, 'TRUCKER DENIM JACKET', 'XL', 'INDIGO', 148.00, 3, 1003),
(1156, 'TRUCKER DENIM JACKET', 'XXL', 'INDIGO', 148.00, 2, 1003),
(1157, 'NYLON BLOCK BOMBER JACKET', 'XS', 'BLUE', 128.00, 2, 1003),
(1158, 'NYLON BLOCK BOMBER JACKET', 'S', 'BLUE', 128.00, 3, 1003),
(1159, 'NYLON BLOCK BOMBER JACKET', 'M', 'BLUE', 128.00, 5, 1003),
(1160, 'NYLON BLOCK BOMBER JACKET', 'L', 'BLUE', 128.00, 5, 1003),
(1161, 'NYLON BLOCK BOMBER JACKET', 'XL', 'BLUE', 128.00, 3, 1003),
(1162, 'NYLON BLOCK BOMBER JACKET', 'XXL', 'BLUE', 128.00, 2, 1003),
(1163, 'LIGHTWEIGHT SHIRT JACKET', 'XS', 'BLACK', 128.00, 2, 1003),
(1164, 'LIGHTWEIGHT SHIRT JACKET', 'S', 'BLACK', 128.00, 3, 1003),
(1165, 'LIGHTWEIGHT SHIRT JACKET', 'M', 'BLACK', 128.00, 5, 1003),
(1166, 'LIGHTWEIGHT SHIRT JACKET', 'L', 'BLACK', 128.00, 5, 1003),
(1167, 'LIGHTWEIGHT SHIRT JACKET', 'XL', 'BLACK', 128.00, 3, 1003),
(1168, 'LIGHTWEIGHT SHIRT JACKET', 'XXL', 'BLACK', 128.00, 2, 1003),
--Women's Product
(1169, 'SHORT SLEEVE TUNIC BLOUSE', 'XS', 'DEEP CORAL', 78.00, 2, 1004),
(1170, 'SHORT SLEEVE TUNIC BLOUSE', 'S', 'DEEP CORAL', 78.00, 3, 1004),
(1171, 'SHORT SLEEVE TUNIC BLOUSE', 'M', 'DEEP CORAL', 78.00, 5, 1004),
(1172, 'SHORT SLEEVE TUNIC BLOUSE', 'L', 'DEEP CORAL', 78.00, 5, 1004),
(1173, 'SHORT SLEEVE TUNIC BLOUSE', 'XL', 'DEEP CORAL', 78.00, 3, 1004),
(1174, 'SHORT SLEEVE TUNIC BLOUSE', 'XXL', 'DEEP CORAL', 78.00, 2, 1004),
(1175, 'SHORT SLEEVE TUNIC BLOUSE', 'XS', 'OPAL GREYL', 78.00, 2, 1004),
(1176, 'SHORT SLEEVE TUNIC BLOUSE', 'S', 'OPAL GREYL', 78.00, 3, 1004),
(1177, 'SHORT SLEEVE TUNIC BLOUSE', 'M', 'OPAL GREYL', 78.00, 5, 1004),
(1178, 'SHORT SLEEVE TUNIC BLOUSE', 'L', 'OPAL GREYL', 78.00, 5, 1004),
(1179, 'SHORT SLEEVE TUNIC BLOUSE', 'XL', 'OPAL GREYL', 78.00, 3, 1004),
(1180, 'SHORT SLEEVE TUNIC BLOUSE', 'XXL', 'OPAL GREYL', 78.00, 2, 1004),
(1181, 'SHORT SLEEVE TUNIC BLOUSE', 'XS', 'BLACK', 78.00, 2, 1004),
(1182, 'SHORT SLEEVE TUNIC BLOUSE', 'S', 'BLACK', 78.00, 3, 1004),
(1183, 'SHORT SLEEVE TUNIC BLOUSE', 'M', 'BLACK', 78.00, 5, 1004),
(1184, 'SHORT SLEEVE TUNIC BLOUSE', 'L', 'BLACK', 78.00, 5, 1004),
(1185, 'SHORT SLEEVE TUNIC BLOUSE', 'XL', 'BLACK', 78.00, 3, 1004),
(1186, 'SHORT SLEEVE TUNIC BLOUSE', 'XXL', 'BLACK', 78.00, 2, 1004),
(1187, 'BUTTON FRONT BLOUSE', 'XS', 'ESTASTE BLUE', 78.00, 2, 1004),
(1188, 'BUTTON FRONT BLOUSE', 'S', 'ESTASTE BLUE', 78.00, 3, 1004),
(1189, 'BUTTON FRONT BLOUSE', 'M', 'ESTASTE BLUE', 78.00, 5, 1004),
(1190, 'BUTTON FRONT BLOUSE', 'L', 'ESTASTE BLUE', 78.00, 5, 1004),
(1191, 'BUTTON FRONT BLOUSE', 'XL', 'ESTASTE BLUE', 78.00, 3, 1004),
(1192, 'BUTTON FRONT BLOUSE', 'XXL', 'ESTASTE BLUE', 78.00, 2, 1004),
(1193, 'BUTTON FRONT BLOUSE', 'XS', 'LIGHT SHELL', 78.00, 2, 1004),
(1194, 'BUTTON FRONT BLOUSE', 'S', 'LIGHT SHELL', 78.00, 3, 1004),
(1195, 'BUTTON FRONT BLOUSE', 'M', 'LIGHT SHELL', 78.00, 5, 1004),
(1196, 'BUTTON FRONT BLOUSE', 'L', 'LIGHT SHELL', 78.00, 5, 1004),
(1197, 'BUTTON FRONT BLOUSE', 'XL', 'LIGHT SHELL', 78.00, 3, 1004),
(1198, 'BUTTON FRONT BLOUSE', 'XXL', 'LIGHT SHELL', 78.00, 2, 1004),
(1199, 'LACE CAMI', 'XS', 'BLACK', 68.00, 2, 1004),
(1200, 'LACE CAMI', 'S', 'BLACK', 68.00, 3, 1004),
(1201, 'LACE CAMI', 'M', 'BLACK', 68.00, 5, 1004),
(1202, 'LACE CAMI', 'L', 'BLACK', 68.00, 5, 1004),
(1203, 'LACE CAMI', 'XL', 'BLACK', 68.00, 3, 1004),
(1204, 'LACE CAMI', 'XXL', 'BLACK', 68.00, 2, 1004),
(1205, 'LACE CAMI', 'XS', 'LIGHT SHELL', 68.00, 2, 1004),
(1206, 'LACE CAMI', 'S', 'LIGHT SHELL', 68.00, 3, 1004),
(1207, 'LACE CAMI', 'M', 'LIGHT SHELL', 68.00, 5, 1004),
(1208, 'LACE CAMI', 'L', 'LIGHT SHELL', 68.00, 5, 1004),
(1209, 'LACE CAMI', 'XL', 'LIGHT SHELL', 68.00, 3, 1004),
(1210, 'LACE CAMI', 'XXL', 'LIGHT SHELL', 68.00, 2, 1004),
(1211, 'CINCHED WAIST SHIRT', 'XS', 'WHITE', 78.00, 2, 1004),
(1212, 'CINCHED WAIST SHIRT', 'S', 'WHITE', 78.00, 3, 1004),
(1213, 'CINCHED WAIST SHIRT', 'M', 'WHITE', 78.00, 5, 1004),
(1214, 'CINCHED WAIST SHIRT', 'L', 'WHITE', 78.00, 5, 1004),
(1215, 'CINCHED WAIST SHIRT', 'XL', 'WHITE', 78.00, 3, 1004),
(1216, 'CINCHED WAIST SHIRT', 'XXL', 'WHITE', 78.00, 2, 1004),
(1217, 'RUFFLE FRONT TOP', 'XS', 'PINK CLOUD', 48.00, 2, 1004),
(1218, 'RUFFLE FRONT TOP', 'S', 'PINK CLOUD', 48.00, 3, 1004),
(1219, 'RUFFLE FRONT TOP', 'M', 'PINK CLOUD', 48.00, 5, 1004),
(1220, 'RUFFLE FRONT TOP', 'L', 'PINK CLOUD', 48.00, 5, 1004),
(1221, 'RUFFLE FRONT TOP', 'XL', 'PINK CLOUD', 48.00, 3, 1004),
(1222, 'RUFFLE FRONT TOP', 'XXL', 'PINK CLOUD', 48.00, 2, 1004),
(1223, 'HERRINGBONE BEADED TANK', 'XS', 'SNOW', 58.00, 2, 1004),
(1224, 'HERRINGBONE BEADED TANK', 'S', 'SNOW', 58.00, 3, 1004),
(1225, 'HERRINGBONE BEADED TANK', 'M', 'SNOW', 58.00, 5, 1004),
(1226, 'HERRINGBONE BEADED TANK', 'L', 'SNOW', 58.00, 5, 1004),
(1227, 'HERRINGBONE BEADED TANK', 'XL', 'SNOW', 58.00, 3, 1004),
(1228, 'HERRINGBONE BEADED TANK', 'XXL', 'SNOW', 58.00, 2, 1004),
(1229, 'HERRINGBONE BEADED TANK', 'XS', 'ESTASTE BLUE', 58.00, 2, 1004),
(1230, 'HERRINGBONE BEADED TANK', 'S', 'ESTASTE BLUE', 58.00, 3, 1004),
(1231, 'HERRINGBONE BEADED TANK', 'M', 'ESTASTE BLUE', 58.00, 5, 1004),
(1232, 'HERRINGBONE BEADED TANK', 'L', 'ESTASTE BLUE', 58.00, 5, 1004),
(1233, 'HERRINGBONE BEADED TANK', 'XL', 'ESTASTE BLUE', 58.00, 3, 1004),
(1234, 'HERRINGBONE BEADED TANK', 'XXL', 'ESTASTE BLUE', 58.00, 2, 1004),
(1235, 'HERRINGBONE BEADED TANK', 'XS', 'TORNADO', 58.00, 2, 1004),
(1236, 'HERRINGBONE BEADED TANK', 'S', 'TORNADO', 58.00, 3, 1004),
(1237, 'HERRINGBONE BEADED TANK', 'M', 'TORNADO', 58.00, 5, 1004),
(1238, 'HERRINGBONE BEADED TANK', 'L', 'TORNADO', 58.00, 5, 1004),
(1239, 'HERRINGBONE BEADED TANK', 'XL', 'TORNADO', 58.00, 3, 1004),
(1240, 'HERRINGBONE BEADED TANK', 'XXL', 'TORNADO', 58.00, 2, 1004),
(1241, 'OFF SHOULDER LOGO TOP', 'XS', 'SCARLET', 58.00, 2, 1004),
(1242, 'OFF SHOULDER LOGO TOP', 'S', 'SCARLET', 58.00, 3, 1004),
(1243, 'OFF SHOULDER LOGO TOP', 'M', 'SCARLET', 58.00, 5, 1004),
(1244, 'OFF SHOULDER LOGO TOP', 'L', 'SCARLET', 58.00, 5, 1004),
(1245, 'OFF SHOULDER LOGO TOP', 'XL', 'SCARLET', 58.00, 3, 1004),
(1246, 'OFF SHOULDER LOGO TOP', 'XXL', 'SCARLET', 58.00, 2, 1004),
(1247, 'SUTURE STITCH SHORT SLEEVE TOP', 'XS', 'DEEP CORAL', 48.00, 2, 1004),
(1248, 'SUTURE STITCH SHORT SLEEVE TOP', 'S', 'DEEP CORAL', 48.00, 3, 1004),
(1249, 'SUTURE STITCH SHORT SLEEVE TOP', 'M', 'DEEP CORAL', 48.00, 5, 1004),
(1250, 'SUTURE STITCH SHORT SLEEVE TOP', 'L', 'DEEP CORAL', 48.00, 5, 1004),
(1251, 'SUTURE STITCH SHORT SLEEVE TOP', 'XL', 'DEEP CORAL', 48.00, 3, 1004),
(1252, 'SUTURE STITCH SHORT SLEEVE TOP', 'XXL', 'DEEP CORAL', 48.00, 2, 1004),
(1253, 'SUTURE STITCH SHORT SLEEVE TOP', 'XS', 'PHANTOM', 48.00, 2, 1004),
(1254, 'SUTURE STITCH SHORT SLEEVE TOP', 'S', 'PHANTOM', 48.00, 3, 1004),
(1255, 'SUTURE STITCH SHORT SLEEVE TOP', 'M', 'PHANTOM', 48.00, 5, 1004),
(1256, 'SUTURE STITCH SHORT SLEEVE TOP', 'L', 'PHANTOM', 48.00, 5, 1004),
(1257, 'SUTURE STITCH SHORT SLEEVE TOP', 'XL', 'PHANTOM', 48.00, 3, 1004),
(1258, 'SUTURE STITCH SHORT SLEEVE TOP', 'XXL', 'PHANTOM', 48.00, 2 , 1004),
(1259, 'SUTURE STITCH SHORT SLEEVE TOP', 'XS', 'SCARLET', 48.00, 2, 1004),
(1260, 'SUTURE STITCH SHORT SLEEVE TOP', 'S', 'SCARLET', 48.00, 3, 1004),
(1261, 'SUTURE STITCH SHORT SLEEVE TOP', 'M', 'SCARLET', 48.00, 5, 1004),
(1262, 'SUTURE STITCH SHORT SLEEVE TOP', 'L', 'SCARLET', 48.00, 5, 1004),
(1263, 'SUTURE STITCH SHORT SLEEVE TOP', 'XL', 'SCARLET', 48.00, 3, 1004),
(1264, 'SUTURE STITCH SHORT SLEEVE TOP', 'XXL', 'SCARLET', 48.00, 2, 1004),
(1265, 'SEQUIN COWL NECK SLEEVELESS TOP', 'XS', 'BLACK', 58.00, 2, 1004),
(1266, 'SEQUIN COWL NECK SLEEVELESS TOP', 'S', 'BLACK', 58.00, 3, 1004),
(1267, 'SEQUIN COWL NECK SLEEVELESS TOP', 'M', 'BLACK', 58.00, 5, 1004),
(1268, 'SEQUIN COWL NECK SLEEVELESS TOP', 'L', 'BLACK', 58.00, 5, 1004),
(1269, 'SEQUIN COWL NECK SLEEVELESS TOP', 'XL', 'BLACK', 58.00, 3, 1004),
(1270, 'SEQUIN COWL NECK SLEEVELESS TOP', 'XXL', 'BLACK', 58.00, 2, 1004),
(1271, 'RUFFLE SHORT SLEEVE DRESS', 'XS', 'DEEP CORAL', 98.00, 2, 1004),
(1272, 'RUFFLE SHORT SLEEVE DRESS', 'S', 'DEEP CORAL', 98.00, 3, 1004),
(1273, 'RUFFLE SHORT SLEEVE DRESS', 'M', 'DEEP CORAL', 98.00, 5, 1004),
(1274, 'RUFFLE SHORT SLEEVE DRESS', 'L', 'DEEP CORAL', 98.00, 5, 1004),
(1275, 'RUFFLE SHORT SLEEVE DRESS', 'XL', 'DEEP CORAL', 98.00, 3, 1004),
(1276, 'RUFFLE SHORT SLEEVE DRESS', 'XXL', 'DEEP CORAL', 98.00, 2, 1004),
(1277, 'LACE FIT AND FLARE DRESS', 'XS', 'BLACK', 98.00, 2, 1004),
(1278, 'LACE FIT AND FLARE DRESS', 'S', 'BLACK', 98.00, 3, 1004),
(1279, 'LACE FIT AND FLARE DRESS', 'M', 'BLACK', 98.00, 5, 1004),
(1280, 'LACE FIT AND FLARE DRESS', 'L', 'BLACK', 98.00, 5, 1004),
(1281, 'LACE FIT AND FLARE DRESS', 'XL', 'BLACK', 98.00, 3, 1004),
(1282, 'LACE FIT AND FLARE DRESS', 'XXL', 'BLACK', 98.00, 2, 1004),
(1283, 'COCOON SHRUG', 'XS', 'PHANTOM', 78.00, 2, 1004),
(1284, 'COCOON SHRUG', 'S', 'PHANTOM', 78.00, 3, 1004),
(1285, 'COCOON SHRUG', 'M', 'PHANTOM', 78.00, 5, 1004),
(1286, 'COCOON SHRUG', 'L', 'PHANTOM', 78.00, 5, 1004),
(1287, 'COCOON SHRUG', 'XL', 'PHANTOM', 78.00, 3, 1004),
(1288, 'COCOON SHRUG', 'XXL', 'PHANTOM', 78.00, 2, 1004),
(1289, 'STRIPPED MAXI SKIRT', 'XS', 'BLACK', 68.00, 2, 1005),
(1290, 'STRIPPED MAXI SKIRT', 'S', 'BLACK', 68.00, 3, 1005),
(1291, 'STRIPPED MAXI SKIRT', 'M', 'BLACK', 68.00, 5, 1005),
(1292, 'STRIPPED MAXI SKIRT', 'L', 'BLACK', 68.00, 5, 1005),
(1293, 'STRIPPED MAXI SKIRT', 'XL', 'BLACK', 68.00, 3, 1005),
(1294, 'STRIPPED MAXI SKIRT', 'XXL', 'BLACK', 68.00, 2, 1005),
(1295, 'INDIGO JEGGING', 'XS', 'INDIGO', 98.00, 2, 1005),
(1296, 'INDIGO JEGGING', 'S', 'INDIGO', 98.00, 3, 1005),
(1297, 'INDIGO JEGGING', 'M', 'INDIGO', 98.00, 5, 1005),
(1298, 'INDIGO JEGGING', 'L', 'INDIGO', 98.00, 5, 1005),
(1299, 'INDIGO JEGGING', 'XL', 'INDIGO', 98.00, 3, 1005),
(1300, 'INDIGO JEGGING', 'XXL', 'INDIGO', 98.00, 2, 1005),
(1301, 'GREY SKINNY JEAN', '0', 'GREY', 98.00, 2, 1005),
(1302, 'GREY SKINNY JEAN', '2', 'GREY', 98.00, 3, 1005),
(1303, 'GREY SKINNY JEAN', '4', 'GREY', 98.00, 5, 1005),
(1304, 'GREY SKINNY JEAN', '6', 'GREY', 98.00, 5, 1005),
(1305, 'GREY SKINNY JEAN', '8', 'GREY', 98.00, 3, 1005),
(1306, 'GREY SKINNY JEAN', '10', 'GREY', 98.00, 2, 1005),
(1307, 'LIGHT INDIGO STRAIGHT JEAN', '0', 'INDIGO', 128.00, 2, 1005),
(1308, 'LIGHT INDIGO STRAIGHT JEAN', '2', 'INDIGO', 128.00, 3, 1005),
(1309, 'LIGHT INDIGO STRAIGHT JEAN', '4', 'INDIGO', 128.00, 5, 1005),
(1310, 'LIGHT INDIGO STRAIGHT JEAN', '6', 'INDIGO', 128.00, 5, 1005),
(1311, 'LIGHT INDIGO STRAIGHT JEAN', '8', 'INDIGO', 128.00, 3, 1005),
(1312, 'LIGHT INDIGO STRAIGHT JEAN', '10', 'INDIGO', 128.00, 2, 1005),
(1313, 'MIDRISE SUPER SKINNY JEAN', '0', 'INDIGO', 128.00, 2, 1005),
(1314, 'MIDRISE SUPER SKINNY JEAN', '2', 'INDIGO', 128.00, 3, 1005),
(1315, 'MIDRISE SUPER SKINNY JEAN', '4', 'INDIGO', 128.00, 5, 1005),
(1316, 'MIDRISE SUPER SKINNY JEAN', '6', 'INDIGO', 128.00, 5, 1005),
(1317, 'MIDRISE SUPER SKINNY JEAN', '8', 'INDIGO', 128.00, 3, 1005),
(1318, 'MIDRISE SUPER SKINNY JEAN', '10', 'INDIGO', 128.00, 2, 1005),
(1319, 'METALLIC JACKET', 'XS', 'SILVER', 128.00, 2, 1006),
(1320, 'METALLIC JACKET', 'S', 'SILVER', 128.00, 3, 1006),
(1321, 'METALLIC JACKET', 'M', 'SILVER', 128.00, 5, 1006),
(1322, 'METALLIC JACKET', 'L', 'SILVER', 128.00, 5, 1006),
(1323, 'METALLIC JACKET', 'XL', 'SILVER', 128.00, 3, 1006),
(1324, 'METALLIC JACKET', 'XXL', 'SILVER', 128.00, 2, 1006),
(1325, 'SHIRT JACKET', 'XS', 'LIGHT SHELL', 130.00, 2, 1006),
(1326, 'SHIRT JACKET', 'S', 'LIGHT SHELL', 130.00, 3, 1006),
(1327, 'SHIRT JACKET', 'M', 'LIGHT SHELL', 130.00, 5, 1006),
(1328, 'SHIRT JACKET', 'L', 'LIGHT SHELL', 130.00, 5, 1006),
(1329, 'SHIRT JACKET', 'XL', 'LIGHT SHELL', 130.00, 3, 1006),
(1330, 'SHIRT JACKET', 'XXL', 'LIGHT SHELL', 130.00, 2, 1006),
(1331, 'PRINT MOTO JACKET', 'XS', 'PHANTOM', 150.00, 2, 1006),
(1332, 'PRINT MOTO JACKET', 'S', 'PHANTOM', 150.00, 3, 1006),
(1333, 'PRINT MOTO JACKET', 'M', 'PHANTOM', 150.00, 5, 1006),
(1334, 'PRINT MOTO JACKET', 'L', 'PHANTOM', 150.00, 5, 1006),
(1335, 'PRINT MOTO JACKET', 'XL', 'PHANTOM', 150.00, 3, 1006),
(1336, 'PRINT MOTO JACKET', 'XXL', 'PHANTOM', 150.00, 2, 1006);

--Add data to the Promotion table
Insert into Promotion
(PromotionID, PromotionPercentage, PromotionStartDate, PromotionEndDate)
Values
(2000, 10, '2021-11-23', '2021-11-27'),
(2001, 20, '2021-12-6', '2021-12-10'),
(2002, 35, '2021-12-13', '2021-12-17'),
(2003, 50, '2021-12-20', '2021-12-24'),
(2004, 75, '2021-12-1', '2021-12-4');

--Add data to the Order table
Insert into Order2 
(OrderID, OrderDate, Price, PersonID)
Values
(3000, '2021-11-20', 130.00, 10001),
(3001, '2021-11-20', 150.00, 10001),
(3002, '2021-11-20', 78.00, 10002),
(3003, '2021-11-20', 98.00, 10002),
(3004, '2021-11-20', 78.00, 10003),
(3005, '2021-11-20', 78.00, 10003),
(3006, '2021-11-20', 78.00, 10004),
(3007, '2021-11-20', 58.00, 10004);

--Add data to the Employee_Order table
Insert into Employee_Order 
(OrderID, PersonID, Starttime, Endtime)
Values
(3000, 10010, '20211120 12:00:00', '20211120 18:00:00'),
(3001, 10010, '20211120 12:00:00', '20211120 18:00:00'),
(3002, 10009, '20211120 12:00:00', '20211120 18:00:00'),
(3003, 10009, '20211120 12:00:00', '20211120 18:00:00'),
(3004, 10008, '20211120 13:00:00', '20211120 19:00:00'),
(3005, 10007, '20211120 14:00:00', '20211120 20:00:00'),
(3006, 10006, '20211120 12:30:00', '20211120 18:30:00'),
(3007, 10005, '20211120 09:30:00', '20211120 16:30:00');

--Add data to the Order_Detail table
Insert into Order_Detail 
(OrderDetailID, ProductID, OrderDetailQty, PromotionID)
Values
(3000, 1265, 2, 2000),
(3001, 1105, 3, 2003),
(3002, 1300, 1, 2004),
(3003, 1234, 5, 2000),
(3004, 1066, 2, 2001),
(3005, 1062, 1, 2004),
(3006, 1278, 6, 2000),
(3007, 1204, 3, 2002);
