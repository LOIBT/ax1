CREATE TABLE BaiTapKHDL1.XE
(
    MAXE varchar2(3) constraint PK_XE PRIMARY KEY,
    BIENKS varchar(10),
    MATUYEN varchar(4),
    SOGHET1 number,
    SOGHET2 number
)

CREATE TABLE BaiTapKHDL1.TUYEN
(
    MATUYEN VARCHAR(4) CONSTRAINT PK_TUYEN PRIMARY KEY,
    BENDAU VARCHAR(3) NOT NULL,
    BENCUOI VARCHAR(3) NOT NULL,
    GIATUYEN DECIMAL,
    NGXB DATE,
    TGDK NUMBER

)

CREATE TABLE BaiTapKHDL1.KHACHHANG
(
    MAKH VARCHAR(4) CONSTRAINT PK_KHACHHANG PRIMARY KEY,
    HOTEN VARCHAR(20),
    GIOITINH VARCHAR(3),
    CMND NUMBER(11)
    

)

CREATE TABLE BaiTapKHDL1.VEXE
(
    MATUYEN VARCHAR(4),
    MAKH VARCHAR(4) NOT NULL,
    NGMUA DATE,
    GIAVE DECIMAL
)


ALTER USER BaiTapKHDL1 QUOTA UNLIMITED ON USERS;
ALTER SESSION SET NLS_DATE_FORMAT =' DD/MM/YYYY HH24:MI:SS ';

INSERT INTO BaiTapKHDL1.XE VALUES('X01', '52LD-4393', 'T11A', 20, 20);
INSERT INTO BaiTapKHDL1.XE VALUES('X02', '59LD-7247', 'T32D', 36, 36);
INSERT INTO BaiTapKHDL1.XE VALUES('X03', '55LD-6850','T06F', 15, 15);
INSERT INTO BaiTapKHDL1.TUYEN VALUES('T11A', 'SG', 'DL', 210000, '30/12/2016', 6);
INSERT INTO BaiTapKHDL1.TUYEN VALUES('T32D', 'PT', 'SG', 120000, '26/12/2016', 4);
INSERT INTO BaiTapKHDL1.TUYEN VALUES('T06F', 'NT', 'DVG', 225000, '02/01/2017', 7);

INSERT INTO BaiTapKHDL1.KHACHHANG VALUES ('KH01', 'Lam Van Ben', 'Nam', 655615896);
INSERT INTO BaiTapKHDL1.KHACHHANG VALUES ('KH02','Duong Thi Luc', 'Nu', 275648642);
INSERT INTO BaiTapKHDL1.KHACHHANG VALUES ('KH03','Hoang Thanh Tung', 'Nam', 456889143);

INSERT INTO BaiTapKHDL1.VEXE VALUES
('T11A','KH01','20/12/2016',210000);
INSERT INTO BaiTapKHDL1.VEXE VALUES
('T32D','KH02','25/12/2016',144000);
INSERT INTO BaiTapKHDL1.VEXE VALUES
('T06F','KH03','30/12/2016',270000);

-- Cau5
SELECT * 
FROM BaiTapKHDL1.VEXE
WHERE EXTRACT(MONTH FROM(NGMUA))=12
ORDER BY GIAVE DESC


--Cau6
SELECT MATUYEN
FROM BaiTapKHDL1.VEXE 
WHERE EXTRACT(YEAR FROM(NGMUA))=2016
GROUP BY MATUYEN
HAVING COUNT(MATUYEN) <= ALL
    (
     SELECT COUNT(MATUYEN) FROM BaiTapKHDL1.VEXE 
     WHERE EXTRACT(YEAR FROM(NGMUA))=2016
     GROUP BY MATUYEN 
    );

-- Cau8
SELECT * FROM BaiTapKHDL1.KHACHHANG KH
    WHERE GIOITINH = 'Nu' and  NOT EXISTS (
        SELECT * FROM BaiTapKHDL1.TUYEN TU
             WHERE NOT EXISTS (
                SELECT * FROM BaiTapKHDL1.VEXE VX 
                     WHERE TU.MATUYEN = VX.MATUYEN AND KH.MAKH = VX.MAKH)
                )

