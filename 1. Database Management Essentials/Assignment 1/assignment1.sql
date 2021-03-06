--CUSTOMER TABLE--

CREATE TABLE CUSTOMER
(
CUSTNO VARCHAR2(8) CONSTRAINT NN_CUSTNO_CUSTOMER NOT NULL,
CUSTNAME VARCHAR2(30) CONSTRAINT NN_CUSTNAME_CUSTOMER NOT NULL,
ADDRESS VARCHAR2(50) CONSTRAINT NN_ADDRESS_CUSTOMER NOT NULL,
INTERNAL CHAR(1) CONSTRAINT NN_INTERNAL_CUSTOMER NOT NULL,
CONTACT VARCHAR2(35) CONSTRAINT NN_CONTACT_CUSTOMER NOT NULL,
PHONE VARCHAR2(12) CONSTRAINT NN_PHONE_CUSTOMER NOT NULL,
CITY VARCHAR2(30) CONSTRAINT NN_CITY_CUSTOMER NOT NULL,
STATE VARCHAR2(2) CONSTRAINT NN_STATE_CUSTOMER NOT NULL,
ZIP VARCHAR2(10) CONSTRAINT NN_ZIP_CUSTOMER NOT NULL,
	CONSTRAINT PK_CUSTNO_CUSTOMER PRIMARY KEY (CUSTNO)
);

--Faciltiy--

CREATE TABLE FACILITY 
(
FACNO VARCHAR2(8) CONSTRAINT NN_FACNO_FACILITY NOT NULL,
FACNAME VARCHAR2(20) CONSTRAINT NN_FACNAME_FACILITY NOT NULL,
	CONSTRAINT PK_FACNO_FACILITY PRIMARY KEY (FACNO)
);

--LOCATION--

CREATE TABLE LOCATION
(
LOCNO VARCHAR2(8) CONSTRAINT NN_LOCNO_LOCATION NOT NULL,
FACNO VARCHAR2(8) CONSTRAINT NN_FACNO_LOCATION NOT NULL,
LOCNAME VARCHAR2(20) CONSTRAINT NN_LOCNAME_LOCATION NOT NULL,
	CONSTRAINT PK_LOCNO_LOCATION PRIMARY KEY (LOCNO),
	CONSTRAINT FK_FACNO_LOCATION FOREIGN KEY (FACNO) REFERENCES FACILITY (FACNO)
);

--EMPLOYEE--

CREATE TABLE EMPLOYEE
(
EMPNO VARCHAR2(8) CONSTRAINT NN_EMPNO_EMPLOYEE NOT NULL,
EMPNAME VARCHAR2(30) CONSTRAINT NN_EMPNAME_EMPLOYEE NOT NULL,
DEPARTMENT VARCHAR2(12) CONSTRAINT NN_DEPARTNAME_EMPLOYEE NOT NULL,
EMAIL VARCHAR2(30) CONSTRAINT NN_EMAIL_EMPLOYEE NOT NULL,
PHONE VARCHAR2(12) CONSTRAINT NN_PHONE_EMPLOYEE NOT NULL,
	CONSTRAINT PK_EMPNO_EMPLOYEE PRIMARY KEY (EMPNO)
);


--RESOURCETBL--
CREATE TABLE RESOURCETBL
(
RESNO VARCHAR2(8) CONSTRAINT NN_RESNO_RESOURCETBL NOT NULL,
RESNAME VARCHAR2(30) CONSTRAINT NN_LOCNO_RESOURCETBL NOT NULL,
RATE INTEGER CONSTRAINT NN_RATE_RESOURCETBL NOT NULL,
	CONSTRAINT PK_RESNO_RESOURCETBL PRIMARY KEY (RESNO),
	CONSTRAINT CHK_RATE_RESOURCETBL CHECK (RATE > 0)
);

--EVENTREQUEST--

