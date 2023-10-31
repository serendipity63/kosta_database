SELECT p1.pdname 제품카테고리, p1.pdsubname 제품명, f.FACNAME 공장명, s1.stoname 판매점명, ifnull(s1.STAMOUNT,0) 판매점재고수량
FROM product p1 JOIN store s1 USING (pdno)
JOIN factory f ON f.FACTNO= p1.FACTNO 
WHERE (s1.STAMOUNT = 0 OR s1.STAMOUNT IS NULL) AND f.FACLOC='SEOUL'
ORDER BY 1;


SELECT pdsubname 제품명, pdcost 제품원가, pdprice 제품가격
FROM product
WHERE pdcost > (SELECT min(pdcost)
FROM product p
WHERE pdname='TV') AND 
pdcost <(SELECT MAX(pdcost)
FROM product
WHERE pdname='CELLPHONE')
ORDER BY 2;

CREATE TABLE DISCARDED_PRODUCT(
PDNO INT PRIMARY KEY,
PDNAME VARCHAR(10),
PDSUBNAME VARCHAR(10),
FACTNO VARCHAR(5) REFERENCES factory(FACTNO),
PDDATE DATE,
PDCOST INT,
PDPRICE INT,
PDAMOUNT INT,
DISCARDED_DATE DATE );


INSERT INTO discarded_product (PDNO,pdname,pdsubname,factno, pddate, pdcost, PDPRICE, pdamount, discarded_DATE)  
SELECT p.*, sysdate() 
FROM product p JOIN factory f USING (factno)
WHERE f.FACLOC='CHANGWON'; 

START TRANSACTION;
DELETE p.* FROM product p JOIN discarded_product d WHERE p.PDNO=d.PDNO



CREATE TABLE goods(
CODE VARCHAR(100) PRIMARY key,
NAME VARCHAR(250),
price INT,
stock INT,
category VARCHAR(250)
);


DROP TABLE goods;

 CREATE TABLE `ORDER`(
   NO INT PRIMARY KEY,
   customer VARCHAR(100) NOT null,
   productcode VARCHAR(20) REFERENCES goods(CODE),
   amount INT,
   iscanceled tinyint ); 
   
DROP TABLE ORDER;



























