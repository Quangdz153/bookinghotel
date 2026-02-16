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
                    <!--<li class="nav-item submenu dropdown ${pageContext.request.requestURI.contains('CRUD') && !pageContext.request.requestURI.contains('accountstaff') ? 'active' : ''}">-->
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
                                    <form action="accountguest" method="get">
                                        <div class="input-group">
                                            <input type="search" name="searchAccount" value="${searchAccount}" class="form-control" placeholder="Search">
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

                    <!--Account-->
                    <div class="row" id="tableStaffAccount">
                        <div id="" class="col-md-12">
                            <div id="customertable" class="table-wrapper">
                                <div class="table-title">
                                    <div class="row">
                                        <div class="col-sm-6 p-0 d-flex justify-content-lg-start justify-content-center">
                                            <h2 class="ml-lg-2">Account Customers</h2>
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
                                                                    <a class="nav-link" href="accountguest?sortby=Username&orderSort=asc&searchAccount=${not empty searchAccount?searchAccount:''}">Username</a>
                                                                </li>
                                                                <li class="nav-item">
                                                                    <a class="nav-link" href="accountguest?sortby=CreatedAt&orderSort=asc&searchAccount=${not empty searchAccount?searchAccount:''}">CreatedAt</a>
                                                                </li>
                                                            </ul>
                                                        </li>
                                                        <li class="nav-item submenu dropdown custom2-dropdown2">
                                                            <!--<a class="nav-link" href="#">Blog Details</a>-->
                                                            <a href="#" class="nav-link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                                                Decreasing</a>
                                                            <ul class=" custom2-dropdown3">
                                                                <li class="nav-item">
                                                                    <a class="nav-link" href="accountguest?sortby=Username&orderSort=desc&searchAccount=${not empty searchAccount?searchAccount:''}">Username</a>
                                                                </li>
                                                                <li class="nav-item">
                                                                    <a class="nav-link" href="accountguest?sortby=CreatedAt&orderSort=desc&searchAccount=${not empty searchAccount?searchAccount:''}">CreatedAt</a>
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
                                                    <i class="material-icons">&#xE147;</i> <span>Create Account</span></a>
                                                <a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal">
                                                    <i class="material-icons">&#xE15C;</i> <span>Delete</span></a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

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
                                            <th style="white-space: nowrap;">Username</th>
                                                <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                                <th style="white-space: nowrap;">Password</th>
                                                </c:if>
                                            <th>Phone</th>
                                            <th>Email</th>
                                            <th>Role</th>
                                            <th style="white-space: nowrap;">Created Date</th>
                                                <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                                <th>Actions</th>
                                                </c:if>
                                            <th>Profile</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listAccGuest}" var="acc1">
                                            <tr>
                                                <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                                    <td>
                                                        <span class="custom-checkbox">
                                                            <input type="checkbox" class="select-item" id="checkbox1" name="options[]" value="${acc1.accountID}"/>
                                                            <label for="checkbox1"></label>
                                                        </span>
                                                    </td>
                                                </c:if>
                                                <td style="white-space: nowrap;">${acc1.username}</td>
                                                <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                                    <td style="white-space: nowrap;">${acc1.password}</td>
                                                </c:if>
                                                <td>${acc1.guest.phone}</td>
                                                <td>${acc1.guest.email}</td>
                                                <td style="white-space: nowrap;">${acc1.role}</td>
                                                <td style="white-space: nowrap; font-size: 14px">${acc1.createAt}</td>
                                                <c:if test="${not empty sessionScope.acc && sessionScope.acc.role != null && sessionScope.acc.role == 'Admin'}">
                                                    <td>
                                                        <a href="#editEmployeeModal" class="edit" data-toggle="modal"
                                                           onclick="guestAccFrom('${acc1.accountID}', '${acc1.username}', '${acc1.password}', '${acc1.role}', '${acc1.guest.guestID}');return false;">
                                                            <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                                                        <a href="#" class="delete" data-toggle="modal" data-target="#deleteEmployeeModal" data-id="${acc1.accountID}">
                                                            <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                                                    </td> 
                                                </c:if>
                                                <td>
                                                    <a href="#profileCustomerModal" class="btn btn-success" style="color: #f8f9fa; font-size: 14px" data-toggle="modal"
                                                       onclick="guestFromProfile('${acc1.guest.guestID}', '${acc1.guest.firstName}', '${acc1.guest.lastName}',
                                                                       '${acc1.guest.dateOfBirth}', '${acc1.guest.address}', '${acc1.guest.city}',
                                                                       '${acc1.guest.country}', '${acc1.guest.phone}', '${acc1.guest.email}'
                                                                       );
                                                               return false;">
                                                        <span>Show</span></a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <div class="clearfix">
                                    <div class="hint-text">Showing <b>${count<5?count:'5'}</b> out of <b>${count}</b> entries</div>
                                    <ul class="pagination">
                                        <c:if test="${tag > 1}">
                                            <li class="page-item disabled"><a href="accountguest?sortby=${not empty sortby?sortby:'default'}&orderSort=${not empty orderSort?orderSort:'default'}&index=${tag - 1}&searchAccount=${not empty searchAccount?searchAccount:''}">Previous</a></li>
                                            </c:if>
                                            <c:forEach begin="1" end="${endPage}" var="i">
                                            <li class="page-item  ${tag == i?"active":""}"><a href="accountguest?sortby=${not empty sortby?sortby:'default'}&orderSort=${not empty orderSort?orderSort:'default'}&index=${i}&searchAccount=${not empty searchAccount?searchAccount:''}" class="page-link">${i}</a></li>
                                            </c:forEach>
                                            <c:if test="${tag < endPage}">
                                            <li class="page-item"><a href="accountguest?sortby=${not empty sortby?sortby:'default'}&orderSort=${not empty orderSort?orderSort:'default'}&index=${tag + 1}&searchAccount=${not empty searchAccount?searchAccount:''}" class="page-link">Next</a></li>
                                            </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Create Modal HTML -->
                        <div id="addEmployeeModal" class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form action="insertasg" method="post">
                                        <input type="hidden" name="insert" value="insertAccountGuest"/>
                                        <div class="modal-header">
                                            <h4 class="modal-title">Create Account</h4>
                                            <button type="button" class="close" data-dismiss="modal" 
                                                    aria-hidden="true">&times;</button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group" style="display: flex; gap: 10px">
                                                <div style="flex: 1;">
                                                    <label>username</label>
                                                    <input type="text" value="${username}" name="username" class="form-control" required>
                                                    <p id="userError" style="color: red;">${userError}</p>
                                                </div>
                                                <div style="flex: 1;">
                                                    <label>password</label>
                                                    <input type="text" value="${password}" name="password" class="form-control" required>
                                                </div>
                                            </div>

                                            <div class="form-group" style="display: flex; gap: 10px">
                                                <div style="flex: 0.5;">
                                                    <label>Position</label>
                                                    <input type="text" name="role" value="Guest" class="form-control" readonly/>
                                                </div>

                                                <div style="flex: 0.5">
                                                    <label>Guest do not have account</label>
                                                    <select value="${guestID}" name="guestID" class="form-control">
                                                        <option>Choose</option>
                                                        <c:forEach var="notAcc" items="${listGuestNotAcc}">
                                                            <option value="${notAcc.guestID}" ${guestID==notAcc.guestID?'selected':''}>${notAcc.phone}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <!--<p id="staffIDError" style="color: red;"></p>-->
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
                                        <input type="hidden" name="update" value="updateAccountGuest"/>
                                        <input type="hidden" name="AccountID" value="${acc1.accountID}" id="AccountID"/>
                                        <div class="modal-header">
                                            <h4 class="modal-title">Edit Account Customers</h4>
                                            <button type="button" class="close" data-dismiss="modal" 
                                                    aria-hidden="true">&times;</button>
                                        </div>
                                        <div class="modal-body">
                                            <div style="width: 30%">
                                                <label>Guest ID</label>
                                                <input value="${acc1.guest.guestID}" id="guestidAcc" readonly class="form-control" name="GuestID"/>
                                            </div>

                                            <div class="form-group" style="display: flex; gap: 10px">
                                                <div style="flex: 1;">
                                                    <label>User Name</label>
                                                    <input type="text" value="" name="username" id="username" class="form-control" required>
                                                    <p id="userUdError" style="color: red;">${userUdError}</p>
                                                </div>
                                                <div style="flex: 1;">
                                                    <label>Password</label>
                                                    <input type="text" value="" name="password" id="password" class="form-control" required>
                                                </div>
                                            </div>

                                            <div style="width: 30%">
                                                <label>Role</label>
                                                <select name="role" id="role" class="form-control">
                                                    <option value="">Choose</option>
                                                    <option value="Admin" 
                                                            <c:if test="${role eq 'Admin'}">selected</c:if>>Admin</option>
                                                            <option value="Staff" 
                                                            <c:if test="${role eq 'Staff'}">selected</c:if>>Staff</option>
                                                            <option value="Guest" 
                                                            <c:if test="${role eq 'Guest'}">selected</c:if>>Guest</option>
                                                    </select>
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



                            <!--Profile-->
                            <div id="profileCustomerModal" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <form action="" method="">
                                            <input type="hidden" name="staffID" value="${acc1.guest.guestID}" id="guestID"/>
                                        <div class="modal-header">
                                            <h4 class="modal-title">Profile Customers</h4>
                                            <button type="button" class="close" data-dismiss="modal" 
                                                    aria-hidden="true">&times;</button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group" style="display: flex; gap: 10px">
                                                <div style="flex: 1;">
                                                    <label>First Name</label>
                                                    <input type="text" name="fname" id="fname" class="form-control" readonly>
                                                </div>
                                                <div style="flex: 1;">
                                                    <label>Last Name</label>
                                                    <input type="text" name="lname" id="lname" class="form-control" readonly>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>DOB</label>
                                                <input type="date" id="dob" name="dob" class="form-control" readonly>
                                            </div>

                                            <div class="form-group" style="display: flex; gap: 10px">
                                                <div style="flex: 1;">
                                                    <label>Country</label>
                                                    <input type="text" id="country" name="country" class="form-control" readonly>
                                                </div>
                                                <div style="flex: 1;">
                                                    <label>City</label>
                                                    <input type="text" id="city" name="city" class="form-control" readonly>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>Address</label>
                                                <input type="text" id="add" name="add" class="form-control" readonly>
                                            </div>

                                            <div class="form-group" style="display: flex; gap: 10px">
                                                <div style="flex: 1;">
                                                    <label>Phone</label>
                                                    <input type="text" id="phone" name="phone" class="form-control" readonly>
                                                </div>
                                                <div style="flex: 1;">
                                                    <label>Email</label>
                                                    <input type="email" id="email" name="email" class="form-control" readonly>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                            <!--<input type="submit" class="btn btn-info" value="Save">-->
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>


                        <!-- Delete Modal HTML -->
                        <div id="deleteEmployeeModal" class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form action="deleteacccountguest" method="post">
                                        <div class="modal-header">
                                            <h4 class="modal-title">Delete Account</h4>
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
                                            <button id="deleteStaffBtn" type="submit" class="btn btn-danger">Delete</button>
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
                            <p class="mb-0">&copy 2025 Royal Hotel </p>
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
                        alert("Please select at least one Account guest to delete.");
                        return false;
                    }
                    // Lưu danh sách ID vào thuộc tính data
                    $("#deleteStaffBtn").data("selected-ids", selectedIDs);
                });
                // Khi nhấn "Delete" trong modal -> gửi AJAX
                $("#deleteStaffBtn").click(function () {
                    let accGuestIDs = $(this).data("selected-ids");
                    if (accGuestIDs.length > 0) {
                        $.ajax({
                            type: "POST",
                            url: "deleteacccountguest",
                            traditional: true,
                            data: {AccountID: accGuestIDs},
                            success: function () {
                                $("#deleteEmployeeModal").modal("hide");
                                alert("Selected Account guest deleted successfully!");
                                localStorage.removeItem("selectedStaff"); // Xóa danh sách đã chọn
                                setTimeout(function () {
                                    location.reload();
                                }, 500);
                            },
                            error: function () {
                                alert("Error deleting Account guest. Please try again.");
                            }
                        });
                    }
                });
            });
            // 🛠️ **Cập nhật trạng thái checkbox vào localStorage**
            function updateSelection(accountID, isChecked) {
                let selectedStaff = JSON.parse(localStorage.getItem("selectedStaff")) || [];
                if (isChecked) {
                    // Nếu chọn thì thêm vào danh sách nếu chưa có
                    if (!selectedStaff.includes(accountID)) {
                        selectedStaff.push(accountID);
                    }
                } else {
                    // Nếu bỏ chọn thì xóa khỏi danh sách
                    selectedStaff = selectedStaff.filter(id => id !== accountID);
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
                if ($(".select-item:checked").length === $(".select-item").length) {
                    $("#selectAll").prop("checked", true);
                } else {
                    $("#selectAll").prop("checked", false);
                }
            }



            //delete icon thung rac
            var accGuestIDToDelete = ""; // Lưu Staff ID cần xóa
            // Khi nhấn vào nút xóa, lấy Staff ID từ `data-id`
            $(".delete").click(function () {
                accGuestIDToDelete = $(this).data("id"); // Lưu ID vào biến
            });
            // Khi nhấn nút Delete trong modal, gửi yêu cầu AJAX
            $("#deleteStaffBtn").click(function () {
                if (accGuestIDToDelete) {
                    $.ajax({
                        type: "POST",
                        url: "deleteacccountguest", // Servlet xử lý xóa
                        data: {AccountID: accGuestIDToDelete},
                        success: function () {
                            $("#deleteEmployeeModal").modal("hide"); // Ẩn modal sau khi xóa
                            alert("Account Guest deleted successfully!");
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
                var userError = document.getElementById("userError")?.innerText.trim();
                var userUdError = document.getElementById("userUdError")?.innerText.trim();
//                var staffIDError = document.getElementById("staffIDError")?.innerText.trim();
                var errorMessages = [];

                if (userError) {
                    errorMessages.push(userError);
                }
                if (userUdError) {
                    errorMessages.push(userUdError);
                }
//                if (staffIDError) {
//                    errorMessages.push(staffIDError);
//                }

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
            function guestAccFrom(id, user, pass, role, guestidAcc) {
                document.getElementById("AccountID").value = id;
                document.getElementById("username").value = user;
                document.getElementById("password").value = pass;
                document.getElementById("role").value = role;
                document.getElementById("guestidAcc").value = guestidAcc;
            }

            function guestFromProfile(id, fname, lname, dob, add, city, country, phone, email) {
                document.getElementById("guestID").value = id;
                document.getElementById("fname").value = fname;
                document.getElementById("lname").value = lname;
                document.getElementById("dob").value = dob;
                document.getElementById("add").value = add;
                document.getElementById("city").value = city;
                document.getElementById("country").value = country;
                document.getElementById("phone").value = phone;
                document.getElementById("email").value = email;
            }

//            function showGuest(selectOption) {
//                var staff = document.getElementById("tableStaff_main");
//                var staffAcc = document.getElementById("tableStaffAccount");
//                if (selectOption === 'guest') {
//                    staff.style.display = "block";
//                    staffAcc.style.display = "none";
//                } else if (selectOption === 'account') {
//                    staff.style.display = "none";
//                    staffAcc.style.display = "block";
//                }
//                sessionStorage.setItem("selectedStaff", selectOption);
//            }
//
//            // Khi trang load lại, lấy trạng thái đã lưu
//            document.addEventListener("DOMContentLoaded", function () {
//                var selectedStaff = sessionStorage.getItem("selectedStaff");
//                if (selectedStaff) {
//                    showGuest(selectedStaff);
//                }
//            });

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
            left: 100%; /* Hiển thị bên phải của menu cha */
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



