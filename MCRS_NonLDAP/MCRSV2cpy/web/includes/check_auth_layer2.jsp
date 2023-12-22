<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>

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

          String v_maintenancePath=getPath+"maintenance.jsp";
          String v_userID = (String) session.getAttribute("session_userid");        
          String v_userLevel = (String) session.getAttribute("session_level");
          String v_userName = (String) session.getAttribute("session_username");
          String v_userGroup = (String) session.getAttribute("session_group");
          String v_firstName = (String) session.getAttribute("session_first_name");
          String v_lastName = (String) session.getAttribute("session_last_name");
          String v_url = request.getParameter("url"); 
          String v_modulID  = request.getParameter("modul_id");
          String v_clientIP = request.getRemoteAddr();
          String v_clientHost = request.getRemoteHost();

//security check 1 (session)                             
    if ( ((String) session.getAttribute("session_username") == null && (String) session.getAttribute("session_password") == null && (String) session.getAttribute("session_group") == null) 
    || !request.getMethod().equalsIgnoreCase("post") ) {
     %><script> window.location.href="<%=v_mainPath%>"; </script><% 
    } 
//else 
//
//{
 
//security check 2 (stat maintennace)          
         int v_statMaintenance=0;
         String v_urlID="";
         String v_userFullName="";
         String v_appName="";
         String v_dokDirPath="";
         String v_currWorkDay="";
         String v_debugMode="0";
         
         auth au = new auth(v_clientIP);
         try {
         v_statMaintenance= au.isMaintenance();
         v_appName=au.getParamValue("APPNAMEURL");
         v_currWorkDay=au.getParamValue("CURR_WORKING_DAY");
         v_dokDirPath=au.getParamValue("DOK_DIR_PATH");
         v_debugMode=au.getParamValue("DEBUG_MODE");
         v_urlID= au.geturltree(v_url, v_userLevel, v_userGroup, v_modulID,v_appName);
         v_userFullName= au.getName(v_userID);
         au.close();
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         }

         
          if (v_statMaintenance == 1) {
    %><script> window.location.href="<%=v_maintenancePath%>"; </script><%
         }else {
             //out.println("URL ID : "+v_urlID+" URL :"+v_url+" USER LEV :"+v_userLevel+" USER GROUP :"+v_userGroup+" MODULE : "+v_modulID+" APPNAME : "+v_appName);
             %>
             <script type="text/javascript">
                 $(".tree_active").attr("class","file");
                 $("#tree_<%=v_urlID%>").attr("class","tree_active");
             </script>  
           <%
         } 
         
//    }
         
%>