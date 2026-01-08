-- tạo csdl hoteldb --
create database hoteldb;

-- tạo schema hotel --
create schema hotel

-- tạo các bảng --
create table hotel.roomtypes (
room_type_id int generated always as identity PRIMARY KEY,
type_name VARCHAR(50) NOT NULL UNIQUE,
price_per_night NUMERIC(10,2) CHECK (price_per_night > 0),
max_capacity INT CHECK  (max_capacity > 0)
);

create table hotel.rooms (
room_id int generated always as identity PRIMARY KEY,
room_number VARCHAR(10) NOT NULL UNIQUE,
room_type_id INT references hotel.roomtypes(room_type_id),
status VARCHAR(20) CHECK (status IN ('Available','Occupied','Maintenance'))
);

create table hotel.customers (
customer_id int generated always as identity PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone VARCHAR(15) NOT NULL
);

create table hotel.bookings (
booking_id int generated always as identity PRIMARY KEY,
customer_id INT references hotel.customers(customer_id),
room_id INT references hotel.rooms(room_id),
check_in DATE NOT NULL,
check_out DATE NOT NULL,
status VARCHAR(20) CHECK (status IN ('Pending','Confirmed','Cancelled'))
);

create table hotel.payments (
payment_id int generated always as identity PRIMARY KEY,
booking_id INT references hotel.bookings(booking_id),
amount NUMERIC(10,2) CHECK (amount >= 0),
payment_date DATE NOT NULL,
method VARCHAR(20) CHECK (method IN ('Credit Card','Cash','Bank Transfer'))
)