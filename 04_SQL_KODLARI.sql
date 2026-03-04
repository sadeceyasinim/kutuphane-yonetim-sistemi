-- CREATE TABLE statements for the library management system

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    published_year INT,
    available_copies INT DEFAULT 0
);

CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    user_id INT,
    book_id INT,
    loan_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Sample data for Users
INSERT INTO Users (user_id, name, email, password) VALUES
(1, 'Alice Johnson', 'alice@example.com', 'password1'),
(2, 'Bob Smith', 'bob@example.com', 'password2');

-- Sample data for Books
INSERT INTO Books (book_id, title, author, published_year, available_copies) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 3),
(2, 'To Kill a Mockingbird', 'Harper Lee', 1960, 2);

-- Sample data for Loans
INSERT INTO Loans (loan_id, user_id, book_id, loan_date, return_date) VALUES
(1, 1, 1, '2022-01-10', NULL),
(2, 2, 2, '2022-01-11', '2022-01-17');