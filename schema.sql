CREATE TABLE Customers (
    custid   INTEGER PRIMARY KEY,
    cname    TEXT    NOT NULL,
    country  CHAR(3) NOT NULL
);

CREATE TABLE Products (
    pcode    INTEGER     PRIMARY KEY,
    pname    TEXT        NOT NULL,
    ptype    VARCHAR(10) NOT NULL CHECK (ptype IN ('BOOK','MOVIE','MUSIC')),
    price    NUMERIC 	 NOT NULL CHECK (price > 0)
);

CREATE TABLE Orders (
    ordid    INTEGER PRIMARY KEY,
    odate    DATE    NOT NULL,
    ocust    INTEGER NOT NULL REFERENCES Customers (custid)
);

CREATE TABLE Details (
    ordid    INTEGER  REFERENCES Orders (ordid),
    pcode    INTEGER  REFERENCES Products (pcode),
    qty      SMALLINT NOT NULL CHECK (qty > 0),
    PRIMARY KEY (ordid, pcode)
);

CREATE TABLE Invoices (
    invid    INTEGER PRIMARY KEY,
    ordid    INTEGER UNIQUE NOT NULL REFERENCES Orders (ordid),
    amount   NUMERIC NOT NULL CHECK (amount > 0),
    issued   DATE    NOT NULL,
    due      DATE    NOT NULL,
    CHECK ( due >= issued )
);

CREATE TABLE Payments (
    payid    INTEGER   PRIMARY KEY,
    tstamp   TIMESTAMP NOT NULL,
    amount   NUMERIC   NOT NULL CHECK (amount > 0),
    invid    INTEGER   NOT NULL REFERENCES Invoices (invid)
);
