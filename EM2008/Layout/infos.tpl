<?php if(count($_SESSION['infos']) > 0): ?>
<section class="content-info info-container">

	<div class="container paddings-mini">
		<div class="row">

			<div class="col-lg-12">
				<!-- Content Text-->
				<div class="panel-box">
					<div class="titles_info">
						<h5>Info</h5>
					</div>

					<!-- Post Item -->
					<div class="post-item">
						<ul>
							<?php foreach($_SESSION['infos'] as $info):?>
							<li><?php echo $info; ?></li>
							<?php endforeach ?>
							<?php unset($_SESSION['infos']); ?>
						</ul>
					</div>
					<!-- End Post Item -->

				</div>
				<!-- End Content Text-->
			</div>
		</div>
	</div>
</section>
<?php endif?>