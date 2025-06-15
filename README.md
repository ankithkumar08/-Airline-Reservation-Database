
# ✈️ Airline Reservation Database

This project simulates a simplified **Airline Reservation System** using a relational database design. It is designed to manage and analyze flight bookings, aircraft assignments, payment tracking, and passenger records.

---

## 📦 Table Structure

### 1. **Passengers**

| Column Name      | Data Type      | Constraints        |
|------------------|----------------|--------------------|
| PassengerID      | VARCHAR(20)    | Primary Key        |
| FullName         | VARCHAR(50)    |                    |
| PassportNumber   | VARCHAR(20)    | Unique             |
| DOB              | DATE           |                    |

---

### 2. **Flights**

| Column Name      | Data Type      | Constraints        |
|------------------|----------------|--------------------|
| FlightID         | VARCHAR(20)    | Primary Key        |
| FlightNumber     | VARCHAR(20)    | Unique             |
| Origin           | VARCHAR(50)    |                    |
| Destination      | VARCHAR(50)    |                    |
| DurationMinutes  | INT            |                    |

---

### 3. **Aircrafts**

| Column Name      | Data Type      | Constraints        |
|------------------|----------------|--------------------|
| AircraftID       | VARCHAR(20)    | Primary Key        |
| Model            | VARCHAR(50)    |                    |
| Capacity         | INT            |                    |
| Manufacturer     | VARCHAR(50)    |                    |

---

### 4. **FlightSchedules**

| Column Name         | Data Type      | Constraints        |
|---------------------|----------------|--------------------|
| ScheduleID          | VARCHAR(20)    | Primary Key        |
| FlightID            | VARCHAR(20)    | Foreign Key        |
| AircraftID          | VARCHAR(20)    | Foreign Key        |
| DepartureDateTime   | DATETIME       |                    |
| ArrivalDateTime     | DATETIME       |                    |

---

### 5. **Reservations**

| Column Name      | Data Type      | Constraints        |
|------------------|----------------|--------------------|
| ReservationID    | VARCHAR(20)    | Primary Key        |
| PassengerID      | VARCHAR(20)    | Foreign Key        |
| ScheduleID       | VARCHAR(20)    | Foreign Key        |
| SeatNumber       | VARCHAR(10)    |                    |
| BookingDate      | DATE           |                    |
| Class            | VARCHAR(20)    | Economy / Business / First |

---

### 6. **Payments**

| Column Name      | Data Type      | Constraints        |
|------------------|----------------|--------------------|
| PaymentID        | VARCHAR(20)    | Primary Key        |
| ReservationID    | VARCHAR(20)    | Foreign Key        |
| AmountPaid       | DECIMAL(10,2)  |                    |
| PaymentMode      | VARCHAR(50)    | Credit Card, UPI, Cash |
| PaymentDate      | DATETIME       |                    |

---

## 🔁 Entity Relationships

- A **Passenger** can make multiple **Reservations**.
- A **Reservation** is tied to a **FlightSchedule**.
- A **FlightSchedule** uses a specific **Flight** and **Aircraft**.
- A **Reservation** is always associated with a **Payment**.

---

## 🧠 SQL Operations & Analysis

### 🔧 Schema & Table Operations

```sql
USE airlines;

SHOW TABLES;
SHOW COLUMNS FROM aircrafts;
DESCRIBE aircrafts;

SELECT 'aircrafts' AS TableName, COUNT(*) AS RowCount FROM aircrafts;

SELECT *, COUNT(*) AS duplicates 
FROM aircrafts 
GROUP BY AircraftID, MODEL, Capacity, Manufacturer 
HAVING COUNT(*) > 1;

SELECT * FROM reserve;
```

---

### 📊 Sample Queries and Business Insights

