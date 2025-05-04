#!/bin/bash

# Criar o banco de dados
docker exec osflix-db mysql -u root -proot -e "CREATE DATABASE IF NOT EXISTS osflix;"

# Executar o script SQL
cat > /tmp/setup.sql << 'EOL'
USE osflix;

-- Tabela de usuários
CREATE TABLE IF NOT EXISTS `users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(255) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `level` int(2) NOT NULL DEFAULT '1',
  `uuid` varchar(255) NOT NULL,
  `reset_token` varchar(64) DEFAULT NULL,
  `reset_token_expires` datetime DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabela de configuração do Xtream
CREATE TABLE IF NOT EXISTS `xtream` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(500) NOT NULL,
  `user` varchar(500) NOT NULL,
  `pass` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabela de cache
CREATE TABLE IF NOT EXISTS `cache_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_video` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `img` varchar(1500) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_video` (`id_video`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Tabela de favoritos
CREATE TABLE IF NOT EXISTS `favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_video` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Tabela de assistidos
CREATE TABLE IF NOT EXISTS `watched` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL DEFAULT '0',
  `id_video` int(11) NOT NULL DEFAULT '0',
  `id_ep` int(11) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `checkpoint` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Inserindo usuário padrão
INSERT IGNORE INTO `users` (`id_user`, `login`, `pass`, `name`, `email`, `level`, `uuid`) VALUES
(1, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrador', 'admin@osflix.com', 10, 'd15225ff-f4d8-4454-8922-ed5e6014ff8c');

-- Inserindo configuração padrão do Xtream
INSERT IGNORE INTO `xtream` (`id`, `url`, `user`, `pass`) VALUES
(1, '', '', '');
EOL

# Copiar o arquivo SQL para o container
docker cp /tmp/setup.sql osflix-db:/tmp/setup.sql

# Executar o script SQL
docker exec osflix-db mysql -u root -proot < /tmp/setup.sql

# Verificar as tabelas criadas
docker exec osflix-db mysql -u root -proot -e "USE osflix; SHOW TABLES;" 