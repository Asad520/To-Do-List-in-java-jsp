import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;

public class logout extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().invalidate();
        response.sendRedirect("login.jsp");
    }

}