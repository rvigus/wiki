/*
CREATE TABLES AND INSERT DATA
*/

DROP TABLE IF EXISTS Users CASCADE;
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Users (username, email, password_hash) VALUES
('tony_soprano', 'tony@example.com', 'hash1'),
('carmela_soprano', 'carmela@example.com', 'hash2'),
('christopher_moltisanti', 'chris@example.com', 'hash3'),
('paulie_gualtieri', 'paulie@example.com', 'hash4'),
('silvio_dante', 'silvio@example.com', 'hash5'),
('dr_melfi', 'melfi@example.com', 'hash6'),
('adriana_la_cerva', 'adriana@example.com', 'hash7'),
('johnny_sack', 'johnny@example.com', 'hash8');


DROP TABLE IF EXISTS Posts CASCADE;
CREATE TABLE Posts (
    post_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    published_at TIMESTAMP WITHOUT TIME ZONE,
    status VARCHAR(50) NOT NULL,
    CONSTRAINT fk_user
        FOREIGN KEY(user_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE
);

INSERT INTO Posts (user_id, title, content, published_at, status) VALUES
(3, 'My First Adventure', 'Content of Alex''s first adventure.', NOW(), 'published'),
(4, 'Future Predictions', 'Predictions about the future from Sarah.', NOW(), 'published'),
(5, 'Tech of Tomorrow', 'Exploring upcoming tech innovations.', NOW(), 'draft'),
(6, 'Robotic Ethics', 'Discussion on the ethics of AI and robotics.', NOW(), 'published'),
(4, 'Time Travel Theories', 'Exploring the possibilities of time travel.', NOW(), 'published'),
(5, 'Survival Tips', 'Tips for surviving in a dystopian future.', NOW(), 'published'),
(7, 'The Unexplained', 'Investigating unexplained phenomena.', NOW(), 'published'),
(8, 'Government Conspiracies', 'Uncovering hidden government conspiracies.', NOW(), 'published');


DROP TABLE IF EXISTS Comments CASCADE;
CREATE TABLE Comments (
    comment_id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_post
        FOREIGN KEY(post_id)
        REFERENCES Posts(post_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_user
        FOREIGN KEY(user_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE
);

INSERT INTO Comments (post_id, user_id, content) VALUES
(3, 4, 'Fascinating adventure!'),
(4, 1, 'Very intriguing predictions.'),
(5, 2, 'Can''t wait to see these techs!'),
(6, 3, 'Really important discussion.'),
(7, 4, 'Always wondered about this.'),
(8, 5, 'This is crucial for our future.'),
(4, 6, 'Time travel is always an interesting topic.'),
(7, 8, 'The truth is out there...'),
(8, 7, 'We need to dig deeper.'),
(3, 5, 'Adventure is the essence of life!');


DROP TABLE IF EXISTS Tags CASCADE;
CREATE TABLE Tags (
    tag_id SERIAL PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE NOT NULL
);


INSERT INTO Tags (tag_name) VALUES
('Adventure'),
('Future'),
('Technology'),
('Ethics'),
('Time Travel'),
('Survival'),
('Mystery'),
('Conspiracy');


DROP TABLE IF EXISTS PostTags CASCADE;
CREATE TABLE PostTags (
    post_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    PRIMARY KEY (post_id, tag_id),
    CONSTRAINT fk_post
        FOREIGN KEY(post_id)
        REFERENCES Posts(post_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_tag
        FOREIGN KEY(tag_id)
        REFERENCES Tags(tag_id)
        ON DELETE CASCADE
);

INSERT INTO PostTags (post_id, tag_id) VALUES
(3, 1),
(4, 2),
(5, 3),
(6, 4),
(7, 5),
(8, 6),
(4, 5),
(7, 7),
(8, 8),
(5, 2),
(6, 3),
(7, 8);

