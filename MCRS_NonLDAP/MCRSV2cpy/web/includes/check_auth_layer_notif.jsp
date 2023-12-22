<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>
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
  String v_userID = (String) session.getAttribute("session_userid");        
  String v_userLevel = (String) session.getAttribute("session_level");
  String v_userName = (String) session.getAttribute("session_username");
  String v_userGroup = (String) session.getAttribute("session_group");
  String v_firstName = (String) session.getAttribute("session_first_name");
  String v_lastName = (String) session.getAttribute("session_last_name");
  
  String v_clientIP = request.getRemoteAddr();
 
  
 if ( ((String) session.getAttribute("session_username") == null && (String) session.getAttribute("session_password") == null && (String) session.getAttribute("session_group") == null) 
    || !request.getMethod().equalsIgnoreCase("post") ) {
     %><script> window.location.href="<%=v_mainPath%>"; </script><%  
    }
          

%>    
