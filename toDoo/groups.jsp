<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Groups</title>
    <link rel="stylesheet" href="css/group.css" />
  </head>
  <body>
    <jsp:include page="head.jsp" />
    <%@ page import="java.util.*,java.sql.*" %> 
    <%@ page session="false" %>
    <%
      HttpSession sess = request.getSession(false);
        if (sess == null) {
          response.sendRedirect("login.jsp");
        }
    %>
        <form method="get" id="frm">
        <h1>All your Groups:</h1>
        <h2>Click on a group to view its ToDo List !</h2>
        <br>
            <%
              String email = (String) sess.getAttribute("email");
              Class.forName("com.mysql.jdbc.Driver");
              String url = "jdbc:mysql://127.0.0.1/todo";
              Connection con = DriverManager.getConnection(url, "root", "root");
              Statement st = con.createStatement();
    
              String query = "Select distinct groups from todos where groups is not null and email = '" +email+ "'";
              String groups = "";
              ResultSet rs = st.executeQuery(query);
              if(!rs.next()){
                out.println("<h2 style=\"text-align:center;\">NO GROUPS CREATED YET ! <br> Click on the pencil icon from home screen to add groups !</h2>");
                    }
              rs.previous();
              while (rs.next()) {
                groups = rs.getString("groups");
                  out.println("<button class=\"btnClass\" type=\"button\">" + groups + "</button>");
                  out.println("<br><br>");
                }
              con.close();
            %>
            <input type="hidden" id="hidField" name="hidField">
        </form>
        
      
      <script src="scripts/groups.js"></script>
  </body>
</html>
