CREATE TABLE  Agents (	
    AGENT_CODE CHAR(6) NOT NULL PRIMARY KEY, 
	AGENT_NAME CHAR(40), 
	WORKING_AREA CHAR(35), 
	COMMISSION DECIMAL(10,2), 
	PHONE_NO CHAR(15), 
	COUNTRY VARCHAR(25) 
	 );

CREATE TABLE  Customer
   (	CUST_CODE VARCHAR(6) NOT NULL PRIMARY KEY, 
	    CUST_NAME VARCHAR(40) NOT NULL, 
	    CUST_CITY CHAR(35), 
	    WORKING_AREA VARCHAR(35) NOT NULL, 
	    CUST_COUNTRY VARCHAR(20) NOT NULL, 
	    GRADE INT, 
	    OPENING_AMT DECIMAL(12,2) NOT NULL, 
	    RECEIVE_AMT DECIMAL(12,2) NOT NULL, 
	    PAYMENT_AMT DECIMAL(12,2) NOT NULL, 
	    OUTSTANDING_AMT DECIMAL(12,2) NOT NULL, 
	    PHONE_NO VARCHAR(17) NOT NULL, 
	    AGENT_CODE CHAR(6) NOT NULL,

        CONSTRAINT AGENTFK
         FOREIGN KEY (AGENT_CODE) REFERENCES Agents(AGENT_CODE)
           ON DELETE SET NULL  ON UPDATE CASCADE
);   

CREATE TABLE  Orders 
   (
    ORD_NUM DECIMAL(6,0) NOT NULL PRIMARY KEY, 
	ORD_AMOUNT DECIMAL(12,2) NOT NULL, 
	ADVANCE_AMOUNT DECIMAL(12,2) NOT NULL, 
	ORD_DATE DATE NOT NULL, 
	CUST_CODE VARCHAR(6) NOT NULL REFERENCES Customer (CUST_CODE), 
	AGENT_CODE CHAR(6) NOT NULL REFERENCES Agents (AGENT_CODE), 
	ORD_DESCRIPTION VARCHAR(60) NOT NULL
   );
   

