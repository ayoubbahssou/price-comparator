<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>

<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<meta charset="utf-8"/>
<title>edit supplier</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta content="" name="description"/>
<meta content="" name="author"/>
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css"/>
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN THEME STYLES -->
<link href="../../assets/global/css/components.css" id="style_components" rel="stylesheet" type="text/css"/>
<link href="../../assets/global/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/admin/layout/css/layout.css" rel="stylesheet" type="text/css"/>
<link id="style_color" href="../../assets/admin/layout/css/themes/darkblue.css" rel="stylesheet" type="text/css"/>
<link href="../../assets/admin/layout/css/custom.css" rel="stylesheet" type="text/css"/>
<!-- END THEME STYLES -->
<link rel="shortcut icon" href="favicon.ico"/>
</head>
<body class="page-header-fixed page-quick-sidebar-over-content ">

        <!-- verify existence of session -->
<%    
    if(null == session.getAttribute("username")){
        response.sendRedirect("login_soft.jsp");
    }
%>
    
    <!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top">
	<!-- BEGIN HEADER INNER -->
	<div class="page-header-inner">

		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
		</a>
		<!-- END RESPONSIVE MENU TOGGLER -->

	</div>
	<!-- END HEADER INNER -->
</div>
<!-- END HEADER -->
<div class="clearfix">
</div>
<!-- BEGIN CONTAINER -->
<div class="page-container">
	<!-- BEGIN SIDEBAR -->
	<div class="page-sidebar-wrapper">
		<div class="page-sidebar navbar-collapse collapse">

			<ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
				<!-- DOC: To remove the sidebar toggler from the sidebar you just need to completely remove the below "sidebar-toggler-wrapper" LI element -->
				<li class="sidebar-toggler-wrapper">
					<!-- BEGIN SIDEBAR TOGGLER BUTTON -->
					<div class="sidebar-toggler">
					</div>
					<!-- END SIDEBAR TOGGLER BUTTON -->
				</li>

						<li>
							<a href="suppliers.jsp">
							<i class="icon-home"></i>
							suppliers</a>
						</li>
						<li>
							<a href="addSupplier.jsp">
							<i class="icon-tag"></i>
							add supplier</a>
						</li>
						<li>
							<a href="bills.jsp">
							<i class="icon-basket"></i>
							bills</a>
						</li>
                                                <li>
							<a href="login_soft.jsp">
							<i class="icon-home"></i>
							Logout</a>
						</li>
	<!-- END SIDEBAR MENU-->
		</div>
	</div>
	<!-- END SIDEBAR -->

	<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">

			<!-- BEGIN PAGE HEADER-->


			<!-- END PAGE HEADER-->
			<!-- BEGIN PAGE CONTENT-->

            <div class="portlet light bordered">
        <div class="portlet-title">
          <div class="caption">
            <i class="icon-equalizer font-red-sunglo"></i>
            <span class="caption-subject font-red-sunglo bold uppercase">edit supplier</span>

          </div>

        </div>
        <div class="portlet-body form">
          <!-- BEGIN FORM-->
          <form action="200edit.jsp" class="form-horizontal">
            
             <% try {
         Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
         Connection cnx=DriverManager.getConnection("jdbc:derby://localhost:1527/pcdb","pcdbun","pcdbpw");
      
         Statement stat=cnx.createStatement();
         String input=request.getParameter("name");
         String sql="SELECT suppliers.idsupp ,suppliers.nomsupp,suppliers.adressesupp,suppliers.telephone , suppliers.email ,suppliers.description FROM  suppliers  where  suppliers.nomsupp='"+input+"'";
         
        
         //out.println();
         ResultSet rs=stat.executeQuery(sql);
         rs.next();
        int idsupp=Integer.parseInt(rs.getString("idsupp"));
         %>
  <jsp:useBean id="sup" class="org.beaans.Supplier">
               
                <jsp:setProperty name="sup" property="nom"/>
                <jsp:setProperty name="sup" property="adresse"/>    
                <jsp:setProperty name="sup" property="telephone"/>        
                       <jsp:setProperty name="sup" property="numero"/>  
                <jsp:setProperty name="sup" property="email"/>
                 <jsp:setProperty name="sup" property="description"/>
                        </jsp:useBean>    
              
              <div class="form-body">

             
               
                
                    <input type="hidden"  value="<%= rs.getString("idsupp") %>" name="numero">

               
              <div class="form-group">
                <label class="col-md-3 control-label" >nom</label>
                <div class="col-md-4">
                    <input type="text" class="form-control" value="<%= rs.getString("nomsupp") %>" name="name">

                </div>
              </div>
              <div class="form-group">
                <label class="col-md-3 control-label">address</label>
                <div class="col-md-4">
                  <input type="text" class="form-control" value="<%= rs.getString("adressesupp")  %>"  name="adresse">

                </div>

              </div>
              <div class="form-group">
                <label class="col-md-3 control-label">telephone</label>
                <div class="col-md-4">
                  <input type="text" class="form-control" value="<%= rs.getString("telephone") %>"name="telephone">

                </div>
              </div>
          
                     <div class="form-group">
                <label class="col-md-3 control-label">email</label>
                <div class="col-md-4">
                  <input type="text" class="form-control" value="<%= rs.getString("email") %>" name="email">

                </div>
              </div>
              <div class="form-group">
                <label class="col-md-3 control-label">Description</label>
                <div class="col-md-4">
                  <input type="text" class="form-control" value="<%= rs.getString("description") %>" name="description">

                </div>


                  <% request.setAttribute("idsupp", rs.getString("idsupp"));  %>

            </div>
            <div class="form-actions">
              <div class="row">
                <div class="col-md-offset-3 col-md-9">
                  <button type="submit" class="btn green">Submit</button>
                  <button type="button" class="btn default">Cancel</button>
                </div>
              </div>
            </div>
          </form>
          <!-- END FORM-->

             </div>
         
             <% }catch(Exception e){
    out.print(e);
    } %>
        </div>

		<!-- END PAGE CONTENT-->
		</div>
	</div>
	<!-- END CONTENT -->

</div>
<!-- END CONTAINER -->
<!-- BEGIN FOOTER -->
<div class="page-footer">

	<div class="scroll-to-top">
		<i class="icon-arrow-up"></i>
	</div>
</div>
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<!--[if lt IE 9]>
<script src="../../assets/global/plugins/respond.min.js"></script>
<script src="../../assets/global/plugins/excanvas.min.js"></script>
<![endif]-->
<script src="../../assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="../../assets/global/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/jquery.cokie.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="../../assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<script src="../../assets/global/scripts/metronic.js" type="text/javascript"></script>
<script src="../../assets/admin/layout/scripts/layout.js" type="text/javascript"></script>
<script src="../../assets/admin/layout/scripts/quick-sidebar.js" type="text/javascript"></script>
<script src="../../assets/admin/layout/scripts/demo.js" type="text/javascript"></script>
<script>
jQuery(document).ready(function() {
   // initiate layout and plugins
   Metronic.init(); // init metronic core components
Layout.init(); // init current layout
QuickSidebar.init(); // init quick sidebar
Demo.init(); // init demo features
});
</script>
</body>
<!-- END BODY -->
</html>
