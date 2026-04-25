CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    user_password VARCHAR(100) NOT NULL,
    user_refresh_token VARCHAR(500) NULL,
    user_score INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS quizzes (
    quiz_id SERIAL PRIMARY KEY,
    quiz_level VARCHAR(20) NOT NULL,
    quiz_category VARCHAR(50) NOT NULL,
    quiz_language VARCHAR(20) NOT NULL,
    quiz_question VARCHAR(255) NOT NULL,
    quiz_option_I VARCHAR(255) NOT NULL,
    quiz_option_II VARCHAR(255) NOT NULL,
    quiz_option_III VARCHAR(255) NOT NULL,
    quiz_answer VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS history (
    history_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    quiz_id INT NOT NULL REFERENCES quizzes(quiz_id),
    start_time TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    score INT NOT NULL
);