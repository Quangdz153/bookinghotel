<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, DAO.RoomTypeDAO, DAO.RoomImageDAO, entity.RoomType, entity.RoomImages" %>

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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- main css -->
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">
        <style>
            /*            input[type="number"]::-webkit-inner-spin-button {
                            background: red;  Đổi màu nền 
                            filter: invert(1);  Đảo màu để đổi màu nút 
                        }*/
            #adult::-webkit-inner-spin-button {
                background: red;
                filter: invert(1);
            }
            .form-select {
                appearance: none; /* Ẩn mũi tên mặc định */
                -webkit-appearance: none; /* Ẩn trên Safari */
                -moz-appearance: none; /* Ẩn trên Firefox */
                background-image: url('custom-arrow.png'); /* Nếu muốn thêm icon tùy chỉnh */
                background-repeat: no-repeat;
                background-position: right 10px center;
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
                                <a class="nav-link" href="accomodation.jsp">Accomodation</a>
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
                    <h2 class="page-cover-tittle">Accomodation</h2>
                    <ol class="breadcrumb">
                        <li><a href="index.jsp">Home</a></li>
                        <li class="active">Accomodation</li>
                    </ol>
                </div>
            </div>
        </section>
        <!--================Breadcrumb Area =================-->

        <!--================ Accomodation Area  =================-->
        <section class="accomodation_area section_gap">
            <div class="container">
                <div class="section_title text-center">
                    <h2 class="title_color">Special Accomodation</h2>
                    <p>We all live in an age that belongs to the young at heart. Life that is becoming extremely fast,</p>
                </div>
                <div class="row mb_30">
                    <c:forEach items="${roomType}" var="i" begin="0" end="3">
                        <div class="col-lg-3 col-sm-6">
                            <div class="accomodation_item text-center">
                                <div class="hotel_img">
                                    <img height="200px" src="${i.imageURL}" alt="">
                                    <a href="bookingguest" style="border-radius: 10px" class="btn theme_btn button_hover">Book Now</a>
                                </div>
                                <a href="#">
                                    <h4 class="sec_h4">
                                        <c:if test="${i.capacity == 1}">Single Deluxe Room</c:if>
                                        <c:if test="${i.capacity == 2}">Double Deluxe Room</c:if>
                                        <c:if test="${i.capacity == 3}">Triple Deluxe Room</c:if>
                                        <c:if test="${i.capacity == 4}">Quad Deluxe Room</c:if>
                                        </h4>
                                    </a>
                                    <h5>$${i.pricePerNight}<small>/night</small></h5>
                            </div>
                        </div>
                    </c:forEach>
                    <!--                    <div class="col-lg-3 col-sm-6">
                                            <div class="accomodation_item text-center">
                                                <div class="hotel_img">
                                                    <img src="image/room2.jpg" alt="">
                                                    <a href="#" class="btn theme_btn button_hover">Book Now</a>
                                                </div>
                                                <a href="#"><h4 class="sec_h4">Single Deluxe Room</h4></a>
                                                <h5>$200<small>/night</small></h5>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-sm-6">
                                            <div class="accomodation_item text-center">
                                                <div class="hotel_img">
                                                    <img src="image/room3.jpg" alt="">
                                                    <a href="#" class="btn theme_btn button_hover">Book Now</a>
                                                </div>
                                                <a href="#"><h4 class="sec_h4">Honeymoon Suit</h4></a>
                                                <h5>$750<small>/night</small></h5>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 col-sm-6">
                                            <div class="accomodation_item text-center">
                                                <div class="hotel_img">
                                                    <img src="image/room4.jpg" alt="">
                                                    <a href="#" class="btn theme_btn button_hover">Book Now</a>
                                                </div>
                                                <a href="#"><h4 class="sec_h4">Economy Double</h4></a>
                                                <h5>$200<small>/night</small></h5>
                                            </div>
                                        </div>-->
                </div>
            </div>
        </section>
        <!--================ Accomodation Area  =================-->
        <!--================Booking Tabel Area =================-->
        <section class="banner_area">
            <div class="booking_table d_flex align-items-center">
                <div class="overlay bg-parallax" data-stellar-ratio="0.9" data-stellar-vertical-offset="0" data-background=""></div>
                <div class="container">
                    <div class="banner_content text-center">
                        <h6>Away from monotonous life</h6>
                        <h2>Relax Your Mind</h2>
                        <p>If you are looking at blank cassettes on the web, you may be very confused at the<br> difference in price. You may see some for as low as $.17 each.</p>
                        <a href="#" class="btn theme_btn button_hover">Get Started</a>
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
                        </div>
                    </form>
                </div>
            </div>
        </section>
        <!--================Booking Tabel Area  =================-->
        <!--================ Accomodation Area  =================-->
        <section class="accomodation_area section_gap" id="listSearchRoom">
            <div class="container">
                <div class="section_title text-center">
                    <h2 class="title_color">Normal Accomodation</h2>
                    <p>We all live in an age that belongs to the young at heart. Life that is becoming extremely fast,</p>
                    <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                        <div>
                            <button style="background-color: red" type="button" class="btn btn-primary" 
                                    data-bs-toggle="modal"
                                    data-bs-target="#addnewroom">Add new room
                            </button>

                            <a href="roomtypecontrol">
                                <button style="background-color: red" type="button" class="btn btn-primary">Manager RoomType</button>
                            </a>
                        </div>
                    </c:if>
                </div>

                <div class="row accomodation_two" id="listSearchRoom"   >
                    <c:forEach var="i" items="${listRoom}">
                        <%
                            entity.Room room = (entity.Room) pageContext.findAttribute("i"); // Lấy i từ c:forEach
                            RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
                            RoomType roomType = roomTypeDAO.getRoomTypeByRoomID(room.getRoomID()); 
                            request.setAttribute("roomType", roomType); 

                            List<entity.RoomType> roomTypeList = new DAO.RoomTypeDAO().getListType();
                            List<entity.RoomImages> roomImgList = new DAO.RoomImageDAO().getImageByRoomID(room.getRoomID());
                            request.setAttribute("roomImgList", roomImgList); 
                            request.setAttribute("roomTypeList", roomTypeList); 
                            
                        %>

                        <div class="col-lg-3 col-sm-6">
                            <div class="accomodation_item text-center">
                                <div class="hotel_img">
                                    <img height="200px" src="${not empty roomImgList ? roomImgList[0].imageURL : roomType.imageURL}" alt="">
                                    <a href="bookingguest" style="border-radius: 10px" class="btn theme_btn button_hover">Book Now </a>
                                </div>

                                <a href="#"><h4 class="sec_h4"><%= room.getRoomID()%>-${roomType.name} </h4></a>
                                <h5>${roomType.pricePerNight}<small>/night</small> </h5>
                                <button type="button" onclick="getAll(this)" class="btn btn-primary" 
                                        data-bs-toggle="modal"
                                        data-bs-target="#roomDetailModal"
                                        data-title ="${roomType.name}"
                                        data-room ="<%= room.getRoomID()%>"
                                        data-roomtypedescription ="${roomType.description}"
                                        data-number ="${roomType.capacity}"
                                        data-typeid ="${roomType.typeID}"
                                        data-img="${not empty roomImgList and roomImgList.size() > 0 ? roomImgList[0].imageURL : roomType.imageURL}"
                                        data-img1="${not empty roomImgList and roomImgList.size() > 1 ? roomImgList[1].imageURL : ''}"
                                        data-img2="${not empty roomImgList and roomImgList.size() > 2 ? roomImgList[2].imageURL : ''}"
                                        data-img3="${not empty roomImgList and roomImgList.size() > 3 ? roomImgList[3].imageURL : ''}"

                                        data-area="${roomType.area}"
                                        data-amenities="${roomType.amenities}"
                                        data-price="$${roomType.pricePerNight}/Night">
                                    Xem chi tiết phòng 
                                </button>

                            </div>
                        </div>
                    </c:forEach>

                    <style>
                        .mainbody{
                            display: flex;
                            flex-direction: row;
                        }
                        .a{
                            display: flex;
                            flex-direction: column;
                            gap: 5px
                        }

                        .mainInfo{
                            margin-left: 20px
                        }

                        .mainInfo h3{
                            font-weight: 600;
                            color: black
                        }
                        .benefit{
                            font-weight: 600;
                            display: inline;
                            color: black
                        }

                        #infotyperoom{
                            display: none;
                        }
                    </style>

                    <!--Addroom-->
                    <div id="addnewroom" class="modal fade" tabindex="-1" aria-hidden="true">

                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="addnewroom" method="post">
                                    <div class="modal-header">						
                                        <h4 class="modal-title"> Add new room</h4>
                                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
                                    </div>
                                    <div class="modal-body">	

                                        <div class="form-group">
                                            <label for="addroomid">RoomID</label>
                                            <input id="addroomid" name="addroomid" type="text"  class="form-control" >
                                        </div>

                                        <div class="form-group">
                                            <label for="addroomtype">RoomType</label>
                                            <select  id="addroomtype" name="addroomtype" class="form-select" aria-label="Default select example">
                                                <option selected>Select room type </option>
                                                <c:forEach items="${roomTypeList}" var="i">
                                                    <option value="${i.typeID}">${i.typeID}-${i.name}</option>
                                                </c:forEach>

                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="selectstatus">Status</label>
                                            <select id="selectstatus" name="selectstatus" class="form-select"  >
                                                <option selected>Select room type status </option>
                                                <option value="Available">Available</option>
                                                <option value="Occupied">Occupied</option>
                                                <option value="Reserved">Reserved</option>
                                                <option value="Cleaning">Cleaning</option>

                                            </select>


                                        </div><br>
                                        <div class="row" style="margin-top: 20px">
                                            <div class="col-md-6 mb-3">
                                                <label for="img1" class="form-label">Image 1</label>
                                                <input type="text" id="img1" name="img1" class="form-control" placeholder="Enter Image URL">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="img2" class="form-label">Image 2</label>
                                                <input type="text" id="img2" name="img2" class="form-control" placeholder="Enter Image URL">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="img3" class="form-label">Image 3</label>
                                                <input type="text" id="img3" name="img3" class="form-control" placeholder="Enter Image URL">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="img4" class="form-label">Image 4</label>
                                                <input type="text" id="img4" name="img4" class="form-control" placeholder="Enter Image URL">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="description">Description</label>
                                            <textarea id="description" name="description" rows="3" style="width: 100%; border-radius: 5px"></textarea>
                                        </div>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default close-modal" data-bs-dismiss="modal">Cancel</button>

                                        <input type="submit" class="btn btn-success" value="AddRoom">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>


                    <!--Roominfo-->
                    <div class="modal fade" id="roomDetailModal" tabindex="-1" aria-labelledby="roomDetailLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="roomDetailLabel"></h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body mainbody">
                                    <!-- Hình ảnh phòng -->
                                    <div class="a">
                                        <div class="mainImg">
                                            <img id="imgDetail"  class="img-fluid" alt="Room luxury" >
                                        </div>
                                        <div class="moreImg">
                                            <img id="imgDetail1" class="img-fluid" alt="Room luxury">
                                            <img id="imgDetail2" class="img-fluid" alt="Room luxury">
                                            <img id="imgDetail3" class="img-fluid" alt="Room luxury">
                                        </div>
                                    </div>

                                    <!-- Thông tin chi tiết -->
                                    <div class="mainInfo">
                                        <h3>Room Information</h3>
                                        <input type="hidden" id="typeID">
                                        <input type="hidden" id="roomID">

                                        <span>
                                            <i style="font-size: 28px;" class="fa-duotone fa-solid fa-chart-area"></i>
                                        </span> 
                                        <p id="area" style="margin-left: 10px;display: inline;"></p>
                                        <br>
                                        <i style="font-size: 25px;margin-top :8px;" class="fa-duotone fa-solid fa-people-group"></i>
                                        <p id="numberPeople" style="margin-left: 8px;display: inline;"></p>
                                        <hr style="width: 330px">

                                        <h3>Customer Benefits</h3>

                                        <div id="roomtypedescription" ></div>
                                        <div id="amenities" style="margin-top: 10px"></div>

                                        <div style="display: flex; align-items: center; flex-wrap: wrap; margin-top: 10px">
                                            <p class="benefit" style="margin: 0; font-weight: 600;">Other: </p>
                                            <p id="other" style="margin: 0;">&nbsp;Breakfast, Gym, Pool, Laundry service...</p>
                                        </div>

                                        <p id="priceDetail" style="margin-top: 10px;"></p>

                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                        <button type="button" class="btn btn-secondary" onclick="deleteRoom()" data-bs-dismiss="modal">Delete</button>

                                        <button type="button" onclick="getRoomInfo()" class="btn btn-primary" 
                                                data-bs-toggle="modal"
                                                data-bs-target="#updateroominfo"
                                                >
                                            Update
                                        </button>
                                    </c:if>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <a href="bookingguest" style="border-radius: 10px" class="btn theme_btn button_hover">Book Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Room update-->

                    <div id="updateroominfo" class="modal fade" tabindex="-1" aria-hidden="true">

                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="updateroom" method="get">
                                    <div class="modal-header">						
                                        <h4 class="modal-title">Update RoomInfo</h4>
                                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
                                    </div>
                                    <div class="modal-body">	
                                        <div class="form-group">
                                            <label>RoomType current <span id="type"></span></label><br>

                                            <select id="updatetypeid" onchange="changeRoomType(this.value)" name="updateroomtype" class="form-select" aria-label="Default select example">
                                                <option value="none" disabled>Select room type </option>
                                                <c:forEach items="${roomTypeList}" var="i" varStatus="index">
                                                    <option value="${i.typeID}" >${i.typeID}-${i.name}</option>
                                                </c:forEach>

                                            </select>

                                        </div>
                                        <!--                                    <select >
                                                                                <option value="1">Option 1</option>
                                                                                <option value="2">Option 2</option>
                                                                                <option value="3">Option 3</option>
                                                                            </select>-->

                                        <div class="form-group">
                                            <label>RoomID</label>
                                            <input id="updateroomid" type="text" name="roomID" class="form-control" >
                                        </div>
                                        <div class="row" style="margin-top: 20px">
                                            <div class="col-md-6 mb-3">
                                                <label for="img1" class="form-label">Image 1</label>
                                                <input type="text" id="updateimg1" name="updateimg1" class="form-control" placeholder="Enter Image URL">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="img2" class="form-label">Image 2</label>
                                                <input type="text" id="updateimg2" name="updateimg2" class="form-control" placeholder="Enter Image URL">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="img3" class="form-label">Image 3</label>
                                                <input type="text" id="updateimg3" name="updateimg3" class="form-control" placeholder="Enter Image URL">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="img4" class="form-label">Image 4</label>
                                                <input type="text" id="updateimg4" name="updateimg4" class="form-control" placeholder="Enter Image URL">
                                            </div>
                                        </div>
                                        <div id="infotyperoom">

                                            <div class="form-group">
                                                <label>Area</label>
                                                <input id="updatearearoom" min="0" type="number" class="form-control" >
                                            </div>
                                            <div class="form-group">
                                                <label>Name</label>
                                                <input id="updatetitlename" type="text"  class="form-control" >
                                            </div>
                                            <div class="form-group">
                                                <label>Cpacity </label>
                                                <input id="updatecapacity" type="number"  class="form-control" >
                                            </div>

                                            <div class="form-group">
                                                <label>Amenities</label>
                                                <input id="updateamenities" type="text" class="form-control" >
                                            </div>


                                            <!--                                    <div class="form-group">
                                                                                    <label>Other</label>
                                                                                    <input id="updateother" type="text" class="form-control" >
                                                                                </div>-->
                                            <div class="form-group">
                                                <label>Price per night</label>
                                                <input id="updateprice" type="text" min="0" class="form-control" >
                                            </div>



                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default close-modal" data-bs-dismiss="modal">Cancel</button>

                                        <input type="submit" class="btn btn-success" value="Update">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!-- them -->
        </section>

        <script>
            // Chuyển đổi danh sách roomTypeList từ JSP sang JSON
            var roomData = {};
            <c:forEach items="${roomTypeList}" var="room">
            roomData["${room.typeID}"] = {
                name: "${room.name}",
                description: "${room.description}",
                price: "${room.pricePerNight}",
                capacity: "${room.capacity}",
                //                        imageURL: "${room.imageURL}",
                area: "${room.area}",
                amenities: "${room.amenities}"
            };
            </c:forEach>

            function changeRoomType(selectedTypeID) {
                let infoDiv = document.getElementById("infotyperoom");
                if (this.value !== "none") {
                    infoDiv.style.display = "block"; // Hiển thị khi chọn loại phòng
                } else {
                    infoDiv.style.display = "none"; // Ẩn nếu không chọn gì
                }
                if (roomData[selectedTypeID]) {
                    document.getElementById("updatearearoom").value = roomData[selectedTypeID].area;
                    document.getElementById("updatetitlename").value = roomData[selectedTypeID].name;
                    document.getElementById("updateamenities").value = roomData[selectedTypeID].amenities;
                    document.getElementById("updateprice").value = roomData[selectedTypeID].price;
                    document.getElementById("updatecapacity").value = roomData[selectedTypeID].capacity;
                } else {

                }
                document.getElementById("updatetypeid").blur();
            }

            function searchBooking() {
                document.getElementById("searchBooking").submit();
            }

            window.onload = function () {
                setTimeout(() => {
                    let resultSection = document.getElementById("listSearchRoom");
                    if (resultSection) {
                        resultSection.scrollIntoView({behavior: "smooth"});
                    } else {
                        console.error("Không tìm thấy #listSearchRoom");
                    }
                }, 500); // Đợi 500ms để đảm bảo phần tử đã được tải xong
            };
            function getAll(button) {

                // Lấy dữ liệu từ data-* attributes
                let title = button.getAttribute("data-title");

                let imgSrc = button.getAttribute("data-img");
                let imgSrc1 = button.getAttribute("data-img1");
                let imgSrc2 = button.getAttribute("data-img2");
                let imgSrc3 = button.getAttribute("data-img3");
                let area = button.getAttribute("data-area");
                let amenities = button.getAttribute("data-amenities");
                let price = button.getAttribute("data-price");
                let typeID = button.getAttribute("data-typeid");
                let roomid = button.getAttribute("data-room");
                let desciption = button.getAttribute("data-roomtypedescription");


                // Cập nhật nội dung modal
                document.getElementById("roomDetailLabel").innerHTML = title;

                document.getElementById("numberPeople").innerHTML = button.getAttribute("data-number") + " People";
                document.getElementById("typeID").value = typeID;
                document.getElementById("roomID").value = roomid;

                document.getElementById("imgDetail").src = imgSrc;
                document.getElementById("imgDetail").style.width = "400px";// Đổi chiều cao thành 200px

                document.getElementById("imgDetail1").src = imgSrc1;
                document.getElementById("imgDetail1").style.width = "130px";
                document.getElementById("imgDetail1").style.height = "90px";
                document.getElementById("imgDetail2").src = imgSrc2;
                document.getElementById("imgDetail2").style.width = "130px";
                document.getElementById("imgDetail2").style.height = "90px";
                document.getElementById("imgDetail3").src = imgSrc3;
                document.getElementById("imgDetail3").style.width = "130px";
                document.getElementById("imgDetail3").style.height = "90px";
                document.getElementById("roomtypedescription").innerHTML = "<p class='benefit'>Description: </p>" + desciption;
                document.getElementById("area").innerHTML = area + "m²";
                document.getElementById("amenities").innerHTML = "<p class='benefit'>Amenities: </p>" + amenities;
                document.getElementById("priceDetail").innerHTML = "<p class='benefit'>Price: </p><span class='text-danger'>" + price + "</span>";
            }


            function getRoomInfo() {
                let typeId = document.getElementById("typeID").value;

                let roomID = document.getElementById("roomID").value;



                document.getElementById("type").innerHTML = typeId;
                document.getElementById("updatetypeid").value = typeId;
                document.getElementById("updateroomid").value = roomID;


                let imgDetail = document.getElementById("imgDetail").getAttribute("src");
                let imgDetail1 = document.getElementById("imgDetail1").getAttribute("src");
                let imgDetail2 = document.getElementById("imgDetail2").getAttribute("src");
                let imgDetail3 = document.getElementById("imgDetail3").getAttribute("src");

                if (imgDetail !== null && imgDetail.trim() !== "") {
                    document.getElementById("updateimg1").value = imgDetail;
                }

                if (imgDetail1 !== null && imgDetail1.trim() !== "") {
                    document.getElementById("updateimg2").value = imgDetail1;
                }

                if (imgDetail2 !== null && imgDetail2.trim() !== "") {
                    document.getElementById("updateimg3").value = imgDetail2;
                }

                if (imgDetail3 !== null && imgDetail3.trim() !== "") {
                    document.getElementById("updateimg4").value = imgDetail3;
                }

            }

            function deleteRoom() {
                let roomid = document.getElementById("roomID").value;
                if (confirm("Do you want to delete room " + roomid + "?")) {
                    window.location.href = "deletebyroomid?roomId=" + roomid;
                } else {

                }
            }
        </script>
        <!--================ Accomodation Area  =================-->
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
                        Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank"></a>
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

        <script>
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
    </body>
</html>