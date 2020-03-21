import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import java.sql.*;

public class updToDo extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sess = request.getSession(false);
        if (sess == null) {
            response.sendRedirect("login.jsp");
        } else {
            try {
                String email = (String) sess.getAttribute("email");
                String newTodo = request.getParameter("liDelete");
                String group = request.getParameter("group");

                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://127.0.0.1/todo";
                Connection con = DriverManager.getConnection(url, "root", "root");
                Statement st = con.createStatement();
                String oldToDoo = request.getParameter("liUpd");
                String oldToDo[] = oldToDoo.split("<");

                String query = "";
                if (group.isEmpty() && newTodo.isEmpty()) {
                    response.sendRedirect("home.jsp");
                } else if ((group == null || group.equals("")) && (newTodo != null || newTodo != "")) {
                    query = "update todos set toDo=\"" + newTodo + "\" where email =  \"" + email + "\" and todo=\""
                            + oldToDo[0] + "\";";
                } else if ((group != null || group != "") && (newTodo == null || newTodo.equals(""))) {
                    query = "update todos set groups=\"" + group + "\" where email =  \"" + email + "\" and todo=\""
                            + oldToDo[0] + "\"";
                } else if ((group != null || group != "") && (newTodo != null) || (newTodo != "")) {
                    query = "update todos set toDo=\"" + newTodo + "\", groups=\"" + group + "\" where email =  \""
                            + email + "\" and todo=\"" + oldToDo[0] + "\";";
                }

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