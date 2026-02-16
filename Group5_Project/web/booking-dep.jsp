<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="image/favicon1.png" type="image/png">
        <title>Booking</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                background: url('img/booking_BG1.jpg') no-repeat center center fixed;
                background-size: cover;
                background-color: #f8f9fa;
            }

            .booking-form {
                max-width: 600px;
                margin: 50px auto;
                background: rgba(255, 255, 255, 0.9);
                padding: 40px;
                border-radius: 12px; /* Bo tròn góc form */
                box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            }

            .form-control, .form-select {
                font-size: 16px;
                padding: 12px;
                border-radius: 8px; /* Bo tròn input */
            }

            .btn-primary {
                font-size: 20px;
                font-weight: bold;
                padding: 12px;
                border-radius: 8px; /* Bo tròn nút */
                transition: background-color 0.3s ease;
            }

            .btn-primary:hover {
                background-color: #007bff; /* Nút đậm màu khi hover */
            }

            .booking-form h2 {
                font-weight: bold;
                font-size: 26px;
            }

            /* Nút trở về trang chủ */
            #backToHomeBtn {
                position: fixed; /* Cố định vị trí của nút */
                top: 20px; /* Khoảng cách từ trên cùng của trang */
                left: 20px; /* Khoảng cách từ bên trái */
                z-index: 1000; /* Đảm bảo nút luôn hiển thị trên các phần tử khác */
                font-size: 18px; /* Cỡ chữ của nút */
                color: #000; /* Màu chữ đen */
                background-color: #fff; /* Nền màu trắng */
                padding: 12px 25px; /* Thêm padding cho nút */
                border-radius: 50px; /* Bo tròn nút theo dạng pill (hình chữ nhật bo tròn) */
                font-weight: 500; /* Độ đậm chữ vừa phải */
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Thêm bóng mờ nhẹ cho nút */
                transition: all 0.3s ease; /* Thêm hiệu ứng chuyển động mượt mà khi hover */
                text-decoration: none; /* Bỏ gạch chân của liên kết */
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }

            /* Khoảng cách giữa biểu tượng và chữ */
            #backToHomeBtn i {
                margin-right: 10px;
            }

            /* Hiệu ứng hover cho nút */
            #backToHomeBtn:hover {
                background-color: #f8f9fa; /* Màu nền khi hover (nhạt hơn một chút so với nền ban đầu) */
                color: #000; /* Chữ vẫn giữ màu đen khi hover */
                transform: translateY(-4px); /* Nâng nút lên một chút khi hover */
            }

            /* Tạo hiệu ứng focus khi người dùng nhấn vào nút */
            #backToHomeBtn:focus {
                outline: none; /* Bỏ viền focus */
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* Thêm hiệu ứng ánh sáng nhẹ khi focus */
            }
        </style>

    </head>
    <body>
        <!-- Nút trở về trang chủ -->
        <a href="loadtohome" class="btn btn-lg btn-outline-primary px-4 py-2 shadow-sm rounded-pill" id="backToHomeBtn">
            <i class="bi bi-house-door-fill"></i> Back to Home
        </a>

        <div class="container">
            <div class="booking-form">
                <h2 class="text-center mb-4">Hotel Booking</h2>
                <form id="bookingForm" action="searchtohome" method="get">
                    <!-- Điền thông tin khách hàng tự động -->
                    <input type="hidden" name="AccountID" value="${not empty sessionScope.acc?sessionScope.acc.accountID:''}" />
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">First Name</label>
                            <input type="text" id="fname" name="fname" class="form-control" placeholder="Enter your first name" required value="${not empty guestAccount.firstName?guestAccount.firstName:param.fname}">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Last Name</label>
                            <input type="text" id="lname" name="lname" class="form-control" placeholder="Enter your last name" required value="${not empty guestAccount.lastName?guestAccount.lastName:param.lname}">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone</label>
                        <input type="text" id="phone" class="form-control" name="phone" placeholder="Enter your phone" required value="${not empty guestAccount.phone?guestAccount.phone:param.phone}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" id="email" class="form-control" name="email" placeholder="Enter your email" required value="${not empty guestAccount.email?guestAccount.email:param.email}">
                    </div>

                    <!-- Chọn loại phòng từ roomtype -->
                    <div class="mb-3">
                        <label class="form-label">Room Type</label>

                        <div class="dropdown">
                            <button class="form-select" type="button" id="roomDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                Select Rooms
                            </button>
                            <ul class="dropdown-menu" id="roomList" style="width: 100%;">
                                <c:forEach var="room" items="${availableRoomList}">
                                    <li>
                                        <label class="dropdown-item">
                                            <input type="checkbox" style="width: 18px; height: 18px; margin: 5px" class="room-checkbox" 
                                                   value="${room.getRoomID()}" data-price="${room.getPrice()}" onchange="updateSelectedRooms()">
                                            ${room.getRoomID()} - ${room.getPrice()}$
                                        </label>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>

                        <input type="hidden" id="roomIDs" name="roomIDs">
                    </div>

                    <!-- Ngày check-in và check-out -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Check-in Date</label>
                            <input type="date" id="checkIn" name="checkInDate" value="${not empty requestScope.getInTime ? requestScope.getInTime : ''}" class="form-control" required onchange="updateTotalPrice()">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Check-out Date</label>
                            <input type="date" id="checkOut" name="checkOutDate" value="${not empty requestScope.getOutTime ? requestScope.getOutTime : ''}" class="form-control" required onchange="updateTotalPrice()">
                        </div>
                    </div>

                    <!-- Tổng tiền -->
                    <div class="mb-3">
                        <label class="form-label">Total Price</label>
                        <input type="text" id="totalPrice" name="totalPrice" class="form-control" value="${not empty totalPrice?totalPrice:'0.00'}" readonly>
                    </div>

                    <!-- Nút đặt phòng -->
                    <button type="submit" class="btn btn-primary w-100" id="submitBtn">Book Now</button>
                </form>
                <c:if test="${empty sessionScope.acc}">
                    <div class="alert alert-warning">
                        You are not logged in. Please <a href="login.jsp">log in</a> to autofill your details.
                    </div>
                </c:if>
            </div>
        </div>

        <script>
            let selectedRoomPrice = 0; // Lưu tổng giá các phòng được chọn

            function updateSelectedRooms() {
                let selectedRooms = [];
                selectedRoomPrice = 0;
                let checkboxes = document.querySelectorAll('.room-checkbox:checked');

                checkboxes.forEach(checkbox => {
                    selectedRooms.push(checkbox.value);
                    selectedRoomPrice += parseFloat(checkbox.getAttribute("data-price")); // Cộng giá tiền từng phòng
                });

                // Hiển thị danh sách phòng đã chọn trong dropdown
                let dropdownButton = document.getElementById('roomDropdown');
                dropdownButton.innerText = selectedRooms.length > 0 ? selectedRooms.join(", ") : "Select Rooms";

                // Gán danh sách phòng vào input hidden
                document.getElementById('roomIDs').value = selectedRooms.join(", ");

                // Cập nhật giá tổng
                updateTotalPrice();
            }

            function updateTotalPrice() {
                let checkIn = document.getElementById('checkIn').value;
                let checkOut = document.getElementById('checkOut').value;

                if (checkIn && checkOut && selectedRoomPrice > 0) {
                    let checkInDate = new Date(checkIn);
                    let checkOutDate = new Date(checkOut);
                    let diffDays = Math.max(1, (checkOutDate - checkInDate) / (1000 * 60 * 60 * 24)); // Số ngày ở

                    let totalPrice = selectedRoomPrice * diffDays;
                    document.getElementById('totalPrice').value = totalPrice.toFixed(2);
                } else {
                    document.getElementById('totalPrice').value = "0.00";
                }
            }

            document.addEventListener('DOMContentLoaded', function () {
                const roomTypeSelect = document.getElementById('roomType');
                const totalPriceInput = document.getElementById('totalPrice');
                const checkInInput = document.getElementById('checkIn');
                const checkOutInput = document.getElementById('checkOut');

                // Hàm tính tổng tiền
                function calculateTotalPrice() {
                    // Lấy giá phòng từ selected option
                    const roomPrice = parseFloat(roomTypeSelect.selectedOptions[0].getAttribute('data-price'));

                    // Kiểm tra và tính tổng tiền
                    const checkInDate = new Date(checkInInput.value);
                    const checkOutDate = new Date(checkOutInput.value);

                    if (checkInDate && checkOutDate && checkOutDate > checkInDate) {
                        // Tính số ngày ở giữa check-in và check-out
                        const stayDuration = (checkOutDate - checkInDate) / (1000 * 60 * 60 * 24); // tính số ngày

                        // Tính tổng tiền
                        const totalPrice = roomPrice * stayDuration;
                        totalPriceInput.value = `${totalPrice.toFixed(2)}`; // Cập nhật tổng tiền vào input
                    } else {
                        totalPriceInput.value = 'Invalid dates'; // Nếu ngày không hợp lệ
                    }
                }

                // Lắng nghe sự kiện thay đổi trong select (khi chọn loại phòng)
                roomTypeSelect.addEventListener('change', calculateTotalPrice);

                // Lắng nghe sự kiện thay đổi trong ngày check-out
                checkOutInput.addEventListener('input', function () {
                    const checkInDate = new Date(checkInInput.value);
                    const checkOutDate = new Date(checkOutInput.value);

                    if (checkOutDate <= checkInDate) {
                        alert('Check-out date must be after check-in date!');
                        checkOutInput.value = '';
                        totalPriceInput.value = 'Invalid dates'; // Nếu ngày không hợp lệ
                    } else {
                        calculateTotalPrice(); // Tiến hành tính toán nếu ngày hợp lệ
                    }
                });

                // Lắng nghe sự kiện thay đổi trong ngày check-in (không cần thông báo lỗi)
                checkInInput.addEventListener('input', calculateTotalPrice);

                // Tính toán ngay khi trang được tải xong nếu đã có giá trị ngày
                calculateTotalPrice();
            });

        </script>
        <!-- Thêm thư viện SweetAlert2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            <% if (request.getAttribute("successMessage") != null) { %>
            Swal.fire({
                icon: "success",
                title: "Booking Successful!",
                text: "<%= request.getAttribute("successMessage") %>",
                confirmButtonColor: "#3085d6",
                confirmButtonText: "OK"
            });
            <% } %>

            <% if (request.getAttribute("errorMessage") != null) { %>
            Swal.fire({
                icon: "error",
                title: "Oops...",
                text: "<%= request.getAttribute("errorMessage") %>",
                confirmButtonColor: "#d33",
                confirmButtonText: "OK"
            });
            <% } %>
        </script>

    </body>
    <style>
        body {
            background: url('img/booking_BG1.jpg') no-repeat center center fixed;
            background-size: cover;
            background-color: #f8f9fa;
        }

        .booking-form {
            max-width: 600px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 12px; /* Bo tròn góc form */
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
        }

        .form-control, .form-select {
            font-size: 16px;
            padding: 12px;
            border-radius: 8px; /* Bo tròn input */
        }

        .btn-primary {
            font-size: 20px;
            font-weight: bold;
            padding: 12px;
            border-radius: 8px; /* Bo tròn nút */
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #007bff; /* Nút đậm màu khi hover */
        }

        .booking-form h2 {
            font-weight: bold;
            font-size: 26px;
        }

        /* Nút trở về trang chủ */
        #backToHomeBtn {
            position: fixed; /* Cố định vị trí của nút */
            top: 20px; /* Khoảng cách từ trên cùng của trang */
            left: 20px; /* Khoảng cách từ bên trái */
            z-index: 1000; /* Đảm bảo nút luôn hiển thị trên các phần tử khác */
            font-size: 18px; /* Cỡ chữ của nút */
            color: #000; /* Màu chữ đen */
            background-color: #fff; /* Nền màu trắng */
            padding: 12px 25px; /* Thêm padding cho nút */
            border-radius: 50px; /* Bo tròn nút theo dạng pill (hình chữ nhật bo tròn) */
            font-weight: 500; /* Độ đậm chữ vừa phải */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Thêm bóng mờ nhẹ cho nút */
            transition: all 0.3s ease; /* Thêm hiệu ứng chuyển động mượt mà khi hover */
            text-decoration: none; /* Bỏ gạch chân của liên kết */
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        /* Khoảng cách giữa biểu tượng và chữ */
        #backToHomeBtn i {
            margin-right: 10px;
        }

        /* Hiệu ứng hover cho nút */
        #backToHomeBtn:hover {
            background-color: #f8f9fa; /* Màu nền khi hover (nhạt hơn một chút so với nền ban đầu) */
            color: #000; /* Chữ vẫn giữ màu đen khi hover */
            transform: translateY(-4px); /* Nâng nút lên một chút khi hover */
        }

        /* Tạo hiệu ứng focus khi người dùng nhấn vào nút */
        #backToHomeBtn:focus {
            outline: none; /* Bỏ viền focus */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* Thêm hiệu ứng ánh sáng nhẹ khi focus */
        }
    </style>
</html>
