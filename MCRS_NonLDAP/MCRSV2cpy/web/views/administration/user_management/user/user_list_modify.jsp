<%@include file="../../../../includes/check_auth_layer3.jsp"%>

<%

 String action = request.getParameter("action");
 String actionCode = "";
 
 if (action==null) {
     actionCode="ADD";
 }else {
     actionCode="EDT";
 }

 //out.println(action);
 
 String header_title_act="";
 String id="0";
 
    String username = "";
    String password = "";
    String first_name="";
    String last_name ="";
    String emp_id="";
    String group_id="";
    String level_id="";
    String email="";
    String notification_msg="";
    String first_time_login="";
    String nda_confirmed="";
    String change_paswd_notif="";
    String title ="";
    String contact_ext ="";
    String homescreen_notif="";
 
 
 
               
 if (actionCode.equals("ADD") ) {
     header_title_act="Add";
 } else {
     header_title_act="Edit";
     id  = request.getParameter("id");
     
     

 
     String denom="999,999,999,999,999.99";
     
                      try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;
                                
                              sql = " select  ID, USERNAME,PASSWORD, FIRST_NAME, LAST_NAME, EMP_ID, IP_ADDRESS, level_id, group_id, "
                                + "EMAIL, STAT_LOGIN, LAST_LOGIN, CREATION_TIME, CREATOR,FIRST_TIME_LOGIN,NDA_CONFIRMED,CHANGE_PASWD_NOTIF,"
                                + "STAT_USER,LEVEL_ID,GROUP_ID,NOTIFICATION_MSG,title,CONTACT_EXT,homescreen_notif "
                                + "from V_USERS "
                                + "  where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                username = resultSet.getString("username");
                                password= resultSet.getString("password");
                                first_name = resultSet.getString("first_name");
                                last_name = resultSet.getString("last_name");
                                emp_id = resultSet.getString("emp_id");
                                group_id = resultSet.getString("group_id");
                                level_id = resultSet.getString("level_id");
                                email = resultSet.getString("email");
                                notification_msg = resultSet.getString("notification_msg");
                                first_time_login = resultSet.getString("first_time_login");
                                nda_confirmed = resultSet.getString("nda_confirmed");
                                change_paswd_notif = resultSet.getString("change_paswd_notif");
                                title = resultSet.getString("title");
                                contact_ext = resultSet.getString("contact_ext");
                                homescreen_notif = resultSet.getString("homescreen_notif");
                             
                               
                            }
                                
                        } catch (SQLException Sqlex) {
                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                        } finally {
                            db.close();
                                if (resultSet != null) resultSet.close(); 
                        }
                    } catch (Exception except) {
                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                    }
     
     
 }
 
%>
<div class="tablelist_wrap">
    <div id="back" class="add_optional">[back] </div>
    
</div>

