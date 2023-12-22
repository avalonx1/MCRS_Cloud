<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>


<%
  String path = request.getContextPath();
  String getProtocol=request.getScheme();
  String getDomain=request.getServerName();
  String getPort=Integer.toString(request.getServerPort());
  String getPath = getProtocol+"://"+getDomain+":"+getPort+path+"/index.jsp?stat_session=1";
  String v_mainPath=getPath;

          String v_maintenancePath=getPath+"maintenance.jsp";
         
          String v_clientIP = request.getRemoteAddr();
          
          String msg="You Dont Have Permission to Access that Report. Your IP is "+v_clientIP+" this report is generated and automatically sent alert to MIS Development Team ";
          out.println(msg);
          
          System.out.println("ALERT! Injection Found :"+msg);

          out.println("<br/><a href="+getPath+" > back to main site </a>");
          
%>

