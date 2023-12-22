<%@include file="../../../includes/check_auth_layer3.jsp"%>

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
 
 String role_id="";
 String group_id="";
 String group_name="";
 String group_id_autoComp="";
 
 String level_id="";
 String level_name="";
 String level_id_autoComp="";
 
 
 
 
               
 if (actionCode.equals("ADD") ) {
     header_title_act="Add";
 } else {
     header_title_act="Edit";
     id  = request.getParameter("id");
     
    
     
                      try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;
                                
                              sql = "select id,id_role,id_user_group,group_code||' - '|| group_name group_name,id_user_level,level_code||' - '|| level_name level_name "
                              + " from v_notif_role_matrix_usrgroup "
                              + "  where id="+id;
                                   
         
                          
                          //debug mode            
                            if (v_debugMode.equals("1")) {
                            out.println("<div class=sql>"+sql+"</div>");
                            }
                        
                        
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                role_id = resultSet.getString("id_role");
                                
                                group_id = resultSet.getString("id_user_group");
                                group_name = resultSet.getString("group_name");
                                group_id_autoComp = resultSet.getString("group_name");
                                
                                level_id = resultSet.getString("id_user_level");
                                level_name = resultSet.getString("level_name");
                                level_id_autoComp = resultSet.getString("level_name");
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
   
   
    <tr>
    <td width="100" align="left">Role</td>
    <td></td>
    <td width="100" align="left"><select id="role_id" name="role_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, t_code||' - '||t_name AS DESC "
                                                    + " FROM t_notif_role where record_stat=1 "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (role_id.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td width="100" align="left">User Group</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left">
            <input type="hidden" id="group_id" name="group_id" value="<% out.println((group_id == null) ? "" : group_id); %>" /> 
      <%

          String group_id_autoDataList="[";
                   
                                    
                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            
                                            
                                            sql = "select id, group_code||' - '||group_name group_name from t_user_group order by 2";
                                                        
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                
                                                            
                                                            if (resultSet.isLast()) {
                                                                 
                                                            group_id_autoDataList+="{name: '"+resultSet.getString(2)+"',code: '"+resultSet.getString(1)+"'} "; 
                                                               
                                                            }else {
                                                                
                                                            group_id_autoDataList+="{name: '"+resultSet.getString(2)+"',code: '"+resultSet.getString(1)+"'}, "; 
                                                            
                                                            }
                                                            
                                             }
                                            
                                             group_id_autoDataList+="]";
                                                   
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
     <input id="group_id_autoComp" size="60px" name="group_id_autoComp" value="<% out.println((group_id_autoComp == null) ? "" : group_id_autoComp); %>"/>
    </td>
  </tr>
  
   
  <tr>
    <td width="100" align="left">User Level</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left">
            <input type="hidden" id="level_id" name="level_id" value="<% out.println((level_id == null) ? "" : level_id); %>" /> 
      <%

          String level_id_autoDataList="[";
                   
                                    
                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            
                                            
                                            sql = "select id, level_code||' - '||level_name level_name from t_user_level order by 2";
                                                        
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                
                                                            
                                                            if (resultSet.isLast()) {
                                                                 
                                                            level_id_autoDataList+="{name: '"+resultSet.getString(2)+"',code: '"+resultSet.getString(1)+"'} "; 
                                                               
                                                            }else {
                                                                
                                                            level_id_autoDataList+="{name: '"+resultSet.getString(2)+"',code: '"+resultSet.getString(1)+"'}, "; 
                                                            
                                                            }
                                                            
                                             }
                                            
                                             level_id_autoDataList+="]";
                                                   
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
     <input id="level_id_autoComp" size="60px" name="level_id_autoComp" value="<% out.println((level_id_autoComp == null) ? "" : level_id_autoComp); %>"/>
    </td>
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
                            url: "report/emailburst_notif_usrrole_matrixgroup/emailburst_notif_usrrole_matrixgroup_list_data.jsp",
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
            url: "report/emailburst_notif_usrrole_matrixgroup/emailburst_notif_usrrole_matrixgroup_list_modify_process.jsp",
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



            var group_id_autoComp_opt = {
                    data : <%=group_id_autoDataList%>,
                    getValue: "name",
                    list: {
                            match: {
                                    enabled: true
                            },
                            onChooseEvent: function() {
                                    var value = $("#group_id_autoComp").getSelectedItemData().code;
                                    $("#group_id").val(value).trigger("change");
                            }
                    },
                    theme: "plate-dark",
                    placeholder: "type User Group.."
            };

        $("#group_id_autoComp").easyAutocomplete(group_id_autoComp_opt);

        $("#group_id_autoComp").keydown(function (e) {
                   $("#group_id").val("0");
                });
                
                
                
            var level_id_autoComp_opt = {
                    data : <%=level_id_autoDataList%>,
                    getValue: "name",
                    list: {
                            match: {
                                    enabled: true
                            },
                            onChooseEvent: function() {
                                    var value = $("#level_id_autoComp").getSelectedItemData().code;
                                    $("#level_id").val(value).trigger("change");
                            }
                    },
                    theme: "plate-dark",
                    placeholder: "type User level.."
            };

        $("#level_id_autoComp").easyAutocomplete(level_id_autoComp_opt);

        $("#level_id_autoComp").keydown(function (e) {
                   $("#level_id").val("0");
                });
                
                

</script>

