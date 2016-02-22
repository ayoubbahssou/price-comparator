<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>

    <!-- verify existence of session -->
<%    
    if(null == session.getAttribute("username")){
        response.sendRedirect("login_soft.jsp");
    }
%>

        <%
            
            String status="unpaid" ;
            String s=request.getParameter("status");
            if(s.equals("unpaid")){
               status="paid";
            }
            out.println(status);
            Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
            Connection cnx=DriverManager.getConnection("jdbc:derby://localhost:1527/pcdb","pcdbun","pcdbpw");
            PreparedStatement stat=cnx.prepareStatement("update BILL set status=? where idbill=?");
            stat.setString(1, status );
            int idbill=Integer.parseInt(request.getParameter("idbill"));
            stat.setInt(2,idbill);
            stat.executeUpdate();
            response.sendRedirect("bills.jsp");
            
        %>
    </body>
</html>
