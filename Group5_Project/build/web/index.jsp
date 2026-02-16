<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="image/favicon1.png" type="image/png">
        <title>Royal Hotel</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="vendors/linericon/style.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
        <link rel="stylesheet" href="vendors/bootstrap-datepicker/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" href="vendors/nice-select/css/nice-select.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <!-- main css -->
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">

        <style>
            input[type="number"]::-webkit-inner-spin-button {
                background: red; /* Đổi màu nền */
                filter: invert(1); /* Đảo màu để đổi màu nút */
            }
            
        </style>
    </head>
    <body>
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
                            <li class="nav-item ${pageContext.request.requestURI.endsWith('accomodation.jsp') ? 'active' : ''}">
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
                                <a class="nav-link" href="historybookingguest">History</a>
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
                                    response.sendRedirect("index.jsp"); // Chuyển hướng về trang đăng nhập
                                }
                            %>
                        </ul>

                    </div> 
                </nav>
            </div>
        </header>
        <!--================Header Area =================-->

        <!--================Banner Area =================-->
        <section class="banner_area">
            <div class="booking_table d_flex align-items-center">
                <div class="overlay bg-parallax" data-stellar-ratio="0.9" data-stellar-vertical-offset="0" data-background=""></div>
                <div class="container">
                    <div class="banner_content text-center">
                        <h6>Away from monotonous life</h6>
                        <h2>Relax Your Mind</h2>
                        <p>If you are looking at blank cassettes on the web, you may be very confused at the<br> difference in price. You may see some for as low as $.17 each.</p>
                        <a href="searchtohome" class="btn theme_btn button_hover">Get Started</a>
                    </div>
                </div>
            </div>
            <div class="hotel_booking_area position">
                <div class="container">
                    <form id="searchBooking" action="searchtohome" method="get">
                        <div class="hotel_booking_table">
                            <div class="col-md-3">
                                <h2>Book<br> Your Room</h2>
                            </div>
                            <div class="col-md-9">
                                <div class="boking_table">
                                    <div class="row">
                                        <!-- Cột 1: Arrival & Departure -->
                                        <div class="col-md-4">
                                            <div class="book_tabel_item">
                                                <div class="form-group">
                                                    <div class='input-group date' id='datetimepicker11'>
                                                        <input type='text' name="checkInDate" class="form-control" placeholder="Arrival Date" />
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-calendar" aria-hidden="true"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class='input-group date' id='datetimepicker1'>
                                                        <input type='text' name="checkOutDate" class="form-control" placeholder="Departure Date" />
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-calendar" aria-hidden="true"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Cột 2: Number of people & Range -->
                                        <div class="col-md-4">
                                            <div class="book_tabel_item">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <input
                                                            type="number"
                                                            class="form-control"
                                                            min="1"
                                                            name="Adult"
                                                            id="numPeople"
                                                            placeholder="Number of people"
                                                            >
                                                    </div>
                                                </div>

                                                <div class="input-group">
                                                    <input
                                                        type="range"
                                                        class="form-range"
                                                        min="1"
                                                        max="30"
                                                        step="1"
                                                        id="customRange1"
                                                        name="range"
                                                        >
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Cột 3: Nút Book Now -->
                                        <div class="col-md-4 d-flex align-items-center justify-content-center">
                                            <a
                                                style="margin: auto; border-radius: 10px"
                                                class="book_now_btn button_hover"
                                                onclick="searchBooking()"
                                                href="bookingguest"
                                                >
                                                Book Now
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </form>
                </div>
            </div>
        </section>
        <!--================Banner Area =================-->

        <!--================ Accomodation Area  =================-->
        <section class="accomodation_area section_gap">
            <div class="container">
                <div class="section_title text-center">
                    <h2 class="title_color">Hotel Accomodation</h2>
                    <p>We all live in an age that belongs to the young at heart. Life that is becoming extremely fast, </p>
                </div>
                <div class="row mb_30">
                    <c:forEach items="${roomType}" var="i" begin="0" end="3">
                        <div class="col-lg-3 col-sm-6">
                            <div class="accomodation_item text-center">
                                <div class="hotel_img">
                                    <img height="200px" src="${i.imageURL}" alt="">
                                    <a href="#" style="border-radius: 10px" class="btn theme_btn button_hover">Book Now</a>
                                </div>
                                <a href="#">
                                    <h4 class="sec_h4">
                                        <c:if test="${i.capacity == 1}">Single Deluxe Room</c:if>
                                        <c:if test="${i.capacity == 2}">Double Deluxe Room</c:if>
                                        <c:if test="${i.capacity == 3}">Triple Deluxe Room</c:if>
                                        <c:if test="${i.capacity == 4}">Quad Deluxe Room</c:if>
                                        </h4>
                                    </a>
                                    <h5>${i.pricePerNight}<small>/night</small></h5>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        <!--================ Accomodation Area  =================-->

        <!--================ Facilities Area  =================-->
        <section class="facilities_area section_gap">
            <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background="">  
            </div>
            <div class="container">
                <div class="section_title text-center">
                    <h2 class="title_w">Royal Facilities</h2>
                    <p>Who are in extremely love with eco friendly system.</p>
                </div>
                <div class="row mb_30">
                    <div class="col-lg-4 col-md-6">
                        <div class="facilities_item">
                            <h4 class="sec_h4"><i class="lnr lnr-dinner"></i>Restaurant</h4>
                            <p>Enjoy a fine dining experience with a variety of exquisite dishes, prepared by top chefs using fresh ingredients.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="facilities_item">
                            <h4 class="sec_h4"><i class="lnr lnr-bicycle"></i>Sports CLub</h4>
                            <p>Stay active and energized with our state-of-the-art sports facilities, tennis courts, and more.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="facilities_item">
                            <h4 class="sec_h4"><i class="lnr lnr-shirt"></i>Swimming Pool</h4>
                            <p>Relax and refresh in our luxurious swimming pool, perfect for a morning swim or a peaceful afternoon.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="facilities_item">
                            <h4 class="sec_h4"><i class="lnr lnr-car"></i>Rent a Car</h4>
                            <p>Explore the city at your own pace with our reliable car rental service, offering flexible options for all travelers.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="facilities_item">
                            <h4 class="sec_h4"><i class="lnr lnr-construction"></i>Gymnesium</h4>
                            <p>Unwind with a signature cocktail or a fine selection of wines in our elegant bar, perfect for any occasion.</p>
                        </div> 
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="facilities_item">
                            <h4 class="sec_h4"><i class="lnr lnr-coffee-cup"></i>Bar</h4>
                            <p>Usage of the Internet is becoming more common due to rapid advancement of technology and power.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================ Facilities Area  =================-->

        <!--================ About History Area  =================-->
        <section class="about_history_area section_gap">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 d_flex align-items-center">
                        <div class="about_content ">
                            <h2 class="title title_color">About Us <br>Our History<br>Mission & Vision</h2>
                            <p>inappropriate behavior is often laughed off as “boys will be boys,” women face higher conduct standards especially in the workplace. That’s why it’s crucial that, as women, our behavior on the job is beyond reproach. inappropriate behavior is often laughed.</p>
                            <a href="#" class="button_hover theme_btn_two">Request Custom Price</a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <img class="img-fluid" src="image/about_bg.jpg" alt="img">
                    </div>
                </div>
            </div>
        </section>
        <!--================ About History Area  =================-->

        <!--================ Testimonial Area  =================-->
        <section class="testimonial_area section_gap">
            <div class="container">
                <div class="section_title text-center">
                    <h2 class="title_color">Testimonial from our Clients</h2>
                    <p>The French Revolution constituted for the conscience of the dominant aristocratic class a fall from </p>
                </div>
                <div class="testimonial_slider owl-carousel">
                    <div class="media testimonial_item">
                        <img class="rounded-circle" src="image/testtimonial-1.jpg" alt="">
                        <div class="media-body">
                            <p>"I was truly impressed with the service at this hotel! 
                                The rooms were spotless, spacious, and well-equipped. 
                                I will definitely return on my next trip!"</p>
                            <a href="#"><h4 class="sec_h4">Binh</h4></a>
                            <div class="star">
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                            </div>
                        </div>
                    </div>    
                    <div class="media testimonial_item">
                        <img class="rounded-circle" src="image/testtimonial-1.jpg" alt="">
                        <div class="media-body">
                            <p>"This trip was amazing thanks to the peaceful atmosphere of the hotel. 
                                I had a wonderful time unwinding here!" </p>
                            <a href="#"><h4 class="sec_h4">Viet</h4></a>
                            <div class="star">
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="media testimonial_item">
                        <img class="rounded-circle" src="image/testtimonial-1.jpg" alt="">
                        <div class="media-body">
                            <p>"Breakfast at the hotel was delicious, offering a variety of dishes, especially local specialties. 
                                I particularly loved the seafood dishes!"</p>
                            <a href="#"><h4 class="sec_h4">Hieu</h4></a>
                            <div class="star">
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star-half-o"></i></a>
                            </div>
                        </div>
                    </div>    
                    <div class="media testimonial_item">
                        <img class="rounded-circle" src="image/testtimonial-1.jpg" alt="">
                        <div class="media-body">
                            <p>"I was extremely satisfied with my stay here. 
                                The staff was exceptionally professional and always ready to help. A truly memorable vacation!"</p>
                            <a href="#"><h4 class="sec_h4">Minh</h4></a>
                            <div class="star">
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================ Testimonial Area  =================-->

        <!--================ Latest Blog Area  =================-->
        <section class="latest_blog_area section_gap">
            <div class="container">
                <div class="section_title text-center">
                    <h2 class="title_color">Latest posts from blog</h2>
                    <p>The French Revolution constituted for the conscience of the dominant aristocratic class a fall from </p>
                </div>
                <div class="row mb_30">
                    <div class="col-lg-4 col-md-6">
                        <div class="single-recent-blog-post">
                            <div class="thumb">
                                <img class="img-fluid" src="image/blog/blog-1.jpg" alt="post">
                            </div>
                            <div class="details">
                                <div class="tags">
                                    <a href="#" class="button_hover tag_btn">Travel</a>
                                    <a href="#" class="button_hover tag_btn">Life Style</a>
                                </div>
                                <a href="#"><h4 class="sec_h4">Low Cost Advertising</h4></a>
                                <p>Acres of Diamonds… you’ve read the famous story, or at least had it related to you. A farmer.</p>
                                <h6 class="date title_color">31st January,2018</h6>
                            </div>	
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="single-recent-blog-post">
                            <div class="thumb">
                                <img class="img-fluid" src="image/blog/blog-2.jpg" alt="post">
                            </div>
                            <div class="details">
                                <div class="tags">
                                    <a href="#" class="button_hover tag_btn">Travel</a>
                                    <a href="#" class="button_hover tag_btn">Life Style</a>
                                </div>
                                <a href="#"><h4 class="sec_h4">Creative Outdoor Ads</h4></a>
                                <p>Self-doubt and fear interfere with our ability to achieve or set goals. Self-doubt and fear are</p>
                                <h6 class="date title_color">31st January,2018</h6>
                            </div>	
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="single-recent-blog-post">
                            <div class="thumb">
                                <img class="img-fluid" src="image/blog/blog-3.jpg" alt="post">
                            </div>
                            <div class="details">
                                <div class="tags">
                                    <a href="#" class="button_hover tag_btn">Travel</a>
                                    <a href="#" class="button_hover tag_btn">Life Style</a>
                                </div>
                                <a href="#"><h4 class="sec_h4">It S Classified How To Utilize Free</h4></a>
                                <p>Why do you want to motivate yourself? Actually, just answering that question fully can </p>
                                <h6 class="date title_color">31st January,2018</h6>
                            </div>	
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================ Recent Area  =================-->

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
        <script>
            function searchBooking() {
                document.getElementById("searchBooking").submit();
            }

            const range = document.getElementById('customRange1');
            const number = document.getElementById('numPeople');

            // Khi kéo thanh range → cập nhật số trong ô number
            range.addEventListener('input', function () {
                number.value = range.value;
            });

            // Nếu người dùng nhập tay vào ô number → cập nhật lại thanh range
            number.addEventListener('input', function () {
                if (number.value >= range.min && number.value <= range.max) {
                    range.value = number.value;
                }
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <!--================ End footer Area  =================-->
       
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
        <script src="js/jquery.ajaxchimp.min.js"></script>
        <script src="js/mail-script.js"></script>
        <script src="vendors/bootstrap-datepicker/bootstrap-datetimepicker.min.js"></script>
        <script src="vendors/nice-select/js/jquery.nice-select.js"></script>
        <script src="js/mail-script.js"></script>
        <script src="js/stellar.js"></script>
        <script src="vendors/lightbox/simpleLightbox.min.js"></script>
        <script src="js/custom.js"></script>

        <script src="//code.tidio.co/sca9mmhhvgov9cyqdw4hrvnuvkshkhru.js" async></script>

    </body>
</html>