<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>authentification</title>
    </head>
    <body>
        <h1>authentification</h1>
        <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");
        %>
        <%
            try{;
                Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
                Connection cnx = DriverManager.getConnection("jdbc:derby://localhost:1527/pcdb","pcdbun","pcdbpw");
                PreparedStatement ps = cnx.prepareStatement("select * from admin where username=? and password=?");
                ps.setString(1,username);
                ps.setString(2,password);
                ResultSet rs=ps.executeQuery();
                if(rs.next()){
                    session.setAttribute("username", rs.getString("username"));
                    response.sendRedirect("homeAdmin.jsp");
                }else{
                    response.sendRedirect("login_soft.jsp");
                }
            }catch(SQLException e){
                out.println(e);
            }
        %>
    </body>
</html>

