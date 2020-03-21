import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import java.sql.*;

public class addToDo extends HttpServlet {

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

                String toDo = request.getParameter("toDo");
                String date = request.getParameter("date");
                String query = "";
                if (!date.isEmpty()) {
                    query = "insert into todos (todo,email,date) values('" + toDo + "', '" + email + "','" + date
                            + "' );";
                } else {

                    query = "insert into todos (todo,email) values('" + toDo + "', '" + email + "' );";
                }
                try {
                    int rs = 0;
                    rs = st.executeUpdate(query);
                    if (rs > 0) {
                        response.sendRedirect("home.jsp");
                    }
                } catch (Exception e) {
                    request.setAttribute("sameToDo", "sameToDo");
                    RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
                    rd.forward(request, response);
                    System.out.println(e.getMessage());
                }

            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }
}
