--Создание енамчиков для удобства
CREATE TYPE title_types AS ENUM ('anime', 'film', 'serial', 'cartoon');
CREATE TYPE title_release_status AS ENUM ('finished', 'continues', 'waiting for release');
CREATE TYPE viewing_status AS ENUM ('postponed', 'watching now', 'will be watching');
CREATE TYPE viewing_mode AS ENUM ('');

--табица с тайтлами
CREATE TABLE titles (
    id SERIAL PRIMARY KEY,
    title_name_ru VARCHAR(512) UNIQUE NOT NULL,
    title_name_en VARCHAR(512) UNIQUE NOT NULL,
    title_name_ja VARCHAR(512) UNIQUE,
    title_type title_types,
    title_year INTEGER NOT NULL,
    title_description VARCHAR(512) UNIQUE NOT NULL,
    title_rating_from_kinopoisk DECIMAL(3,1),
    title_total_seasons INTEGER NOT NULL,
    title_total_episodes INTEGER NOT NULL,
    title_status title_release_status
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

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(64) UNIQUE NOT NULL
);

--таблциа связи между тайтлом и жанрами
CREATE TABLE title_genres (
    title_id INTEGER REFERENCES titles(id),
    genre_id INTEGER REFERENCES genres(id)
);

--таблица связи между тайтлом и ярлыками
CREATE TABLE title_tags (
    title_id INTEGER REFERENCES titles(id),
    tag_id INTEGER REFERENCES tags(id)
);

--таблица связи между сиквелами/приквелами и тд
CREATE TABLE relations (
    title_id INTEGER REFERENCES titles(id),
    ------
);

--таблица с личными данными пользователя
CREATE TABLE user_media (
    user_id INTEGER REFERENCES users(id),
    title_id INTEGER REFERENCES titles(id),
    title_status_now viewing_status,
    title_mode viewing_mode,
    user_rating DECIMAL(3,1),
    garem_rating DECIMAL(3,1)
);

--таблица с историей просмотров
CREATE TABLE watch_sessions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    title_id INTEGER REFERENCES titles(id),
    dub_id INTEGER REFERENCES dubs(id),
    time_watch
    title_session_rating DECIMAL(3,1) NOT NULL,
    dub_session_rating DECIMAL(3,1) NOT NULL
);

--таблица с персонажами
CREATE TABLE characters (
    id SERIAL PRIMARY KEY,
    character_name VARCHAR(256) NOT NULL,
    character_from INTEGER REFERENCES titles(id),
    gif_url
);

--таблица с лучшими моментами
CREATE TABLE character_moments (
    id SERIAL PRIMARY KEY,
    character_id INTEGER REFERENCES characters(id),
    timecode
    emotion_type VARCHAR(64) NOT NULL
);

--таблица для хранения ссылок на фото, видео, гифки
CREATE TABLE title_images (
    id SERIAL PRIMARY KEY,
    title_id INTEGER REFERENCES titles(id),
    image_name VARCHAR(64) NOT NULL,
    image_url 
)