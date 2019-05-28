<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
            ps = con.prepareStatement("delete from active");
            int j = ps.executeUpdate();
            if (j > 0) {
                out.println("You have successfully logged out");
                response.sendRedirect("homepage.jsp");
            }
        %>
    </body>
</html>
