<%@page import="com.ram.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ram.blog.dao.PostDao"%>
<%@page import="com.ram.blog.helper.ConnectionProvider"%>
<%@page import="com.ram.blog.entities.Message"%>
<%@page import="com.ram.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <link href="css/myCss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>
    <body>
        <!--navbar-->
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
            <!-- Brand -->
            <a class="navbar-brand" href="#"><span class="fa fa-id-badge"></span> Blog App</a>

            <!-- Links -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="#"><span class="fa fa-home"></span> Home</a>
                </li>


                <!-- Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown"><span class="fa fa-check-circle"></span>
                        Catagories
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Java</a>
                        <a class="dropdown-item" href="#">Python</a>
                        <a class="dropdown-item" href="#">SQL</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><span class="fa fa-phone"></span> Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-plus-circle"></span> Add Post</a>
                </li>


            </ul>
            <ul class="navbar-nav mr-right">
                <li class="nav-item">
                    <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span> <%=user.getName()%></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"></span> Log Out</a>
                </li>
            </ul>

        </nav>

        <!--end nav bar-->
        <!--message-->
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
        <!--message end-->

        <!--main body of page-->

        <div class="container">
            <div class="row mt-4">
                <!--first column-->
                <div class="col-md-4">
                    <!--categories-->

                    <div class="list-group">
                        <a href="#" onclick="getPosts(0,this)" class=" c-link list-group-item list-group-item-action active">
                            All Posts
                        </a>
                        
                        <!--categories from db-->
                        <%
                            PostDao dao=new PostDao(ConnectionProvider.getConnection());
                            ArrayList<Category> list1=dao.getAllCategories();
                            for(Category cc:list1){
                            %>
                            <a href="#" onclick="getPosts(<%=cc.getCid()%>,this)" class=" c-link list-group-item list-group-item-action"><%=cc.getName()%></a>
                            <%
                            }
                        %>
                        
            
                    </div>

                </div>

                <!--second column-->
                <div class="col-md-8">
                    <!--post-->
                    <div class="container text-center" id="loader">
                        <i class="fa fa-refresh fa-4x fa-spin"></i>
                        <h3 class="mt-2">Loading...</h3>
                    </div>
                    
                    <div class="container-fluid" id="post-container">
                        
                    </div>


                </div>

            </div>
        </div>

        <!--end of main body-->


        <!--model-->


        <!-- profile Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white text-center">
                        <h5 class="modal-title" id="exampleModalLabel">Blog App</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="profile/<%=user.getProfile()%>" style="border-radius: 50%; max-width: 150px">
                            <br>
                            <h5 class="modal-title" id="exampleModalLabel"><%= user.getName()%></h5>
                            <!--details table-->
                            <div id="profile-details">
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row">ID :</th>
                                            <td><%=user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email</th>
                                            <td><%=user.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender</th>
                                            <td><%=user.getGender()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">About</th>
                                            <td><%=user.getAbout()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Registered on :</th>
                                            <td><%=user.getDatetime().toString()%></td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--profile edit-->
                            <div id="profile-edit" style="display: none">
                                <h4>Please edit profile</h4>
                                <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <td>ID</td>
                                            <td><%=user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <td>Name</td>
                                            <td><input type="text" class="form-control" name="user_name" value="<%=user.getName()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Email</td>
                                            <td><input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>About</td>
                                            <td>
                                                <textarea rows="5" class="form-control" name="user_about"><%=user.getAbout()%>
                                                </textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Select Profile:</td>
                                            <td>
                                                <input type="file" name="image" class="form-control">
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save</button>
                                    </div>
                                </form>
                            </div>
                            <!--details table end-->
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit Profile</button>
                    </div>
                </div>
            </div>
        </div>
        <!--profile model end-->

        <!--add post model-->
        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide post details.</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form id="add-post-form" action="AddPostServlet" method="post">
                            <div class="form-group">
                                <select class="form-control" name="cid">

                                    <option selected disabled>---Select Category---</option>
                                    <%
                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postd.getAllCategories();
                                        for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>
                                    <%
                                        }
                                    %>

                                </select>
                            </div>

                            <div class="form-group">
                                <input name="pTitle" type="text" placeholder="Enter post title" class="form-control"/>
                            </div>

                            <div class="form-group">
                                <textarea name="pContent" placeholder="Enter post title" class="form-control" style="height: 200px;"></textarea>
                            </div>

                            <div class="form-group">
                                <textarea name="pCode" placeholder="Enter code (if any)" class="form-control" style="height: 200px;"></textarea>
                            </div>

                            <div class="form-group">
                                <label>Select File</label>
                                <br>
                                <input type="file" name="pic"/>
                            </div>

                            <div class="container text-center" >
                                <button type="submit" class="btn-outline-primary">POST</button>
                            </div>

                        </form>


                    </div>

                </div>
            </div>
        </div>
        <!--end add post model-->
        <!--javascript-->

        <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/myScript.js" type="text/javascript"></script>
        <script>
            $(document).ready(function () {
                let editStatus = false;

                $('#edit-profile-btn').click(function () {

                    if (editStatus == false) {
                        $("#profile-details").hide();

                        $("#profile-edit").show();
                        editStatus = true;
                        $(this).text("Back");
                    } else {
                        $("#profile-details").show();

                        $("#profile-edit").hide();
                        $(this).text("Edit Profile");
                        editStatus = false;
                    }

                })
            });
        </script>

        <!--add post js-->
        <script>
            $(document).ready(function (e) {
                $("#add-post-form").on("submit", function (event) {
                    //this code called when form submited
                    event.preventDefault();
                    console.log("you have clicked on submit");
                    let form = new FormData(this);


                    //now requesting to server ajax

                    $.ajax({
                        url: "AddPostServlet",
                        type: "POST",
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            if (data.trim() == 'done') {
                                swal("Good job!", "Saved Successfully...", "success");
                            } else {
                                swal("Error!", "Something went wrong...", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            swal("Something went wrong...", "error");
                        },
                        processData: false,
                        contentType: false
                    })
                })
            })
        </script>
        
        <!--loading post-->
        
        <script>
            function getPosts(cid,temp){
                $("#loader").show();
                $('#post-container').hide();
                $(".c-link").removeClass('active')
                
                $.ajax({
                    url:"load_posts.jsp",
                    data:{cid:cid},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $("#loader").hide();
                        $('#post-container').show();
                        $('#post-container').html(data);
                        $(temp).addClass('active')
                    }
                    
                })
            }
            $(document).ready(function(e){
                let allPostRef=$('.c-link')[0]
                getPosts(0,allPostRef)
            })
        </script>

    </body>
</html>
