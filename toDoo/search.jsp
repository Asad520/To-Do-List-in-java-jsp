<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Home</title>
    <link rel="stylesheet" href="css/home.css" />
  </head>
  <body class="invisible-scrollbar">
    <jsp:include page="head.jsp" />
    <%@ page import="java.util.*,java.sql.*" %>
    <%@ page session="false" %>
    <% 
    HttpSession sess = request.getSession(false);
    String name = "", email = "", srchToDo="";
      if (sess == null) {
        response.sendRedirect("login.jsp");
      }else{

      
        try{
          Enumeration attributeNames = sess.getAttributeNames();
              while (attributeNames.hasMoreElements()) {
                    name = attributeNames.nextElement().toString();
                    email = sess.getAttribute(name).toString();
                    }  
          }catch(Exception e){
            System.out.println(e.getMessage());
            response.sendRedirect("index.jsp");
          }
          srchToDo = request.getParameter("search");
          if(srchToDo == null){
            response.sendRedirect("home.jsp");
          }
          
      }

    %>
    
    <div id="toDo">
      <ul id="myUL">
        <%
          Class.forName("com.mysql.jdbc.Driver");
          String url = "jdbc:mysql://127.0.0.1/todo";
          Connection con = DriverManager.getConnection(url, "root", "root");
          Statement st = con.createStatement();

          String query = "Select todo,status,priority from todos where email='" + email + "' and todo like '%"+srchToDo+"%'";
          String todo = "", status = "", priority="";
          int idNum = 0;
          ResultSet rs = st.executeQuery(query);
          if(!rs.next()){
              out.println("<h1>NO RECORD FOUND!</h1>");
          }
          rs.previous();
          while (rs.next()) {
            todo = rs.getString("todo");
            status = rs.getString("status");
            priority = rs.getString("priority");
            out.println("<li id=lis" + idNum + " >" + todo + "</li>");
            if(status.equals("true")){
                out.println("<script>document.getElementById(\"lis" + idNum + "\").classList.add(\"checked\"); </script>");
              }
              if(priority.equals("high") && status.equals("false")){
                out.println("<script>document.getElementById(\"lis" + idNum + "\").classList.add(\"high\"); </script>");
              }
              
              idNum++;
            }
          con.close();
        %>
      </ul>
      
    </div>

    <script src="scripts/toDo.js"></script>
    <div class="form-popup" id="myForm">
      <form action="" id="hidForm" method="get">
        <h1>Update To do:</h1>   
        <input type="text" name="liDelete" placeholder="Enter to do..." id="liDelete"/>
        <input type="text" name="group" id="grp" placeholder="Enter group if need...">
        <input type="hidden" name="liUpd" id="liUpd">
        <button type="submit" class="hidBtn"  >Enter</button>
        <button type="button" class="cancel" onclick="closeForm()" >Close</button>
      </form>  
    </div>
  </body>
</html>
