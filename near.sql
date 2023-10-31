CREATE TABLE patient (
  pidnum  VARCHAR(200) PRIMARY KEY,
  pemail  varchar(200),
  ppassword  varchar(200),
  pname  varchar(200),
  ptel  varchar(200),
  proadaddress varchar(200),
  ppostcode VARCHAR(200),
  pdetailaddress VARCHAR(200)
);


CREATE TABLE family (
  fidnum varchar(200),
  fname varchar(200),
  ftel varchar(200),
  pidnum varchar(200) REFERENCES patient(pidnum),
  faddress varchar(200)
);


CREATE TABLE hospital (
  hname varchar(200),
  comnum varchar(200) PRIMARY KEY,
  htel  varchar(200),
  department   varchar(200),
  hpassword   varchar(200),
  lunch  varchar(200),
  clinic  varchar(200),
  hroad varchar(200),
  hdetail varchar(200),
  hpostcode varchar(200),
  hrul VARCHAR(200)
);

CREATE TABLE reservation (
  pidnum varchar(200) REFERENCES patient(pidnum),
  comnum varchar(200) REFERENCES hospital(comnum),
  resdate varchar(200),
  restime varchar(200),
  `comment` varchar(200),
  `status` boolean,
  doccomment varchar(200)
);


CREATE TABLE review (
  pidnum varchar(200) REFERENCES patient(pidnum),
  comnum varchar(200) REFERENCES hospital(comnum),
  content varchar(200),
  star varchar(200)
);


DROP TABLE review;
DROP TABLE reservation;
DROP TABLE hospital;
DROP TABLE family;
DROP TABLE patient;







