<%@page import="com.ram.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.ram.blog.dao.UserDao"%>
<%@page import="com.ram.blog.helper.ConnectionProvider"%>
<%@page import="com.ram.blog.dao.PostDao"%>
<%@page import="com.ram.blog.entities.Post"%>
<%@page import="com.ram.blog.entities.User"%>

<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao dao = new PostDao(ConnectionProvider.getConnection());
    Post p = dao.getPostByPostId(postId);
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=p.getpTitle()%> || Blog app</title>
        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <link href="css/myCss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user-info{
                font-size: 20px;
            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }
            
            body{
                background: url(img/background1.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>
       
        <!--main content of body-->
        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header primary-background text-white">
                            <h4 class="post-title"><%=p.getpTitle()%></h4>
                        </div>
                        
                        <div class="card-body">
                            <img class="card-img-top my-2" src="blog_pics/<%=p.getpPic()%>" alt="Card image cap">
                           
                            <div class="row my-3 row-user">
                                <div class="col-md-8">
                                    <%
                                        UserDao d=new UserDao(ConnectionProvider.getConnection());
                                        
                                    %>
                                    <p class="post-user-info"><a href="#!"><%=d.getUserByUserId(p.getUserId()).getName()%></a> has posted</p> 
                                </div>
                                <div class="col-md-4">
                                    <p class="post-date"><%=DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                                </div>
                            </div>
                            <p class="post-content"><%=p.getpContent()%></p>
                            <br>
                            <br>
                            <div class="post-code">
                                <pre> <%=p.getpCode()%> </pre>
                            </div>
                           
                        </div>

                        <div class="card-footer primary-background">
                            <%
                                LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
                                
                            %>
                            <a href="#!" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-up"><span class="like-counter"> <%=ld.countLike(p.getPid())%></span></i></a>
                            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting"><span> 10</span></i></a>

                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!--end of main content-->
        
        <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/myScript.js" type="text/javascript"></script>
        
    </body>
</html>
