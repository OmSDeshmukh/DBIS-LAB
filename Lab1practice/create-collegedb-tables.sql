CREATE TABLE student(
    "sid" INTEGER NOT NULL,
    sname VARCHAR(100) NOT NULL,
    gender VARCHAR(1) NOT NULL,
    gpa REAL,
    PRIMARY KEY ("sid")
);

CREATE TABLE department(
    dname VARCHAR(100) NOT NULL ,
    numphds INTEGER ,
    PRIMARY KEY (dname)
);

CREATE TABLE professor(
    pname VARCHAR(100) NOT NULL ,
    dname VARCHAR(100) REFERENCES department(dname),
    PRIMARY KEY(pname)
);

CREATE TABLE course(
    cno INTEGER NOT NULL,
    cname VARCHAR(100),
    dname VARCHAR(100) NOT NULL REFERENCES department(dname),
    PRIMARY KEY (cno,dname)
);

CREATE TABLE major(
    dname VARCHAR(100) NOT NULL REFERENCES department(dname),
    "sid" INTEGER NOT NULL REFERENCES student("sid"),
    PRIMARY KEY (dname,"sid")
);

CREATE TABLE enroll(
    "sid" INTEGER NOT NULL REFERENCES student("sid"),
    grade REAL,
    dname VARCHAR(100) NOT NULL,
    cno INTEGER NOT NULL,
    PRIMARY KEY ("sid", dname, cno),
    FOREIGN KEY (dname,cno) REFERENCES course(dname,cno)
);