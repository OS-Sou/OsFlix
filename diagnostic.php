<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "<h1>Diagnóstico do Sistema</h1>";

// Verificar extensões PHP
echo "<h2>Extensões PHP</h2>";
echo "<pre>";
print_r(get_loaded_extensions());
echo "</pre>";

// Verificar variáveis de ambiente
echo "<h2>Variáveis de Ambiente</h2>";
echo "<pre>";
print_r($_ENV);
echo "</pre>";

// Testar conexão com banco
echo "<h2>Teste de Conexão com Banco</h2>";
try {
    $host = 'osflix-db';
    $dbname = 'osflix';
    $user = 'root';
    $pass = 'root';
    
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Conexão com banco de dados estabelecida com sucesso!";
    
    // Testar consulta
    $stmt = $pdo->query("SHOW TABLES");
    echo "<br>Tabelas no banco:<br>";
    while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        print_r($row);
        echo "<br>";
    }
} catch(PDOException $e) {
    echo "Erro na conexão: " . $e->getMessage();
}

// Verificar permissões de diretório
echo "<h2>Permissões de Diretório</h2>";
echo "Document Root: " . $_SERVER['DOCUMENT_ROOT'] . "<br>";
echo "Script filename: " . __FILE__ . "<br>";
echo "Permissões deste arquivo: " . substr(sprintf('%o', fileperms(__FILE__)), -4) . "<br>";
echo "Diretório atual: " . getcwd() . "<br>";
?> 