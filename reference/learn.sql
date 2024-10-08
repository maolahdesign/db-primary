**1. 會員資料表 (users)**

| 字段名稱 | 資料類型 | 說明 |
|---|---|---|
| id | SERIAL PRIMARY KEY | 會員唯一識別碼 |
| username | VARCHAR(255) UNIQUE NOT NULL | 會員帳號 |
| email | VARCHAR(255) UNIQUE NOT NULL | 會員電子郵件地址 |
| password | VARCHAR(255) NOT NULL | 會員密碼 (建議使用哈希加密) |
| name | VARCHAR(255) | 會員姓名 |
| nikename | VARCHAR(255) | 會員暱稱 |
| avatar | VARCHAR(255) | 會員頭像 URL |
| status | INTAGER | 會員頭像 URL |
| activation key | VARCHAR(255) | 會員驗證碼 |
| registered | TIMESTAMP DEFAULT CURRENT_TIMESTAMP | 會員註冊時間 |
| updated | TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 會員資料更新時間 |

**2. 課程資料表 (courses)**

| 字段名稱 | 資料類型 | 說明 |
|---|---|---|
| id | SERIAL PRIMARY KEY | 課程唯一識別碼 |
| course name | VARCHAR(255) NOT NULL | 課程標題 |
| description | TEXT | 課程描述 |
| category | VARCHAR(255) | 課程類別 |
| price | DECIMAL(10,2) | 課程價格 |
| instructor | VARCHAR(255) | 課程講師 |
| image | VARCHAR(255) | 課程封面圖片 URL |
| created | TIMESTAMP DEFAULT CURRENT_TIMESTAMP | 課程創建時間 |
| updated | TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 課程更新時間 |

**3. 課程學員資料表 (enrollments)**

| 字段名稱 | 資料類型 | 說明 |
|---|---|---|
| id | SERIAL PRIMARY KEY | 學員記錄唯一識別碼 |
| user_id | INTEGER REFERENCES users(id) | 會員 ID |
| course_id | INTEGER REFERENCES courses(id) | 課程 ID |
| status | VARCHAR(255) | 學員狀態 (例如：已報名、已完成、未完成) |
| created | TIMESTAMP DEFAULT CURRENT_TIMESTAMP | 學員記錄創建時間 |

**4. 課程評論資料表 (reviews)**

| 字段名稱 | 資料類型 | 說明 |
|---|---|---|
| id | SERIAL PRIMARY KEY | 評論唯一識別碼 |
| user_id | INTEGER REFERENCES users(id) | 會員 ID |
| course_id | INTEGER REFERENCES courses(id) | 課程 ID |
| rating | INTEGER | 評分 (例如：1-5 星) |
| comment | TEXT | 評論內容 |
| created | TIMESTAMP DEFAULT CURRENT_TIMESTAMP | 評論創建時間 |

-- 1. 會員資料表 (users)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, 
    name VARCHAR(255),
    avatar VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. 課程資料表 (courses)
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(255),
    price DECIMAL(10,2),
    instructor VARCHAR(255),
    image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. 課程學員資料表 (enrollments)
CREATE TABLE enrollments (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES courses(id) ON DELETE CASCADE,
    status VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. 課程評論資料表 (reviews)
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES courses(id) ON DELETE CASCADE,
    rating INTEGER,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
