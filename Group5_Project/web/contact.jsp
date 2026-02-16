<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="image/favicon.png" type="image/png">
        <title>Royal Hotel</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="vendors/linericon/style.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="vendors/bootstrap-datepicker/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" href="vendors/nice-select/css/nice-select.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
        <!-- main css -->
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">
    </head>
    <body>
        <!--================Header Area =================-->
        <!--================Header Area =================-->
        <header class="header_area">
            <div class="container">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <a class="navbar-brand logo_h" href="loadtohome"><img src="image/Logo.png" alt=""></a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
                        <ul class="nav navbar-nav menu_nav ml-auto">
                            <li class="nav-item ${pageContext.request.requestURI.endsWith('index.jsp') ? 'active' : ''}">
                                <a class="nav-link" href="loadtohome">Home</a>
                            </li>
                            <li class="nav-item ${pageContext.request.requestURI.endsWith('about.jsp') ? 'active' : ''}">
                                <a class="nav-link" href="about.jsp">About us</a>
                            </li>
                            <li class="nav-item ${pageContext.request.requestURI.endsWith('accomodation.jsp') ? 'active' : ''}">
                                <a class="nav-link" href="searchtohome">Accomodation</a>
                            </li>
                            <li class="nav-item ${pageContext.request.requestURI.endsWith('booking-dep.jsp') ? 'active' : ''}">
                                <a class="nav-link" href="bookingguest">Booking</a>
                            </li>
                            <li class="nav-item submenu dropdown ${pageContext.request.requestURI.endsWith('blog.jsp') || pageContext.request.requestURI.endsWith('blog-single.jsp') ? 'active' : ''}">
                                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Blog</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item ${pageContext.request.requestURI.endsWith('blog-single.jsp') ? 'active' : ''}">
                                        <a class="nav-link" href="blog-single.jsp">Blog Details</a>
                                    </li>
                                    <li class="nav-item ${pageContext.request.requestURI.endsWith('gallery.jsp') ? 'active' : ''}">
                                        <a class="nav-link" href="gallery.jsp">Gallery</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item ${pageContext.request.requestURI.endsWith('elements.jsp') ? 'active' : ''}">
                                <a class="nav-link" href="elements.jsp">History</a>
                            </li>
                            <li class="nav-item ${pageContext.request.requestURI.endsWith('contact.jsp') ? 'active' : ''}">
                                <a class="nav-link" href="contact.jsp">Contact</a>
                            </li>

                            <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                <li class="nav-item submenu dropdown ${pageContext.request.requestURI.endsWith('admin.jsp') ? 'active' : ''}">
                                    <a href="crudASG.jsp" class="nav-link dropdown-toggle" role="button" aria-haspopup="true" aria-expanded="false">Admin ${sessionScope.acc.username}</a>
                                </li> 
                            </c:if>

                            <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Staff'}">
                                <li class="nav-item submenu dropdown ${pageContext.request.requestURI.endsWith('staff.jsp') ? 'active' : ''}">
                                    <a href="crudASG.jsp" class="nav-link dropdown-toggle" role="button" aria-haspopup="true" aria-expanded="false">Staff ${sessionScope.acc.username}</a>
                                </li> 
                            </c:if>

                            <c:if test="${sessionScope.acc == null}">
                                <li class="nav-item ${pageContext.request.requestURI.endsWith('login.jsp') ? 'active' : ''}">
                                    <a class="nav-link" href="login.jsp">Login</a>
                                </li>
                            </c:if>
                            <c:if test="${sessionScope.acc != null}">
                                <li class="nav-item">
                                    <form action="" method="" style="display:inline;">
                                        <button type="submit" name="logout" class="btn btn-link nav-link" style="border:none; background:none; padding:0;">
                                            Logout
                                        </button>
                                    </form>
                                </li>
                            </c:if>
                            <%
                                if (request.getParameter("logout") != null) {
                                    session.invalidate(); // Hủy session
                                    response.sendRedirect("login.jsp"); // Chuyển hướng về trang đăng nhập
                                }
                            %>
                        </ul>
                    </div> 
                </nav>
            </div>
        </header>
        <!--================Header Area =================-->

        <!--================Breadcrumb Area =================-->
        <section class="breadcrumb_area">
            <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
            <div class="container">
                <div class="page-cover text-center">
                    <h2 class="page-cover-tittle">Contact Us</h2>
                    <ol class="breadcrumb">
                        <li><a href="index.jsp">Home</a></li>
                        <li class="active">Contact Us</li>
                    </ol>
                </div>
            </div>
        </section>
        <!--================Breadcrumb Area =================-->

        <!--================Contact Area =================-->
        <section class="contact_area section_gap">
            <div class="container">
