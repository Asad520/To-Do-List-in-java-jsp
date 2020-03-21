<%@ page session="false" %>
<%
  HttpSession sess = request.getSession(false);
    if (sess == null) {
      response.sendRedirect("login.jsp");
    }
%>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<link rel="stylesheet" href="css/head.css" />
<div id="head">
  <form action="logout" method="Get">
    <div id="centre">
      <button class="Btn" type="submit">
        Logout
      </button>
    </form>
    
      <button
        class="Btn"
        type="button"
        onclick="window.location.href = 'groups.jsp';"
      >
        Groups
      </button>
      <button
        class="Btn"
        type="button"
        onclick="window.location.href = 'home.jsp';"
      >
        Home
      </button>
    </div>
  
  <div>
    <form action="search.jsp" method="Get">
      <input
        class="search"
        name="search"
        type="text"
        placeholder="&#9906; Search ToDo..."
        required
      />
    </form>
  </div>
</div>
