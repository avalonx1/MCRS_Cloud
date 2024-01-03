<!DOCTYPE html SYSTEM "../includes/xhtml1-strict.dtd" >
<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.util.regex.*, java.sql.*,javax.naming.*,javax.sql.*, java.lang.String"%>
<%
    
         String clientIP = request.getRemoteAddr();
//         int v_statMaintenance=0;
         
         String v_userID = (String) session.getAttribute("session_userid"); 
//         String v_userID = "session_userid"; 


        String path = request.getContextPath();
        String getProtocol=request.getScheme();
        String getDomain=request.getServerName();
        String getPort=Integer.toString(request.getServerPort());
        String getPath = getProtocol+"://"+getDomain+":"+getPort+path;
  
  
         String v_urlID="";
         String v_appNameDesc="";
         String v_appNameURL="";
         String v_debugMode="0";
         String v_betaMode="0";
         String v_headerTextMode="0";
         String v_appVer="0";
         String v_appUpdateYear = "";
         String v_appCompany="";
         
         int v_homescren_notif=0;
         int v_firstTimeLogin_notif=0;
         int v_NDAConfirmed_notif=0;
         int v_changepaswd_notif=0;
         
         
         auth au = new auth(clientIP);
         try {
//         v_statMaintenance= au.isMaintenance();
         v_appNameDesc=au.getParamValue("APPNAMEDESC");
         v_appNameURL=au.getParamValue("APPNAMEURL");
         v_debugMode=au.getParamValue("DEBUG_MODE");
         v_betaMode=au.getParamValue("BETA_MODE");
         v_headerTextMode=au.getParamValue("HEADER_TITLETEXT_MODE");
         v_appVer=au.getParamValue("APPVERSION");
         v_appUpdateYear=au.getParamValue("APPUPDATEYEAR");
         v_appCompany=au.getParamValue("APPCOMPANY");
                 
                 
                 
                 
         v_homescren_notif=au.getHomescreenNotifStat(v_userID);
         v_firstTimeLogin_notif=au.getFirstTimeLoginStat(v_userID);
         v_NDAConfirmed_notif=au.getNDAConfirmedStat(v_userID);
         v_changepaswd_notif=au.getChangePasswdNotifStat(v_userID);
         
         
         au.close();
         } catch (SQLException Sqlex) {
         out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
         } finally {
         au.close();
         }

