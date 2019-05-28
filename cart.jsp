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

        <%  // register for connection
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            // create connetion
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/users", "userinfo", "userinfo");
            // Query for database
            PreparedStatement ps;
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
        <h1 class="text-center" style="padding: 20px;padding-left:0px;">User Cart Items: </h1>
        
        <%
            String userid = "";
            ps = con.prepareStatement("select * from active");
            user = ps.executeQuery();
            if (user.next()) {
                userid = user.getString(1);
//                out.println("User is : " + userid + "<br>");
                ps = con.prepareStatement("select pid from cart where uid=?");
                ps.setString(1, userid);
                ResultSet pids = ps.executeQuery();
                double total = 0;
                %>
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <h3>User <%=userid%></h3>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-7">
                            <%while (pids.next()) {
                                String pid = pids.getString("pid");
                                ps = con.prepareStatement("select * from products where pid=?");
                                ps.setString(1, pid);
                                ResultSet item = ps.executeQuery();

                                if (item.next()) {
                                    String img = item.getString("image");
                                    String title = item.getString("ptitle");
                                    String price = item.getString("price");
                                    String seller = "Apka Apna Brand";
                                    total += Double.parseDouble(price);%>
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="row">
                                                    <img src="images/<%=img%>" class="cart-img" alt="<%=img%>" />
                                                </div>
                                                
                                                
                                            </div>
                                            <div class="col-md-9">
                                                <h6><%=title%></h6>
                                                <h6><%=seller%></h6>
                                                <h6>Rs. <%=price%>/-</h6>
                                                <p>
                                                    <a href="#" onclick="decrement(<%=price%>,<%=pid%>)"><i class="fa fa-minus-square"></i></a>
                                                    <span id="<%=pid%>"> 1</span>
                                                    <a href="#" onclick="increment(<%=price%>,<%=pid%>)"><i class="fa fa-plus-square"></i></a>
                                                    <a href="remove_from_cart.jsp?userid=<%=userid%>&pid=<%=pid%>"> Remove</a>
                                                </p>
                                            </div>
                                        </div>
                                        <hr/>
                                        <div style="padding:2px;"></div>
                                    </div>
                                    
                                 <%}

                            }%>
                        </div>
                        <div class="col-md-5">
                            <p>Total: <span id="total"><%=total%></span></p>
                            <a class="btn btn-success" onclick="prompt_total(<%=userid%>,<%=total%>)">Checkout</a>
                            
                        </div>
                    </div>
                        
                        <div class="row">
                            <div class="col-md-12">
                                <p><%=userid%></p>
                                <p>Aapka bill hua hai = <span id="display"><%=total%></span></p>
                            </div>
                        </div>
                </div>
                <%
                
                
//                out.println("Aapka bill hua hai = " + total);
            }
            
            
        %>
        
        
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
