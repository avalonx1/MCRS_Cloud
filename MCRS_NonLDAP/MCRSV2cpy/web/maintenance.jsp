<%@ page language="java" import="java.util.*,java.sql.*,javax.naming.*,javax.sql.*,Database.*,Engines.*"%>
<%
    
     String path = request.getContextPath();
  String getProtocol=request.getScheme();
  String getDomain=request.getServerName();
  String getPort=Integer.toString(request.getServerPort());
  String getPath = getProtocol+"://"+getDomain+":"+getPort+path;
  String getAttrHome="/index.jsp?stat_session=1";
  String getAttrDocs="/docs";
  String getHomePath = getPath+getAttrHome;
  String v_mainPath=getHomePath;
  String v_docsPath=getPath+getAttrDocs;
  //out.println(v_mainPath);
  String v_maintenancePath=getPath+"maintenance.jsp";
  String v_clientIP = request.getRemoteAddr();
  
  int v_statMaintenance=0;
  
   auth au = new auth(v_clientIP);
         try {
         v_statMaintenance= au.isMaintenance();
        
         au.close();
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         }

         
          if (v_statMaintenance == 1) {
    %><script> window.location.href="<%=v_maintenancePath%>"; </script><%
         }else {
  
  
  
    
        String msg = " ";
        notification notif = new notification();
        try {
        msg = notif.getMsgMaintenance();
        notif.close();
      
        } catch (SQLException Sqlex) {
     out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
     } finally {
     notif.close();
     }
%>

<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style/login.css" media="screen" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Maintenance</title>
        <link rel="stylesheet" type="text/css" href="style/main.css" media="screen" />
        <script type="text/javascript" src="js_file/jquery/jquery-1.3.2.js"></script>
        <script type="text/javascript" src="js_file/jquery/jquery-ui-1.7.1.custom.min.js"></script>
        <script type="text/javascript" src="js_file/jquery/jquery.li-scroller.1.0.js"></script>
        <script type="text/javascript" src="js_file/jquery/mbContainer.js"></script>
        <script type="text/javascript" src="js_file/jquery/jquery.metadata.js"></script>
        <script type="text/javascript" src="js_file/jquery.treeview.js" ></script>



    </head>
    <body >
        <div id="stat_maintenance"></div>
        <div class="warning">
            <%=msg%>
            <br>
            Your IP is <%=v_clientIP%>. 
            <br/>
            <br/>
            <a href=<%=getPath%>> back to main site </a>

        </div>
    </body>
</html>

<% } %>