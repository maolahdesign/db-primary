-- 1. 會員資料表 (users)
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(64) UNIQUE NOT NULL,
    email VARCHAR(128) UNIQUE NOT NULL,
    passwd VARCHAR(255) NOT NULL,
    name VARCHAR(64),
    nikename VARCHAR(64),
    avatar VARCHAR(255),
    status VARCHAR(20),
    activation_key UUID DEFAULT uuid_generate_v4(),
    registered TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- add new user
INSERT INTO users; (username,email,passwd,name,nikename,avatar) 
VALUES ('troie','troie@wow.com','hello','潘冬瓜','troie','https://troie.pro/avatar.jpg');


-- 2. 課程資料表 (courses)
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_content JSONB,
    category VARCHAR(50),
    price DECIMAL(10, 2),
    instructor_id INT,
    instructor_name VARCHAR(100),       --違反三階正規劃
    course_cover VARCHAR(255),          --違反三階正規劃
    rating INTEGER,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

INSERT INTO courses (course_name,course_content,category,price,instructor_id,instructor_name,course_cover,rating)
VALUES ('hello css','{}','f2d',3600,1,'troie','https://',0);

-- 3. 報名學員資料表 (enrollments)
CREATE TYPE enroll_status AS ENUM ('等待付款中','處理中','完成','已取消','已退費','失敗');
CREATE TABLE enrollments (
    enroll_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    course_id INTEGER REFERENCES courses(course_id),
    progress_rate DECIMAL(5, 2) DEFAULT 0,
    status enroll_status,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, course_id)
);


INSERT INTO enrollments (user_id,course_id,status) 
VALUES (1,1,'等待付款中');

-- 4. 課程評論資料表 (reviews)
CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    course_id INTEGER REFERENCES courses(course_id),
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO reviews (user_id, course_id, rating, comment)
VALUES (1,1,5,'GOOD');

-- 5. 講師資料表 (instructors)
DROP TABLE  IF EXISTS instructors CASCADE;
CREATE TABLE instructors (
    instructor_id SERIAL PRIMARY KEY,
    instructor_name VARCHAR(100),
    email VARCHAR(100),
    office VARCHAR(100),
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO instructors (instructor_name,email,office)
VALUES ('troie','troiepan@gmail.com','maolah design');