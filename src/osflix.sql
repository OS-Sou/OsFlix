-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           5.7.36 - MySQL Community Server (GPL)
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS `osflix` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `osflix`;

-- Tabela de usuários
CREATE TABLE IF NOT EXISTS `users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(255) COLLATE utf8_bin NOT NULL,
  `pass` varchar(255) COLLATE utf8_bin NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `email` varchar(255) COLLATE utf8_bin NOT NULL,
  `level` int(2) NOT NULL DEFAULT '1',
  `uuid` varchar(255) COLLATE utf8_bin NOT NULL,
  `reset_token` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `reset_token_expires` datetime DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Tabela de configuração do Xtream
CREATE TABLE IF NOT EXISTS `xtream` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(500) CHARACTER SET utf8 NOT NULL,
  `user` varchar(500) CHARACTER SET utf8 NOT NULL,
  `pass` varchar(500) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Inserindo usuário padrão
INSERT INTO `users` (`id_user`, `login`, `pass`, `name`, `email`, `level`, `uuid`) VALUES
(1, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrador', 'admin@osflix.com', 10, 'd15225ff-f4d8-4454-8922-ed5e6014ff8c');

-- Inserindo configuração padrão do Xtream
INSERT INTO `xtream` (`id`, `url`, `user`, `pass`) VALUES
(1, '', '', '');

-- Copiando estrutura para tabela osflix.cache_info
CREATE TABLE IF NOT EXISTS `cache_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_video` int(11) NOT NULL,
  `type` varchar(20) COLLATE utf8_bin NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `img` varchar(1500) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_video` (`id_video`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela osflix.cache_info: 0 rows
/*!40000 ALTER TABLE `cache_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_info` ENABLE KEYS */;

-- Copiando estrutura para tabela osflix.favorites
CREATE TABLE IF NOT EXISTS `favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_video` int(11) NOT NULL,
  `type` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela osflix.favorites: 0 rows
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;

-- Copiando estrutura para tabela osflix.watched
CREATE TABLE IF NOT EXISTS `watched` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL DEFAULT '0',
  `id_video` int(11) NOT NULL DEFAULT '0',
  `id_ep` int(11) DEFAULT NULL,
  `type` varchar(20) COLLATE utf8_bin NOT NULL,
  `checkpoint` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela osflix.watched: 0 rows
/*!40000 ALTER TABLE `watched` DISABLE KEYS */;
/*!40000 ALTER TABLE `watched` ENABLE KEYS */;

-- Copiando estrutura para tabela osflix.tv_categories
CREATE TABLE IF NOT EXISTS `tv_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando estrutura para tabela osflix.anime_categories
CREATE TABLE IF NOT EXISTS `anime_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando estrutura para tabela osflix.cartoon_categories
CREATE TABLE IF NOT EXISTS `cartoon_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando estrutura para tabela osflix.tv_content
CREATE TABLE IF NOT EXISTS `tv_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `description` text COLLATE utf8_bin,
  `category_id` int(11) NOT NULL,
  `stream_url` varchar(1000) COLLATE utf8_bin NOT NULL,
  `cover_url` varchar(1000) COLLATE utf8_bin NOT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando estrutura para tabela osflix.anime_content
CREATE TABLE IF NOT EXISTS `anime_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `description` text COLLATE utf8_bin,
  `category_id` int(11) NOT NULL,
  `stream_url` varchar(1000) COLLATE utf8_bin NOT NULL,
  `cover_url` varchar(1000) COLLATE utf8_bin NOT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando estrutura para tabela osflix.cartoon_content
CREATE TABLE IF NOT EXISTS `cartoon_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `description` text COLLATE utf8_bin,
  `category_id` int(11) NOT NULL,
  `stream_url` varchar(1000) COLLATE utf8_bin NOT NULL,
  `cover_url` varchar(1000) COLLATE utf8_bin NOT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Inserindo categorias de TV
INSERT INTO tv_categories (category_name) VALUES 
('Esportes'),
('Notícias'),
('Filmes'),
('Séries'),
('Documentários'),
('Infantil'),
('Música'),
('Variedades');

-- Inserindo categorias de Animes
INSERT INTO anime_categories (category_name) VALUES 
('Ação'),
('Aventura'),
('Comédia'),
('Drama'),
('Fantasia'),
('Ficção Científica'),
('Romance'),
('Slice of Life');

-- Inserindo categorias de Desenhos
INSERT INTO cartoon_categories (category_name) VALUES 
('Pré-escolar'),
('Infantil'),
('Juvenil'),
('Educativo'),
('Aventura'),
('Comédia'),
('Ação'),
('Fantasia');

-- Inserindo conteúdo de TV
INSERT INTO tv_content (name, description, category_id, stream_url, cover_url) VALUES 
('ESPN Brasil', 'Canal de esportes 24 horas', 1, 'http://exemplo.com/stream/espn', 'http://exemplo.com/covers/espn.jpg'),
('CNN Brasil', 'Canal de notícias 24 horas', 2, 'http://exemplo.com/stream/cnn', 'http://exemplo.com/covers/cnn.jpg'),
('HBO', 'Canal de filmes e séries', 3, 'http://exemplo.com/stream/hbo', 'http://exemplo.com/covers/hbo.jpg'),
('Discovery Channel', 'Canal de documentários', 5, 'http://exemplo.com/stream/discovery', 'http://exemplo.com/covers/discovery.jpg');

-- Inserindo conteúdo de Animes
INSERT INTO anime_content (name, description, category_id, stream_url, cover_url) VALUES 
('Dragon Ball Super', 'Continuação da saga Dragon Ball Z', 1, 'http://exemplo.com/stream/dbs', 'http://exemplo.com/covers/dbs.jpg'),
('One Piece', 'Aventuras de Luffy e sua tripulação', 2, 'http://exemplo.com/stream/onepiece', 'http://exemplo.com/covers/onepiece.jpg'),
('Naruto Shippuden', 'Saga do ninja Naruto', 1, 'http://exemplo.com/stream/naruto', 'http://exemplo.com/covers/naruto.jpg'),
('Death Note', 'Thriller psicológico', 4, 'http://exemplo.com/stream/deathnote', 'http://exemplo.com/covers/deathnote.jpg');

-- Inserindo conteúdo de Desenhos
INSERT INTO cartoon_content (name, description, category_id, stream_url, cover_url) VALUES 
('Bob Esponja', 'Aventuras do Bob Esponja e seus amigos', 2, 'http://exemplo.com/stream/bob', 'http://exemplo.com/covers/bob.jpg'),
('Peppa Pig', 'Desenho educativo para crianças', 1, 'http://exemplo.com/stream/peppa', 'http://exemplo.com/covers/peppa.jpg'),
('Ben 10', 'Menino que pode se transformar em alienígenas', 7, 'http://exemplo.com/stream/ben10', 'http://exemplo.com/covers/ben10.jpg'),
('Gravity Falls', 'Mistérios e aventuras em Gravity Falls', 5, 'http://exemplo.com/stream/gravity', 'http://exemplo.com/covers/gravity.jpg');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
