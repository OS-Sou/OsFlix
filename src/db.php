<?php

class Conn {

    public static $instance;

    private function __construct() {
        //
    }
 
    public static function getInstance() {
        $host = 'localhost'; // Host do banco no aapanel
        $dbname = 'sql_osflix_facil';
        $user = 'sql_osflix_facil';
        $pass = 'ZHhtfGHaSs8y4YTS';

        if (!isset(self::$instance)) {
            try {
                self::$instance = new PDO(
                    'mysql:host='.$host.';dbname='.$dbname,
                    $user,
                    $pass,
                    array(
                        PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8",
                        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
                    )
                );
            } catch (PDOException $e) {
                error_log("Erro de conexão: " . $e->getMessage());
                throw new Exception("Erro ao conectar ao banco de dados");
            }
        }

        return self::$instance;
    }
}

?>