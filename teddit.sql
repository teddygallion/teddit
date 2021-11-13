class DROP DATABASE IF EXISTS teddit;

CREATE DATABASE teddit;

SET statement_timeout = 0;

SET lock_timeout = 0;

SET client_encoding = 'UTF8';

SET standard_conforming_strings = ON;

SET check_function_bodies = FALSE;

SET client_min_messages = warning;

SET default_tablespace = '';

SET default_with_oids = FALSE;

CREATE TABLE users (
    user_id serial PRIMARY KEY,
    username varchar(30) UNIQUE NOT NULL,
    password varchar(128) NOT NULL,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    blurb text,
);

CREATE TABLE posts (
    post_id serial PRIMARY KEY,
    author_id int NOT NULL,
    subteddit_id int NOT NULL,
    date_created timestamp DEFAULT NOW() NOT NULL,
    upvotes int NOT NULL,
    downvotes int NOT NULL,
    CONSTRAINT fk_post_subteddit_id FOREIGN KEY (subteddit_id) REFERENCES subteddits(subteddit_id),
    CONSTRAINT fk_post_author_id FOREIGN KEY (author_id) REFERENCES USER (user_id),
);

CREATE TABLE subteddits (
    subteddit_id serial PRIMARY KEY,
    blurb text NOT NULL,
    moderated_by int NOT NULL,
    CONSTRAINT fk_subteddit_moderator_id FOREIGN KEY (moderated_by) REFERENCES users (user_id)
);

CREATE TABLE comments (
    comment_id serial PRIMARY KEY,
    body text NOT NULL,
    date_created timestamp DEFAULT NOW() NOT NULL,
    comment_author int NOT NULL,
    original_post int NOT NULL,
    upvotes int NOT NULL,
    downvotes int NOT NULL,
    CONSTRAINT fk_comment_original_post FOREIGN KEY (original_post) REFERENCES posts (post_id),
    CONSTRAINT fk_comment_author FOREIGN KEY (comment_author) REFERENCES users (user_id)
);
