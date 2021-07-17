/* load the dataset folder archive into mlb folder */
/* located in MySQL Server Folder */

/* Only use these lines for the very first time. */

# DROP DATABASE IF EXISTS `mlb`;
CREATE DATABASE `mlb`;
USE `mlb`;

/* Pitches */

# DROP TABLE Pitches;

CREATE TABLE Pitches (
	px DECIMAL(5,3),
    pz DECIMAL(5,3),
    start_speed DECIMAL(4,1),
    end_speed DECIMAL(4,1),
    spin_rate DECIMAL(7,3),
    spin_dir DECIMAL(7,3),
    break_angle DECIMAL(6,3),
    break_length DECIMAL(4,1),
    break_y DECIMAL(3,1),
    ax DECIMAL(5,3),
    ay DECIMAL(5,3),
    az DECIMAL(5,3),
    sz_bot DECIMAL(4,2),
    sz_top DECIMAL(4,2),
    type_confidence DECIMAL(4,3),
    vx0 DECIMAL(6,3),
    vy0 DECIMAL(6,3),
    vz0 DECIMAL(6,3),
    x DECIMAL(6,3),
    x0 DECIMAL(6,3),
    y DECIMAL(6,3),
    y0 INTEGER,
    z0 DECIMAL(6,3),
    pfx_x DECIMAL(4,2),
    pfx_z DECIMAL(4,2),
    nasty INTEGER,
    zone INTEGER,
    `code` VARCHAR(3),
    `type` VARCHAR(2),
    pitch_type VARCHAR(2),
    event_num INTEGER,
    b_score INTEGER,
    ab_id INTEGER NOT NULL,
    b_count INTEGER,
    s_count INTEGER,
    outs INTEGER,
    pitch_num INTEGER NOT NULL,
    on_1b INTEGER,
    on_2b INTEGER,
    on_3b INTEGER,
    PRIMARY KEY (ab_id, pitch_num)
);


LOAD DATA INFILE "mlb/archive/pitches.csv"
INTO TABLE Pitches
FIELDS TERMINATED BY ","
LINES TERMINATED BY "\n"
IGNORE 1 ROWS
(@px, @pz, @start_speed, @end_speed, @spin_rate, @spin_dir, 
@break_angle, @break_length, @break_y, 
@ax, @ay, @az, @sz_bot, @sz_top, @type_confidence,
@vx0, @vy0, @vz0, @x, @x0, @y, @y0, @z0, @pfx_x, @pfx_z,
@nasty, @zone, code, type, @pitch_type,
event_num, b_score, ab_id, b_count, s_count, outs, pitch_num,
on_1b, on_2b, on_3b)
SET 
px = IF(@px='', NULL, TRUNCATE(@px, 3)), pz = IF(@pz='', NULL, TRUNCATE(@pz, 3)),
start_speed = NULLIF(@start_speed, ''), end_speed = NULLIF(@end_speed, ''),
spin_rate = NULLIF(@spin_rate, ''), spin_dir = NULLIF(@spin_dir, ''),
break_angle = NULLIF(@break_angle, ''),
break_length = IF(@break_length = '' OR @break_length > 100, NULL, @break_length),
break_y = IF(@break_y = '' OR @break_y > 100, NULL, @break_y),
ax = IF(@ax='', NULL, TRUNCATE(@ax, 3)), ay = IF(@ay='', NULL, TRUNCATE(@ay, 3)),
az = IF(@az='', NULL, TRUNCATE(@az, 3)), sz_bot = IF(@sz_bot='', NULL, TRUNCATE(@sz_bot, 2)),
sz_top = IF(@sz_top='', NULL, TRUNCATE(@sz_top, 2)), type_confidence = NULLIF(@type_confidence, ''),
vx0 = IF(@vx0='', NULL, TRUNCATE(@vx0, 3)), vy0 = IF(@vy0='', NULL, TRUNCATE(@vy0, 3)),
vz0 = IF(@vz0='', NULL, TRUNCATE(@vz0, 3)), x = IF(@x='', NULL, TRUNCATE(@x, 3)),
x0 = IF(@x0='', NULL, TRUNCATE(@x0, 3)), y = IF(@y='', NULL, TRUNCATE(@y, 3)),
y0 = NULLIF(@y0, ''),
z0 = NULLIF(@z0, ''), pfx_x = IF(@pfx_x='', NULL, TRUNCATE(@pfx_x, 2)),
pfx_z = IF(@pfx_z='', NULL, TRUNCATE(@pfx_z, 2)), nasty = NULLIF(@nasty, ''),
zone = NULLIF(@zone, ''), pitch_type = NULLIF(@pitch_type, '');

SELECT * FROM Pitches WHERE ab_id = 2015000177;

SELECT * FROM Pitches WHERE ab_id = 2015000073;

SELECT * FROM Pitches;


/* Games */

DROP TABLE Games;

CREATE TABLE Games (
	attendance INTEGER,
    away_final_score INTEGER,
    away_team VARCHAR(4),
    `date` DATE,
    elasped_time INTEGER,
    g_id INTEGER NOT NULL,
    home_final_score INTEGER,
    home_team VARCHAR(4),
    start_time TIME,
    umpire_1B VARCHAR(30),
    umpire_2B VARCHAR(30),
    umpire_3B VARCHAR(30),
    umpire_HB VARCHAR(30),
    venue_name VARCHAR(50),
    weather VARCHAR(30),
    wind VARCHAR(30),
    delay INTEGER,
    temperature INTEGER,
    `condition` VARCHAR(20),
    speed VARCHAR(10),
    direction VARCHAR(20),
	PRIMARY KEY (g_id)
);

LOAD DATA INFILE "mlb/archive/games.csv"
INTO TABLE Games
FIELDS TERMINATED BY "," ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 ROWS;

SELECT * FROM Games;

SELECT * FROM Games WHERE umpire_HB = "Joe West";


/* AtBats */
/* For top column, 1 if true, 0 if false */

DROP TABLE AtBats;

CREATE TABLE AtBats (
	ab_id INTEGER UNSIGNED NOT NULL,
    batter_id INTEGER UNSIGNED,
    `event` VARCHAR(20),
    g_id INTEGER UNSIGNED,
    inning TINYINT UNSIGNED,
    o TINYINT UNSIGNED,
    p_score TINYINT UNSIGNED,
    p_throws CHAR(1),
    pitcher_id INTEGER UNSIGNED,
    stand CHAR(1),
    top BOOLEAN,
    PRIMARY KEY (ab_id)
);

LOAD DATA INFILE "mlb/archive/atbats.csv"
INTO TABLE AtBats
FIELDS TERMINATED BY "," ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 ROWS
(ab_id, batter_id, `event`, g_id, inning, o, p_score,
p_throws, pitcher_id, stand, @top)
SET
top = IF(@top = 'True', 1, 0);

SELECT * FROM AtBats;