<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <title>JSP Page</title>
        <link href="style.css" type="text/css" rel="stylesheet">
    </head>
    <body>
        <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        
        <!--<h1>This is the product detail page for : </h1>-->
        <%! String pid; %>
        <% pid = request.getParameter("pid"); %>
        <!--<a class="btn btn-primary" href=<%= "add_to_cart.jsp?pid="+pid %>>Add to Cart</a>-->
        
        <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        <%  // register for connection
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            // create connetion
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/users","userinfo","userinfo");
            // Query for database
            PreparedStatement ps;
        %>
        
        <% 
            ps = con.prepareStatement("select * from products where pid=?");
            ps.setString(1, pid);
            ResultSet item = ps.executeQuery();
            String img,title,description,rating,price;
            img=title=description=rating=price="";
            if (item.next()) {
                img = item.getString("image");
                price = item.getString("price");
                rating = item.getString("rating");
                title = item.getString("ptitle");
                description = item.getString("description");
            }
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
        <div style="margin-top: 20px;"></div>
        
        <div class="container">
            
            <div class="row">
                
                <div class="col-md-4">
                    <img src="images/<%=img%>" alt="<%=img%>" class="card-hover" />
                    <!--<div style="margin-top:5px"></div>-->
<!--                    <p>
                        <a class="btn btn-success" href=<%= "add_to_cart.jsp?pid="+pid %>>Add to Cart</a>
                        <a class="btn btn-success text-white">Buy Now</a>
                    </p>-->
                    <div style="margin-top: 10px;"></div>
                    <div class="row">
                        <div class="col-md-6">
                            <a class="btn btn-success cart-btn" href=<%= "add_to_cart.jsp?pid="+pid %>>Add to Cart</a>
                        </div>
                        <div class="col-md-6">
                            <a class="btn btn-success text-white cart-btn" href="#">Buy Now</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-8">
                    <h3>Aelomart</h3>
                    <p><%=title%></p>
                    <h4>Rs. <%=price%> /-</h4>
                    <h5 class="badge badge-secondary"><%=rating%><i class="fa fa-star"></i></h5>
                    <p><i class="fa fa-map-marker"></i> Deliver to</p>
                    <p>
                        <input type="text"/><button class="btn btn-primary btn-sm">Check</button>
                    </p>
                    <p><%=description%></p>
                </div>
                
            </div>
            
        </div>
                
        <div style="margin-top: 20px;"></div>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2>You May also like </h2>
                </div>
            </div>
            <hr/>
            <div class="row">
                <div class="col-md-4" >
                    <div class="card" style="width:300px;height:250px;">
                        <img class="card-img-top" src="images/3.jpg" alt="Card image" style="opacity:0.7;">
                        <div class="card-img-overlay">
                            <center>
                                <h4 class="card-title">Mens's Jeans</h4>
                                <p class="card-text">Min 50% off</p>
                                <a href="#" class="btn btn-primary">Shop Now</a>
                            </center>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card" style="width:300px;height:250px;">
                        <img class="card-img-top" src="images/3.jpg" alt="Card image" style="opacity:0.7;">
                        <div class="card-img-overlay">
                            <center>
                                <h4 class="card-title">Men's Casual & Party Wear Shirts</h4>
                                <p class="card-text">Min 50% off.</p>
                                <a href="#" class="btn btn-primary">Shop Now</a>
                            </center>
                        </div>
                    </div>
                </div>
                <div class="col-md-4" >
                    <div class="card" style="width:300px;height:250px;">
                        <img class="card-img-top" src="images/3.jpg" alt="Card image" style="opacity:0.7;">
                        <div class="card-img-overlay">
                            <center>
                                <h4 class="card-title">Womens Tops</h4>
                                <p class="card-text">Min 60% off.</p>
                                <a href="#" class="btn btn-primary">Shop Now</a>
                            </center>
                        </div>
                    </div>
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
<!--                <div class="row" style="background-color: gray;">
                    <div class="col-md-4"></div>
                    <div class="col-md-4" style="margin-top:10px;"><p>Copyright @2018. Apna Shopping Site Ltd.</p></div>
                    <div class="col-md-4"></div>
                </div>-->
            </div>

        </footer>
        
        <div style="background-color: gray;width:100%;">
            <p style="margin-bottom:0px;padding:10px; width:100%;" class="text-center">
                Copyright @2018. Apna Shopping Site Ltd.
            </p>
        </div>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        
    </body>
</html>
