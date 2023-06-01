<?php
$total = 0;

$qry = $conn->query("SELECT c.*, p.title, i.price, p.id as pid FROM `cart` c INNER JOIN `inventory` i ON i.id = c.inventory_id INNER JOIN products p ON p.id = i.product_id WHERE c.client_id = ".$_settings->userdata('id'));

$productList = ''; // Initialize an empty string to store the list of products

while ($row = $qry->fetch_assoc()) {
    $quantity = $row['quantity'];
    $price = $row['price'];
    $subtotal = $price * $quantity; // Calculate the subtotal price by multiplying the price and quantity of each item
    $total += $subtotal; // Add the subtotal to the total variable
    $product = $row['title'];

    $products[] = array(
        'product' => $product,
        'quantity' => $quantity,
        'price' => $price,
    );

    $productList .= '<div><p><b>Product:</b> ' . $row['title'] . '</p><p><b>Quantity:</b> ' . $row['quantity'] . '</p><p><b>Price per unit:</b> ' . number_format($row['price']) . '</p><p><b>Subtotal:</b> ' . number_format($subtotal) . '</p></div>'; // Concatenate the product details to the $productList variable
}
?>

<?php
$bg_image = 'public/images/background.png';
?>
<style>
    body {
        background-image: url(<?php echo $bg_image; ?>);
        /* additional background styles */
    }
    .member-container {
        display: flex;
        justify-content: center;
    }
</style>
<section class="py-5">
    <div class="container">
        <div class="card rounded-0">
            <div class="card-body"></div>
            <h3 class="text-center"><b>Checkout</b></h3>
            <hr class="border-dark">
            <form action="public/payment.php" id="place_order" method="POST">
                <input type="hidden" name="amount" value="<?php echo $total ?>">
                <input type="hidden" name="products" value="<?php echo htmlspecialchars(json_encode($products)) ?>">
                <input type="hidden" name="payment_method" value="card">
                <input type="hidden" name="paid" value="0">
                <div class="row row-col-1 justify-content-center">
                    <div class="col-6">
                        <div class="form-group col mb-0">
                            <label for="" class="control-label">Order Type</label>
                        </div>
                        <div class="form-group d-flex pl-2">
                            <div class="custom-control custom-radio">
                                <input class="custom-control-input custom-control-input-primary" type="radio" id="customRadio4" name="order_type" value="2" checked="">
                                <label for="customRadio4" class="custom-control-label">For Delivery</label>
                            </div>
                            <div class="custom-control custom-radio ml-3">
                                <input class="custom-control-input custom-control-input-primary custom-control-input-outline" type="radio" id="customRadio5" name="order_type" value="1">
                                <label for="customRadio5" class="custom-control-label">For Pick up</label>
                            </div>
                        </div>
                        <div class="form-group col address-holder">
                            <label for="" class="control-label">Delivery Address</label>
                            <textarea id="" cols="30" rows="3" name="delivery_address" class="form-control" style="resize:none"><?php echo $_settings->userdata('default_delivery_address') ?></textarea>
                        </div>
                        <!-- Product List -->
                        <div class="col">
                            <h4><b>Products</b></h4>
                            <div class="card">
                                <div class="card-body">
                                    <?php echo $productList; ?>
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <span><h4><b>Total:</b> <?php echo number_format($total) ?></h4></span>
                        </div>
                        <hr>
                        <div class="col my-3">
                            <h4 class="text-muted">Payment Method</h4>
                            <div class="d-flex w-100 justify-content-between align-items-center">
                                <button class="btn btn-flat btn-success">Pay With Stripe</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
