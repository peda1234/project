<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
           <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
        <title>JSP Page</title>
        <link href="style.css" type="text/css" rel="stylesheet">
    </head>
    <body>
    <marquee style="background-color: blue;margin:-3px;"><h1 class="moto">Value with variety</h1></marquee>

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

            <!--<a class="nav-link" href=<%="profile.jsp"%> ><i class="fa fa-user-circle fa-lg" style="color:white"></i></a>-->

            <li class="nav-item dropdown">
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

    <!--carousel for images-->
    <div id="demo" class="carousel slide" data-ride="carousel">

        <!-- Indicators -->
        <ul class="carousel-indicators">
            <li data-target="#demo" data-slide-to="0" class="active"></li>
            <li data-target="#demo" data-slide-to="1"></li>
            <li data-target="#demo" data-slide-to="2"></li>
        </ul>

        <!-- The slideshow -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="images/3.jpg" alt="Los Angeles" width="1100" height="500">
            </div>
            <div class="carousel-item">
                <img src="images/5.jpg" alt="Chicago" width="1100" height="500">
            </div>
            <div class="carousel-item">
                <img src="images/8.jpg" alt="New York" width="1100" height="500">
            </div>
        </div>

        <!-- Left and right controls -->
        <a class="carousel-control-prev" href="#demo" data-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <a class="carousel-control-next" href="#demo" data-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
    </div>


    <%
        ps = con.prepareStatement("select distinct(category) from products");
        ResultSet category = ps.executeQuery();
    %>

    <% while (category.next()) { %>

    <%
        ps = con.prepareStatement("select * from products where category=? fetch first 4 rows only");
        ps.setString(1, category.getString(1));
        ResultSet items = ps.executeQuery();
    %>

    <div class="container" style="margin-top: 10px;">
        <div class="row">
            <%! String cat;%>
            <% cat = category.getString("category");%>
            <div class="col-md-9"><h2><%= cat%> </h2></div>
            <div class="col-offset-1 col-md-2"><a class="btn btn-primary" href=<%="items.jsp?category=" + cat%>>View More</a></div>
        </div>
        <hr/>

        <div class="row">
            <% while (items.next()) {
                    String title = items.getString("ptitle");
                    String description = items.getString("description");
                    description = description.substring(0, 30) + "...";
                    String price = items.getString("price");
                    String img = items.getString("image");
            %>

            <div class="col-md-3">
                <div class="card card-hover">
                    <img class="card-img-top" src="images/<%=img%>" alt="<%=title%>">
                    <div class="card-body">
                        <h4 class="card-title"><%=title%></h4>
                        <p class="card-text text-muted">Rs. <%=price%>/-</p>
                        <p class="card-text"><%=description%></p>
                        <a href=<%= "product_detail.jsp?pid=" + items.getString(1)%> class="card-link">View</a>
                    </div>
                </div>

            </div>

            <% } %>
        </div>
    </div>

    <% }%>
    
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
