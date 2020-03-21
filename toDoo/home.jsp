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
    <%@ page import="java.util.*,java.sql.*,java.text.*,java.util.Date" %>
    <%@ page session="false" %>
    <% 
    HttpSession sess = request.getSession(false);
    String name = "", email = "";
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
      }

    %>
    
    <div id="toDo">
      <div id="myDIV" class="header">
        <h2>My To Do List</h2>
        <form action="addToDo" method="get">
          <div id="datHed">Completion Date:</div>
          <input type="text" id="myInput" name="toDo" placeholder="To-Do Description..."  required/>
          <input type="date" name="date" id="date" placeholder="Add Date">
          <button type="submit" class="addBtn">Add</button>
          <br>
          <p id="toDoExist">ToDo already exists! Please delete first one to add again...</p>
        </form>
      </div>
      
      

      <ul id="myUL">
        <%
          Class.forName("com.mysql.jdbc.Driver");
          String url = "jdbc:mysql://127.0.0.1/todo";
          Connection con = DriverManager.getConnection(url, "root", "root");
          Statement st = con.createStatement();

          String query = "Select todo,status,priority,date from todos where email='" + email + "' ";
          String todo = "", status = "", priority="",dat="";
          int idNum = 0;
          ResultSet rs = st.executeQuery(query);
          while (rs.next()) {
            todo = rs.getString("todo");
            status = rs.getString("status");
            priority = rs.getString("priority");
            dat = rs.getString("date");
            if(dat != null){
              DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
              String data = df.format(new Date());
              String date[] = data.split("-");
              int y = Integer.parseInt(date[0]);
              int m = Integer.parseInt(date[1]);
              int d = Integer.parseInt(date[2]);
              
              String date1[] = dat.split("-");
              int y1 = Integer.parseInt(date1[0]);
              int m1 = Integer.parseInt(date1[1]);
              int d1 = Integer.parseInt(date1[2]);
              
              if(y>y1 && status.equals("false")){
                out.println("<script>alert(\"Your ToDo: "+ todo + "  has been outdated. Please complete it (^_^)/ \"); </script>");
              }else if(y==y1 && status.equals("false")){
                if(m>m1 && status.equals("false")){
                  out.println("<script>alert(\"Your ToDo: "+ todo + "  has been outdated. Please complete it (^_^)/ \"); </script>");
                }else if(m==m1 && status.equals("false")){
                  if(d>d1 && status.equals("false")){
                    out.println("<script>alert(\"Your ToDo: "+ todo + "  has been outdated. Please complete it (^_^)/ \"); </script>");
                  }else if((d1-d == 1) && status.equals("false")){
                    out.println("<script>alert(\"You have 1 day to complete your ToDo: "+ todo + ". Please complete it (^_^)/ \"); </script>");
                  }

                }
              }

              
            }
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
          if(request.getAttribute("sameToDo") != null){
             out.println("<script>document.getElementById(\"toDoExist\").style.display= \"block\"</script>");
          }
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
