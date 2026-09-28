-- Optional local/demo data for Mock Evaluation System.
-- IMPORTANT: These are demo credentials/data only. Do not reuse the password
-- for any real account. Change/remove this demo account for production use.
--
-- Demo admin login:
-- Email: admin@gmail.com
-- Password: admin123
--
-- The application currently supports BCrypt hashes and legacy plaintext
-- passwords during login. For this local demo seed only, the password is
-- stored as plaintext because the original application supports it.
-- For a production deployment, use the application's user-creation flow,
-- which hashes passwords with BCrypt.

USE mock_evaluation_system;

INSERT INTO users (full_name, email, password, role)
VALUES ('Admin', 'admin@gmail.com', 'admin123', 'ADMIN')
ON DUPLICATE KEY UPDATE email = VALUES(email);

INSERT INTO users (full_name, email, password, role)
VALUES ('Demo Evaluator', 'evaluator@gmail.com', 'evaluator123', 'EVALUATOR')
ON DUPLICATE KEY UPDATE email = VALUES(email);

INSERT INTO batches (batch_name, start_date, end_date)
VALUES ('Demo Batch', '2026-01-01', '2026-06-30')
ON DUPLICATE KEY UPDATE batch_name = VALUES(batch_name);

INSERT INTO technologies (technology_name, description)
VALUES ('Java', 'Java Full Stack mock evaluation')
ON DUPLICATE KEY UPDATE technology_name = VALUES(technology_name);

SET @technology_id = (SELECT technology_id FROM technologies WHERE technology_name = 'Java');
SET @batch_id = (SELECT batch_id FROM batches WHERE batch_name = 'Demo Batch');
SET @evaluator_id = (SELECT user_id FROM users WHERE email = 'evaluator@gmail.com');

INSERT INTO evaluation_rounds (round_name, technology_id)
SELECT 'Technical Round', @technology_id
WHERE NOT EXISTS (
    SELECT 1 FROM evaluation_rounds
    WHERE round_name = 'Technical Round' AND technology_id = @technology_id
);

SET @round_id = (
    SELECT round_id FROM evaluation_rounds
    WHERE round_name = 'Technical Round' AND technology_id = @technology_id
    LIMIT 1
);

INSERT INTO participants (full_name, email, phone, batch_id, technology_id)
VALUES
    ('Demo Participant 1', 'participant1@example.com', '9000000001', @batch_id, @technology_id),
    ('Demo Participant 2', 'participant2@example.com', '9000000002', @batch_id, @technology_id),
    ('Demo Participant 3', 'participant3@example.com', '9000000003', @batch_id, @technology_id)
ON DUPLICATE KEY UPDATE email = VALUES(email);

SET @p1 = (SELECT participant_id FROM participants WHERE email = 'participant1@example.com');
SET @p2 = (SELECT participant_id FROM participants WHERE email = 'participant2@example.com');
SET @p3 = (SELECT participant_id FROM participants WHERE email = 'participant3@example.com');

INSERT IGNORE INTO evaluator_assignments (participant_id, evaluator_id, round_id)
VALUES
    (@p1, @evaluator_id, @round_id),
    (@p2, @evaluator_id, @round_id),
    (@p3, @evaluator_id, @round_id);

INSERT INTO evaluations (participant_id, evaluator_id, round_id, score, feedback)
SELECT @p1, @evaluator_id, @round_id, 80, 'Good'
WHERE NOT EXISTS (
    SELECT 1 FROM evaluations
    WHERE participant_id = @p1 AND evaluator_id = @evaluator_id AND round_id = @round_id
);

INSERT INTO evaluations (participant_id, evaluator_id, round_id, score, feedback)
SELECT @p2, @evaluator_id, @round_id, 75, 'Average'
WHERE NOT EXISTS (
    SELECT 1 FROM evaluations
    WHERE participant_id = @p2 AND evaluator_id = @evaluator_id AND round_id = @round_id
);

INSERT INTO evaluations (participant_id, evaluator_id, round_id, score, feedback)
SELECT @p3, @evaluator_id, @round_id, 90, 'Excellent'
WHERE NOT EXISTS (
    SELECT 1 FROM evaluations
    WHERE participant_id = @p3 AND evaluator_id = @evaluator_id AND round_id = @round_id
);
