

            <!DOCTYPE html>
            <html lang="en">
            <head>
                <!-- Basic -->
                <meta charset="utf-8">
                <title>Das ultimative <WM-Tippspiel></WM-Tippspiel></title>
                <meta name="keywords" content="HTML5 Template" />
                <meta name="description" content="SportsCup - Bootstrap 4 Theme for Sports">
                <meta name="author" content="iwthemes.com">

                <!-- Mobile Metas -->
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
                <!-- Theme CSS -->
                <link href="assets/css/main.css" rel="stylesheet" media="screen">

                <!-- Favicons -->
                <link rel="shortcut icon" href="img/icons/favicon.ico">
                <link rel="apple-touch-icon" href="img/icons/apple-touch-icon.png">
                <link rel="apple-touch-icon" sizes="72x72" href="img/icons/apple-touch-icon-72x72.png">
                <link rel="apple-touch-icon" sizes="114x114" href="img/icons/apple-touch-icon-114x114.png">
            </head>

            <body>

            <!-- layout-->
            <div id="layout">
                <!-- Header-->
                <header class="header-3">
                    <!-- End headerbox-->
                    <div class="headerbox">
                        <div class="container">
                            <div class="row justify-content-between align-items-center">
                                <!-- Logo-->
                                <div class="col col-xl-12 text-center">
                                    <div class="logo">
                                        <a href="index.html" title="Return Home">
                                            <img src="img/logo_2.png" alt="Logo" class="logo_img">
                                        </a>
                                    </div>
                                </div>
                                <!-- End Logo-->

                                <!-- Adds Header-->
                                <div class="col col-xl-12">
                                    <!-- Call Nav Menu-->
                                    <a class="mobile-nav" href="#mobile-nav"><i class="fa fa-bars"></i></a>
                                    <!-- End Call Nav Menu-->
                                </div>
                                <!-- End Adds Header-->
                            </div>
                        </div>
                    </div>
                    <!-- End headerbox-->
                    <?php
            		include ('Menu/Menu.php');
            		$menu = new Menu();
            		include($menu->getMenu());
                    ?>
