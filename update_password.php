<?php
require_once 'src/db.php';

$pdo = Conn::getInstance();
$password = '123';
$hash = password_hash($password, PASSWORD_BCRYPT);

$sql = "UPDATE users SET pass = ? WHERE login = 'admin'";
$stmt = $pdo->prepare($sql);
$result = $stmt->execute([$hash]);

if ($result) {
    echo "Senha atualizada com sucesso!\n";
    echo "Hash: " . $hash . "\n";
} else {
    echo "Erro ao atualizar senha.\n";
}
?> 