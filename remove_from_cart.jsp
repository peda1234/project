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
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/users","userinfo","userinfo");
            // Query for database
            PreparedStatement ps;
            String uid="",pid="";
        %>
        <% pid = request.getParameter("pid");%>
        <% uid = request.getParameter("userid");%>
        <%
            out.println(uid);
            out.println(pid);
            ps = con.prepareStatement("delete from cart where uid=? and pid=?");
            ps.setString(1, uid);
            ps.setString(2, pid);
            ps.executeUpdate();
            response.sendRedirect("cart.jsp");
        %>
    </body>
</html>
