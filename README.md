# -Airline-Reservation-Database
3. Airline Reservation Database
Passengers


PassengerID (VARCHAR(20), Primary Key)


FullName (VARCHAR(100))


PassportNumber (VARCHAR(20), UNIQUE)


Nationality (VARCHAR(50))


DOB (DATE)


Flights


FlightID (VARCHAR(20), Primary Key)


FlightNumber (VARCHAR(20), UNIQUE)


Origin (VARCHAR(100))


Destination (VARCHAR(100))


DurationMinutes (INT)


Aircrafts


AircraftID (VARCHAR(20), Primary Key)


Model (VARCHAR(100))


Capacity (INT)


Manufacturer (VARCHAR(100))


FlightSchedules


ScheduleID (VARCHAR(20), Primary Key)


FlightID (VARCHAR(20))


AircraftID (VARCHAR(20))


DepartureDateTime (DATETIME)


ArrivalDateTime (DATETIME)


Reservations


ReservationID (VARCHAR(20), Primary Key)


PassengerID (VARCHAR(20))


ScheduleID (VARCHAR(20))


SeatNumber (VARCHAR(10))


BookingDate (DATE)


Class (VARCHAR(20)) — Economy / Business


TicketPayments


PaymentID (VARCHAR(20), Primary Key)


ReservationID (VARCHAR(20))


AmountPaid (DECIMAL(10,2))


PaymentMode (VARCHAR(50))


PaymentDate (DATETIME)