<!--            <div id="mapBox" class="mapBox"
                 data-lat="21.00747"
                 data-lon="105.78288"
                 data-zoom="13"
                 data-info="JW Marriott Hotel Hanoi, 8 Đỗ Đức Dục, Mễ Trì, Nam Từ Liêm, Hà Nội, Việt Nam."
                 data-mlat="21.00747"
                 data-mlon="105.78288">
            </div>-->

            <iframe
              width="100%"
              height="400"
              frameborder="0"
              scrolling="no"
              marginheight="0"
              marginwidth="0"
              src="https://www.openstreetmap.org/export/embed.html?bbox=105.779%2C21.004%2C105.787%2C21.011&layer=mapnik&marker=21.0075%2C105.783">
            </iframe>
            <br/>
            <small>
              <a href="https://www.openstreetmap.org/?mlat=21.0075&mlon=105.783#map=15/21.0075/105.783">
                Xem bản đồ lớn hơn
              </a>
            </small>

            <div class="row">
              <div class="col-md-3">
                <div class="contact_info">
                  <div class="info_item">
                    <i class="lnr lnr-home"></i>
                    <h6>Hà Nội, Việt Nam</h6>
                    <p>JW Marriott Hotel Hanoi<br>8 Đỗ Đức Dục, Mễ Trì, Nam Từ Liêm</p>
                  </div>
                  <div class="info_item">
                    <i class="lnr lnr-phone-handset"></i>
                    <h6><a href="tel:+842438338888">(+84) 24 3833 8888</a></h6>
                    <p>Mở cửa 24/7</p>
                  </div>
                  <div class="info_item">
                    <i class="lnr lnr-envelope"></i>
                    <h6><a href="mailto:info@jwmarriotthanoi.com">info@jwmarriotthanoi.com</a></h6>
                    <p>Liên hệ với chúng tôi bất cứ lúc nào!</p>
                  </div>
                </div>
              </div>
            </div>

