import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import java.sql.*;

public class starToDo extends HttpServlet {

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

                String query = "Select priority,status from todos where toDo='" + toDo[0] + "' and email =  '" + email
                        + "'";
                String priority = "", status = "";
                ResultSet rs = st.executeQuery(query);
                rs.next();
                priority = rs.getString("priority");
                status = rs.getString("status");

                String query1 = "";
                if (priority.equals("normal") && status.equals("false")) {
                    query1 = "update todos set priority=\"high\" where todo='" + toDo[0] + "' and email='" + email
                            + "';";
                } else {
                    query1 = "update todos set priority=\"normal\" where todo='" + toDo[0] + "' and email='" + email
                            + "';";
                }

                int rss = 0;
                try {
                    rss = st.executeUpdate(query1);
                    if (rss > 0) {
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