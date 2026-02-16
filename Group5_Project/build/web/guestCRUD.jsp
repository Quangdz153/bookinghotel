<%-- 
    Document   : account
    Created on : Mar 3, 2025, 10:49:37 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="image/favicon1.png" type="image/png">
        <title>Royal Hotel - Account</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="vendors/linericon/style.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
        <link rel="stylesheet" href="vendors/bootstrap-datepicker/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" href="vendors/nice-select/css/nice-select.css">
        <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
        <!-- main css -->
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">

        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
        <title>crud dashboard</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!----css3---->
        <link rel="stylesheet" href="css/custom.css">


        <!--google fonts -->

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">


        <!--google material icon-->
        <link href="https://fonts.googleapis.com/css2?family=Material+Icons"rel="stylesheet">

        <!-- Thư viện SweetAlert2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- jQuery và Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!--<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>-->
        <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">-->



    </head>
    <body>

        <div class="wrapper">

            <div class="body-overlay"></div>

            <!-------------------------sidebar------------>
            <!-- Brand and toggle get grouped for better mobile display -->
            <!-- Sidebar  -->
            <nav id="sidebar">
                <div class="sidebar-header">
                    <h3><a href="loadtohome" style="font-weight: bold"><img src="image/Logo.png" class="img-fluid"/><span>Royal Hotel</span></a></h3>
                </div>
                <ul class="list-unstyled components">
                    <li class="">
                        <a href="#" class="dashboard"><i class="material-icons">dashboard</i>
                            <span style="font: 17px Poppins, sans-serif; font-weight: 600; text-transform: uppercase;">Welcome ${sessionScope.acc.username}</span></a>
                    </li>

                    <li class="dropdown">
                        <a href="#homeSubmenu1" data-toggle="collapse" aria-expanded="false" 
                           class="dropdown-toggle">
                            <i class="material-icons">streetview</i>Customer Data</a>
                        <ul class="collapse list-unstyled menu" id="homeSubmenu1">
                            <li><a href="guest"><i class="material-icons">account_circle</i>Customer</a></li>
                            <li><a href="accountguest"><i class="material-icons">account_box</i>Account</a></li>
                        </ul>
                    </li>

                    <li class="dropdown">
                        <a href="#pageSubmenu2" data-toggle="collapse" aria-expanded="false" 
                           class="dropdown-toggle">
                            <i class="material-icons">people</i><span>Staff Data</span></a>
                        <ul class="collapse list-unstyled menu" id="pageSubmenu2">
                            <li><a href="staff"><i class="material-icons">account_circle</i>Staff</a></li>
                                <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                <li><a href="accountstaff"><i class="material-icons">account_box</i>Account</a></li>
                                </c:if>
                        </ul>
                    </li>

                    <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                        <li class="dropdown">
                            <a href="#pageSubmenu3" data-toggle="collapse" aria-expanded="false" 
                               class="dropdown-toggle">
                                <i class="material-icons">account_circle</i><span>Account</span></a>
                            <ul class="collapse list-unstyled menu" id="pageSubmenu3">
                                <li><a href="accountstaff"><i class="material-icons">person_outline</i>Staff</a></li>
                                <li><a href="accountguest"><i class="material-icons">person_outline</i>guest</a></li>
                            </ul>
                        </li>
                    </c:if>
                    <li class="">
                        <a href="booking"><i class="material-icons">touch_app</i><span>Booking</span></a>
                    </li>
                    <li class="">
                        <a href="paymentaddmin"><i class="material-icons">payment</i><span>Payment</span></a>
                    </li>
                    <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                        <li class="">
                            <a href="roomtypecontrol"><i class="material-icons">domain</i><span>Room</span></a>
                        </li>
                    </c:if>
                </ul>
            </nav>

            <!--------page-content---------------->

            <div id="content">
                <!--top--navbar----design--------->

                <div class="top-navbar">
                    <div class="xp-topbar">

                        <!-- Start XP Row -->
                        <div class="row"> 
                            <!-- Start XP Col -->
                            <div class="col-2 col-md-1 col-lg-1 order-2 order-md-1 align-self-center">
                                <div class="xp-menubar">
                                    <span class="material-icons text-white">signal_cellular_alt</span>
                                </div>
                            </div> 
                            <!-- End XP Col -->

                            <!-- Start XP Col -->
                            <div class="col-md-5 col-lg-3 order-3 order-md-2">
                                <div class="xp-searchbar">
                                    <form action="guest" method="get">
                                        <div class="input-group">
                                            <input type="search" name="searchGuest" value="${searchGuest}" class="form-control" placeholder="Search">
                                            <div class="input-group-append">
                                                <button class="btn" type="submit" id="button-addon2">GO</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <!-- End XP Col -->

                            <!-- Start XP Col -->
                            <div class="col-10 col-md-6 col-lg-8 order-1 order-md-3">
                                <div class="xp-profilebar text-right">
                                    <nav class="navbar p-0">
                                        <ul class="nav navbar-nav flex-row ml-auto">   
                                            <li class="dropdown nav-item active">
                                                <a href="#" class="nav-link" data-toggle="dropdown">
                                                    <span class="material-icons">notifications</span>
                                                    <span class="notification">4</span>
                                                </a>
                                                <ul class="dropdown-menu">
                                                    <li><a href="#">You have 5 new messages</a></li>
                                                    <li><a href="#">You're now friend with Mike</a></li>
                                                    <li><a href="#">Wish Mary on her birthday!</a></li>
                                                    <li><a href="#">5 warnings in Server Console</a></li>
                                                </ul>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="#">
                                                    <span class="material-icons">question_answer</span>
                                                </a>
                                            </li>
                                            <li class="nav-item dropdown">
                                                <a class="nav-link" href="#" data-toggle="dropdown">
                                                    <img src="img/admin2.jpg" style="width:35px; border-radius:50%;"/>
                                                    <span class="xp-user-live"></span>
                                                </a>
                                                <ul class="dropdown-menu small-menu">
                                                    <li>
                                                        <a href="#"><span class="material-icons">settings</span>Settings</a>
                                                    </li>
                                                    <li>
                                                        <a href="login.jsp"><span class="material-icons">logout</span>Logout</a>
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <!-- End XP Col -->

                        </div> 
                        <!-- End XP Row -->

                    </div>
                    <div class="xp-breadcrumbbar text-center">
                        <h4 class="page-title">Dashboard</h4>  
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#">Booster</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
                        </ol>                
                    </div>

                </div>


                <!--------main-content------------->

                <div class="main-content">
                    <div class="row" id="tableStaff_main">

                        <div id="staffTable" class="col-md-12">
                            <div id="customertable" class="table-wrapper">
                                <div class="table-title">
                                    <div class="row">
                                        <div class="col-sm-6 p-0 d-flex justify-content-lg-start justify-content-center">
                                            <h2 class="ml-lg-2">Manage Customers</h2>
                                            <!--<h2 class="ml-lg-4">Sort</h2>-->
                                        </div>
                                        <div class="col-sm-3 p-0 d-flex justify-content-lg-start justify-content-center">
                                            <ul class="nav navbar-nav menu_nav ml-auto">
                                                <li class="nav-item submenu dropdown">
                                                    <a href="#" class="nav-link custom1-dropdown1" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                                        <span>Sort</span> <i class="material-icons">arrow_drop_down</i></a>
                                                    <ul class="dropdown-menu custom2-dropdown1">
                                                        <li class="nav-item submenu dropdown custom2-dropdown2">
                                                            <a href="#" class="nav-link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                                                Asscending</a>
                                                            <ul class=" custom2-dropdown3">
                                                                <li class="nav-item">
                                                                    <a class="nav-link" href="guest?sortby=lastName&orderSort=asc&searchGuest=${not empty searchGuest?searchGuest:''}">Name</a>
                                                                </li>
                                                                <li class="nav-item">
                                                                    <a class="nav-link" href="guest?sortby=dateOfBirth&orderSort=desc&searchGuest=${not empty searchGuest?searchGuest:''}">Age</a>
                                                                </li>
                                                                <li class="nav-item">
                                                                    <a class="nav-link" href="guest?sortby=city&orderSort=asc&searchGuest=${not empty searchGuest?searchGuest:''}">City</a>
                                                                </li>
                                                            </ul>
                                                        </li>
                                                        <li class="nav-item submenu dropdown custom2-dropdown2">
                                                            <a href="#" class="nav-link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                                                Decreasing</a>
                                                            <ul class=" custom2-dropdown3">
                                                                <li class="nav-item">
                                                                    <a class="nav-link" href="guest?sortby=lastName&orderSort=desc&searchGuest=${not empty searchGuest?searchGuest:''}">Name</a>
                                                                </li>
                                                                <li class="nav-item">
                                                                    <a class="nav-link" href="guest?sortby=dateOfBirth&orderSort=asc&searchGuest=${not empty searchGuest?searchGuest:''}">Age</a>
                                                                </li>
                                                                <li class="nav-item">
                                                                    <a class="nav-link" href="guest?sortby=city&orderSort=desc&searchGuest=${not empty searchGuest?searchGuest:''}">City</a>
                                                                </li>
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </div>
                                        <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                            <div class="col-sm-3 p-0 d-flex justify-content-lg-end justify-content-center">
                                                <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal">
                                                    <i class="material-icons">&#xE147;</i> <span>Add New Customer</span></a>
                                                <a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal">
                                                    <i class="material-icons">&#xE15C;</i> <span>Delete</span></a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <!--<form action="staff">-->
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                                <th>
                                                    <span class="custom-checkbox">
                                                        <input type="checkbox" id="selectAll">
                                                        <label for="selectAll"></label>
                                                    </span>
                                                </th>
                                            </c:if>
                                            <th style="white-space: nowrap;">First Name</th>
                                            <th style="white-space: nowrap;">Last Name</th>
                                            <th style="white-space: nowrap;">Date Of Birth</th>
                                            <th>Address</th>
                                            <th>City</th>
                                            <th>Country</th>
                                            <th>Phone</th>
                                            <th>Email</th>
                                                <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                                <th>Actions</th>
                                                </c:if>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listGuestSS}" var="gs">
                                            <tr>
                                                <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                                    <td>
                                                        <span class="custom-checkbox">
                                                            <input type="checkbox" class="select-item" id="checkbox1" name="options[]" value="${gs.guestID}"/>
                                                            <label for="checkbox1"></label>
                                                        </span>
                                                    </td>
                                                </c:if>
                                                <td style="white-space: nowrap;">${gs.firstName}</td>
                                                <td style="white-space: nowrap;">${gs.lastName}</td>
                                                <td style="white-space: nowrap;">${gs.dateOfBirth}</td>
                                                <td style="white-space: nowrap;">${gs.address}</td>
                                                <td style="white-space: nowrap;">${gs.city}</td>
                                                <td style="white-space: nowrap;">${gs.country}</td>
                                                <td>${gs.phone}</td>
                                                <td style="font-size: 13px">${gs.email}</td>
                                                <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                                    <td>
                                                        <a href="#editEmployeeModal" class="edit" data-toggle="modal"
                                                           onclick="guestFrom('${gs.guestID}', '${gs.firstName}', '${gs.lastName}', '${gs.dateOfBirth}',
                                                                           '${gs.address}', '${gs.city}', '${gs.country}', '${gs.phone}', '${gs.email}');
                                                                   return false;">
                                                            <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                                                        <a href="#" class="delete" data-toggle="modal" data-target="#deleteEmployeeModal" data-id="${gs.guestID}">
                                                            <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                                                    </td> 
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <div class="clearfix">
                                    <div class="hint-text">Showing <b>${count<5?count:'5'}</b> out of <b>${count}</b> entries</div>
                                    <ul class="pagination">
                                        <c:if test="${tag > 1}">
                                            <li class="page-item disabled"><a href="guest?sortby=${not empty sortby?sortby:'default'}&orderSort=${not empty orderSort?orderSort:'default'}&index=${tag - 1}&searchGuest=${not empty searchGuest?searchGuest:''}">Previous</a></li>
                                            </c:if>
                                            <c:forEach begin="1" end="${endPage}" var="i">
                                            <li class="page-item  ${tag == i?"active":""}"><a href="guest?sortby=${not empty sortby?sortby:'default'}&orderSort=${not empty orderSort?orderSort:'default'}&index=${i}&searchGuest=${not empty searchGuest?searchGuest:''}" class="page-link">${i}</a></li>
                                            </c:forEach>
                                            <c:if test="${tag < endPage}">
                                            <li class="page-item"><a href="guest?sortby=${not empty sortby?sortby:'default'}&orderSort=${not empty orderSort?orderSort:'default'}&index=${tag + 1}&searchGuest=${not empty searchGuest?searchGuest:''}" class="page-link">Next</a></li>
                                            </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Edit Modal HTML -->
                        <div id="addEmployeeModal" class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form action="insertasg" method="post">
                                        <input type="hidden" name="insert" value="insertGuest"/>
                                        <div class="modal-header">
                                            <h4 class="modal-title">Add Customer</h4>
                                            <button type="button" class="close" data-dismiss="modal" 
                                                    aria-hidden="true">&times;</button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group" style="display: flex; gap: 10px">
                                                <div style="flex: 1;">
                                                    <label>First Name</label>
                                                    <input type="text" value="${fname}" name="fname" class="form-control" required>
                                                </div>
                                                <div style="flex: 1;">
                                                    <label>Last Name</label>
                                                    <input type="text" value="${lname}" name="lname" class="form-control" required>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>DOB</label>
                                                <input type="date" value="${dob}" name="dob" class="form-control" required>
                                            </div>

                                            <div class="form-group">
                                                <label>Address</label>
                                                <input type="text" value="${add}" name="add" class="form-control" >
                                            </div>
                                            <div class="form-group" style="display: flex; gap: 10px">
                                                <div style="flex: 1">
                                                    <label>City</label>
                                                    <input type="text" value="${city}" name="city" class="form-control" >
                                                </div>
                                                <div style="flex: 1">
                                                    <label>Country</label>
                                                    <input type="text" value="${country}" name="country" class="form-control" >
                                                </div>
                                            </div>

                                            <div class="form-group" style="display: flex; gap: 10px">
                                                <div style="flex: 1">
                                                    <label>Phone</label>
                                                    <input type="text" value="${phone}" name="phone" class="form-control" required>
                                                    <p id="phoneError" style="color: red;">${phoneError}</p>
                                                </div>
                                                <div style="flex: 1">
                                                    <label>Email</label>
                                                    <input type="email" value="${email}" name="email" class="form-control" required>
                                                    <p id="emailError" style="color: red;">${emailError}</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                            <input type="submit" class="btn btn-info" value="Save">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Edit Modal HTML -->
                        <div id="editEmployeeModal" class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form action="updateasg" method="post">
                                        <input type="hidden" name="update" value="updateGuest"/>
                                        <input type="hidden" name="guestIDud" value="${gs.guestID}" id="guestIDud"/>
                                        <div class="modal-header">
                                            <h4 class="modal-title">Edit Customer</h4>
                                            <button type="button" class="close" data-dismiss="modal" 
                                                    aria-hidden="true">&times;</button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group" style="display: flex; gap: 10px">
                                                <div style="flex: 1;">
                                                    <label>First Name</label>
                                                    <input type="text" name="fnameud" id="fnameud" class="form-control" required>
                                                </div>
                                                <div style="flex: 1;">
                                                    <label>Last Name</label>
                                                    <input type="text" name="lnameud" id="lnameud" class="form-control" required>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>DOB</label>
                                                <input type="date" id="dobud" name="dobud" class="form-control" required>
                                            </div>

                                            <div class="form-group" style="display: flex; gap: 10px">
                                                <div style="flex: 1;">
                                                    <label>Country</label>
                                                    <input type="text" id="countryud" name="countryud" class="form-control" >
                                                </div>
                                                <div style="flex: 1;">
                                                    <label>City</label>
                                                    <input type="text" id="cityud" name="cityud" class="form-control" >
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>Address</label>
                                                <input type="text" id="addud" name="addud" class="form-control" >
                                            </div>

                                            <div class="form-group" style="display: flex; gap: 10px">
                                                <div style="flex: 1;">
                                                    <label>Phone</label>
                                                    <input type="text" id="phoneud" name="phoneud" class="form-control" required>
                                                    <p id="phoneudError" style="color: red;">${phoneudError}</p>
                                                </div>
                                                <div style="flex: 1;">
                                                    <label>Email</label>
                                                    <input type="email" id="emailud" name="emailud" class="form-control" required>
                                                    <p id="emailudError" style="color: red;">${emailudError}</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                            <input type="submit" class="btn btn-info" value="Save">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>


                        <!-- Delete Modal HTML -->
                        <div id="deleteEmployeeModal" class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form action="deleteguest" method="post">
                                        <div class="modal-header">
                                            <h4 class="modal-title">Delete Customer</h4>
                                            <button type="button" class="close" data-dismiss="modal" 
                                                    aria-hidden="true">&times;</button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Are you sure you want to delete these Records?</p>
                                            <p class="text-warning"><small>This action cannot be undone.</small></p>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                            <!--<input id="deleteStaffBtn" type="submit" class="btn btn-danger" value="Delete">-->
                                            <button id="deleteStaffBtn" class="btn btn-danger">Delete</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!---footer---->

                </div>

                <footer class="footer">
                    <div class="container-fluid">
                        <div class="footer-in">
                            <p class="mb-0">&copy 2025 Royal Hotel.</p>
                        </div>
                    </div>
                </footer>
            </div>
        </div>


        <!----------html code compleate----------->
        <script>
            //delete checkbox
            $(document).ready(function () {
                restoreSelection(); // Khôi phục checkbox khi tải trang
                // Chọn/Bỏ chọn tất cả
                $("#selectAll").click(function () {
                    let isChecked = this.checked;
                    $(".select-item").prop("checked", isChecked);

                    let selectedStaff = [];
                    if (isChecked) {
                        // Nếu chọn tất cả, lưu toàn bộ staff ID vào mảng
                        $(".select-item").each(function () {
                            selectedStaff.push($(this).val());
                        });
                    }
                    localStorage.setItem("selectedStaff", JSON.stringify(selectedStaff));
                });

                // Xử lý chọn từng checkbox
                $(".select-item").click(function () {
                    updateSelection($(this).val(), $(this).prop("checked"));
                });
                // Khi nhấn "Delete" để lấy danh sách Staff ID
                $(".btn-danger[data-toggle='modal']").click(function () {
                    let selectedIDs = JSON.parse(localStorage.getItem("selectedStaff")) || [];
                    if (selectedIDs.length === 0) {
                        alert("Please select at least one staff to delete.");
                        return false;
                    }
                    // Lưu danh sách ID vào thuộc tính data
                    $("#deleteStaffBtn").data("selected-ids", selectedIDs);
                });
                // Khi nhấn "Delete" trong modal -> gửi AJAX
                $("#deleteStaffBtn").click(function () {
                    let staffIDs = $(this).data("selected-ids");
                    if (staffIDs.length > 0) {
                        $.ajax({
                            type: "POST",
                            url: "deleteguest",
                            traditional: true,
                            data: {guestIDud: staffIDs},
                            success: function () {
                                $("#deleteEmployeeModal").modal("hide");
                                alert("Selected staff deleted successfully!");
                                localStorage.removeItem("selectedStaff"); // Xóa danh sách đã chọn
                                setTimeout(function () {
                                    location.reload();
                                }, 500);
                            },
                            error: function () {
                                alert("Error deleting staff. Please try again.");
                            }
                        });
                    }
                });
            });
            // 🛠️ **Cập nhật trạng thái checkbox vào localStorage**
            function updateSelection(staffID, isChecked) {
                let selectedStaff = JSON.parse(localStorage.getItem("selectedStaff")) || [];
                if (isChecked) {
                    // Nếu chọn thì thêm vào danh sách nếu chưa có
                    if (!selectedStaff.includes(staffID)) {
                        selectedStaff.push(staffID);
                    }
                } else {
                    // Nếu bỏ chọn thì xóa khỏi danh sách
                    selectedStaff = selectedStaff.filter(id => id !== staffID);
                }
                localStorage.setItem("selectedStaff", JSON.stringify(selectedStaff));
            }

            // 🔄 **Khôi phục trạng thái checkbox khi chuyển trang**
            function restoreSelection() {
                let selectedStaff = JSON.parse(localStorage.getItem("selectedStaff")) || [];

                $(".select-item").each(function () {
                    if (selectedStaff.includes($(this).val())) {
                        $(this).prop("checked", true);
                    }
                });
                // Cập nhật trạng thái "Select All" dựa trên checkbox đã chọn
                $("#selectAll").prop("checked", $(".select-item:checked").length === $(".select-item").length);
            }



            //delete icon thung rac
            var staffIDToDelete = ""; // Lưu Staff ID cần xóa
            // Khi nhấn vào nút xóa, lấy Staff ID từ `data-id`
            $(".delete").click(function () {
                staffIDToDelete = $(this).data("id"); // Lưu ID vào biến
            });
            // Khi nhấn nút Delete trong modal, gửi yêu cầu AJAX
            $("#deleteStaffBtn").click(function () {
                if (staffIDToDelete) {
                    $.ajax({
                        type: "POST",
                        url: "deleteguest", // Servlet xử lý xóa
                        data: {guestIDud: staffIDToDelete},
                        success: function () {
                            $("#deleteEmployeeModal").modal("hide"); // Ẩn modal sau khi xóa
                            alert("Staff deleted successfully!");
                            setTimeout(function () {
                                location.reload(); // Reload trang sau khi modal đóng
                            }, 500); // Chờ modal đóng rồi reload
                        },
                        error: function () {
                            alert("Error deleting staff. Please try again.");
                        }
                    });
                }
            });
        </script>


        <script>
            // hien thi alert nhap id trung
            document.addEventListener("DOMContentLoaded", function () {
                var phoneError = document.getElementById("phoneError")?.innerText.trim();
                var emailError = document.getElementById("emailError")?.innerText.trim();
                var phoneudError = document.getElementById("phoneudError")?.innerText.trim();
                var emailudError = document.getElementById("emailudError")?.innerText.trim();

                var errorMessages = [];

                if (phoneError) {
                    errorMessages.push(phoneError);
                }
                if (emailError) {
                    errorMessages.push(emailError);
                }
                if (phoneudError) {
                    errorMessages.push(phoneudError);
                }
                if (emailudError) {
                    errorMessages.push(emailudError);
                }

                if (errorMessages.length > 0) {
                    // Hiển thị alert với tất cả lỗi
                    Swal.fire({
                        icon: "error",
                        title: "Oops...",
                        html: errorMessages.join("<br>"), // Xuống dòng trong alert
                        confirmButtonColor: "#d33",
                        confirmButtonText: "OK"
                    }).then(() => {
                        // Đảm bảo modal mở lại ngay sau khi alert đóng
                        $("#addEmployeeModal").modal("show");
                    });

                    // Giữ modal mở ngay từ đầu nếu có lỗi
                    $("#addEmployeeModal").modal("show");
                }
            });


        </script>

        <script>
            function guestFrom(id, fname, lname, dob, add, city, country, phone, email) {
                document.getElementById("guestIDud").value = id;
                document.getElementById("fnameud").value = fname;
                document.getElementById("lnameud").value = lname;
                document.getElementById("dobud").value = dob;
                document.getElementById("addud").value = add;
                document.getElementById("cityud").value = city;
                document.getElementById("countryud").value = country;
                document.getElementById("phoneud").value = phone;
                document.getElementById("emailud").value = email;
            }

        </script>


        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="js/jquery-3.3.1.slim.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-3.3.1.min.js"></script>


        <script type="text/javascript">

            $(document).ready(function () {
                $(".xp-menubar").on('click', function () {
                    $('#sidebar').toggleClass('active');
                    $('#content').toggleClass('active');
                });

                $(".xp-menubar,.body-overlay").on('click', function () {
                    $('#sidebar,.body-overlay').toggleClass('show-nav');
                });

            });

        </script>
    </body>

    <style>
        .custom1-dropdown1 {
            background: #21a117;
            border-radius: 2px;
            /*box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);*/
            /*padding: 10px 0;*/
            min-width: 70px;
        }

        .custom1-dropdown1:hover {
            background: #1e7e34;
            border-radius: 5px;
        }

        .custom2-dropdown1 .nav-item a {
            color: #333;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .custom2-dropdown1 .nav-item a:hover {
            background: #f8f9fa;
            color: #007bff;
            border-radius: 5px;
        }

        .custom2-dropdown3{
            display: none;
            position: absolute;
            right: 100%; /* Hiển thị bên phải của menu cha */
            top: 0;
            background: white;
            padding: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            min-width: 150px;
        }

        .custom2-dropdown2:hover .custom2-dropdown3{
            display: block;
        }

        .custom2-dropdown1{
            min-width: 120px;
        }

    </style>
</html>



