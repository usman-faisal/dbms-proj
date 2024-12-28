-- Create the authoriser table first (for foreign key references)
CREATE TABLE authoriser (
    id VARCHAR(50) PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    request VARCHAR(200) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    location VARCHAR(200) NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    adminuser VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the worker table
CREATE TABLE worker (
    id VARCHAR(10) PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    area VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    service_type ENUM('Plumber', 'Electrician', 'Carpenter', 'AC & Refrigerator', 'Washing Machine') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status BOOLEAN DEFAULT TRUE
);

-- Create the customer table
CREATE TABLE customer (
    id VARCHAR(50) PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    area VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the service table
CREATE TABLE service (
    id VARCHAR(50),
    request VARCHAR(200) NOT NULL,
    dateofreq DATE NOT NULL,
    authid VARCHAR(50),
    aflag TINYINT DEFAULT 0,
    transflag TINYINT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id) REFERENCES customer(id),
    FOREIGN KEY (authid) REFERENCES authoriser(id)
);

-- Create the finance table
CREATE TABLE finance (
    transno VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    wid VARCHAR(50) NOT NULL,
    wage DECIMAL(10,2) NOT NULL,
    aid VARCHAR(50) NOT NULL,
    request VARCHAR(200) NOT NULL,
    cust_name VARCHAR(100) NOT NULL,
    auth_name VARCHAR(100) NOT NULL,
    worker_name VARCHAR(100) NOT NULL,
    tdate DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cid) REFERENCES customer(id),
    FOREIGN KEY (wid) REFERENCES worker(id),
    FOREIGN KEY (aid) REFERENCES authoriser(id)
);

CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    status ENUM('active', 'inactive') DEFAULT 'active',
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_status (status)
);

INSERT INTO admin (username, password, email) 
VALUES ('usman', 'usman', 'usman@example.com');