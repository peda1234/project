<!DOCTYPE html>
<html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
          <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
          <title>JSP Page</title>
          <link href="style.css" type="text/css" rel="stylesheet">
      <style>
        /* Always set the map height explicitly to define the size of the div
         * element that contains the map. */
        #map {
          height: 425px;
        }
        /* Optional: Makes the sample page fill the window. */
        html, body {
          height: 100%;
          margin: 0;
          padding: 0;
        }
      </style>
    </head>
    
    <%@ page import="java.io.*" %>
    <%@ page import="java.sql.*" %>

    <%  // register for connection
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        // create connetion
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/users", "userinfo", "userinfo");
        // Query for database
        PreparedStatement ps;
        
    %>
    <%
        ps = con.prepareStatement("select * from active");
        ResultSet user = ps.executeQuery();
        boolean show;
        if (user.next()) {
            show = true;
        } else {
            show = false;
        }
    %>
    <nav class="navbar navbar-expand-sm bg-dark navbar-dark sticky-top">

        <!-- Links -->
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="homepage.jsp">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="aboutus.jsp">About Us</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="contactus.jsp">Contact Us</a>
            </li>
        </ul>
        <form class="form-inline" action="">
            <input class="form-control mr-sm-2" type="text" placeholder="Search">
            <button class="btn btn-success" type="submit">Search</button>
        </form>

        <% if (show) { %>
            <a class="nav-link" href="cart.jsp"><i class="fa fa-shopping-cart fa-lg" style="color:white;"></i></a>

            <li class="nav-item dropdown" style="list-style-type:none;">
                <a class="nav-link dropdown-toggle text-white" href="#" id="navbardrop" data-toggle="dropdown">
                    <i class="fa fa-user-circle fa-lg"></i>
                </a>
                <div class="dropdown-menu">
                  <a class="dropdown-item" href=<%="profile.jsp"%>><i class="fa fa-user fa-lg"></i> My Profile(<%=user.getString(1)%>)</a>
                  <a class="dropdown-item" href="logout.jsp"><i class="fa fa-sign-out fa-lg"></i> Logout</a>
                </div>
            </li>
        <% } else {%>
            <a class="nav-link text-white" href="login.jsp">
                <i class="fa fa-sign-in fa-lg"></i> Sign In
            </a>
            <a class="nav-link text-white" href="signup.jsp">
                <i class="fa fa-user-plus fa-lg"></i> Sign Up
            </a>
        <%}%>
    </nav>
  
  <body>
      
      <div style="margin-top: 10px;"></div>
      <div class="container-fluid">
          <div class="row">
              <div class="col-md-6">
                  <h3>Contact Us</h3>
                  <div style="padding: 10px; margin: 20px;">
                      <form method="post" action="">
                    <div class="form-group">
                      <label for="userid">User ID: </label>
                      <input type="text" class="form-control" name="userid" id="userid">
                    </div>
                    <div class="form-group">
                      <label for="password">Password:</label>
                      <input type="password" name="password" class="form-control" id="password">
                    </div>
                    <div class="form-group">
                        <label for="comment">Comment:</label>
                        <textarea class="form-control"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form> 
                  </div>
              </div>
              
              <div class="col-md-6">
                  <div id="map"></div>
                    <script>
                      var map;
                      function initMap() {
                        map = new google.maps.Map(document.getElementById('map'), {
                          center: {lat: -34.397, lng: 150.644},
                          zoom: 8
                        });
                      }
                    </script>
                    <script src="https://maps.googleapis.com/maps/api/js?
                            key=AIzaSyA3uIgHLLajF1tPZcqSq3ALOEHyex8Jx9Y
                            &callback=initMap"
                            async defer>
                    </script>
              </div>
          </div>
      </div>
        
    
        
        <div style="padding:10px;"></div>
        <footer>
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <h4>Get to Know Us</h4>
                        <ul>
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">Careers</a></li>
                            <li><a href="#">Press Releases</a></li>
                            <li><a href="#">Apna Cares</a></li>
                            <li><a href="#">Gift a Smile</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h4>Connect with Us</h4>
                        <ul>
                            <li><a href="">Facebook</a></li>
                            <li><a href="">Twitter</a></li>
                            <li><a href="">Google</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h4>Make Money with Us</h4>
                        <ul>
                            <li><a href="">Sell Here</a></li>
                            <li><a href="">Become an Affiliate</a></li>
                            <li><a href="">Advertise Your Products</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h4>Let Us Help You </h4>
                        <ul>
                            <li><a href="">Your Account</a></li>
                            <li><a href="">100% Purchase Protection</a></li>
                            <li><a href="">Help</a></li>
                        </ul>
                    </div>
                </div>
    <!--            <div class="row" style="background-color: gray;">
                    <div class="col-md-4"></div>
                    <div class="col-md-4" style="margin-top:10px;"><p>Copyright @2018. Apna Shopping Site Ltd.</p></div>
                    <div class="col-md-4"></div>
                </div>-->
            </div>

        </footer>
        <div style="background-color: gray;">
        <p style="margin-bottom:0px;padding:10px;" class="text-center">
            Copyright @2018. Apna Shopping Site Ltd.
        </p>
    </div>
        
        
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
            <script src="main.js" type="text/javascript"></script>
  </body>
</html>