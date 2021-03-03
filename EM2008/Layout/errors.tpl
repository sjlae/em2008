<?php if($this->errors != null && count($this->errors) > 0): ?>
<section class="content-info info-container">

	<div class="container paddings-mini">
		<div class="row">

			<div class="col-lg-12">
				<!-- Content Text-->
				<div class="panel-box">
					<div class="titles error">
						<h4>Fehler</h4>
					</div>


					<!-- Post Item -->
					<div class="post-item">
						<ul>
							<?php foreach($this->errors as $error):?>
							<li><?php echo $error; ?></li>
							<?php endforeach ?>
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