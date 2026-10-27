CREATE TABLE titles (
    id SERIAL PRIMARY KEY,
    title_name_ru VARCHAR(512) UNIQUE NOT NULL,
    title_name_en VARCHAR(512) UNIQUE,
    title_name_jp VARCHAR(512) UNIQUE,
    title_year INTEGER,
    title_episodes INTEGER,
    title_description VARCHAR(512) UNIQUE,
    title_rating DECIMAL(2,1)
);
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    title_genre VARCHAR(64) UNIQUE
);
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    title_tag VARCHAR(64) UNIQUE
);
CREATE TABLE dubs (
    id SERIAL PRIMARY KEY,
    dub_name VARCHAR(64) UNIQUE
);
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(32) UNIQUE
);

CREATE TABLE title_genres (
    title_id INTEGER REFERENCES titles(id),
    genre_id INTEGER REFERENCES genres(id)
);
CREATE TABLE title_tags (
    title_id INTEGER REFERENCES titles(id),
    tag_id INTEGER REFERENCES tags(id)
);
CREATE TABLE title_connections (
    title_id INTEGER REFERENCES titles(id),

)
CREATE TABLE user_media (
    id SERIAL PRIMARY KEY,
    title_status VARCHAR(64) NOT NULL
    my_title_rating INTEGER,
    title_viewing_mode VARCHAR(64) UNIQUE
);
CREATE TABLE watch_sessions (
    id SERIAL PRIMARY KEY,
    data_of_viewing TIMESTAMP NOT NULL,
    fresh_title_rating DECIMAL(2,1),
    what_was_dub INTEGER REFERENCES dubs(id)
);
CREATE TABLE characters (
    id SERIAL PRIMARY KEY,
    character_name VARCHAR(32),
    character_role VARCHAR(64),
    from_title INTEGER REFERENCES titles(id) 
);
CREATE TABLE best_moment (
    id SERIAL PRIMARY KEY,
    title_name INTEGER REFERENCES titles(id),
    character_name INTEGER REFERENCES characters(id),
    season_number INTEGER,
    episode_number INTEGER,
    moment_time TIME NOT NULL DEFAULT '00:00:00',
    media_url VARCHAR(128) 
);