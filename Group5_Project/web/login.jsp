<%-- 
    Document   : login
    Created on : Mar 2, 2025, 10:34:33 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="image/favicon1.png" type="image/png">
        <title>Royal Hotel - Login</title>
        <meta name="theme-color" content="#33b5e5">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="https://mdbcdn.b-cdn.net/wp-content/themes/mdbootstrap4/docs-app/css/dist/mdb5/standard/core.min.css">
        <link rel="stylesheet" id="roboto-subset.css-css" href="https://mdbcdn.b-cdn.net/wp-content/themes/mdbootstrap4/docs-app/css/mdb5/fonts/roboto-subset.css?ver=3.9.0-update.5" type="text/css" media="all">
    </head>

    <style>
        body {
            background-image: url('https://cdn.blastness.biz/media/1288/royalvictoria-top/thumbs/full/royalvictoria_esterni14_top.jpg');
            /*background-image: url('https://duonggiahotel.vn/wp-content/uploads/2023/01/4048e2d8302ae874b13b.jpg');*/
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
                <div class="tab-pane fade show active" id="pills-login" role="tabpanel" aria-labelledby="tab-login">
                    <form action="login" method="post">
                        <input type="hidden" name="action" value="login"/>
                        <div class="text-center mb-3">
                            <p>Sign in with:</p>
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

                        <!-- Email input -->
                        <i style="color: red">${userErr}</i>
                        <div class="form-outline mb-4">
                            <input type="text" id="loginName" name="user" value="${user12}" class="form-control" required/>
                            <label class="form-label" for="loginName">Email or username</label>
                        </div>

                        <!-- Password input -->
                        <i style="color: red">${passErr}</i>
                        <div class="form-outline mb-4">
                            <input type="password" id="loginPassword" name="pass" value="" class="form-control" required/>
                            <label class="form-label" for="loginPassword">Password</label>
                        </div>

                        <!-- 2 column grid layout -->
                        <div class="row mb-4">
                            <div class="col-md-6 d-flex justify-content-center">
                                <!-- Checkbox -->
                                <div class="form-check mb-3 mb-md-0">
                                    <input class="form-check-input" type="checkbox" name="remember" value="" id="loginCheck" checked />
                                    <label class="form-check-label" for="loginCheck"> Remember me </label>
                                </div>
                            </div>

                            <div class="col-md-6 d-flex justify-content-center">
                                <!-- Simple link -->
                                <a href="#!">Forgot password?</a>
                            </div>
                        </div>

                        <!-- Submit button -->
                        <button type="submit" class="btn btn-primary btn-block mb-4">Sign in</button>

                        <!-- Register buttons -->
                        <div class="text-center">
                            <p>Not a member? <a href="register.jsp?tab=register">Register</a></p>
                        </div>
                    </form>
                </div>

            </div>
        </div>
        <!-- Pills content -->
    </body>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const urlParams = new URLSearchParams(window.location.search);
            const activeTab = urlParams.get("tab");

            if (activeTab === "register") {
                document.getElementById("tab-register").classList.add("active");
                document.getElementById("tab-login").classList.remove("active");
            } else {
                document.getElementById("tab-login").classList.add("active");
                document.getElementById("tab-register").classList.remove("active");
            }
        });

        function showmess(event) {
            var mess = document.getElementById("mess");
            var user1 = document.getElementById("loginName").value;
            var pass1 = document.getElementById("loginPassword").value;

            if (user1 === "" || pass1 === "") {
                mess.style.display = "none";
            } else {
//                if (user1 !== "${user12}" || pass1 !== "${pass}") {
                    mess.style.display = "block";
                    event.preventDefault();
//                } 
            }
        }

    </script>



    <!--    <script>
            document.addEventListener("DOMContentLoaded", function () {
                let triggerEl = document.querySelectorAll('#ex1 a');
                triggerEl.forEach(el => {
                    el.addEventListener('click', function (event) {
                        event.preventDefault();
                        let tab = new bootstrap.Tab(this);
                        tab.show();
                    });
                });
            });
        </script>-->

</html>
