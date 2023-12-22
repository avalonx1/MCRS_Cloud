<%@ page language="java" import="java.util.*,java.sql.*,javax.naming.*,javax.sql.*,Database.*,Engines.*"%>
<%
    
    String v_clientIP = request.getRemoteAddr();
    
        boolean isEligible = false;
        String errCode = "";
        ldapActiveDirectory ldap = new ldapActiveDirectory(v_clientIP);
        String username="20131254";
        String password="Password*3";
        
        isEligible=ldap.getAuthByDName(username,password);
        String AttrName=ldap.getName(username);
        String AttrEmail=ldap.getEmail(username);
        String AttrTitle=ldap.getTitle(username);
        
        errCode=ldap.getErr();
        
        
     
%>

<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style/login.css" media="screen" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LDAPTEST</title>
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
            <table>
            <%  out.println("<tr><td>Username </td><td>: "+username+" (Status "+isEligible+")");
                out.println("<tr><td>Nama</td><td>: "+AttrName+"</td></tr>");
                out.println("<tr><td>Title</td><td>: "+AttrTitle+"</td></tr>");
                out.println("<tr><td>Email</td><td>: "+AttrEmail+"</td></tr>");
                
            
            %>
            </table>
            <br>
            Error <%=errCode%>. 
            <br>
            Your IP is <%=v_clientIP%>. 
        </div>
    </body>
</html>
