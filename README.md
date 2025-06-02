# ✈️ Airline Reservation Database

This project simulates a simplified **Airline Reservation System** using a relational database design. It consists of core entities such as **Passengers**, **Flights**, **Aircrafts**, **Flight Schedules**, **Reservations**, and **Payments**.

---

## 📦 Table Structure

### 1. **Passengers**

| Column Name      | Data Type      | Constraints        |
|------------------|----------------|--------------------|
| PassengerID      | VARCHAR(20)    | Primary Key        |
| FullName         | VARCHAR(50)   |                    |
| PassportNumber   | VARCHAR(20)    | Unique             |
| DOB              | DATE           |                    |

---

### 2. **Flights**

| Column Name      | Data Type      | Constraints        |
|------------------|----------------|--------------------|
| FlightID         | VARCHAR(20)    | Primary Key        |
| FlightNumber     | VARCHAR(20)    | Unique             |
| Origin           | VARCHAR(50)   |                    |
| Destination      | VARCHAR(50)   |                    |
| DurationMinutes  | INT            |                    |

---

### 3. **Aircrafts**

| Column Name      | Data Type      | Constraints        |
|------------------|----------------|--------------------|
| AircraftID       | VARCHAR(20)    | Primary Key        |
| Model            | VARCHAR(50)   |                    |
| Capacity         | INT            |                    |
| Manufacturer     | VARCHAR(50)   |                    |

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
| Class            | VARCHAR(20)    | Values: Economy / Business / First |

---

### 6. **Payments**

| Column Name      | Data Type      | Constraints        |
|------------------|----------------|--------------------|
| PaymentID        | VARCHAR(20)    | Primary Key        |
| ReservationID    | VARCHAR(20)    | Foreign Key        |
| AmountPaid       | DECIMAL(10,2)  |                    |
| PaymentMode      | VARCHAR(50)    | e.g., Credit Card, UPI, Cash |
| PaymentDate      | DATETIME       |                    |

---

## 🔁 Relationships

- A **Passenger** can make multiple **Reservations**.
- Each **Reservation** is linked to a **FlightSchedule**.
- Each **FlightSchedule** is assigned to a **Flight** and an **Aircraft**.
- Each **Reservation** has one corresponding **TicketPayment**.

---