CREATE TABLE EVENTREQUEST
(
EVENTNO VARCHAR2(8) CONSTRAINT NN_EVENTNO_EVENTREQUEST NOT NULL,
DATEHELD DATE CONSTRAINT NN_DATEHELD_EVENTREQUEST NOT NULL,
DATEREQ DATE CONSTRAINT NN_DATEREQ_EVENTREQUEST NOT NULL,
FACNO VARCHAR2(8) CONSTRAINT NN_FACNO_EVENTREQUEST NOT NULL,
CUSTNO VARCHAR2(8) CONSTRAINT NN_CUSTNO_EVENTREQUEST NOT NULL,
DATEAUTH DATE,
STATUS VARCHAR2(10) CONSTRAINT NN_STATUS_EVENTREQUEST NOT NULL,
ESTCOST VARCHAR2(10) CONSTRAINT NN_ESTCOST_EVENTREQUEST NOT NULL,
ESTAUDIENCE INTEGER CONSTRAINT NN_ESTAUDIENCE_EVENTREQUEST NOT NULL,
BUDNO VARCHAR2(8),
	CONSTRAINT PK_EVENTNO_EVENTREQUEST PRIMARY KEY (EVENTNO),
	CONSTRAINT FK_FACNO_EVENTREQUEST FOREIGN KEY (FACNO) REFERENCES FACILITY (FACNO),
	CONSTRAINT FK_CUSTNO_EVENTREQUEST FOREIGN KEY (CUSTNO) REFERENCES CUSTOMER (CUSTNO),
	CONSTRAINT CHK_STATUS_EVENTREQUEST CHECK (STATUS IN ('Approved','Denied','Pending')),
	CONSTRAINT CHK_ESTAUDIENCE_EVENTREQUEST CHECK (ESTAUDIENCE > 0)
);

--EVENTPLAN--

CREATE TABLE EVENTPLAN
(
PLANNO VARCHAR2(8) CONSTRAINT NN_PLANNO_EVENTPLAN NOT NULL,
EVENTNO VARCHAR2(8) CONSTRAINT NN_EVENTNO_EVENTPLAN NOT NULL,
WORKDATE DATE CONSTRAINT NN_WORKDATE_EVENTPLAN NOT NULL,
NOTES VARCHAR2(50),
ACTIVITY VARCHAR2(10) CONSTRAINT NN_ACTIVITY_EVENTPLAN NOT NULL,
EMPNO VARCHAR2(8),
	CONSTRAINT PK_PLANNO_EVENTPLAN PRIMARY KEY (PLANNO),
	CONSTRAINT FK_EVENTNO_EVENTPLAN FOREIGN KEY (EVENTNO) REFERENCES EVENTREQUEST (EVENTNO),
	CONSTRAINT FK_EMPNO_EVENTPLAN FOREIGN KEY (EMPNO) REFERENCES EMPLOYEE (EMPNO
);

--EVENTPLANLINE--

CREATE TABLE EVENTPLANLINE
(
PLANNO VARCHAR2(8) CONSTRAINT NN_PLANNO_EVENTPLANLINE NOT NULL,
LINENO INTEGER CONSTRAINT NN_LINENO_EVENTPLANLINE NOT NULL,
TIMESTART DATE CONSTRAINT NN_TIMESTART_EVENTPLANLINE NOT NULL,
TIMEEND DATE CONSTRAINT NN_TIMEEND_EVENTPLANLINE NOT NULL,
NUMBERFLD INTEGER CONSTRAINT NN_NUMBERFLD_EVENTPLANLINE NOT NULL,
LOCNO VARCHAR2(8) CONSTRAINT NN_LOCNO_EVENTPLANLINE NOT NULL,
RESNO VARCHAR2(8) CONSTRAINT NN_RESNO_EVENTPLANLINE NOT NULL,
	CONSTRAINT PK_PLANNO_LINENO_EVENTPLANLINE PRIMARY KEY (PLANNO,LINENO),
	CONSTRAINT FK_PLANNO_EVENTPLANLINE FOREIGN KEY (PLANNO) REFERENCES EVENTPLAN (PLANNO),
	CONSTRAINT FK_LOCNO_EVENTPLANLINE FOREIGN KEY (LOCNO) REFERENCES LOCATION (LOCNO),
	CONSTRAINT FK_RESNO_EVENTPLANLINE FOREIGN KEY (RESNO) REFERENCES RESOURCETBL (RESNO),
	CONSTRAINT CHK_TIMEVERIFY_EVENTPLANLINE CHECK (TIMESTART < TIMEEND)
);