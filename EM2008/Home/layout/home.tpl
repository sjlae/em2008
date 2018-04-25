
<!-- Section Title -->
<div class="section-title" style="background:url(img/slide/1.jpg)">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <h1>Das ultimative Tippspiel</h1>
            </div>
        </div>
    </div>
</div>
<!-- End Section Title -->
<?php require_once('Layout/infos.tpl'); ?>

<!-- Section Area - Content Central -->
<section class="content-info">

    <div class="container paddings-mini">
        <div class="row">

            <div class="col-lg-12">
                <!-- Content Text-->
                <div class="panel-box">
                    <div class="titles">
                        <h4>News</h4>
                    </div>


                    <?php foreach($this->news as $article): ?>

                    <!-- Post Item -->
                    <div class="post-item">
                                <h5><?php echo $article['title']; ?></h5>
                                <span class="data-info"><?php echo $article['date']; ?></span>
                                <p><?php echo $article['text']; ?></p>
                    </div>
                    <!-- End Post Item -->

                    <?php endforeach; ?>
                </div>
                <!-- End Content Text-->
            </div>
        </div>
    </div>
</section>
<!-- End Section Area -  Content Central -->