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
        <%@ page import="java.util.concurrent.TimeUnit" %>
        <%  // register for connection
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            // create connetion
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/users","userinfo","userinfo");
            // Query for database
            PreparedStatement ps;
            
            ps = con.prepareStatement("select * from active");
            ResultSet user = ps.executeQuery();
            String userid = "";
            if (user.next()) {
                userid = user.getString(1);
            }
            String pid = request.getParameter("pid");
            String message = "";
            ps = con.prepareStatement("insert into cart values(?,?)");
            ps.setString(1, userid);
            ps.setString(2, pid);
            int j = ps.executeUpdate();
        %>
        <%   if (j > 0) {
                
//                out.println("<script type=\"text/javascript\">");
//                out.println("alert('User or password incorrect');");
//                out.println("location='homepage.jsp';");
//                out.println("</script>");

                out.println("<meta http-equiv='refresh' content='2;URL=homepage.jsp'>");//redirects after 2 seconds
//                out.println("<p style='color:green;'>Product Added to Cart</p>");
        %>
                <div class="container-fluid">
                    <h1>Congratulations!</h1>
                    <div class="alert alert-success alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        <p style='color:green;'>Product Added to Cart</p>
                    </div>
                    <div class="alert alert-success alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        <p style='color:green;'>You are being redirected to homepage.</p>
                    </div>
                </div>
            <%}%>
            
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        
    </body>
</html>
