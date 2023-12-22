<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,javax.naming.*,javax.sql.*,java.math.*, java.lang.String,java.io.*,javax.servlet.*,java.text.*"%>
<%
    
         String clientIP = request.getRemoteAddr();
         
         String notifcode = request.getParameter("notifcode");
         String act = request.getParameter("act");
         String notifcolumn = request.getParameter("notifcolumn");
         String addlinfo = request.getParameter("addlinfo");
         
         
         String path = request.getContextPath();
        String getProtocol=request.getScheme();
        String getDomain=request.getServerName();
        String getPort=Integer.toString(request.getServerPort());
        String getPath = getProtocol+"://"+getDomain+":"+getPort+path;
        String v_maintenancePath=getPath+"maintenance.jsp";
  
         int v_statMaintenance=0;
         String v_urlID="";
         String v_appNameDesc="";
         String v_appNameURL="";
         String v_debugMode="0";
         String v_betaMode="0";
         String v_headerTextMode="0";
         String v_appVer="0";
         String v_appUpdateYear = "";
         String v_appCompany="";
         auth au = new auth(clientIP);
         try {
         v_statMaintenance= au.isMaintenance();
         v_appNameDesc=au.getParamValue("APPNAMEDESC");
         v_appNameURL=au.getParamValue("APPNAMEURL");
         v_debugMode=au.getParamValue("DEBUG_MODE");
         v_betaMode=au.getParamValue("BETA_MODE");
         v_headerTextMode=au.getParamValue("HEADER_TITLETEXT_MODE");
         v_appVer=au.getParamValue("APPVERSION");
         v_appUpdateYear=au.getParamValue("APPUPDATEYEAR");
         v_appCompany=au.getParamValue("APPCOMPANY");
         
         au.close();
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         }

         if (v_statMaintenance == 1) {
             %><script> window.location.href="<%=v_maintenancePath%>"; </script><%
         }

         String userid = (String) session.getAttribute("session_userid");
        String user = (String) session.getAttribute("session_username");
        String userName = (String) session.getAttribute("session_first_name")+" "+(String) session.getAttribute("session_last_name");
        String group = (String) session.getAttribute("session_group");
        String level = (String) session.getAttribute("session_level");
        String url = "";
        

       
        //out.println(modul_id+" "+url);
%>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
     
        <title><%=v_appNameURL%></title>
        <%@include file="../../../includes/javascript_popup_notif.jsp" %>

        <script type="text/javascript">

         
                   
                
                $("#loading").show();
                $.ajax({
                    type: 'POST',
                    url: "home_base_data.jsp",
                    data: "notifcode=<%=notifcode%>&act=<%=act%>&notifcolumn=<%=notifcolumn%>&addlinfo=<%=addlinfo%>",
                    cache:false,
                    success: function(d) {
                        $("#data").empty();
                        $("#data").html(d);
                        $("#data").show();
                    },
                    complete: function(){
                        $("#loading").hide();
                
                    }	});
                    

 
        </script>
                        
                        
    </head>
    <body>
        <div class="upper"></div>
        <div id="wrap">
            <div id="header">
  
                
                 <% if (v_betaMode.equals("1")) { %>
                <div id="header-logo-beta"></div>
                <%}%>
                
                <div id="header-text">

                    <!-- page header - use <span></span> to colour text white, default color orange -->
                    <div id="header-logo"></div>
                    <div id="header-title">
                    
                        <% if (v_headerTextMode.equals("1")) { %> 
                        <div id="header-title-text">  <%=v_appNameDesc%>  </div>
                        <% } else { %>
                        <div id="header-title-background"></div>
                        <% } %>
                        
                    </div>
                   
                    <div class="profile">welcome <a href="#" id="myprofile"><%=userName%></a>|<a href="../../../logout.jsp">Logout</a></div>
                    <div class="clear"></div>
                </div>
            </div>

            <div id="content-wrap">
                <div id="wrap2">
                    
                    <div id="content">
                        <div id="loading" style="display:none;"><img src="../images/loading.gif" alt="loading..." /></div>
                        <div id="loading_inner" style="display:none;"><img src="../images/loading.gif" alt="loading..." /></div>
                        <div class="cleanup_data" id="data"></div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <!-- start footer -->

            <div class="footer">
                <p class="left">&copy; <%=v_appUpdateYear%> <%=v_appCompany%>. <%=v_appNameURL%> <%=v_appVer%></p>
                
                <p class="right">
                    <a href="mailto:gumilar.supendi@bankmuamalat.co.id?Subject=Hello%20Gumilar">need help?</a> 
                </p>
                <div class="clear"></div>
                <div id="stat_window"></div>
            </div>

            <!-- end footer -->
        </div>

        <div style="font-size: 0.8em; text-align: center; width:50px">
            

        </div>
                        <table ><tr><td height="200px"></td></tr></table>
    </body>
</html>