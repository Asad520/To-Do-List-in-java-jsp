import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import java.sql.*;

public class delToDo extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sess = request.getSession(false);
        if (sess == null) {
            response.sendRedirect("login.jsp");
        } else {
            try {
                String email = (String) sess.getAttribute("email");
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://127.0.0.1/todo";
                Connection con = DriverManager.getConnection(url, "root", "root");
                Statement st = con.createStatement();

                String toDoo = request.getParameter("liDelete");
                String toDo[] = toDoo.split("<");

                String query = "delete from todos where toDo='" + toDo[0] + "' and email = '" + email + "' ";

                int rs = 0;
                try {
                    rs = st.executeUpdate(query);
                    if (rs > 0) {
                        response.sendRedirect("home.jsp");
                    }
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }
}