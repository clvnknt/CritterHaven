<?php
$bg_image = 'images/bg_1.png';
?>
<style>
    body {
        background-image: url(<?php echo $bg_image; ?>);
        /* additional background styles */
    }
</style>

<section class="py-5">
    <div class="container">
        <div class="card rounded-0">
            <div class="card-body">
                <?php include "about.html" ?>
                <div class="container">
                <div style="text-align: center">
  <h2>Members</h2>
</div>
    <div class="row">
      <div class="col-md-3 mb-3">
        <div class="card text-center">
          <img src="images/member1.jpg" class="card-img" alt="Member 1" width="300" height="300">
          <div class="card-body">
            <h5 class="card-title mb-0">Miguel Carl Basilio</h5>
          </div>
        </div>
      </div>
      <div class="col-md-3 mb-3">
        <div class="card text-center">
          <img src="images/member2.jpg" class="card-img" alt="Member 2" width="300" height="300">
          <div class="card-body">
            <h5 class="card-title mb-0">Jesel Aurvic S. De Jesus</h5>
          </div>
        </div>
      </div>
      <div class="col-md-3 mb-3">
        <div class="card text-center">
          <img src="images/member3.jpg" class="card-img" alt="Member 3" width="300" height="300">
          <div class="card-body">
            <h5 class="card-title mb-0">Jello P. Mangune</h5>
          </div>
        </div>
      </div>
      <div class="col-md-3 mb-3">
        <div class="card text-center">
          <img src="images/member4.jpg" class="card-img" alt="Member 4" width="300" height="300">
          <div class="card-body">
            <h5 class="card-title mb-0">Ryan Matthew Masaqnue</h5>
          </div>
        </div>
      </div>
      <div class="col-md-3 mb-3">
        <div class="card text-center">
          <img src="images/member5.jpg" class="card-img" alt="Member 5" width="300" height="300">
          <div class="card-body">
            <h5 class="card-title mb-0">Calvin Kent R. Pamandanan</h5>
          </div>
        </div>
      </div>
    </div>
  </div>
            </div>
        </div>
    </div>
</section>
