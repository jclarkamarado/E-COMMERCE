<?php
declare(strict_types=1);

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/lib/helpers.php';
require_once __DIR__ . '/lib/auth.php';
require_once __DIR__ . '/lib/google_oauth.php';
require_once __DIR__ . '/views/layout.php';

$route = (string)($_GET['route'] ?? 'shop.list');

if ($route === 'home') {
    $route = 'shop.list';
}

if (str_starts_with($route, 'auth.')) {
    require __DIR__ . '/routes/auth.php';
} elseif (str_starts_with($route, 'admin.')) {
    require __DIR__ . '/routes/admin.php';
} elseif (str_starts_with($route, 'cart.')) {
    require __DIR__ . '/routes/cart.php';
} elseif (str_starts_with($route, 'orders.')) {
    require __DIR__ . '/routes/orders.php';
} elseif (str_starts_with($route, 'profile.')) {
    require __DIR__ . '/routes/profile.php';
} else {
    require __DIR__ . '/routes/shop.php';
}