```sql
-- 1. List all flights
SELECT * FROM flights;

-- 2. Passengers who booked a seat
SELECT DISTINCT * 
FROM passengers 
JOIN reserve ON passengers.PassengerID = reserve.PassengerID;

-- 3. All aircrafts
SELECT * FROM aircrafts;

-- 4. Payment details for each reservation
SELECT * FROM payments;

-- 5. Reservations with passenger name and flight number
SELECT r.ReservationID, p.FullName, f.FlightNumber
FROM reservations r
JOIN passengers p ON r.PassengerID = p.PassengerID
JOIN flightschedules fs ON r.ScheduleID = fs.ScheduleID
JOIN flights f ON fs.FlightID = f.FlightID;

-- 6. Passengers with flight schedule
SELECT p.PassengerID, fs.DepartureDateTime, fs.ArrivalDateTime 
FROM passengers p
JOIN reserve r ON p.PassengerID = r.PassengerID
JOIN flightschedules fs ON r.ScheduleID = fs.ScheduleID;

-- 7. Reservations with seat and class + payment info
SELECT r.ReservationID, r.SeatNumber, r.CLASS, p.PaymentID, p.AmountPaid 
FROM reserve r
JOIN payments p ON r.ReservationID = p.ReservationID;

-- 8. Flight schedules with aircraft model
SELECT DISTINCT fs.AircraftID, fs.DepartureDateTime, fs.ArrivalDateTime, a.MODEL 
FROM flightschedules fs
JOIN aircrafts a ON a.AircraftID = fs.AircraftID;

-- 9. Count of reservations per flight
SELECT f.FlightNumber, COUNT(fs.FlightID) AS no_of_flights 
FROM reserve r
JOIN flightschedules fs ON r.ScheduleID = fs.ScheduleID
JOIN flights f ON fs.FlightID = f.FlightID
GROUP BY f.FlightNumber
ORDER BY no_of_flights DESC;

-- 10. Bookings by class
SELECT CLASS, COUNT(CLASS) AS no_of_bookings 
FROM reserve 
GROUP BY CLASS
ORDER BY CLASS DESC;

-- 11. Revenue per payment mode
SELECT PaymentMode, SUM(AmountPaid) AS total_amount 
FROM payments
GROUP BY PaymentMode
ORDER BY total_amount DESC;

-- 12. Average flight duration per route
SELECT Origin, Destination, AVG(DurationMinutes) AS Average 
FROM flights
GROUP BY Origin, Destination;

-- 13. Top passenger by number of reservations
SELECT p.FullName, COUNT(*) AS ReservationCount
FROM passengers p
JOIN reserve r ON p.PassengerID = r.PassengerID
GROUP BY p.FullName
ORDER BY ReservationCount DESC
LIMIT 1;

-- 14. Most used aircraft model
SELECT MODEL, COUNT(MODEL) AS CountOfModel 
FROM aircrafts
GROUP BY MODEL
ORDER BY CountOfModel DESC
LIMIT 1;

-- 15. Most popular route
SELECT f.Origin, f.Destination, COUNT(*) AS TripCount
FROM reserve r
JOIN flightschedules fs ON r.ScheduleID = fs.ScheduleID
JOIN flights f ON fs.FlightID = f.FlightID
GROUP BY f.Origin, f.Destination
ORDER BY TripCount DESC
LIMIT 1;

-- 16. Top 5 passengers by total spend
SELECT p.FullName, SUM(pay.AmountPaid) AS TotalSpent 
FROM payments pay
JOIN reserve r ON r.ReservationID = pay.ReservationID
JOIN passengers p ON r.PassengerID = p.PassengerID
GROUP BY p.FullName
ORDER BY TotalSpent DESC
LIMIT 5;

-- 17. Recent reservations (last 30 days)
SELECT * 
FROM reservations
WHERE BookingDate >= CURDATE() - INTERVAL 30 DAY;

-- 18. Today’s departures
SELECT * 
FROM flightschedules
WHERE DATE(DepartureDateTime) = CURDATE();

-- 19. Passengers born before 2000
SELECT FullName, DOB 
FROM passengers
WHERE DOB < '2000-01-01';

-- 20. Payments this month
SELECT * 
FROM payments
WHERE MONTH(PaymentDate) = MONTH(CURDATE()) 
  AND YEAR(PaymentDate) = YEAR(CURDATE());

-- 21. Duplicate passenger entries
SELECT FullName, PassportNumber, COUNT(*) AS dup_count
FROM passengers
GROUP BY FullName, PassportNumber
HAVING COUNT(*) > 1;

-- 22. Duplicate reservations
SELECT PassengerID, ScheduleID, SeatNumber, COUNT(*) AS duplicate
FROM reserve
GROUP BY PassengerID, ScheduleID, SeatNumber
HAVING duplicate > 1;

-- 23. Flights scheduled multiple times per day
SELECT FlightID, DATE(DepartureDateTime) AS flightdate, COUNT(*) AS CountOfFlights
FROM flightschedules
GROUP BY FlightID, flightdate
HAVING CountOfFlights > 1
ORDER BY CountOfFlights DESC;

-- 24. Invalid schedules
SELECT * 
FROM flightschedules
WHERE ArrivalDateTime < DepartureDateTime;

-- 25. Distinct columns in 'aircrafts'
SELECT DISTINCT column_name 
FROM information_schema.columns 
WHERE table_schema = 'airlines' 
  AND table_name = 'aircrafts';
```

---

## 🛠️ Skills Demonstrated

- ✅ Relational Database Design  
- ✅ SQL Querying (Joins, Aggregations, Filtering, Validation)  
- ✅ Data Analysis & Business Reporting  
- ✅ Data Cleaning & Duplicate Checks  
- ✅ Time-based and Revenue-based Reporting  

---

## 📬 Contact

**Ankithkumar Chillapalli**  
📫 [Your LinkedIn or Email]  
📁 [GitHub Repository Link]
