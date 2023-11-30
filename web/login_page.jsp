<%-- 
    Document   : login_page
    Created on : 02-Jun-2023, 11:49:17 am
    Author     : ramch
--%>

<%@page import="com.ram.blog.entities.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <link href="css/myCss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 100%, 68% 97%, 30% 100%, 0 97%, 0 0);
            }
        </style>
    </head>
    <body>
        <!--navbar-->
        <%@include file="normal-nav-bar.jsp" %>
        <main class="d-flex align-items-center primary-background banner-background" style="height:70vh">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card">
                            <div class="card-header primary-background text-white text-center">
                                <span class="fa fa-user-plus fa-3x"></span>
                                <p>Login here</p>
                            </div>
                            <%
                                Message m = (Message) session.getAttribute("msg");
                                if (m != null) {
                            %>
                            <div class="alert <%=m.getCssClass()%> text-center" role="alert">
                                    <%=m.getContent()%>
                                </div>

                            <%
                                session.removeAttribute("msg");
                                }
                            %>
                            <div class="card-body">
                                <form action="LoginServlet" method="POST">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email address</label>
                                        <input name="email" required type="email" class="form-control" id="email" aria-describedby="emailHelp">

                                    </div>
                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password</label>
                                        <input name="password" required type="password" class="form-control" id="password">
                                    </div>
                                    <div class="container text-center">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>

                                </form>
                            </div>
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
        <script>

        </script>
    </body>
</html>
