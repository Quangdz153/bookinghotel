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

        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <!-- main css -->
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="stylesheet" href="css/stylecrud.css">

        <style>
            .payment-form{
                padding-bottom: 50px;
                font-family: 'Montserrat', sans-serif;
            }

            .payment-form.dark{
                background-color: #f6f6f6;
            }

            .payment-form .content{
                box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.075);
                background-color: white;
            }

            .payment-form .block-heading{
                padding-top: 50px;
                margin-bottom: 40px;
                text-align: center;
            }

            .payment-form .block-heading p{
                text-align: center;
                max-width: 420px;
                margin: auto;
                opacity:0.7;
            }

            .payment-form.dark .block-heading p{
                opacity:0.8;
            }

            .payment-form .block-heading h1,
            .payment-form .block-heading h2,
            .payment-form .block-heading h3 {
                margin-bottom:1.2rem;
                color: #3b99e0;
            }

            .payment-form form{
                border-top: 2px solid #5ea4f3;
                box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.075);
                background-color: #ffffff;
                padding: 0;
                max-width: 600px;
                margin: auto;
            }

            .payment-form .title{
                font-size: 1em;
                border-bottom: 1px solid rgba(0,0,0,0.1);
                margin-bottom: 0.8em;
                font-weight: 600;
                padding-bottom: 8px;
            }

            .payment-form .products{
                background-color: #f7fbff;
                padding: 25px;
            }

            .payment-form .products .item{
                margin-bottom:1em;
            }

            .payment-form .products .item-name{
                font-weight:600;
                font-size: 0.9em;
            }

            .payment-form .products .item-description{
                font-size:0.8em;
                opacity:0.6;
            }

            .payment-form .products .item p{
                margin-bottom:0.2em;
            }

            .payment-form .products .price{
                float: right;
                font-weight: 600;
                font-size: 0.9em;
            }

            .payment-form .products .total{
                border-top: 1px solid rgba(0, 0, 0, 0.1);
                margin-top: 10px;
                padding-top: 19px;
                font-weight: 600;
                line-height: 1;
            }

            .payment-form .card-details{
                padding: 25px 25px 15px;
            }

            .payment-form .card-details label{
                font-size: 12px;
                font-weight: 600;
                margin-bottom: 15px;
                color: #79818a;
                text-transform: uppercase;
            }

            .payment-form .card-details button{
                margin-top: 0.6em;
                padding:12px 0;
                font-weight: 600;
            }

            .payment-form .date-separator{
                margin-left: 10px;
                margin-right: 10px;
                margin-top: 5px;
            }

            @media (min-width: 576px) {
                .payment-form .title {
                    font-size: 1.2em;
                }

                .payment-form .products {
                    padding: 40px;
                }

                .payment-form .products .item-name {
                    font-size: 1em;
                }

                .payment-form .products .price {
                    font-size: 1em;
                }

                .payment-form .card-details {
                    padding: 40px 40px 30px;
                }

                .payment-form .card-details button {
                    margin-top: 2em;
                }
            }

            body.modal-open {
                overflow: hidden;
            }

            #payment-modal {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: none;
                justify-content: center;
                align-items: center;
                z-index: 1000;
            }

            .payment-form {
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
                width: 40%;
                max-height: 80vh;
                overflow-y: auto;
                position: relative;
                z-index: 1001;
            }

            select {
                display: block !important;
                z-index: 1000 !important;
            }

            .nice-select{
                display: none;
            }

            .close-button {
                position: absolute;
                top: 10px;
                right: 15px;
                cursor: pointer;
                font-size: 18px;
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
                                    <a class="nav-link" href="login.jsp">Logout</a>
                                </li>
                            </c:if>
                        </ul>
                    </div> 
                </nav>
            </div>
        </header>
        <!--================Header Area =================-->

        <!--================Breadcrumb Area =================-->
        <section class="breadcrumb_area blog_banner_two">
            <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
            <div class="container">
                <div class="page-cover text-center">
                    <h2 class="page-cover-tittle f_48">History Booking</h2>
                    <ol class="breadcrumb">
                        <li><a href="index.jsp">Home</a></li>
                        <li class="active">history</li>
                    </ol>
                </div>
            </div>
        </section>
        <!--================Breadcrumb Area =================-->

        <!-- Start Button -->

        <!-- End Button -->
        <!-- Start Align Area -->
        <div class="whole-wrap">
            <div class="container">
                <div class="section-top-border">
                    <h3 class="mb-30 title_color">Your Booking Information</h3>
                    <div class="progress-table-wrap">
                        <div class="progress-table">
                            <div class="table-head" >
                                <div class="serial">#</div>
                                <div class="visit">Full Name</div>
                                <!--<div class="visit">Last Name</div>-->
                                <div class="visit">Room ID</div>
                                <div class="visit">Check-in Date</div>
                                <div class="visit">Check-out Date</div>
                                <div class="visit">Phone</div>
                                <div class="visit">Price</div>
                                <div class="visit">Status</div>
                                <div class="visit">Pay</div>
                            </div>
                            <input type="hidden" name="AccountID" value="${sessionScope.acc.accountID}" />

                            <!-- Duyệt qua danh sách guestBookingList -->
                            <c:forEach var="booking" items="${guestBookingList}" varStatus="status">
                                <div class="table-row">
                                    <div class="serial">${status.index + 1}</div>
                                    <div class="visit">${booking.guest.firstName} ${booking.guest.lastName}</div>
                                    <div class="visit">${booking.roomID}</div>
                                    <div class="visit">${booking.checkinDate}</div>
                                    <div class="visit">${booking.checkoutDate}</div>
                                    <div class="visit">${booking.guest.phone}</div>
                                    <div class="visit">${booking.totalPrice}</div>
                                    <div class="visit">${booking.takeStatus()}</div>
                                    <div class="visit">
                                        <c:if test="${booking.status > 2 && booking.status <5 && booking.payment.paymentID != null}">
                                            <button type="submit" class="btn btn-success" style="color: white; font-size: 12px; font-weight: 600">
                                                Complete
                                            </button>
                                        </c:if>
                                        <c:if test="${booking.status == 5}">
                                            <button type="submit" class="btn btn-dark" style="color: white; font-size: 12px; font-weight: 600">
                                                Cancel
                                            </button>
                                        </c:if>
                                        <c:if test="${booking.status < 3}">
                                            <button type="submit" class="btn btn-primary" style="color: white; font-size: 12px; font-weight: 600" onclick="showPaymentForm()">
                                                <a onclick="bookingPayFrom('${booking.bookingID}', '${booking.totalPrice}');
                                                        return false;">Pay</a>
                                            </button>
                                        </c:if>&nbsp;&nbsp;&nbsp;
                                        <c:if test="${booking.status == 2}">
                                            <form action="payment" method="post" onsubmit="return confirmCancel()">
                                                <input type="hidden" name="paymentID" value="${booking.bookingID}"/>
                                                <input type="hidden" name="statusbook" value="cancel-5"/>
                                                <button type="submit" class="btn btn-danger" style="color: white; font-size: 12px; font-weight: 600">
                                                    Cancel
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty guestBookingList}">
                                <tr><td colspan="8">No bookings available.</td></tr>
                            </c:if>
                        </div>
                    </div>
                </div>

                <%--<jsp:include page="payment.jsp" />--%>

                <div id="payment-modal" onclick="hidePaymentForm(event)">
                    <section id="payment-form" class="payment-form dark" onclick="event.stopPropagation()">
                        <span class="close-button" onclick="hidePaymentForm(event)">&times;</span>
                        <div class="block-heading">
                            <h2>Payment</h2>
                            <p>Please fill in the payment details below.</p>
                        </div>
                        <form action="payment" method="POST">
                            <input type="hidden" name="paymentID" value="${bk.bookingID}" id="bookingPay"/>
                            <div class="card-details">
                                <h3 class="title">Payment Details</h3>
                                <div class="form-group">
                                    <label for="amount">Amount</label>
                                    <input id="amount" name="amount" type="number" class="form-control"  placeholder="Enter Amount" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="payment-date">Payment Date</label>
                                    <input id="payment-date" type="date" class="form-control" value="" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="payment-method">Payment Method</label>
                                    <select name="paymentMethod" class="form-control">
                                        <option value="Cash">Cash</option>
                                        <option value="Credit Card">Credit Card</option>
                                        <option value="Debit Card">Debit Card</option>
                                        <option value="Online Payment">Online Payment</option>
                                    </select>
                                </div>
                                <br/>
                                <button type="submit" class="btn btn-primary btn-block">Proceed</button>
                            </div>
                        </form>
                    </section>
                </div>


                <div class="section-top-border">
                    <h3 class="mb-30 title_color">Your Payment Information</h3>
                    <div class="progress-table-wrap">
                        <div class="progress-table">
                            <div class="table-head">
                                <div class="serial">#</div>
                                <div class="visit">Payment ID</div>
                                <div class="visit">Booking ID</div>
                                <div class="visit">Amount</div>
                                <div class="visit">Payment Date</div>
                                <div class="visit">Payment Method</div>
                            </div>

                            <!-- Duyệt qua danh sách guestPaymentList -->
                            <c:forEach var="payment" items="${guestPaymentList}" varStatus="status">
                                <div class="table-row">
                                    <div class="serial">${status.index + 1}</div>
                                    <div class="visit">${payment.getPaymentID()}</div>
                                    <div class="visit">${payment.getBookingID()}</div> <!-- Lấy Booking ID từ đối tượng Booking -->
                                    <div class="visit">${payment.getAmount()}</div>
                                    <div class="visit">${payment.getPaymentDate()}</div>
                                    <div class="visit">${payment.getPaymentMethod()}</div>                                
                                </div>
                            </c:forEach>
                            <c:if test="${empty guestPaymentList}">
                                <div>No payments available.</div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Align Area -->

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
                        Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved <i class="fa fa-heart-o" aria-hidden="true"></i>  <a href="https://colorlib.com" target="_blank"></a>
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
        <script src="vendors/lightbox/simpleLightbox.min.js"></script>
        <script src="js/custom.js"></script>

        <script>
                            function bookingPayFrom(id, price) {
                                document.getElementById("bookingPay").value = id;
                                document.getElementById("amount").value = price;
                            }
        </script>

        <script>
            function confirmCancel() {
                return confirm("Are you sure you want to cancel this booking?");
            }
        </script>
        <script>
            function showPaymentForm() {
                document.getElementById("payment-modal").style.display = "flex";
                document.getElementById("payment-date").value = new Date().toISOString().split('T')[0];
            }

            function hidePaymentForm(event) {
                if (event.target.id === "payment-modal" || event.target.classList.contains("close-button")) {
                    document.getElementById("payment-modal").style.display = "none";
                }
            }

            function toggleCardDetails() {
                var method = document.getElementById("payment-method").value;
                var cardDetails = document.getElementById("card-details");
                cardDetails.style.display = (method === "Credit Card" || method === "Debit Card") ? "block" : "none";
            }

            function updateTotalPrice() {
                var bookingSelect = document.getElementById("booking-id");
                var selectedOption = bookingSelect.options[bookingSelect.selectedIndex];

                if (selectedOption) {
                    var price = selectedOption.getAttribute("data-price");
                    console.log("Updating Total Price:", price); // Debugging
                    document.getElementById("total-price").innerText = `$${price}`;
                }
            }
        </script>

        <script>
            <% if (session.getAttribute("successMessage") != null) { %>
            Swal.fire({
                icon: "success",
                title: "Pay Successful!",
                text: "<%= session.getAttribute("successMessage") %>",
                confirmButtonColor: "#3085d6",
                confirmButtonText: "OK"
            });
            <% } %>
        </script>

        <script>
            function loadid(element) {
                document.getElementById("deletebookingid").value = element.closest('tr').querySelector('[data-bookingid]').getAttribute('data-bookingid');
            }

            function loadform(element) {
                document.getElementById("bookingid").value = element.closest('tr').querySelector('[data-bookingid]').getAttribute('data-bookingid');
                document.getElementById("guestid").value = element.closest('tr').querySelector('[data-guestid]').getAttribute('data-guestid');
                document.getElementById("roomid").value = element.closest('tr').querySelector('[data-roomid]').getAttribute('data-roomid');
                document.getElementById("checkindate").value = element.closest('tr').querySelector('[data-checkindate]').getAttribute('data-checkindate');
                document.getElementById("checkoutdate").value = element.closest('tr').querySelector('[data-checkoutdate]').getAttribute('data-checkoutdate');
                document.getElementById("totalprice").value = element.closest('tr').querySelector('[data-totalprice]').getAttribute('data-totalprice');
                document.getElementById("status").value = element.closest('tr').querySelector('[data-status]').getAttribute('data-status');
            }

            $(document).ready(function () {
                // Activate tooltip
                $('[data-toggle="tooltip"]').tooltip();

                // Select/Deselect checkboxes
                var checkbox = $('table tbody input[type="checkbox"]');
                $("#selectAll").click(function () {
                    if (this.checked) {
                        checkbox.each(function () {
                            this.checked = true;
                        });
                    } else {
                        checkbox.each(function () {
                            this.checked = false;
                        });
                    }
                });
                checkbox.click(function () {
                    if (!this.checked) {
                        $("#selectAll").prop("checked", false);
                    }
                });
            });
        </script>

        <script>
            window.onload = function () {
                if (window.location.hash === "#booking-manage") {
                    document.getElementById("booking-manage").scrollIntoView({behavior: "smooth"});
                }
            };
        </script>
    </body>
</html> 