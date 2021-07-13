/* load the dataset folder archive into mlb folder */
/* located in MySQL Server Folder */

/* Only use these lines for the very first time. */

DROP DATABASE IF EXISTS `mlb`;
CREATE DATABASE `mlb`;
USE `mlb`;

DROP TABLE Pitches;

CREATE TABLE Pitches (
	px DECIMAL(5,3),
    pz DECIMAL(5,3),
    ab_id INTEGER NOT NULL,
    pitch_num INTEGER NOT NULL,
    PRIMARY KEY (ab_id, pitch_num)
);


/* this assumes that  if px, pz is unavailable, we put 99.999 as a garbage value. */

LOAD DATA INFILE "mlb/archive/pitches.csv"
INTO TABLE Pitches
FIELDS TERMINATED BY ","
LINES TERMINATED BY "\n"
IGNORE 1 ROWS
(@px, @pz, @C, @D, @E, @F, @G, @H, @I, @J, @K, @L, @M, @N,
@O, @P, @Q, @R, @S, @T, @U, @V, @W, @X, @Y, @Z, @AA, @AB, @AC,
@AD, @AE, @AF, ab_id, @AH, @AI, @AJ, pitch_num, @AL, @AM, @AN)
SET px = IF(@px='', 99.999, TRUNCATE(@px, 3)), pz = IF(@pz='', 99.999, TRUNCATE(@pz, 3));


SELECT * FROM Pitches;

SELECT * FROM Pitches WHERE ab_id = 2015000073;