//         if (v_statMaintenance == 1) {
//             response.sendRedirect("../maintenance.jsp");
//         }
         
          String v_popup_notif_path="";
          
     
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

         
         
       
    if ((String) session.getAttribute("session_username") == null && 
(String) session.getAttribute("session_password") == null && (String) session.getAttribute("session_level") == null) {
//        response.sendRedirect("../login.jsp");
response.sendRedirect("index.jsp");
    } else if ((String) session.getAttribute("session_username") != null) {
        
        String userid = (String) session.getAttribute("session_userid");
        String user = (String) session.getAttribute("session_username");
        String userName = (String) session.getAttribute("session_first_name")+" "+(String) session.getAttribute("session_last_name");
        String group = (String) session.getAttribute("session_group");
        String level = (String) session.getAttribute("session_level");


        System.out.println("printout session = "+userid+", user="+user+", userName="+userName+",Group="+group+", level ="+level);


        String url = "";
        if (group.equals("1")) {
            url = "welcome.jsp";
        } 
            else {
            url = "welcome.jsp";
        }

        String modul_id;
        String TabMenu="";
        int tabloop=0;
  
        
        modul_id = request.getParameter("menuid");
        
        
        if (modul_id == null ) {
            modul_id="1";
        }
        

                        try {
                                ResultSet resultSet = null;
                                Database db = new Database();
                                try {
                                    db.connect(1);
                                    String sql;
                                        
                                   sql = "select modul,c.name,c.inorder,count(1) JML "
                                            + " from T_USER a,v_menu_matrix b, t_module c"
                                            + " where a.level_id=b.user_level_id "
                                            + " and a.group_id=b.user_group_id "
                                            + " and b.modul=c.id "
                                            + " and a.id=" + userid + " and b.stat=1 and b.status_matrix=1"
                                            + " group by modul,c.name,c.inorder "
                                            + "order by c.inorder,modul,c.name ";
                                               
                                   System.out.println("### Select view index.jsp T_USER = "+sql);
                                   
                                    resultSet = db.executeQuery(sql);
                                    
                                     while (resultSet.next()) {
                                        tabloop++;
                                        
                                        if (tabloop==1) {
                                        
                                            if (modul_id.equalsIgnoreCase(resultSet.getString("modul"))) {
                                            TabMenu+="<li class=\"navleft active\"><a href=\"index.jsp?menuid="+resultSet.getString(1)+"\">"+resultSet.getString(2)+"</a></li>";
                                            }
                                            else{
                                            TabMenu+="<li class=\"navleft\"><a href=\"index.jsp?menuid="+resultSet.getString(1)+"\">"+resultSet.getString(2)+"</a></li>";
                                            }
                                        }
                                        else {
                                            
                                            if (modul_id.equalsIgnoreCase(resultSet.getString(1))) {
                                            TabMenu+="<li class=\"active\"><a href=\"index.jsp?menuid="+resultSet.getString(1)+"\">"+resultSet.getString(2)+"</a></li>";
                                            }else{
                                            TabMenu+="<li class=\"\"><a href=\"index.jsp?menuid="+resultSet.getString(1)+"\">"+resultSet.getString(2)+"</a></li>";
                                            }
                                        } 
                                    }
                                    
                                    if (tabloop==0) {
                                            modul_id="0";
                                            TabMenu="No Tab Activated";
                                    }
         
                                } catch (SQLException Sqlex) {
                                    out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                } finally {
                                    db.close();
                                    if (resultSet != null) {
                                        resultSet.close();
                                    }
                                        
                                }
                            } catch (Exception except) {
                                out.println("<div class=sql>" + except.getMessage() + "</div>");
                            }
            
                            


                       
        
       String PathTree="getDataTreeMenu.jsp?level="+level+"&group="+group+"&modul="+modul_id;
       
       
        //out.println(modul_id+" "+url);
%>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="Pragma" content="no-cache"/>
        <title><%=v_appNameURL%></title>
        <%@include file="../includes/javascript.jsp" %>

        <script type="text/javascript">

            $(document).ready(function() {
               $("#uisetting").hide();
               $("#refresh_page").hide();
               $("#refresh_box_enable").hide();
               $("#refresh_box_disable").show();
               $("#status_msg").hide(); 
               $("#filter_box").hide(); 
               $(".cleanup_data").empty();
               $(".cleanup_data").hide();
               
               var stat_setting=0;
               
               
                $("#terminal_setting_icon").click( function(){
                    if (stat_setting===0) {
                    $("#uisetting").slideDown();
                    stat_setting=1;
                    }else {
                    $("#uisetting").slideUp("1000");
                    stat_setting=0;
                    }
                });
                

               
                var progress = null;
                
                $("#loading").show();
                progress = $.ajax({
                    type: 'POST',
                    url: "<%=url%>",
                    data: "",
                    cache:false,
                    success: function(d) {
                        $("#data").empty();
                        $("#data").html(d);
                        $("#data").show();
                    },
                    complete: function(){
                        $("#loading").hide();
                        progress = null;
                    }	});

                 
                
                var file_url="";
                
              
                //menu config
                

                $("#treeMenu").fileTree({
                    root: '0',
                    script: "<%=PathTree%>",
                    expandSpeed: 100,
                    collapseSpeed: 100,
                    multiFolder: false
                }, function(file) {
                    
                    $("#refresh_page").empty();
                    $("#refresh_page").hide();
                    $(".cleanup_data").empty();
                    $(".cleanup_data").hide();
                    $("#status_msg").hide(); 
                    $("#filter_box").hide();
                    $("#icon_panel_hide_filter").unbind();
                    $("#icon_panel_show_filter").unbind();
                    $("#icon_panel_hide_action").unbind();
                    $("#icon_panel_show_action").unbind();
                    
                    $("#icon_panel_show_filter").hover(
                function () {
                    $(this).append($("<div  class='hover_info'>Filter Data..[open]</div>"));
                }, 
                function () {
                    $(".hover_info").remove();
                });

                $("#icon_panel_hide_filter").hover(
                function () {
                    $(this).append($("<div  class='hover_info'>Filter Data..[hide]</div>"));
                }, 
                function () {
                    $(".hover_info").remove();
                });
                                         
                $("#icon_panel_show_action").hover(
                function () {
                    $(this).append($("<div class='hover_info'>Bulk Action..[open]</div>"));
                }, 
                function () {
                    $(".hover_info").remove();
                });

                $("#icon_panel_hide_action").hover(
                function () {
                    $(this).append($("<div class='hover_info'>Bulk Action..[hide]</div>"));
                }, 
                function () {
                    $(".hover_info").remove();
                });

                    
                    $("#loading").show();
                    
                    
                    
                    
                    file_url=file;
                    
                    
                 
                    
                    if (progress) {
                    progress.abort();
                    }
                    
                    //alert(progress);
                    
                    progress = $.ajax({
                        type: 'POST',
                        url: file ,
                        async: false,
                        data: {url:file,modul_id:<%=modul_id%>},
                        cache:false,
                        success: function(d) {
                            
                            $("#data").empty();
                            $("#title_box").empty();
                            $("#data").html(d);
                            $("#data").show();
                     
                        },
                        complete: function(){
                            $("#loading").hide();
                            $("#checkboxSelect_act_refresh").attr("checked",false);
                            $("#data_inner_refresh_time option[value='60000']").attr("selected", true);
                            clearInterval(refresh_data_inner);
                            progress = null;
                            
                            $.ajax({
                                type: 'POST',
                                async: false,
                                url: "audit/page_access_log/trace.jsp" ,
                                data: {pagepath:file_url},
                                cache:false,
                                success: function(d) {
                                    $("#status_msg").empty();
                                    $("#status_msg").html(d);
                                    $("#status_msg").show();
                              
                                },
                                complete: function(){
                                    $("#loading").hide();
                                    $("#status_msg").delay(5000).hide(400);  
                                }});
                    
                           
                        }});
                  
                });
                
                $("#myprofile").click(function() {
                   
                   
                    $(".cleanup_data").empty();
                    $(".cleanup_data").hide();
                    $("#status_msg").hide(); 
                    $("#filter_box").hide(); 
  
                    $.ajax({
                        type: 'POST',
                        url: "administration/user_management/profile.jsp" ,
                        data: "",
                        cache:false,
                        success: function(d) {
                            $("#data").empty();
                            $("#data").html(d);
                            $("#data").show();
                            
                        },
                        complete: function(){
                            $("#loading").hide();
                        }});
                    
                });

               
   
               $("#loading_marquee").show();
               
              
                            
               $.ajax({
                    cache:false,
                    type: 'POST',
                    url: "../includes/get_notif_marquee.jsp",
                    data: "",
                    success: function(d) {
                        
                        $("#info_news").empty();
                        $("#info_news").html(d);
                        $("#info_news").show();
                    },
                    complete: function(){
                        $("#loading_marquee").hide();
                    }
                });
               
               
             /*
                var refresh_data_marquee;
                
                refresh_data_marquee = setInterval(function()
                    {
                        $("#loading_marquee").show();
                           $.ajax({
                                cache:false,
                                type: 'POST',
                                url: "../includes/get_notif_marquee.jsp",
                                data: "",
                                success: function(d) {
                                    $("#info_news").empty();
                                    $("#info_news").html(d);
                                    $("#info_news").show();
                                },
                                complete: function(){
                                    $("#loading_marquee").hide();
                                }
                            });
                    }, 3600000);
                    
               */     
                   
                   

      // set refresh setting
      var refresh=document.getElementById("data_inner_refresh_time").value;
      var refresh_data_inner; 
      var refresh_data="{url:"+file_url+",modul_id:<%=modul_id%>}";
      
  
      
      $("#data_inner_refresh_time").change(function() {
           refresh=document.getElementById("data_inner_refresh_time").value;
           clearInterval(refresh_data_inner);
           if ($("#checkboxSelect_act_refresh").prop('checked')) {
           refresh_data_inner = setInterval(function()
                    {
                        $("#data_inner").hide();
                        $("#loading").show();
                        $.ajax({
                            type: 'POST',
                            url: file_url,
                            data: refresh_data,
                            success: function(data) {
                                $("#data").empty();
                                $("#data").html(data);
                                $("#data").show();

                            },
                            complete: function(){
                                $("#loading").hide(); 
                            }
                        });
                    }, refresh);
              }
                    
      });
      
      
       $("#checkboxSelect_act_refresh").change(function() {
                if (this.checked){
 
                    refresh_data_inner = setInterval(function()
                    {

                        $("#data_inner").hide();
                        $("#loading").show();
                        $.ajax({
                            type: 'POST',
                            url: file_url,
                            data: {url:file_url,modul_id:<%=modul_id%>},
                            success: function(data) {
                                $("#data").empty();
                                $("#data").html(data);
                                $("#data").show();

                            },
                            complete: function(){
                                $("#loading").hide(); 
                            }
                        });
                    }, refresh);

                }else {        
                    clearInterval(refresh_data_inner);

                }
            });
            
               

            });

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

                    <%   if (v_debugMode.equals("1")) {   %>
                    <div class="debug">Debug Mode</div>
                    <%  } %>
                    
                    <div class="profile">welcome <a href="#" id="myprofile"><%=userName%></a>|<a href="../logout.jsp">Logout</a></div>

                    <div class="clear"></div>
                    
                </div>
            </div>

            <div id="navigation">
                <div id="innernav">
                    <ul>
                        <!-- top navigation  -->
                        <!-- add class navleft to first item and navright to last item as shown -->
                        <%=TabMenu%>
                    </ul>
                    
                    <div id="terminal_setting_icon" class="setting_icon" title="Setting.."></div>   
                </div>
                        
            </div>


            <div id="content-wrap">
                <div id="wrap2">
                    <div id="utility">
                        <div id="treeMenu" class="treeMenu"></div>
                    </div>
                    
                    <div id="running_text">
                        <div id="loading_marquee" style="display:none;"><img src="../images/loading.gif" alt="loading..." /></div>
                         <div id="info_news"></div>
                    </div>
                    
                    <div id="filter_box">
                        <div id="loading_filter" style="display:none;"><img src="../images/loading.gif" alt="loading..." /></div>
                        <div class="icon_panel_hide_filter" id="icon_panel_hide_filter"></div>
                        <div class="icon_panel_show_filter" id="icon_panel_show_filter"></div>
                        <div class="cleanup_data" id="filter_box_data"></div>
                        <div class="icon_panel_hide_action" id="icon_panel_hide_action"></div>
                        <div class="icon_panel_show_action" id="icon_panel_show_action"></div>
                        <div class="cleanup_data" id="action_box_data"></div>
                    </div>
                    <div id="status_msg"></div>
                    <div id="uisetting" >
                        <div id="refresh_box_enable" class="refresh_box">
                        <table >     
                        <tr>
                            <td width="150">Refresh Interval </td>
                            <td>
                                <select id="data_inner_refresh_time" name="refresh_time">
                                    <option value="10000" >10 seconds</option>
                                    <option value="30000" >30 seconds</option>
                                    <option value="60000" selected="true">1 minute</option>
                                    <option value="300000" >5 minutes</option>
                                </select>
                            </td>
                        </tr>
                        <tr><td>refresh status</td><td><input class="checkboxSelect_refresh" type="checkbox" id="checkboxSelect_act_refresh" name="checkboxSelect_act_refresh"/> (checked for enable/uncheck for disable refresh)</td></tr>
                        <tr><td>Number Column per row </td><td><input id="contentSettingNumberColumn" type="text" name="contentSettingNumberColumn" value="5" size="10" maxlength="2" /></td></tr>
                        <tr><td>align</td><td><input class="checkboxSelect_refresh" type="checkbox" id="checkboxAlignView" name="checkboxAlignView"/> (check to align 100%)</td></tr>
        
                        </table>
                        </div>
                        <div id="refresh_box_disable" >
                        <table>     
                        <tr><td><div class="info">refresh is disabled for this page</div></td></tr>
                        </table>
                        </div>
                        <div class="cleanup_data" id="refresh_page"></div>
                    </div>
                    <div class="cleanup_data" id="title_box"></div>
                    <div id="content">
                        <div id="loading" style="display:none;"><img src="../images/loading.gif" alt="loading..." /></div>
                        <div id="loading_inner" style="display:none;"><img src="../images/loading.gif" alt="loading..." /></div>
                        <div class="cleanup_data" id="data"></div>
                        <div class="cleanup_data" id="data_inner" ></div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <!-- start footer -->

            <div class="footer">
                <p class="left">&copy; <%=v_appUpdateYear%> <%=v_appCompany%>. <%=v_appNameURL%> <%=v_appVer%></p>
                
                <p class="right">
                    <a href="mailto:it.helpdesk@bankmuamalat.co.id?Subject=[MCRS]%20Hello%20IT%20Helpdesk">need help?</a> 
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


<%
    } else {
    response.sendRedirect("../oops.jsp");
}
%>