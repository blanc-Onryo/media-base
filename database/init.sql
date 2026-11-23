--Создание енамчиков для удобства
CREATE TYPE title_types AS ENUM ('anime', 'film', 'serial', 'cartoon');
CREATE TYPE title_release_status AS ENUM ('finished', 'continues', 'waiting for release');
CREATE TYPE viewing_status AS ENUM ('postponed', 'watching now', 'will be watching');
CREATE TYPE viewing_mode AS ENUM ('background', 'full immersion', 'partial immersion');
CREATE TYPE relation_types AS ENUM ('sequel', 'prequel', 'spin-off', 'crossover', 'remake', 'OVA', 'ONA');

--табица с тайтлами
CREATE TABLE titles (
    id SERIAL PRIMARY KEY,
    title_name_ru VARCHAR(512) UNIQUE NOT NULL,
    title_name_en VARCHAR(512) UNIQUE NOT NULL,
    title_name_ja VARCHAR(512) UNIQUE,
    title_type title_types,
    title_year INTEGER NOT NULL,
    title_description TEXT NOT NULL,
    title_rating_from_kinopoisk DECIMAL(3,1),
    title_total_seasons INTEGER NOT NULL,
    title_total_episodes INTEGER NOT NULL,
    title_status title_release_status,
    title_total_watch_time INTEGER NOT NULL
);

--таблица с жанрами тайтлов
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    genre_name VARCHAR(64) UNIQUE NOT NULL
);

--таблица с ярлыками для тайтлов
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    tag_name VARCHAR(64) UNIQUE NOT NULL
);

--таблица с студиями озвучки тайтлов
CREATE TABLE dubs (
    id SERIAL PRIMARY KEY,
    dub_name VARCHAR(64) UNIQUE NOT NULL
);

--таблица с юзерами
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(64) UNIQUE NOT NULL
);

--таблциа связи между тайтлом и жанрами
CREATE TABLE title_genres (
    id SERIAL PRIMARY KEY,
    title_id INTEGER REFERENCES ON DELETE CASCADE titles(id),
    genre_id INTEGER REFERENCES ON DELETE CASCADE genres(id)
);

--таблица связи между тайтлом и ярлыками
CREATE TABLE title_tags (
    id SERIAL PRIMARY KEY,
    title_id INTEGER REFERENCES ON DELETE CASCADE titles(id),
    tag_id INTEGER REFERENCES ON DELETE CASCADE tags(id)
);

--таблица связи между сиквелами/приквелами и тд
CREATE TABLE relations (
    related_title_id INTEGER REFERENCES ON DELETE CASCADE titles(id),
    relation_type relation_types
);

--таблица с личными данными пользователя
CREATE TABLE user_media (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES ON DELETE CASCADE users(id),
    title_id INTEGER REFERENCES ON DELETE CASCADE titles(id),
    title_status_now viewing_status,
    title_mode viewing_mode,
    user_rating DECIMAL(3,1),
    garem_rating DECIMAL(3,1)
);

--таблица с историей просмотров
CREATE TABLE watch_sessions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES ON DELETE CASCADE users(id),
    title_id INTEGER REFERENCES ON DELETE CASCADE titles(id),
    dub_id INTEGER REFERENCES ON DELETE CASCADE dubs(id),
    time_watch TIMESTAMPTZ NOT NULL,
    title_session_rating DECIMAL(3,1) NOT NULL,
    dub_session_rating DECIMAL(3,1) NOT NULL,
    review_text TEXT NOT NULL
);

--таблица с персонажами
CREATE TABLE characters (
    id SERIAL PRIMARY KEY,
    character_name VARCHAR(256) NOT NULL,
    title_id INTEGER REFERENCES ON DELETE CASCADE titles(id),
    image_url INTEGER REFERENCES ON DELETE CASCADE title_images(id)
);

--таблица с лучшими моментами
CREATE TABLE character_moments (
    id SERIAL PRIMARY KEY,
    character_id INTEGER REFERENCES ON DELETE CASCADE characters(id),
    title_id INTEGER REFERENCES ON DELETE CASCADE titles(id),
    title_episode INTEGER REFERENCES ON DELETE CASCADE titles(id)
    timecode TIME,
    emotion_type VARCHAR(64) NOT NULL
);

--таблица для хранения ссылок на фото, видео, гифки
CREATE TABLE title_images (
    id SERIAL PRIMARY KEY,
    title_id INTEGER REFERENCES ON DELETE CASCADE titles(id),
    image_name VARCHAR(64) UNIQUE NOT NULL,
    image_url VARCHAR(255) UNIQUE
);