<!--                    <div class="col-md-9">
                        <form class="row contact_form" action="contact_process.php" method="post" id="contactForm" novalidate="novalidate">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name">
                                </div>
                                <div class="form-group">
                                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter email address">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" id="subject" name="subject" placeholder="Enter Subject">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <textarea class="form-control" name="message" id="message" rows="1" placeholder="Enter Message"></textarea>
                                </div>
                            </div>
                            <div class="col-md-12 text-right">
                                <button type="submit" value="submit" class="btn theme_btn button_hover">Send Message</button>
                            </div>
                        </form>
                    </div>-->
                </div>
            </div>
        </section>
        <!--================Contact Area =================-->

        <!--================ start footer Area  =================-->	
        <footer class="footer-area section_gap">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3  col-md-6 col-sm-6">
                        <div class="single-footer-widget">
                            <h6 class="footer_title">About Agency</h6>
                            <p>The world has become so fast paced that people don’t want to stand by reading a page of information, they would much rather look at a presentation and understand the message. It has come to a point </p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="single-footer-widget">
                            <h6 class="footer_title">Navigation Links</h6>
                            <div class="row">
                                <div class="col-4">
                                    <ul class="list_style">
                                        <li><a href="#">Home</a></li>
                                        <li><a href="#">Feature</a></li>
                                        <li><a href="#">Services</a></li>
                                        <li><a href="#">Portfolio</a></li>
                                    </ul>
                                </div>
                                <div class="col-4">
                                    <ul class="list_style">
                                        <li><a href="#">Team</a></li>
                                        <li><a href="#">Pricing</a></li>
                                        <li><a href="#">Blog</a></li>
                                        <li><a href="#">Contact</a></li>
                                    </ul>
                                </div>										
                            </div>							
                        </div>
                    </div>							
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="single-footer-widget">
                            <h6 class="footer_title">Newsletter</h6>
                            <p>For business professionals caught between high OEM price and mediocre print and graphic output, </p>		
                            <div id="mc_embed_signup">
                                <form target="_blank" action="https://spondonit.us12.list-manage.com/subscribe/post?u=1462626880ade1ac87bd9c93a&amp;id=92a4423d01" method="get" class="subscribe_form relative">
                                    <div class="input-group d-flex flex-row">
                                        <input name="EMAIL" placeholder="Email Address" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email Address '" required="" type="email">
                                        <button class="btn sub-btn"><span class="lnr lnr-location"></span></button>		
                                    </div>									
                                    <div class="mt-10 info"></div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="single-footer-widget instafeed">
                            <h6 class="footer_title">InstaFeed</h6>
                            <ul class="list_style instafeed d-flex flex-wrap">
                                <li><img src="image/instagram/Image-01.jpg" alt=""></li>
                                <li><img src="image/instagram/Image-02.jpg" alt=""></li>
                                <li><img src="image/instagram/Image-03.jpg" alt=""></li>
                                <li><img src="image/instagram/Image-04.jpg" alt=""></li>
                                <li><img src="image/instagram/Image-05.jpg" alt=""></li>
                                <li><img src="image/instagram/Image-06.jpg" alt=""></li>
                                <li><img src="image/instagram/Image-07.jpg" alt=""></li>
                                <li><img src="image/instagram/Image-08.jpg" alt=""></li>
                            </ul>
                        </div>
                    </div>						
                </div>
                <div class="border_line"></div>
                <div class="row footer-bottom d-flex justify-content-between align-items-center">
                    <p class="col-lg-8 col-sm-12 footer-text m-0"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved  <i class="fa fa-heart-o" aria-hidden="true"></i> <a href="https://colorlib.com" target="_blank"></a>
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                    <div class="col-lg-4 col-sm-12 footer-social">
                        <a href="#"><i class="fa fa-facebook"></i></a>
                        <a href="#"><i class="fa fa-twitter"></i></a>
                        <a href="#"><i class="fa fa-dribbble"></i></a>
                        <a href="#"><i class="fa fa-behance"></i></a>
                    </div>
                </div>
            </div>
        </footer>
        <!--================ End footer Area  =================-->


        <!--================Contact Success and Error message Area =================-->
        <div id="success" class="modal modal-message fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <i class="fa fa-close"></i>
                        </button>
                        <h2>Thank you</h2>
                        <p>Your message is successfully sent...</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modals error -->

        <div id="error" class="modal modal-message fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <i class="fa fa-close"></i>
                        </button>
                        <h2>Sorry !</h2>
                        <p> Something went wrong </p>
                    </div>
                </div>
            </div>
        </div>
        <!--================End Contact Success and Error message Area =================-->


        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
        <script src="js/jquery.ajaxchimp.min.js"></script>
        <script src="vendors/bootstrap-datepicker/bootstrap-datetimepicker.min.js"></script>
        <script src="vendors/nice-select/js/jquery.nice-select.js"></script>
        <script src="js/mail-script.js"></script>
        <script src="js/stellar.js"></script>
        <script src="vendors/imagesloaded/imagesloaded.pkgd.min.js"></script>
        <script src="vendors/isotope/isotope-min.js"></script>
        <script src="js/stellar.js"></script>
        <script src="vendors/lightbox/simpleLightbox.min.js"></script>
        <!--gmaps Js-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCjCGmQ0Uq4exrzdcL6rvxywDDOvfAu6eE"></script>
        <script src="js/gmaps.min.js"></script>
        <!-- contact js -->
        <script src="js/jquery.form.js"></script>
        <script src="js/jquery.validate.min.js"></script>
        <script src="js/contact.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>