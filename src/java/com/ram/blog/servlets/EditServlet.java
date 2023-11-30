package com.ram.blog.servlets;

import com.ram.blog.dao.UserDao;
import com.ram.blog.entities.Message;
import com.ram.blog.entities.User;
import com.ram.blog.helper.ConnectionProvider;
import com.ram.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

//            fetch all new data
            String userEmail = request.getParameter("user_email");
            String userName = request.getParameter("user_name");
            String userAbout = request.getParameter("user_about");
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();

            //get the user from session
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            user.setEmail(userEmail);
            user.setName(userName);
            user.setAbout(userAbout);
            String oldFile=user.getProfile();
            user.setProfile(imageName);

            //update new data in database
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            boolean flag = dao.updateUser(user);
            if (flag == true) {

                String path = request.getRealPath("/") + "profile" + File.separator + user.getProfile();
                
                String oldPath = request.getRealPath("/") + "profile" + File.separator + oldFile;
                
                if(!oldFile.equals("default.png")){
                    Helper.deleteFile(oldPath);
                }
                
                if (Helper.saveFile(part.getInputStream(), path)) {
                    out.println("Profile updated");
                    Message msg = new Message("Profile updated", "success", "alert-success");
                    session.setAttribute("msg", msg);
                    
                } else {
                    out.println("Profile not updated");
                    
                    Message msg = new Message("Something went wrong", "error", "alert-denger");
                    session.setAttribute("msg", msg);
                }

            } else {
                out.println("not updated to DB");
                Message msg = new Message("Something went wrong", "error", "alert-denger");
                session.setAttribute("msg", msg);
            }
            response.sendRedirect("profile.jsp");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
