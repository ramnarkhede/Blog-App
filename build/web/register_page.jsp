<%-- 
    Document   : register_page
    Created on : 08-Jun-2023, 1:43:22 pm
    Author     : ramch
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <link href="css/myCss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>
    <body>
        <%@include file="normal-nav-bar.jsp" %>
        <main class="primary-background p-5 banner-background">
            <div class="container">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header primary-background text-white text-center">
                            <span class="fa fa-user-plus fa-3x"></span>
                            <br>
                            Register here
                        </div>
                        <div class="card-body">
                            <form id="reg-form" action="RegisterServlet" method="POST">
                                <div class="mb-3">
                                    <label for="user_name" class="form-label">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Password</label>
                                    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1">
                                </div>
                                <div class="mb-3">
                                    <label for="gender">Select Gender</label>
                                    <br>
                                    <input type="radio" id="gender"name="gender" value="male">Male
                                    <input type="radio" id="gender"name="gender"value="female">Female
                                </div>
                                <div class="mb-3">
                                    <textarea class="form-control" id="" name="about" rows="5" placeholder="Enter Something about yourself"></textarea>
                                </div>

                                <div class="mb-3 form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree terms and conditions.</label>
                                </div>
                                <div class="container text-center" id="loader" style="display: none">
                                    <span class="fa fa-refresh fa-spin fa-2x"></span>
                                    <h4>Please wait...</h4>
                                    <br>
                                </div>
                                <button id="submit_btn" type="submit" class="btn btn-primary">Submit</button>
                            </form>
                        </div>

                    </div>
                </div>

            </div>
        </main>

        <!--javascript-->

        <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/myScript.js" type="text/javascript"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
            $(document).ready(function () {
                console.log("loaded...")
                $('#reg-form').on('submit', function (event) {
                    event.preventDefault();
                    let form = new FormData(this);
                    //hide submit
                    $("#submit_btn").hide();
                    //show loading
                    $("#loader").show();
                    //send reg servlet

                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data)
                            //hide submit
                            $("#submit_btn").show();
                            //show loading
                            $("#loader").hide();
                            if(data.trim()==='done'){
                                swal("Registered successfully... ")
                                    .then((value) => {
                                        window.location="login_page.jsp"
                                    });
                            }else{
                                swal(data);
                            }
                            
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR)
                            $("#submit_btn").show();
                            //show loading
                            $("#loader").hide();
                            swal("Something went wrong try again ");
                                    
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>

    </body>
</html>
