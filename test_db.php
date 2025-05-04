<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'src/db.php';

try {
    $conn = Conn::getInstance();
    echo "Conexão com o banco de dados estabelecida com sucesso!<br>";
    
    $stmt = $conn->query("SHOW TABLES");
    echo "Tabelas no banco:<br>";
    while($row = $stmt->fetch()) {
        print_r($row);
        echo "<br>";
    }
} catch (Exception $e) {
    echo "Erro: " . $e->getMessage();
}
?> 