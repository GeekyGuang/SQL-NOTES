CREATE TABLE T_Person
(
 FId		VARCHAR(20)		NOT NULL,
 FNumber    VARCHAR(20),
 FName      VARCHAR(20),
 FManagerId VARCHAR(20),
 PRIMARY KEY(FId),
 FOREIGN KEY(FManagerId) REFERENCES T_Person(FId)
);

CREATE TABLE T_Merchandise
(
 FId		VARCHAR(20)		NOT NULL,
 FNumber	VARCHAR(20),
 FName		VARCHAR(20),
 FPrice		INT,
 PRIMARY KEY(FId)
);

CREATE TABLE T_SaleBill
(
 FId		VARCHAR(20)		NOT NULL,
 FNumber	VARCHAR(20),
 FBillMakerId VARCHAR(20),
 FMakeDate  DATETIME,
 FConfirmDate	DATETIME,
 PRIMARY KEY(FId),
 FOREIGN KEY(FBillMakerId) REFERENCES T_Person(FId)
);

CREATE TABLE T_SaleBillDetail
(
 FId		VARCHAR(20)			NOT NULL,
 FBillId	VARCHAR(20),
 FMerchandiseId	VARCHAR(20),
 FCount		INT,
 PRIMARY KEY(FId),
 FOREIGN KEY(FBillId) REFERENCES T_SaleBill(FId),
 FOREIGN KEY(FMerchandiseId) REFERENCES T_Merchandise(FId)
);

CREATE TABLE T_PurchaseBill
(
 FId		VARCHAR(20)		NOT NULL,
 FNumber	VARCHAR(20),
 FBillMakerId	VARCHAR(20),
 FMakeDate	DATETIME,
 FConfirmDate DATETIME,
 PRIMARY KEY(FId),
 FOREIGN KEY(FBillMakerId) REFERENCES T_Person(FId)
);

CREATE TABLE T_PurchaseBillDetail
(
 FId		VARCHAR(20)		NOT NULL,
 FBillId	VARCHAR(20),
 FMerchandiseId	VARCHAR(20),
 FCount INT,
 PRIMARY KEY(FId),
 FOREIGN KEY(FBillId) REFERENCES T_PurchaseBill(FId),
 FOREIGN KEY(FMerchandiseId) REFERENCES T_Merchandise(FId)
);

insert into T_Person(FId,FNumber,FName,FManagerId)
values('00001','1','Robert',NULL);
insert into T_Person(FId,FNumber,FName,FManagerId)
values('00002','2','John','00001');
insert into T_Person(FId,FNumber,FName,FManagerId)
values('00003','3','Tom','00001');
insert into T_Person(FId,FNumber,FName,FManagerId)
values('00004','4','Jim','00003');
insert into T_Person(FId,FNumber,FName,FManagerId)
values('00005','5','Lily','00002');
insert into T_Person(FId,FNumber,FName,FManagerId)
values('00006','6','Merry','00003');

insert into T_Merchandise(FId,FNumber,FName,FPrice)
values('00001','1','Bacon',30);
insert into T_Merchandise(FId,FNumber,FName,FPrice)
values('00002','2','Cake',2);
insert into T_Merchandise(FId,FNumber,FName,FPrice)
values('00003','3','Apple',6);

insert into T_SaleBill(FId,FNumber,FBillMakerId,FMakeDate,FConfirmDate)
values('00001','1','00006','2007-03-15','2007-05-15');
insert into T_SaleBill(FId,FNumber,FBillMakerId,FMakeDate,FConfirmDate)
values('00002','2',null,'2006-01-25','2006-02-03');
insert into T_SaleBill(FId,FNumber,FBillMakerId,FMakeDate,FConfirmDate)
values('00003','3','00001','2006-02-12','2007-01-11');
insert into T_SaleBill(FId,FNumber,FBillMakerId,FMakeDate,FConfirmDate)
values('00004','4','00003','2008-05-25','2008-06-15');
insert into T_SaleBill(FId,FNumber,FBillMakerId,FMakeDate,FConfirmDate)
values('00005','5','00005','2008-03-17','2007-04-15');
insert into T_SaleBill(FId,FNumber,FBillMakerId,FMakeDate,FConfirmDate)
values('00006','6','00002','2002-02-03','2007-11-11');

insert into T_PurchaseBill(FId,FNumber,FBillMakerId,FMakeDate,FConfirmDate)
values('00001','1','00006','2007-02-15','2007-02-15');
insert into T_PurchaseBill(FId,FNumber,FBillMakerId,FMakeDate,FConfirmDate)
values('00002','2','00004','2003-02-25','2006-03-03');
insert into T_PurchaseBill(FId,FNumber,FBillMakerId,FMakeDate,FConfirmDate)
values('00003','3','00001','2007-02-12','2007-07-12');
insert into T_PurchaseBill(FId,FNumber,FBillMakerId,FMakeDate,FConfirmDate)
values('00004','4','00002','2007-05-25','2007-06-15');
insert into T_PurchaseBill(FId,FNumber,FBillMakerId,FMakeDate,FConfirmDate)
values('00005','5','00002','2007-03-17','2007-04-15');
insert into T_PurchaseBill(FId,FNumber,FBillMakerId,FMakeDate,FConfirmDate)
values('00006','6',null,'2006-02-03','2006-11-20');

insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00001','00001','00003',20);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00002','00001','00001',30);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00003','00001','00002',22);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00004','00002','00003',12);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00005','00002','00002',11);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00006','00003','00001',60);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00007','00003','00002',2);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00008','00003','00003',5);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00009','00004','00001',16);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00010','00004','00002',8);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00011','00004','00003',9);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00012','00005','00001',6);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00013','00005','00003',26);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00014','00006','00001',66);
insert into T_SaleBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00015','00006','00002',518);


insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00001','00001','00002',12);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00002','00001','00001',20);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00003','00002','00001',32);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00004','00002','00003',18);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00005','00002','00002',88);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00006','00003','00003',19);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00007','00003','00002',6);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00008','00003','00001',2);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00009','00004','00001',20);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00010','00004','00003',18);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00011','00005','00002',19);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00012','00005','00001',26);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00013','00006','00003',3);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00014','00006','00001',22);
insert into T_PurchaseBillDetail(FId,FBillId,FMerchandiseId,FCount)
values('00015','00006','00002',168);
