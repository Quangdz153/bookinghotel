<%-- 
    Document   : ManagerProduct
    Created on : Dec 28, 2020, 5:19:02 PM
    Author     : trinh
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="image/favicon1.png" type="image/png">
        <title>Manager Room</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <style>
            img{
                width: 200px;
                height: 120px;
            }
        </style>
    <body>
        
        <div class="container">
            <div class="table-wrapper">
                <form action="deleteroomtype" method="post" id="deleteSelect">

                    <div class="table-title" style="margin-top: 10px">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2><a href="crudASG.jsp"><i class="material-icons">home</i></a> Manage <b>Product</b></h2>
                            </div>
                            <div class="col-sm-6">
                                <a href="#addnewroomtype" class="btn btn-success" data-bs-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Product</span></a>
                                <!--<a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal"><i class="material-icons">&#xE15C;</i> <span>Delete</span></a>-->					
                                <button type="submit" onclick="deleteListType()"  class="btn btn-danger">DELETE</button>					
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>
                                    <span class="custom-checkbox">
                                        <input type="checkbox" id="selectAll" name="selectAll">
                                        <label for="selectAll"></label>
                                    </span>
                                </th>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Image</th>
                                <th>Price</th>
                                <th>Area</th>
                                <th>Amenities</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach items="${listroomtype}" var="o">
                                <tr>
                                    <td>
                                        <span class="custom-checkbox">
                                            <input type="checkbox" id="checkbox1" name="options" value="${o.typeID}">
                                            <label for="checkbox1"></label>
                                        </span>  
                                    </td>
                                    <td>${o.typeID}</td>
                                    <td>${o.name}</td>
                                    <td>
                                        <img src="${o.imageURL}">
                                    </td>
                                    <td>${o.pricePerNight} $</td>
                                    <td>${o.area} </td>
                                    <td>${o.amenities} </td>
                                    <td>
                                        <a href="#editroomtype"  class="edit" 
                                           data-bs-toggle="modal"
                                           data-typeID="${o.typeID}"
                                           data-name="${o.name}"
                                           data-description="modal"
                                           data-pricePerNight="${o.pricePerNight}"
                                           data-capacity="${o.capacity}"
                                           data-imageURL="${o.imageURL}"
                                           data-area="${o.area}"
                                           data-amenities="${o.amenities}"

                                           ><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                                        <a href="#" onclick="doDelete(${o.typeID})" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>

                                    </td>
                                </tr>

                            </c:forEach>

                        </tbody>
                    </table>
                </form>

                <div class="clearfix">
                    <div class="hint-text">Showing <b>${currentpage}</b> out of <b>${endP}</b> entries</div>
                    <ul class="pagination">
                        <li class="page-item ${currentpage == 1 ? 'disabled' : ''}">
                            <a href="roomtypecontrol?page=${currentpage == 1 ? 1 : currentpage-1}" class="page-link">Previous</a>
                        </li>
                        <c:forEach begin="1" end="${endP}" var="i">
                            <li class="page-item ${i == currentpage ? 'active':''}">
                                <a href="roomtypecontrol?page=${i}" class="page-link">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentpage == endP ? 'disabled' : ''}">
                            <a href="roomtypecontrol?page=${currentpage == endP ? endP : currentpage+1}" class="page-link">Next</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div>
                <a href="loadtohome"><button type="button" class="btn btn-primary" style="margin: 20px 40px; padding: 10px">Back to home</button></a>
            </div>
        </div>
        <!--EDIT Modal HTML--> 
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                let editButtons = document.querySelectorAll(".edit");

                editButtons.forEach(button => {
                    button.addEventListener("click", function () {
                        // Lấy dữ liệu từ các thuộc tính data-*
                        let typeID = button.getAttribute("data-typeid");
                        let name = button.getAttribute("data-name");
                        let description = button.getAttribute("data-description");
                        let price = button.getAttribute("data-pricePerNight");
                        let capacity = button.getAttribute("data-capacity");
                        let image = button.getAttribute("data-imageURL");
                        let area = button.getAttribute("data-area");
                        let amenities = button.getAttribute("data-amenities");

                        // Đưa dữ liệu vào form Edit
                        document.getElementById("edittypeID").value = typeID;
                        document.getElementById("edittypename").value = name;
                        document.getElementById("editdescription").value = description;
                        document.getElementById("editprice").value = price;
                        document.getElementById("editcapacity").value = capacity;
                        document.getElementById("editimage").value = image;
                        document.getElementById("editarea").value = area;
                        document.getElementById("editamenities").value = amenities;

                    });
                });
            });

        </script>
        <div id="editroomtype" class="modal fade" tabindex="-1" aria-hidden="true">

            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="editroomtype" method="get">
                        <div class="modal-header">						
                            <h4 class="modal-title">Edit RoomType</h4>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">	

                            <div class="form-group">
                                <label>TypeID</label>
                                <input id="edittypeID" name="typeID" type="text"  class="form-control" value="<%=new DAO.RoomTypeDAO().getLastTypeID() +1%>" readonly="">
                            </div>
                            <div class="form-group">
                                <label>Name type </label>
                                <input id="edittypename" name="typename" type="text"  class="form-control" >
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <input id="editdescription" name="description" type="text"  class="form-control" >
                            </div>
                            <div class="form-group">
                                <label>Price per night</label>
                                <input id="editprice" name="price" type="number" min="0" class="form-control" >
                            </div>
                            <div class="form-group">
                                <label>ImageURL</label>
                                <input id="editimage" name="image" type="text"  class="form-control" >
                            </div>
                            <div class="form-group">
                                <label>Capacity</label>
                                <input id="editcapacity" name="capacity" type="number" class="form-control" >
                            </div>
                            <div class="form-group">
                                <label>Area</label>
                                <input id="editarea" name="area" type="text" class="form-control" >
                            </div>
                            <div class="form-group">
                                <label>Amenities</label>
                                <textarea id="editamenities" name="amenities" rows="3" style="width: 100%; border-radius: 5px"></textarea>
                            </div>



                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default close-modal" data-bs-dismiss="modal">Cancel</button>

                            <input type="submit" class="btn btn-success" value="Edit Roomtype">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div id="addnewroomtype" class="modal fade" tabindex="-1" aria-hidden="true">

            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="addnewroomtype" method="get">
                        <div class="modal-header">						
                            <h4 class="modal-title">Add Roomtype</h4>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">	

                            <div class="form-group">
                                <label>TypeID</label>
                                <input id="" name="typeID" type="text"  class="form-control" value="<%=new DAO.RoomTypeDAO().getLastTypeID() +1%>" readonly="">
                            </div>
                            <div class="form-group">
                                <label>Name type </label>
                                <input id="" name="typename" type="text"  class="form-control" >
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <input id="" name="description" type="text"  class="form-control" >
                            </div>
                            <div class="form-group">
                                <label>Price per night</label>
                                <input id="" name="price" type="number" min="0" class="form-control" >
                            </div>
                            <div class="form-group">
                                <label>ImageURL</label>
                                <input id="" name="image" type="text"  class="form-control" >
                            </div>
                            <div class="form-group">
                                <label>Capacity</label>
                                <input id="" name="capacity" type="number" step="0.01" class="form-control" >
                            </div>
                            <div class="form-group">
                                <label>Area</label>
                                <input id="" name="area" type="number" step="0.01"  class="form-control" >
                            </div>
                            <div class="form-group">
                                <label>Amenities</label>
                                <textarea id="" name="amenities" rows="3" style="width: 100%; border-radius: 5px"></textarea>
                            </div>



                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default close-modal" data-bs-dismiss="modal">Cancel</button>

                            <input type="submit" class="btn btn-success" value="Add Roomtype">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Modal HTML -->
        <!-- Delete Modal HTML -->
        <div id="deleteroomtype" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">                        
                            <h4 class="modal-title">Delete Product</h4>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">                    
                            <p>Are you sure you want to delete with TypeID = <span id="select"></span></p>
                            <p class="text-warning"><small>This action cannot be undone.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-bs-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-danger" value="Delete">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="js/manager.js" type="text/javascript"></script>
        <script type="text/javascript">
            function doDelete(id) {
                if (confirm("Are you sure to delete typeID with id=" + id)) {
                    window.location = "deleteroomtype?typeID=" + id;//deletelesson là tên của link servlet để nó nhận doGet
                }
            }

            function deleteListType() {
                if (confirm("Are you sure to delete list typeID: ")) {
                    document.getElementById("deleteSelect").submit();
                }
            }
            function deleteSelect() {
                if (confirm("Are you sure to delete all of them select!!")) {
                    document.getElementById("deleteSelect").submit();
                }
            }

            document.addEventListener("DOMContentLoaded", function () {
                // Lấy checkbox "Select All"
                let selectAllCheckbox = document.getElementById("selectAll");

                // Lấy danh sách tất cả checkbox cần chọn
                let checkboxes = document.querySelectorAll("input[name='options']");

                // Khi click vào "Select All"
                selectAllCheckbox.addEventListener("change", function () {
                    checkboxes.forEach(checkbox => {
                        checkbox.checked = selectAllCheckbox.checked;
                    });
                });

                // Nếu tất cả các checkbox con được chọn, cũng chọn "Select All"
                checkboxes.forEach(checkbox => {
                    checkbox.addEventListener("change", function () {
                        selectAllCheckbox.checked = [...checkboxes].every(chk => chk.checked);
                    });
                });
            });
            function getinfo(button) {
                let imgSrc = button.getAttribute("data-img");
                let imgSrc1 = button.getAttribute("data-img1");
                let imgSrc2 = button.getAttribute("data-img2");
                let imgSrc3 = button.getAttribute("data-img3");
            }

        </script>
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