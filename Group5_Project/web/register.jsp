<%-- 
    Document   : register
    Created on : Mar 3, 2025, 1:08:40 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="image/favicon1.png" type="image/png">
        <title>Royal Hotel - Register</title>
        <meta name="theme-color" content="#33b5e5">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="https://mdbcdn.b-cdn.net/wp-content/themes/mdbootstrap4/docs-app/css/dist/mdb5/standard/core.min.css">
        <link rel="stylesheet" id="roboto-subset.css-css" href="https://mdbcdn.b-cdn.net/wp-content/themes/mdbootstrap4/docs-app/css/mdb5/fonts/roboto-subset.css?ver=3.9.0-update.5" type="text/css" media="all">
    </head>
    <style>
        body {
            background-image: url('https://cdn.blastness.biz/media/1288/royalvictoria-top/thumbs/full/royalvictoria_esterni14_top.jpg');
            background-size: cover;  /* Phủ toàn bộ màn hình */
            background-position: center; /* Căn giữa */
            background-repeat: no-repeat; /* Không lặp lại */
            height: 100vh;
            overflow: hidden;
        }
        /*        #pills-register{
                    margin-bottom: -30px;
                }*/
        #container123{
            background-color: white;
            margin: 0 auto;
            margin-top: 5%;
            padding: 2%;
            width: 30%;
            border-radius: 3%;
        }

    </style>

    <body>
        <!-- Pills navs -->
        <div id="container123" >
            <!--            <div class="alert alert-danger" role="alert">
            ${mess}
        </div>-->
            <ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="tab-login" href="login.jsp?tab=login" role="tab"
                       aria-controls="pills-login">Login</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="tab-register" href="register.jsp?tab=register" role="tab"
                       aria-controls="pills-register">Register</a>
                </li>
            </ul>

            <!-- Pills navs -->

            <!-- Pills content -->
            <div class="tab-content">

                <div class="tab-pane fade show active" id="pills-register" role="tabpanel" aria-labelledby="tab-register">
                    <form action="login" method="post">
                        <input type="hidden" name="action" value="register"/>
                        <div class="text-center mb-3">
                            <p>Sign up with:</p>
                            <button  type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-facebook-f"></i>
                            </button>

                            <button  type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-google"></i>
                            </button>

                            <button  type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-twitter"></i>
                            </button>

                            <button  type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-github"></i>
                            </button>
                        </div>

                        <!-- Name input -->
                        <div data-mdb-input-init class="form-outline mb-4">
                            <input type="text" id="registerName" name="rname" value="${rname}" class="form-control" required/>
                            <label class="form-label" for="registerName">Name</label>
                        </div>

                        <!-- Username input -->
                        <span id="errUser" style="display: block; color: red">${errUser}</span>
                        <div data-mdb-input-init class="form-outline mb-4">
                            <input type="text" id="registerUsername" name="ruser" value="${ruser}" class="form-control" required/>
                            <label class="form-label" for="registerUsername">Username</label>
                        </div>

                        <!-- Email input -->
                        <span id="errEmail" style="display: block; color: red">${errEmail}</span>
                        <div data-mdb-input-init class="form-outline mb-4">
                            <input type="email" id="registerEmail" name="remail" value="${remail}" class="form-control" required/>
                            <label class="form-label" for="registerEmail">Email</label>
                        </div>

                        <!-- Date of Birth -->
                        <div data-mdb-input-init class="form-outline mb-4">
                            <input type="date" id="registerBirth" name="rbirth" value="${rbirth}" class="form-control"/>
                            <label class="form-label" for="registerBirth">Date of Birth</label>
                        </div>
                            
                        <!-- Address -->
                        <div data-mdb-input-init class="form-outline mb-4">
                            <input type="text" id="registerAddress" name="raddress" value="${raddress}" class="form-control"/>
                            <label class="form-label" for="registerAddress">Address</label>
                        </div>

                        <!-- City -->
                        <div data-mdb-input-init class="form-outline mb-4">
                            <input type="text" id="registerCity" name="rcity" value="${rcity}" class="form-control"/>
                            <label class="form-label" for="registerCity">City</label>
                        </div>

                        <!-- Country -->
                        <div data-mdb-input-init class="form-outline mb-4">
                            <input type="text" id="registerCountry" name="rcountry" value="${rcountry}" class="form-control"/>
                            <label class="form-label" for="registerCountry">Country</label>
                        </div>
                        <!--  Phone input -->
                        <span id="errPhone" style="display: block; color: red">${errPhone}</span>
                        <div data-mdb-input-init class="form-outline mb-4">
                            <input type="tel" id="registerPhone" name="rphone" value="${rphone}" class="form-control" 
                                   pattern="[0-9]{10,15}" required/>
                            <label class="form-label" for="registerPhone">Phone number</label>
                        </div>   

                        <!-- Password input -->
                        <div data-mdb-input-init class="form-outline mb-4">
                            <input type="password" id="registerPassword" name="rpass" value="${rpass}" class="form-control" required/>
                            <label class="form-label" for="registerPassword">Password</label>
                        </div>



                        <!-- Repeat Password input -->
                        <div data-mdb-input-init class="form-outline mb-4">
                            <input type="password" id="registerRepeatPassword" name="reppass" value="${reppass}" class="form-control" required/>
                            <label class="form-label" for="registerRepeatPassword" style="width: 200%">Repeat password 
                                <span id="errPass" style="display: block; color: red; margin-left: 20%">${errPass}</span>
                            </label>
                        </div>
<!--                        <i id="errPass" style="display: block; color: red">${errPass}</i>-->

                        <!-- Checkbox -->
                        <span id="errRecheck" style="display: block; color: red">${errRecheck}</span>
                        <div class="form-check d-flex justify-content-center mb-4">
                            <input class="form-check-input me-2" type="checkbox" name="recheck" value="" id="registerCheck" 
                                   aria-describedby="registerCheckHelpText" />
                            <label class="form-check-label" for="registerCheck">
                                I have read and agree to the terms
                            </label>
                        </div>

                        <!-- Submit button -->
                        <button type="submit" data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-block mb-3">Sign in</button>
                    </form>
                </div>
            </div>
        </div>
        <!-- Pills content -->
    </body>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
//        function showmess1() {
//            var errUser = document.getElementById("errUser");
//            var errEmail = document.getElementById("errEmail");
//            var errPass = document.getElementById("errPass");
//            var errRecheck = document.getElementById("errRecheck");
//
//            errUser.style.display = "block";
//            errEmail.style.display = "block";
//            errPass.style.display = "block";
//            errRecheck.style.display = "block";
//        }

        document.addEventListener("DOMContentLoaded", function () {
            const urlParams = new URLSearchParams(window.location.search);
            const activeTab = urlParams.get("tab");

            if (activeTab === "register") {
                document.getElementById("tab-register").classList.add("active");
//                document.getElementById("tab-login").classList.remove("active");
            } else {
                document.getElementById("tab-register").classList.add("active");
//                document.getElementById("tab-login").classList.add("active");
//                document.getElementById("tab-register").classList.remove("active");
            }
        });
    </script>


</html>
