<%@page import="java.sql.*" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.util.Date" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<meta charset="utf-8"/>
<title>supplier</title>
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
            <span class="caption-subject font-red-sunglo bold uppercase">supplier</span>

          </div>

        </div>
        <div class="portlet-body form">
          <!-- BEGIN FORM-->
          <form action="200edit.jsp" class="form-horizontal">
        <% 
            Calendar cal = Calendar.getInstance(); 
            int iyear=cal.get(Calendar.YEAR); 
            int imonth=cal.get(Calendar.MONTH); 
            String smonth="";
            switch(imonth){
                case 0 : smonth="janvier"; break;
                case 1 : smonth="fevrier"; break;
                case 2 : smonth="mars"; break;
                case 3 : smonth="avril"; break;
                case 4 : smonth="mai"; break;
                case 5 : smonth="juin"; break;
                case 6 : smonth="juillet"; break;
                case 7 : smonth="aout"; break;
                case 8 : smonth="septembre"; break;
                case 9 : smonth="octobre"; break;
                case 10 : smonth="novembre"; break;
                case 11 : smonth="decembre"; break;
            }
        %>
             <% try {
                        
                 
                     
                        Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
                        Connection c=DriverManager.getConnection("jdbc:derby://localhost:1527/pcdb","pcdbun","pcdbpw");
                        PreparedStatement st = c.prepareStatement("select idbl from billline where idprod=? and MONTH=? and years=?");
                        int idprod=Integer.parseInt(request.getParameter("idprod"));
                        st.setInt(1,idprod);
                        st.setString(2,smonth);
                        st.setInt(3,iyear);
                        ResultSet res=st.executeQuery();
                     
                    if(res.next()){ 
                       try{
                        Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
                        Connection cnx=DriverManager.getConnection("jdbc:derby://localhost:1527/pcdb","pcdbun","pcdbpw");
                        PreparedStatement s = cnx.prepareStatement("update BILLLINE set clicksnbr=clicksnbr+1 where idprod=? and MONTH=? and years=?");
                        int idproduit=Integer.parseInt(request.getParameter("idprod"));
                        s.setInt(1,idproduit);
                        s.setString(2,smonth);
                        s.setInt(3,iyear);
                        s.executeUpdate();
                       
                      }catch(Exception ex){
                            out.println(ex);
                      } 
                    }else{ 
                       try{ 
                        Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
                        Connection cn=DriverManager.getConnection("jdbc:derby://localhost:1527/pcdb","pcdbun","pcdbpw");
                        PreparedStatement sta=cn.prepareStatement("select idbl from billline");
                        ResultSet r=sta.executeQuery();
                        String idbl="0";
                        while(r.next()){
                            idbl=r.getString("idbl");
                        }
                    
                        Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
                        Connection cx=DriverManager.getConnection("jdbc:derby://localhost:1527/pcdb","pcdbun","pcdbpw");
                        PreparedStatement state = cx.prepareStatement("insert into BILLLINE values(?,?,1,?,?,?)");
                        int idbline=Integer.parseInt(idbl)+1;
                        state.setInt(1,idbline);
                        state.setInt(2,Integer.parseInt(request.getParameter("idprod")));
                        state.setString(3,smonth);
                        state.setInt(4,iyear);
                        state.setInt(5,Integer.parseInt(request.getParameter("idsupp")));
                        state.executeUpdate();
                       }catch(Exception exce){
                           out.println(exce);
                       }
                    }
                 
                  
                
         Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
         Connection cnx=DriverManager.getConnection("jdbc:derby://localhost:1527/pcdb","pcdbun","pcdbpw");
         Statement stat=cnx.createStatement();
         String sql="SELECT suppliers.idsupp ,suppliers.nomsupp,suppliers.adressesupp,suppliers.telephone , suppliers.email FROM  suppliers  where  suppliers.idsupp="+request.getParameter("idsupp");
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

                        </jsp:useBean>

              <div class="form-body">
              <div class="form-group">
                <label class="col-md-3 control-label" >nom</label>
                <div class="col-md-4">
                    <%= rs.getString("nomsupp") %>

                </div>
              </div>
              <div class="form-group">
                <label class="col-md-3 control-label">address</label>
                <div class="col-md-4">
                  <%= rs.getString("adressesupp")  %>

                </div>

              </div>
              <div class="form-group">
                <label class="col-md-3 control-label">telephone</label>
                <div class="col-md-4">
                  <%= rs.getString("telephone") %>

                </div>
              </div>

                     <div class="form-group">
                <label class="col-md-3 control-label">email</label>
                <div class="col-md-4">
                  <%= rs.getString("email") %>

                </div>
              </div>
              


                  <% request.setAttribute("idsupp", rs.getString("idsupp"));  %>

            </div>
         
          </form>
          <!-- END FORM-->

             </div>

            <% }catch(Exception e){
                out.println(e);
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
