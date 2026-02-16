<%-- 
    Document   : payment
    Created on : Mar 17, 2025, 2:34:40 PM
    Author     : viet7
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Payment</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
        <link rel="stylesheet" href="css/payment.css">
        <style>
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
            }
            .payment-form {
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
                width: 40%;
                position: relative;
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
        <main class="page payment-page">
            <div class="container">
                <button class="btn btn-primary" onclick="showPaymentForm()">Pay</button>
                <div id="payment-modal" onclick="hidePaymentForm(event)">
                    <section id="payment-form" class="payment-form dark" onclick="event.stopPropagation()">
                        <span class="close-button" onclick="hidePaymentForm(event)">&times;</span>
                        <div class="block-heading">
                            <h2>Payment</h2>
                            <p>Please fill in the payment details below.</p>
                        </div>
                        <form action="addPayment" method="POST">
                            <div class="products">
                                <h3 class="title">Checkout</h3>
                                <div id="booking-list"></div>
                                <div class="total">Total<span id="total-price" class="price">$0</span></div>
                            </div>
                            <div class="card-details">
                                <h3 class="title">Payment Details</h3>
                                <div class="form-group">
                                    <label for="booking-id">Booking ID</label>
                                    <select id="booking-id" name="bookingID"class="form-control" onchange="updateTotalPrice()">
                                        <c:forEach var="bk" items="${bookings}">
                                            <option value="${bk.getBookingID()}" data-price="${bk.getTotalPrice()}">
                                                Booking ${bk.getBookingID()} - $${bk.getTotalPrice()}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="amount">Amount</label>
                                    <input id="amount" name="amount"type="text" class="form-control" placeholder="Enter Amount" required>
                                </div>
                                <div class="form-group">
                                    <label for="payment-date">Payment Date</label>
                                    <input id="payment-date" type="date" class="form-control" value="" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="payment-method">Payment Method</label>
                                    <select id="payment-method" name="paymentMethod" class="form-control">
                                        <option value="Cash">Cash</option>
                                        <option value="Credit Card">Credit Card</option>
                                        <option value="Debit Card">Debit Card</option>
                                        <option value="Online Payment">Online Payment</option>
                                    </select>
                                </div>
                                <div>
                                <form>
                                <button type="submit" class="btn btn-primary btn-block">Proceed</button>
                                </form>
                                </div>>
                            </div>
                        </form>
                    </section>
                </div>
            </div>
        </main>
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
    </body>
</html>
