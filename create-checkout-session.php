<?php

require 'vendor/autoload.php';

$stripe = new \Stripe\StripeClient('sk_test_51N7v8TAb0a70xhgJPpWcRU0y228OtWVYGCieLwX36rahDrudgvT5ULhgLPp56kCTdJixjAelOXZGZrn0QiKSMgF800cWnHpxTG');

$price = $_GET['amount'];

$checkout_session = $stripe->checkout->sessions->create([
  'line_items' => [[
    'price_data' => [
      'currency' => 'php',
      'product_data' => [
        'name' => 'Total Price: ',
      ],
      'unit_amount' => $price*100,
    ],
    'quantity' => 1,
  ]],
  'mode' => 'payment',
  'success_url' => 'http://localhost//CritterHaven/success.html',
  'cancel_url' => 'http://localhost/CritterHaven/?p=checkout',
]);

header("HTTP/1.1 303 See Other");
header("Location: " . $checkout_session->url);
?>