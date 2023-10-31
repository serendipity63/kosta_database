-- create table
CREATE TABLE ACCOUNT(
	id VARCHAR(100) PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL,
	balance INT DEFAULT 0 CHECK(balance>=0), 
	grade VARCHAR(100)
);

-- make account
INSERT INTO ACCOUNT (id, NAME, balance, grade) VALUES ('10001', '메시', 100000,'VIP');
INSERT INTO ACCOUNT (id, NAME, balance, grade) VALUES ('10002', '모드리치', 100000,'Gold');

-- deposit
UPDATE ACCOUNT SET balance =balance+10000 WHERE id='10001';

-- withdraw
UPDATE ACCOUNT SET balance = balance-5000 WHERE id='10001';

-- accountInfo
SELECT * from ACCOUNT WHERE id = '10001';

-- allAccountInfo
SELECT * FROM ACCOUNT;

information_schema