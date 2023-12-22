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
          String v_userLevelCode = (String) session.getAttribute("session_level_code");
          String v_userName = (String) session.getAttribute("session_username");
          String v_userGroup = (String) session.getAttribute("session_group");
          String v_ipPhone = (String) session.getAttribute("session_ipphone");
          String v_title = (String) session.getAttribute("session_title");
          String v_mail = (String) session.getAttribute("session_email");
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
 
       
         int v_statMaintenance=0;
         String v_urlID="";
         String v_userFullName="";
         String v_appName="";
         String v_dokDirPath="";
         
         String v_currMonth="";
         String v_prevMonth="";
         String v_debugMode="0";
         String v_swffileExt="";
         String v_swfdir="";
         String v_fileUploadDir="";
         String v_fileUploadDirCognos="";
         String v_currWorkDay="";
         String v_currETLStatus="";
         String v_nextWorkDay="";
         String v_maxsizeUploadMB="";
         String v_lastIPAddr="";
         String v_lastHost="";
         String v_listrowlimit="";
         
         int v_homescren_notif=0;
         int v_firstTimeLogin_notif=0;
         int v_NDAConfirmed_notif=0;
         int v_changepaswd_notif=0;
         
         auth au = new auth(v_clientIP);
         try {
         v_statMaintenance= au.isMaintenance();
         v_appName=au.getParamValue("APPNAMEURL");
         v_currWorkDay=au.getParamValue("CURR_WORKING_DAY");
         v_nextWorkDay=au.getParamValue("NEXT_WORKING_DAY");
         v_currETLStatus=au.getParamValue("CURR_ETL_STATUS");
         v_maxsizeUploadMB=au.getParamValue("MAXSIZE_UPLOAD_MB");
         v_listrowlimit=au.getParamValue("LIST_ROW_LIMIT");
         
        Calendar aCalendar = Calendar.getInstance();
        // add -1 month to current month
        aCalendar.add(Calendar.MONTH, -1);
        // set DATE to 1, so first date of previous month
        aCalendar.set(Calendar.DATE, 1);
        java.util.Date firstDateOfPreviousMonth = aCalendar.getTime();
        DateFormat df = new SimpleDateFormat("yyyyMM");
        v_prevMonth = df.format(firstDateOfPreviousMonth);
        v_currMonth = v_currWorkDay.substring(0, 6);
        
         
         v_dokDirPath=au.getParamValue("DOK_DIR_PATH");
         v_debugMode=au.getParamValue("DEBUG_MODE");
         v_swffileExt= au.getParamValue("SWF_FILE_EXT");
         v_swfdir=au.getParamValue("DIR_SWF_VIEWER");
         
         v_fileUploadDir=au.getParamValue("DIR_FILE_UPLOAD");
         v_fileUploadDirCognos=au.getParamValue("DIR_FILE_UPLOAD_COGNOS");
         
         v_lastIPAddr = au.getIPAddr(v_userID);
         v_lastHost = au.getRemoteHost(v_userID);
            
         v_urlID= au.geturltree(v_url, v_userLevel, v_userGroup, v_modulID,v_appName);
         v_userFullName= au.getName(v_userID);
         v_homescren_notif=au.getHomescreenNotifStat(v_userID);
         v_firstTimeLogin_notif=au.getFirstTimeLoginStat(v_userID);
         v_NDAConfirmed_notif=au.getNDAConfirmedStat(v_userID);
         v_changepaswd_notif=au.getChangePasswdNotifStat(v_userID);
         
         
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         }

         
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //         
// Check Maintenance
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //         
 
         
         if (v_statMaintenance == 1) {
             
             %><script> window.location.href="<%=v_maintenancePath%>"; </script><%
             
         }
         
         
         String v_popup_notif_path="";

         
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //         
// notification popup
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //         
           if (v_firstTimeLogin_notif == 1) {
              v_popup_notif_path =getPath+"/views/etc/popup_notification/home_base.jsp?";
              v_popup_notif_path += "notifcode=FIRSTLOGNTF&act=1&notifcolumn=first_time_login";
              
             %>
             <script> window.location.href="<%=v_popup_notif_path%>"; </script>
             <%
         } else if (v_changepaswd_notif == 1) {
             v_popup_notif_path =getPath+"/views/etc/popup_notification/home_base.jsp?";
              v_popup_notif_path += "notifcode=CHGPASSNTF&act=1&notifcolumn=change_paswd_notif";
             %>
             <script> window.location.href="<%=v_popup_notif_path%>"; </script>
             <%
         } else if (v_NDAConfirmed_notif == 1) {
             v_popup_notif_path =getPath+"/views/etc/popup_notification/home_base.jsp?";
              v_popup_notif_path += "notifcode=NDANTF&act=1&notifcolumn=nda_confirmed";
             %>
             <script> window.location.href="<%=v_popup_notif_path%>"; </script>
             <%
         } else if (v_homescren_notif == 1) {
             
              v_popup_notif_path =getPath+"/views/etc/popup_notification/home_base.jsp?";
              v_popup_notif_path += "notifcode=POPNTF&act=1&notifcolumn=homescreen_notif";
              
             %>
             <script> window.location.href="<%=v_popup_notif_path%>"; </script>
             <%
         }
         //out.println(v_popup_notif_path);
           
           
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //         
// Check Login dengan PC Lain
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //         

           if (!v_lastIPAddr.equals(v_clientIP)) {
               
               
               
              v_popup_notif_path =getPath+"/views/etc/popup_notification/home_base.jsp?";
              v_popup_notif_path += "notifcode=LOGINDUPNTF&act=0&notifcolumn=none&addlinfo="+v_lastIPAddr+"("+v_lastHost+")";
                
             %><script> window.location.href="<%=v_popup_notif_path%>"; </script><%
             
           }
           
           
           
    

%>


