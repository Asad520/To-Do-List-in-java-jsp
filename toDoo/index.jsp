<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Document</title>

    <link rel="stylesheet" href="css/style.css" />
  </head>
  <body>
    <section class="forms-section">
      <p class="section-title">Your Personal To Do List!</p>
      <div class="forms">
        <div class="form-wrapper ">
          <button type="button" class="switcher switcher-login">
            Login
            <span class="underline"></span>
          </button>
          <form class="form form-login" action="login.jsp" method="post">
            <fieldset>
              <legend>Please, enter your email and password for login.</legend>
              <div class="input-block">
                <label for="login-email">E-mail:</label>

                <input
                  id="login-email"
                  name="login-email"
                  type="email"
                  required
                />
              </div>

              <div class="input-block">
                <label for="login-password">Password:</label>
                <input
                  id="login-password"
                  name="login-password"
                  type="password"
                  required
                />
              </div>
            </fieldset>
            <button type="submit" class="btn-login">Login</button>
          </form>
        </div>
        <div class="form-wrapper is-active">
          <button type="button" class="switcher switcher-signup">
            Sign Up
            <span class="underline"></span>
          </button>
          <form
            class="form form-signup"
            action="index.jsp"
            method="post"
            onsubmit="return validateSignup()"
          >
            <fieldset>
              <legend>
                Please, enter your name, email, password and password
                confirmation for sign up.
              </legend>
              <div class="input-block">
                <label for="signup-name">Username</label>
                <input
                  id="signup-name"
                  name="signup-name"
                  type="text"
                  pattern="^[a-zA-Z][a-zA-Z0-9._-]+.{2,}$"
                  title="Username must start with an alphabet and can contain . _ - as special characters only and should be atleast 4 characters"
                  required
                />
              </div>
              <div class="input-block">
                <label for="signup-email">E-mail<span id="incEmail"
                  ><b><u> User already exists!</u></b>
                </span></label>
                <input
                  id="signup-email"
                  name="signup-email"
                  type="email"
                  required
                />
              </div>
              <div class="input-block">
                <label for="signup-password"
                  >Password
                  <span class="incPass"
                    ><b><u> Passwords do not match!</u></b>
                  </span></label
                >
                <input
                  id="signup-password"
                  name="signup-password"
                  type="password"
                  pattern=".{4,}"
                  title="At least 4 characters needed"
                  required
                />
              </div>
              <div class="input-block">
                <label for="signup-password-confirm"
                  >Confirm password
                  <span class="incPass"
                    ><b><u> Passwords do not match!</u></b>
                  </span></label
                >
                <input
                  id="signup-password-confirm"
                  name="signup-password-confirm"
                  type="password"
                  required
                />
              </div>
            </fieldset>
            <button type="submit" class="btn-signup">Continue</button>
          </form>
        </div>
      </div>
    </section>
    <script src="scripts/app.js"></script>

    <%@ page import="java.sql.*, encPkg.enc" %>
    <%@ page session="false" %>
      
    <% 
    if (request.getSession(false) != null) {
      response.sendRedirect("home.jsp");
      }
      
      String uname = request.getParameter("signup-name");
      String email = request.getParameter("signup-email");
      String pass1 = request.getParameter("signup-password");

      if(email != null){

      try{

        String pass = enc.getMd5(pass1);

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://127.0.0.1/todo";
        Connection con = DriverManager.getConnection(url, "root", "root");
        Statement st = con.createStatement();

        
          String query = "insert into signup values('" + uname + "', '" + email + "', '" + pass + "' );";
          try{
            int rs = st.executeUpdate(query);
            response.sendRedirect("login.jsp");
          } catch(Exception e){
            System.out.println(e.getMessage());
            out.println("<script> document.getElementById(\"incEmail\").style.display = \"block\"; </script>");
          }
        

      }catch(Exception e){
        System.out.println(e.getMessage());
      }
      }
      

    %>
  </body>
</html>