<form id="modifyForm" method="post" action="#">
    <input type="hidden" id="id" name="id" value="<%=id%>" />
    <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />
    <div id="stylized" class="myform">
        <h1><%=header_title_act%> Record </h1>
        <p></p>
   <table class="formtable" border="0"><tr><td>
   <table class="formtable" border="0">
   
       <%
       
        if (actionCode.equals("ADD") ) {
            
            first_time_login="1";
            nda_confirmed="1";
            change_paswd_notif="1";
            
            
            %>
    <tr>
    <td>Username</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="username" name="username" size="30" maxlength="50" /></td>
    </tr>
    
        
    
    <tr>
    <td>Password</td>
    <td><div class="markMandatory">LDAP</div></td>
    <td><input disabled="true" type="password" id="password" name="password" size="30" maxlength="50" /></td>
    </tr>
            
            
       <% } else { %>
   
       
    <tr>
    <td>Username</td>
    <td><div class="markMandatory">LDAP</div></td>
    <td><input type="text" disabled="true" id="username" name="username" size="30" maxlength="50" value="<% out.println((username == null) ? "" : username); %>" /></td>
    </tr>
    
    <% }%>
    
    <tr>
    <td>First Name</td>
    <td><div class="markMandatory">LDAP</div></td>
    <td><input type="text" disabled="true" id="first_name" name="first_name" size="30" maxlength="50" value="<% out.println((first_name == null) ? "" : first_name); %>"  /></td>
    </tr>
    
    <tr>
    <td>Last Name</td>
    <td><div class="markMandatory">LDAP</div></td>
    <td><input type="text" disabled="true" id="last_name" name="last_name" size="30" maxlength="50" value="<% out.println((last_name == null) ? "" : last_name); %>"  /></td>
    </tr>
    
     <tr>
    <td>Title</td>
    <td><div class="markMandatory">LDAP</div></td>
    <td><input type="text" disabled="true" id="title" name="title" size="30" maxlength="50" value="<% out.println((title == null) ? "" : title); %>"  /></td>
    </tr>
    
     <tr>
    <td>Contact Extension</td>
    <td><div class="markMandatory">LDAP</div></td>
    <td><input type="text" disabled="true" id="contact_ext" name="contact_ext" size="30" maxlength="50" value="<% out.println((contact_ext == null) ? "" : contact_ext); %>"  /></td>
    </tr>
    
     <tr>
    <td>Email</td>
    <td><div class="markMandatory">LDAP</div></td>
    <td><input type="text" disabled="true" id="email" name="email" size="30" maxlength="50" value="<% out.println((email == null) ? "" : email); %>"  /></td>
    </tr>
    
    <tr>
    <td width="100" align="left">Group</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="group_id" name="group_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, group_code||' - '||group_name AS DESC, BRANCH_FLAG "
                                                    + " FROM t_user_group  "
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (group_id.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
                                            }
                                            resultSet.close();
                                        } catch (SQLException Sqlex) {
                                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                        } finally {
                                            db.close();
                                             if (resultSet != null) resultSet.close(); 

                                        }
                                    } catch (Exception except) {
                                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                                    }
                    %>
    </select></td>
  </tr>
  
  <tr>
    <td width="100" align="left">Level</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="level_id" name="level_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, level_code||' - '||level_name AS DESC "
                                                    + " FROM t_user_level  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (level_id.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
                                            }
                                            resultSet.close();
                                        } catch (SQLException Sqlex) {
                                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                        } finally {
                                            db.close();
                                             if (resultSet != null) resultSet.close(); 

                                        }
                                    } catch (Exception except) {
                                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                                    }
                    %>
    </select></td>
  </tr>
    
  <%
       
        if (actionCode.equals("EDT") ) {
            %>
            
            
             <tr>
    <td width="100" align="left">First Time Login Notif</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="first_time_login" name="first_time_login">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT 1 AS ID, '-Yes-' AS DESC, 1 AS ORD UNION ALL SELECT 0 AS ID, '-No-' AS DESC,2 AS ORD "
                                                    + "  ORDER BY 3";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (first_time_login.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
                                            }
                                            resultSet.close();
                                        } catch (SQLException Sqlex) {
                                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                        } finally {
                                            db.close();
                                             if (resultSet != null) resultSet.close(); 

                                        }
                                    } catch (Exception except) {
                                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                                    }
                    %>
    </select></td>
  </tr>
    
          <tr>
    <td width="100" align="left">NDA Confirmed Notif</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="nda_confirmed" name="nda_confirmed">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT 1 AS ID, '-Yes-' AS DESC, 1 AS ORD UNION ALL SELECT 0 AS ID, '-No-' AS DESC,2 AS ORD "
                                                    + "  ORDER BY 3";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (nda_confirmed.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
                                            }
                                            resultSet.close();
                                        } catch (SQLException Sqlex) {
                                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                        } finally {
                                            db.close();
                                             if (resultSet != null) resultSet.close(); 

                                        }
                                    } catch (Exception except) {
                                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                                    }
                    %>
    </select></td>
  </tr>
  
     <tr>
    <td width="100" align="left">Change Password Notif</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="change_paswd_notif" name="change_paswd_notif">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT 1 AS ID, '-Yes-' AS DESC, 1 AS ORD UNION ALL SELECT 0 AS ID, '-No-' AS DESC,2 AS ORD "
                                                    + "  ORDER BY 3";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (change_paswd_notif.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
                                            }
                                            resultSet.close();
                                        } catch (SQLException Sqlex) {
                                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                        } finally {
                                            db.close();
                                             if (resultSet != null) resultSet.close(); 

                                        }
                                    } catch (Exception except) {
                                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                                    }
                    %>
    </select></td>
  </tr>
  
     <tr>
    <td width="100" align="left">Home Screen Notif</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="homescreen_notif" name="homescreen_notif">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT 1 AS ID, '-Yes-' AS DESC, 1 AS ORD UNION ALL SELECT 0 AS ID, '-No-' AS DESC,2 AS ORD "
                                                    + "  ORDER BY 3";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (homescreen_notif.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
                                            }
                                            resultSet.close();
                                        } catch (SQLException Sqlex) {
                                            out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                                        } finally {
                                            db.close();
                                             if (resultSet != null) resultSet.close(); 

                                        }
                                    } catch (Exception except) {
                                        out.println("<div class=sql>" + except.getMessage() + "</div>");
                                    }
                    %>
    </select></td>
  </tr>
    
    
 
    
    <% } %>
    <tr>
    <td>Notification Msg</td>
    <td></td>
    <td><textarea class="notes_info" id="notification_msg" name="notification_msg"  rows="10" cols="50" maxlength="4000"><% out.println((notification_msg == null) ? "" : notification_msg); %></textarea>
    </tr>
    
    
</table></td></tr>
            <tr>
                <td>
                    <span class="small"><font color="red">*) Mandatory</span>
                </td>
            </tr>
            <tr><td align="left"> <p></p>
                    <button type="submit">Submit</button>
                    <button type="reset">Reset</button>
                </td>
            </tr>
        </table>


                                
    </div>
</form>

<script type="text/javascript">

    
    
               $('#back').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/user_management/user/user_list_data.jsp",
                            data: "",
                            success: function(data) {
                                $('#data_inner').empty();
                                $('#data_inner').html(data);
                                $('#data_inner').show();
                            },
                            complete: function(){
                                $('#loading').hide(); 
                            }
                        });        
             });
             
             
    $('#modifyForm').submit(function () {
        $("#status_msg").empty();
        $('#loading').show();
        $.ajax({
            type: 'POST',
            url: "administration/user_management/user/user_list_modify_process.jsp",
            data: $(this).serialize(),
            success: function (data) {

                $("#status_msg").empty();
                $("#status_msg").html(data);
                $("#status_msg").show();
            },
            complete: function () {
                $('#loading').hide();
            }
        });
        return false;
    });


</script>

