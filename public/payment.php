<?php
include 'shared.php';
$amount = $_POST['amount'] * 100;
$order_type = $_POST['order_type'];
$paid = 1;
$delivery_address = $_POST['delivery_address'];
session_start();
$_SESSION['delivery_address'] = $delivery_address;
$_SESSION['order_type'] = $order_type;
$products = json_decode($_POST['products'], true);
$metadata = [
  'order_id' => 'Order ID #231789348SIA',
];

for ($i = 0; $i < count($products); $i++) {
  $productKey = 'product' . ($i + 1);
  $product = $products[$i]['product'];
  $quantity = $products[$i]['quantity'];
  $price = $products[$i]['price'];
  
  $metadata[$productKey] = $product;
  $metadata[$productKey . '_quantity'] = $quantity;
  $metadata[$productKey . '_price'] = $price;
  $metadata['total'] = $amount;
  $metadata['order_type'] = $order_type;
  $metadata['delivery_address'] = $delivery_address;
}

try {
  $currency = "PHP";
  $paymentIntent = $stripe->paymentIntents->create([
    'automatic_payment_methods' => ['enabled' => true],
    'amount' => $amount,
    'currency' => $currency,
    'metadata'=> $metadata

  ]);
} catch (\Stripe\Exception\ApiErrorException $e) {
  http_response_code(400);
  error_log($e->getError()->message);
?>
  <h1>Error</h1>
  <p>Your Payment Intent failed</p>
  <p>Please try again!</p>
<?php
  exit;
} catch (Exception $e) {
  error_log($e);
  http_response_code(500);
  exit;
}
?>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Payment</title>
    <script src="https://js.stripe.com/v3/"></script>
    <link rel="stylesheet" href="css/bases.css" />
    <script src="utils2.js"></script>
    <script>


      document.addEventListener('DOMContentLoaded', async () => {
        const stripe = Stripe('<?= $_ENV["STRIPE_PUBLISHABLE_KEY"]; ?>', {
          apiVersion: '2022-11-15',
        });

        const elements = stripe.elements({
          clientSecret: '<?= $paymentIntent->client_secret; ?>', appearance,
        });

        const linkAuthenticationElement = elements.create("linkAuthentication");
        linkAuthenticationElement.mount("#link-authentication-element");

        const addressElement = elements.create("address", {
        mode: "shipping",
        });
        addressElement.mount("#address-element");

        const paymentElement = elements.create('payment');
        paymentElement.mount('#payment-element');



        const paymentForm = document.querySelector('#payment-form');
        paymentForm.addEventListener('submit', async (e) => {
          // Avoid a full page POST request.
          e.preventDefault();

          // Disable the form from submitting twice.
          paymentForm.querySelector('button').disabled = true;

          // Confirm the card payment that was created server side:
          const {error} = await stripe.confirmPayment({
            elements,
            confirmParams: {
              return_url: `${window.location.origin}/CritterHaven/?p=finish`
            }
          });
          if(error) {
            addMessage(error.message);

            // Re-enable the form so the customer can resubmit.
            paymentForm.querySelector('button').disabled = false;
            return;
          }
          
        });
        function payment_online(){
            $('[name="payment_method"]').val("Online Payment")
            $('[name="paid"]').val(1)
            $('#payment-form').submit()
        }

        $(function(){
            $('[name="order_type"]').change(function(){
                if($(this).val() ==2){
                    $('.address-holder').hide('slow')
                }else{
                    $('.address-holder').show('slow')
                }
            })
            $('#payment-form').submit(function(e){
                e.preventDefault()
                start_loader();
                $.ajax({
                    url:'../classes/Master.php?f=place_order',
                    method:'POST',
                    data:$(this).serialize(),
                    dataType:"json",
                    error:err=>{
                        console.log(err)
                        alert_toast("an error occured","error")
                        end_loader();
                    },
                    success:function(resp){
                        if(!!resp.status && resp.status == 'success'){
                            alert_toast("Order Successfully placed.","success")
                            setTimeout(function(){
                                location.replace('./')
                            },2000)
                        }else{
                            console.log(resp)
                            alert_toast("an error occured","error")
                            end_loader();
                        }
                    }
                })
            })
        })





      });
    </script>
  </head>
  <body style="background-color:white;">
    <main>
      <h1 style="color: black;"><center>Pay With Stripe</center></h1>

      <form id="payment-form" method="POST" >

        <input type="hidden" name="amount" value="<?php echo $amount ?>">
        <input type="hidden" name="order_type" value="<?php echo $order_type ?>">
        <input type="hidden" name="delivery_address" value="<?php echo $delivery_address ?>">
        <input type="hidden" name="paid" value="<?php echo $paid ?>">

        <label style="color: white;" for="payment-element"><b>Contact Information</b></label>
        <div id="link-authentication-element">
        <!--Stripe.js injects the Link Authentication Element-->
        </div>
        <label style="color: white;" for="payment-element"><b>Billing Address</b></label>
        <div id="address-element">
        <!-- Elements will create form elements here -->
        </div>
        <label style="color: white;" for="payment-element"><b>Card Information</b></label>
        <div id="payment-element">
          <!-- Elements will create input elements here -->
        </div>

        <!-- We'll put the error messages in this element -->
        <div id="payment-errors" role="alert"></div>
        <center>
        <button type="submit" id="submit" style="width: 437px;">
  Pay Now
</button>
</center>
<center>
<a href="../index.php?p=checkout" style="background-color: black; color: white; width: 400px; display: inline-block; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Back</a>

</center>


      </form>

      <div id="messages" role="alert" style="display: none;"></div>
      
    </main>
    
  </body>
</html>