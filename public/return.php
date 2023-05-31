<?php
require_once 'shared.php';
require_once('../config.php');

// Returning after redirecting to a payment method portal.
$paymentIntent = $stripe->paymentIntents->retrieve(
   $_GET['payment_intent'],
);
$myJSON = json_encode($paymentIntent);
?>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Payment Intent</title>
    <link rel="stylesheet" href="css/success.css" />
    <script src="https://js.stripe.com/v3/"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
      document.addEventListener('DOMContentLoaded', function() {
      // Make an AJAX request to execute the place_order method
      var xhr = new XMLHttpRequest();
      xhr.open('GET', 'path/to/master.php?f=place_order', true);
      xhr.onload = function() {
        if (xhr.status >= 200 && xhr.status < 400) {
          var response = JSON.parse(xhr.responseText);
          if (response.status === 'success') {
            // Order placed successfully
            // Handle the success case
          } else {
            // Order placement failed
            // Handle the failure case
          }
        } else {
          // Error occurred
          // Handle the error case
        }
      };
      xhr.onerror = function() {
        // Error occurred
        // Handle the error case
      };
      xhr.send();
    });
    </script>

  </head>
  <body style="background-color:#1A1F36;">
    <main>

      <div class="card"> 
  <div class="header"> 
    <div class="image">
      <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M20 7L9.00004 18L3.99994 13" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
      </div> 
      <div class="content">
         <span class="title">Payment Successful</span> 
         #<p class="message"><?= $myJSON?>;</p> 
      </div> 
         <div class="actions">
            <a href="https://gmail.com/"><button class="history" type="button">Check Email</button></a>
            <a href="../index.php"><button class="track">Back</button></a>
            </div> 
            </div> 
            </div>
            
    </main>
  </body>
 
</html>