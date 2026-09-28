-- Mock Evaluation System database schema
-- MySQL 8.x
-- This file creates the database and all tables required by the application.

CREATE DATABASE IF NOT EXISTS mock_evaluation_system
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE mock_evaluation_system;

CREATE TABLE IF NOT EXISTS users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN','EVALUATOR') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS batches (
    batch_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    batch_name VARCHAR(100) UNIQUE NOT NULL,
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS technologies (
    technology_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    technology_name VARCHAR(100) UNIQUE NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS participants (
    participant_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    batch_id BIGINT,
    technology_id BIGINT,
    CONSTRAINT fk_participant_batch
        FOREIGN KEY (batch_id) REFERENCES batches(batch_id)
        ON DELETE SET NULL,
    CONSTRAINT fk_participant_technology
        FOREIGN KEY (technology_id) REFERENCES technologies(technology_id)
        ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS evaluation_rounds (
    round_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    round_name VARCHAR(100) NOT NULL,
    technology_id BIGINT NOT NULL,
    CONSTRAINT fk_round_technology
        FOREIGN KEY (technology_id) REFERENCES technologies(technology_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS evaluator_assignments (
    assignment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    participant_id BIGINT NOT NULL,
    evaluator_id BIGINT NOT NULL,
    round_id BIGINT NOT NULL,
    assignment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_assignment_participant
        FOREIGN KEY (participant_id) REFERENCES participants(participant_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_assignment_evaluator
        FOREIGN KEY (evaluator_id) REFERENCES users(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_assignment_round
        FOREIGN KEY (round_id) REFERENCES evaluation_rounds(round_id)
        ON DELETE CASCADE,
    CONSTRAINT uq_assignment
        UNIQUE (participant_id, evaluator_id, round_id)
);

CREATE TABLE IF NOT EXISTS evaluations (
    evaluation_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    participant_id BIGINT NOT NULL,
    evaluator_id BIGINT NOT NULL,
    round_id BIGINT NOT NULL,
    score INT NOT NULL,
    feedback TEXT,
    evaluation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_evaluation_participant
        FOREIGN KEY (participant_id) REFERENCES participants(participant_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_evaluation_evaluator
        FOREIGN KEY (evaluator_id) REFERENCES users(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_evaluation_round
        FOREIGN KEY (round_id) REFERENCES evaluation_rounds(round_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS login_activity (
    activity_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    role VARCHAR(20),
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    logout_time TIMESTAMP NULL,
    CONSTRAINT fk_login_activity_user
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
);

-- Useful indexes for common joins/report queries.
CREATE INDEX idx_participants_batch ON participants(batch_id);
CREATE INDEX idx_participants_technology ON participants(technology_id);
CREATE INDEX idx_rounds_technology ON evaluation_rounds(technology_id);
CREATE INDEX idx_evaluations_participant ON evaluations(participant_id);
CREATE INDEX idx_evaluations_evaluator ON evaluations(evaluator_id);
CREATE INDEX idx_evaluations_round ON evaluations(round_id);
CREATE INDEX idx_login_activity_user ON login_activity(user_id);
