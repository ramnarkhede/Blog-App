<%@page import="com.ram.blog.entities.User"%>
<%@page import="com.ram.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.ram.blog.entities.Post"%>
<%@page import="com.ram.blog.helper.ConnectionProvider"%>
<%@page import="com.ram.blog.dao.PostDao"%>

<div class="row">
    <%
        User user=(User)session.getAttribute("currentUser");
        PostDao dao = new PostDao(ConnectionProvider.getConnection());

        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> list = null;
        if (cid == 0) {
            list = dao.getAllPost();
        } else {
            list = dao.getPostByCatId(cid);
        }

        if (list.size() == 0) {
            out.println("<h3 class='display-3 text-center'>No post in this category...</h3>");
            return;
        }

        for (Post p : list) {
    %>

    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="blog_pics/<%=p.getpPic()%>" alt="Card image cap">
            <div class="card-body">
                <b><%=p.getpTitle()%></b>
                <p><%=p.getpContent()%></p>

            </div>

            <div class="card-footer text-center primary-background">
                <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-light btn-sm">Read More...</a>
        
            </div>
        </div>

    </div>

    <%
        }
    %>

</div>