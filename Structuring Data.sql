use airlines;

show tables;

-- count the no of records in a each table 
SELECT 'aircrafts' AS TableName, COUNT(*) AS RowCount FROM aircrafts
UNION all 
SELECT 'flights', COUNT(*) FROM flights
UNION all
SELECT 'flightschedules', COUNT(*) FROM flightschedules
UNION all
SELECT 'passengers', COUNT(*) FROM passengers
UNION all
SELECT 'payments', COUNT(*) FROM payments
UNION all
SELECT 'reserve', COUNT(*) FROM reserve;


show columns from reservations;
describe passengers;


SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    DATA_TYPE,
    COLUMN_DEFAULT,
    IS_NULLABLE,
    COLUMN_KEY
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('aircrafts', 'flights', 'flightschedules', 'passengers', 'payments', 'reserve')
ORDER BY TABLE_NAME, ORDINAL_POSITION;

DESCRIBE aircrafts;
ALTER TABLE aircrafts 
MODIFY COLUMN AircraftID VARCHAR(20) NOT NULL;

ALTER TABLE aircrafts
ADD PRIMARY KEY (AircraftID);

describe flights;
ALTER TABLE flights
MODIFY COLUMN FlightID VARCHAR(20) NOT NULL,
MODIFY COLUMN FlightNumber VARCHAR(20) NOT NULL;

ALTER TABLE flights
ADD PRIMARY KEY (FlightID),
ADD UNIQUE (FlightNumber);

DESCRIBE flightschedules;

ALTER TABLE flightschedules
MODIFY COLUMN ScheduleID VARCHAR(20) NOT NULL,
MODIFY COLUMN FlightID VARCHAR(20) NOT NULL,
MODIFY COLUMN AircraftID VARCHAR(20) NOT NULL,
MODIFY COLUMN DepartureDateTime VARCHAR(20),
MODIFY COLUMN ArrivalDateTime VARCHAR(20);

ALTER TABLE flightschedules
ADD PRIMARY KEY (ScheduleID),
ADD INDEX (FlightID),
ADD INDEX (AircraftID),
ADD FOREIGN KEY (FlightID) REFERENCES flights(FlightID),
ADD FOREIGN KEY (AircraftID) REFERENCES aircrafts(AircraftID);

describe passengers;
 ALTER TABLE passengers
 MODIFY COLUMN PassengerID VARCHAR(20) NOT NULL,
 MODIFY COLUMN PassportNumber VARCHAR(20) UNIQUE;
 
 describe payments;
 ALTER TABLE payments
 MODIFY COLUMN PaymentID VARCHAR(20) NOT NULL,
 MODIFY COLUMN ReservationID VARCHAR(20) NOT NULL,
 MODIFY COLUMN PaymentDate VARCHAR(20);
 
 ALTER TABLE payments
ADD FOREIGN KEY (ReservationID) REFERENCES reserve(ReservationID);


describe reserve;
ALTER TABLE reserve
MODIFY COLUMN ReservationID VARCHAR(20) NOT NULL,
MODIFY COLUMN PassengerID VARCHAR(20) NOT NULL,
MODIFY COLUMN ScheduleID VARCHAR(20) NOT NULL,
MODIFY COLUMN FlightID VARCHAR(20) NOT NULL,
MODIFY COLUMN SeatNumber VARCHAR(10),
MODIFY COLUMN BookingDate VARCHAR(20);

ALTER TABLE reserve
ADD PRIMARY KEY (ReservationID),
ADD INDEX (PassengerID),
ADD INDEX (ScheduleID),
ADD FOREIGN KEY (PassengerID) REFERENCES passengers(PassengerID),
ADD FOREIGN KEY (ScheduleID) REFERENCES flightschedules(ScheduleID),
ADD FOREIGN KEY (FlightID) REFERENCES flights(FlightID);

ALTER TABLE reservations
ADD COLUMN FlightID VARCHAR(20);
ALTER TABLE reservations
ADD CONSTRAINT fk_reservations_flightid
FOREIGN KEY (FlightID) REFERENCES flights(FlightID);


describe passengers;
ALTER TABLE passengers
MODIFY FullName VARCHAR(30),
MODIFY PassportNumber VARCHAR(20);
ALTER TABLE passengers
MODIFY DOB DATE; 

describe flights;
ALTER TABLE flights
MODIFY Origin VARCHAR(50),
MODIFY Destination VARCHAR(50);

describe aircrafts;
ALTER TABLE aircrafts
MODIFY MODEL VARCHAR(50),
MODIFY COLUMN Manufacturer VARCHAR(50);

describe flightschedules;
ALTER TABLE flightschedules
MODIFY DepartureDateTime DATETIME,
MODIFY ArrivalDateTime DATETIME;

describe reserve;
ALTER TABLE reserve
MODIFY BookingDate DATE,
MODIFY CLASS VARCHAR(20);

DESCRIBE payments;
ALTER TABLE payments
MODIFY AmountPaid decimal(10,2),
MODIFY PaymentMode VARCHAR(30),
MODIFY PaymentDate DATETIME;