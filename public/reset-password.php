<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Redefinir Senha - ÓSFLIX</title>
    <link rel="stylesheet" href="/assets/css/bootstrap-reboot.min.css">
    <link rel="stylesheet" href="/assets/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="/assets/css/main.css">
</head>
<body class="body">
    <div class="sign section--bg" data-bg="/assets/img/section/section.jpg">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="sign__content">
                        <form action="/reset-password" method="post" class="sign__form">
                            <a href="/" class="sign__logo">
                                <img src="/assets/img/logo.png" alt="">
                            </a>

                            <span class="success_form"><?= $success ?? '' ?></span>
                            <span class="error_form"><?= $error ?? '' ?></span>

                            <input type="hidden" name="token" value="<?= $token ?>">

                            <div class="sign__group">
                                <input name="password" type="password" class="sign__input" placeholder="Nova senha">
                            </div>

                            <div class="sign__group">
                                <input name="confirm_password" type="password" class="sign__input" placeholder="Confirmar nova senha">
                            </div>

                            <button type="submit" class="sign__btn">Redefinir Senha</button>

                            <span class="sign__text">
                                Lembrou sua senha? <a href="/login">Faça login</a>
                            </span>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 