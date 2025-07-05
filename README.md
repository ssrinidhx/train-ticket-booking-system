# Train Ticket Booking System 
A web-based train ticket reservation system where users can create an account, book tickets, and view their bookings. Admins can manage trains and view passenger details through a dedicated dashboard.

# Features:

## Admin:
- Login using admin credentials.
- Add new train details with date, time, origin, destination, and seat availability.
- View list of added trains.
- View all booked passenger details.
- Logout securely.

## User:
- Create an account with full name, age, gender, phone number, email, and password.
- Log in using email and password.
- View list of available trains.
- Book train tickets and select the number of seats.
- View booked train ticket details.
- Logout securely.

# Technologies Used:

- **Java (JSP & Servlet)** – Backend and dynamic frontend logic.
- **MySQL** – Stores train, booking, and user data.
- **JDBC** – Java Database Connectivity for interacting with MySQL.
- **Apache Tomcat v10.1** – Web server for deployment.
- **HTML/CSS** – Frontend design.

# Project Structure:

```
TrainTicketBookingSystem/
│
├── src/main/java/
│   └── (default package)
│ 	  └── AddNewTrainServlet.java
│ 	  └── AdminLoginServlet.java
│ 	  └── BookedPassengersServlet.java
│ 	  └── BookedTrainDetailsServlet.java
│ 	  └── BookSeatsServlet.java
│ 	  └── BookTicketServlet.java
│ 	  └── ChangePasswordServlet.java
│ 	  └── CreateAccountServlet.java
│ 	  └── DeleteTrainServlet.java
│ 	  └── DeleteUserServlet.java
│ 	  └── EditTrainServlet.java
│ 	  └── EditUserServlet.java
│ 	  └── UserLoginServlet.java
│   └── DBC
│ 	  └── DBConnection.java
│
├── WebContent
│	  └── images
│ 	      └── all images
│	  └── add-new-train.jsp
│	  └── admin-dashboard.jsp
│	  └── admin-login.jsp
│	  └── admin-logout.jsp
│	  └── booked-passengers.jsp
│	  └── booked-train-details.jsp
│	  └── book-ticket.jsp
│	  └── change-password.jsp
│	  └── confirm-logout.jsp
│	  └── confirm-logout-admin.jsp
│	  └── create-account.jsp
│	  └── delete-train.jsp
│	  └── delete-user.jsp
│	  └── edit-train.jsp
│	  └── edit-user.jsp
│	  └── error.jsp
│	  └── error1.jsp
│	  └── error2.jsp
│	  └── erroraccount.jsp
│	  └── erroradd-students.jsp
│	  └── erroradd1.jsp
│	  └── errorbook.jsp
│	  └── index.jsp
│	  └── list-trains.jsp
│	  └── list-trains-user.jsp
│	  └── user-dashboard.jsp
│	  └── user-details.jsp
└──       └── user-login.jsp
```

# Database Tables(MySQL):

### Database Name: `train_booking_db`

### 1. `admin` : Stores admin login credentials.

### 2. `users` : Stores user registration details.

### 3. `user_login` : Stores login credentials for users.

### 4. `trains` : Stores train details.

### 5. `available_seats` : Tracks the remaining seats for each train.

### 6. `bookings` : Stores all user ticket bookings.

## Relationships:
- `train_number` is the linking key across trains, available_seats, and bookings.

- `email` is used to associate users across users, user_login, and bookings.
