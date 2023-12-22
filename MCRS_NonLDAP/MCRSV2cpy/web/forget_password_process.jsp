<%@ page language="java" import="java.util.*,java.sql.*,javax.naming.*,javax.sql.*,Database.*,Engines.*"%>
<%
    String path = request.getContextPath();
  String getProtocol=request.getScheme();
  String getDomain=request.getServerName();
  String getPort=Integer.toString(request.getServerPort());
  String getPath = getProtocol+"://"+getDomain+":"+getPort+path+"/index.jsp?stat_session=1";
  
  
    String v_clientIP = request.getRemoteAddr();
    String vusername = request.getParameter("username");
    
        String randomStr = "";
        String msgForm="";
        
        auth au = new auth(v_clientIP);
        try {
            
        randomStr = au.randomString(10);
        msgForm=au.execForgetPasswdSendMail(vusername, randomStr);
                
        out.println(msgForm+" <a href="+getPath+"> back to main site </a>");
        } catch (SQLException Sqlex) {
     out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
     } finally {
     au.close();
     }
        
        
%>
