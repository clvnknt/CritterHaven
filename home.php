<?php
$bg_image = 'public/images/background.png';
?>
<style>
    body {
        background-image: url(<?php echo $bg_image; ?>);
        /* additional background styles */
    }
</style>
<!-- Header-->
<header class="bg-dark py-5" id="main-header">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">CritterHaven</h1>
            <p class="lead fw-normal text-white mb-0">"Pamper your furry friends with CritterHaven's high-quality accessories for dogs and cats. Shop now and show your pets some love!"</p>
            <br>
            <a href=".?p=products" class="btn btn-primary" role="button">Shop Now!</a>
        </div>
    </div>
</header>

<!-- Section-->
<section class="py-5">
    <div class="container px-4 px-lg-5 mt-5">
        <div class="row gx-4 gx-lg-5 row-cols-md-3 row-cols-xl-4">
            <div class="col-12">
                <!-- Products header -->
                <h2 class="fw-bolder">Some Accessories</h2>
            </div>
        </div>

        <div class="row gx-4 gx-lg-5 row-cols-md-3 row-cols-xl-4">
            <?php 
                $products = $conn->query("SELECT * FROM `products` where status = 1 order by rand() limit 8 ");
                while($row = $products->fetch_assoc()):
                    $upload_path = base_app.'/uploads/product_'.$row['id'];
                    $img = "";
                    if(is_dir($upload_path)){
                        $fileO = scandir($upload_path);
                        if(isset($fileO[2]))
                            $img = "uploads/product_".$row['id']."/".$fileO[2];
                        // var_dump($fileO);
                    }
                    foreach($row as $k=> $v){
                        $row[$k] = trim(stripslashes($v));
                    }
                    $inventory = $conn->query("SELECT * FROM inventory where product_id = ".$row['id']);
                    $inv = array();
                    while($ir = $inventory->fetch_assoc()){
                        $inv[] = number_format($ir['price']);
                    }
            ?>
            <div class="col">
                <a href=".?p=view_product&id=<?php echo md5($row['id']) ?>" class="card-link" style="text-decoration: none; color: inherit;">
                    <div class="card product-item">
                        <!-- Product image-->
                        <img class="card-img-top w-100 book-cover" src="<?php echo validate_image($img) ?>" alt="..." />
                        <!-- Product details-->
                        <div class="card-body p-4">
                            <div class="">
                                <!-- Product name-->
                                <h5 class="fw-bolder"><?php echo $row['title'] ?></h5>
                                <!-- Product price-->
                                <?php foreach($inv as $k=> $v): ?>
                                    <span><b>₱</b></span>
                                    <span><?php echo $v ?></span>
                                <?php endforeach; ?>
                            </div>
                            <p class="m-0"><small><?php echo $row['brand'] ?></small></p>
                        </div>
                    </div>
                </a>
            </div>
            <?php endwhile; ?>
        </div>
    </div>
</section>





