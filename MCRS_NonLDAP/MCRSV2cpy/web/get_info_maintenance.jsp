<%@ page language="java" import="java.util.*,java.sql.*,javax.naming.*,javax.sql.*,Database.*,Engines.*"%>
<%
     String user_id = (String) session.getAttribute("session_userid");        
     String user_level = (String) session.getAttribute("session_level");
     String username = (String) session.getAttribute("session_username");
     String user_group = (String) session.getAttribute("session_group");
     String url = request.getParameter("url"); 
     String modul_id  = request.getParameter("modul_id");
   
     String IP_client = request.getRemoteAddr();
     int stat_maintenance=0;
     String url_id="";
     auth au = new auth(IP_client);
     try {
     stat_maintenance= au.isMaintenance();
     url_id= au.geturltree(url, user_level, user_group, modul_id);
     au.close();
     } catch (SQLException Sqlex) {
     out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
     } finally {
     au.close();
     }
        
        if (stat_maintenance != 1) {
%>
<script>
    window.location.href="index.jsp";
</script>
<%        }
%>