CREATE TABLE patient (
  pidnum  varchar(100),
  pemail  varchar(100) PRIMARY key,
  ppassword  varchar(100),
  pname  varchar(100),
  ptel  varchar(100),
  proadaddress varchar(100),
  ppostcode varchar(100),
  pdetailaddress varchar(100)
);

DROP TABLE patient;

CREATE TABLE family (
  fidnum varchar(100),
  fname varchar(100),
  ftel varchar(100),
  pidnum varchar(100) REFERENCES patient(pidnum),
  faddress varchar(100)
);


CREATE TABLE hospital (
  hname varchar(100),
  comnum varchar(100) PRIMARY KEY,
  hemail  varchar(100),
  haddress  varchar(100),
  htel  varchar(100),
  department  varchar(100),
  hpassword  varchar(100)
);

CREATE TABLE reservation (
  pidnum varchar(100) REFERENCES patient(pidnum),
  comnum varchar(100) REFERENCES hospital(comnum),
  resdate varchar(100),
  restime varchar(100),
  `comment` varchar(200),
  `status` boolean,
  doccomment varchar(200)
);


CREATE TABLE review (
  pidnum varchar(100) REFERENCES patient(pidnum),
  comnum varchar(100) REFERENCES hospital(comnum),
  content varchar(200),
  star varchar(100)
);

