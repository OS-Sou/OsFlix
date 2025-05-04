CREATE TABLE IF NOT EXISTS users (
  id_user int(11) NOT NULL AUTO_INCREMENT,
  login varchar(255) COLLATE utf8_bin NOT NULL,
  pass varchar(255) COLLATE utf8_bin NOT NULL,
  name varchar(255) COLLATE utf8_bin NOT NULL,
  email varchar(255) COLLATE utf8_bin NOT NULL,
  level int(2) NOT NULL DEFAULT '1',
  uuid varchar(255) COLLATE utf8_bin NOT NULL,
  reset_token varchar(64) COLLATE utf8_bin DEFAULT NULL,
  reset_token_expires datetime DEFAULT NULL,
  PRIMARY KEY (id_user),
  UNIQUE KEY login (login),
  UNIQUE KEY email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS xtream (
  id int(11) NOT NULL AUTO_INCREMENT,
  url varchar(500) NOT NULL,
  user varchar(500) NOT NULL,
  pass varchar(500) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS cache_info (
  id int(11) NOT NULL AUTO_INCREMENT,
  id_video int(11) NOT NULL,
  type varchar(20) COLLATE utf8_bin NOT NULL,
  name varchar(255) COLLATE utf8_bin NOT NULL,
  img varchar(1500) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (id),
  KEY id_video (id_video)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS favorites (
  id int(11) NOT NULL AUTO_INCREMENT,
  id_user int(11) NOT NULL,
  id_video int(11) NOT NULL,
  type varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (id),
  KEY id_user (id_user)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS watched (
  id int(11) NOT NULL AUTO_INCREMENT,
  id_user int(11) NOT NULL DEFAULT '0',
  id_video int(11) NOT NULL DEFAULT '0',
  id_ep int(11) DEFAULT NULL,
  type varchar(20) COLLATE utf8_bin NOT NULL,
  checkpoint double NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS tv_categories (
  category_id int(11) NOT NULL AUTO_INCREMENT,
  category_name varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS anime_categories (
  category_id int(11) NOT NULL AUTO_INCREMENT,
  category_name varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS cartoon_categories (
  category_id int(11) NOT NULL AUTO_INCREMENT,
  category_name varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS tv_content (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) COLLATE utf8_bin NOT NULL,
  description text COLLATE utf8_bin,
  category_id int(11) NOT NULL,
  stream_url varchar(1000) COLLATE utf8_bin NOT NULL,
  cover_url varchar(1000) COLLATE utf8_bin NOT NULL,
  added_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY category_id (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS anime_content (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) COLLATE utf8_bin NOT NULL,
  description text COLLATE utf8_bin,
  category_id int(11) NOT NULL,
  stream_url varchar(1000) COLLATE utf8_bin NOT NULL,
  cover_url varchar(1000) COLLATE utf8_bin NOT NULL,
  added_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY category_id (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS cartoon_content (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) COLLATE utf8_bin NOT NULL,
  description text COLLATE utf8_bin,
  category_id int(11) NOT NULL,
  stream_url varchar(1000) COLLATE utf8_bin NOT NULL,
  cover_url varchar(1000) COLLATE utf8_bin NOT NULL,
  added_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY category_id (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO users (id_user, login, pass, name, email, level, uuid) VALUES 
(1, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrador', 'admin@osflix.com', 10, 'd15225ff-f4d8-4454-8922-ed5e6014ff8c');

INSERT INTO xtream (url, user, pass) VALUES ('', '', ''); 