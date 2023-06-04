<?php 
$total = 0;
$qry = $conn->query("SELECT c.*, p.title, i.price, p.id as pid FROM `cart` c INNER JOIN `inventory` i ON i.id = c.inventory_id INNER JOIN products p ON p.id = i.product_id WHERE c.client_id = ".$_settings->userdata('id'));

while ($row = $qry->fetch_assoc()) {
    $quantity = $row['quantity'];
    $price = $row['price'];
    $subtotal = $price * $quantity;
    $total += $subtotal;
    $product = $row['title'];

    $products[] = array(
        'product' => $product,
        'quantity' => $quantity,
        'price' => $price,
        'subtotal' => $subtotal
    );
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
            <div class="card-body">
                <h3 class="text-center"><b>Payment Successful</b></h3>

                <div class="receipt-details">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($products as $product): ?>
                                <tr>
                                    <td><?php echo $product['product']; ?></td>
                                    <td><?php echo $product['quantity']; ?></td>
                                    <td><?php echo $product['price']; ?></td>
                                    <td><?php echo $product['subtotal']; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>

                <div class="total-section">
                    <h4><b>Total: <?php echo number_format($total); ?></b></h4>
                </div>

                <hr>

                <form action="public/payment.php" id="place_order" method="POST">
                    <input type="hidden" name="amount" value="<?php echo $total ?>">
                    <input type="hidden" name="products" value="<?php echo htmlspecialchars(json_encode($products)) ?>">
                    <input type="hidden" name="payment_method" value="card">
                    <input type="hidden" name="paid" value="1">

                    <div class="row row-col-1 justify-content-center">
                        <div class="col-6">
                            <div class="form-group col mb-0">
                                <label for="" class="control-label">Order Type</label>
                            </div>
                            <div class="form-group d-flex pl-2">
                                <?php if ($_SESSION['order_type'] == 2) : ?>
                                    <div class="custom-control custom-radio">
                                        <input class="custom-control-input custom-control-input-primary" type="radio" id="customRadio4" name="order_type" value="2" checked>
                                        <label for="customRadio4" class="custom-control-label">For Delivery</label>
                                    </div>
                                    <div class="custom-control custom-radio ml-3">
                                        <input class="custom-control-input custom-control-input-primary custom-control-input-outline" type="radio" id="customRadio5" name="order_type" value="1" disabled>
                                        <label for="customRadio5" class="custom-control-label">For Pick up</label>
                                    </div>
                                <?php else :?>
                                    <div class="custom-control custom-radio">
                                        <input class="custom-control-input custom-control-input-primary" type="radio" id="customRadio4" name="order_type" value="2" disabled>
                                        <label for="customRadio4" class="custom-control-label">For Delivery</label>
                                    </div>
                                    <div class="custom-control custom-radio ml-3">
                                        <input class="custom-control-input custom-control-input-primary custom-control-input-outline" type="radio" id="customRadio5" name="order_type" value="1" checked>
                                        <label for="customRadio5" class="custom-control-label">For Pick up</label>
                                    </div>
                                <?php endif; ?>
                            </div>
                            <div class="form-group col address-holder">
                                <label for="" class="control-label">Delivery Address</label>
                                <textarea id="" cols="30" rows="3" name="delivery_address" class="form-control" style="resize:none" readonly><?php echo $_SESSION['delivery_address']; session_abort()?></textarea>
                            </div>
                            <div class="col my-3">
                                <div class="d-flex w-100 justify-content-between">
                                <button class="btn btn-flat btn-dark" style="background-color: green; border-color: green; color: white;">Complete Transaction</button>
                                    <span id="paypal-button"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<script>
    function payment_online(){
        $('[name="payment_method"]').val("Online Payment")
        $('[name="paid"]').val(1)
        $('#place_order').submit()
    }

    $(function(){
        $('[name="order_type"]').change(function(){
            if($(this).val() ==2){
                $('.address-holder').hide('slow')
            }else{
                $('.address-holder').show('slow')
            }
        })
        $('#place_order').submit(function(e){
            e.preventDefault()
            start_loader();
            $.ajax({
                url:'classes/Master.php?f=place_order',
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
</script>