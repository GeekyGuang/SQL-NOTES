CREATE TABLE T_Person(
                      FName      VARCHAR(20),
					  FAge       INT,
					  FRemark    VARCHAR(20),
					  PRIMARY KEY(FName));

CREATE TABLE T_Debt(
                    FNumber    VARCHAR(20),
					FAmount    NUMERIC(10,2)    NOT NULL,
					FPerson    VARCHAR(20),
					PRIMARY KEY(Fnumber),
					FOREIGN KEY(FPerson) REFERENCES T_Person(FName)); 