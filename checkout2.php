<?php
// Set your secret key. Remember to switch to your live secret key in production.
// See your keys here: https://dashboard.stripe.com/apikeys
$stripe = new \Stripe\StripeClient('sk_test_51N7v8TAb0a70xhgJPpWcRU0y228OtWVYGCieLwX36rahDrudgvT5ULhgLPp56kCTdJixjAelOXZGZrn0QiKSMgF800cWnHpxTG');

$stripe->checkout->sessions->create(
  [
    'line_items' => [
      [
        'price_data' => [
          'currency' => 'usd',
          'product_data' => ['name' => 'T-shirt'],
          'unit_amount' => 2000,
        ],
        'quantity' => 4,
      ],
    ],
    'mode' => 'payment',
    'success_url' => 'http://localhost:/CritterHaven/success.html',
    'cancel_url' => 'http://localhost:/CritterHaven/cancel.html',
  ]
);