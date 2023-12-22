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
 String key_data="";
 String user_id="";
 String user_id_autoComp="";
 
 
 
               
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
                                
                              sql = "select id,user_id,role_id,KEY_DATA,NAMA||' ('||USER_ID||')' as FULLNAME"
                              + " from v_notif_user_role "
                              + "  where id="+id;
                                   
         
                          
                          //debug mode            
                            if (v_debugMode.equals("1")) {
                            out.println("<div class=sql>"+sql+"</div>");
                            }
                        
                        
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                role_id = resultSet.getString("role_id");
                                key_data = resultSet.getString("KEY_DATA");
                                user_id = resultSet.getString("user_id");
                                user_id_autoComp = resultSet.getString("FULLNAME");                                
                                
  
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
    <td width="100" align="left">User</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left">
            <input type="hidden" id="user_id" name="user_id" value="<% out.println((user_id == null) ? "" : user_id); %>" /> 
      <%

          String user_id_autoDataList="[";
                   
                                    
                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            
                                            
                                            sql = "select nik as id,regexp_replace(employee_name||' ('||nik||')','''','-') as DESCR,job_position from t_user_hc_employee  order by 2";
                                                        
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                
                                                            
                                                            if (resultSet.isLast()) {
                                                                 
                                                            user_id_autoDataList+="{name: '"+resultSet.getString(2)+"',code: '"+resultSet.getString(1)+"',type: '"+resultSet.getString(3)+"'} "; 
                                                               
                                                            }else {
                                                                
                                                            user_id_autoDataList+="{name: '"+resultSet.getString(2)+"',code: '"+resultSet.getString(1)+"',type: '"+resultSet.getString(3)+"'}, "; 
                                                            
                                                            }
                                                            
                                             }
                                            
                                             user_id_autoDataList+="]";
                                                   
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
     <input id="user_id_autoComp" size="60px" name="user_id_autoComp" value="<% out.println((user_id_autoComp == null) ? "" : user_id_autoComp); %>"/>
    </td>
  </tr>
  
    <tr>
    <td>Burst Key</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="key_data" name="key_data" size="60" maxlength="100" value="<% out.println((key_data == null) ? "" : key_data); %>"  /></td>
    </tr>
    
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
                                                    + "  ORDER BY inorder";
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
                            url: "report/emailburst_notif_usrrole/emailburst_notif_usrrole_list_data.jsp",
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
            url: "report/emailburst_notif_usrrole/emailburst_notif_usrrole_list_modify_process.jsp",
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



            var user_id_autoComp_opt = {
                    data : <%=user_id_autoDataList%>,
                    getValue: "name",
                    list: {
                            match: {
                                    enabled: true
                            },
                            onChooseEvent: function() {
                                    var value = $("#user_id_autoComp").getSelectedItemData().code;
                                    $("#user_id").val(value).trigger("change");
                            }
                    },
                    template: {
                            type: "description",
                            fields: {
                                    description: "type"
                            }
                    },
                    theme: "plate-dark",
                    placeholder: "type employee name.."
            };

        $("#user_id_autoComp").easyAutocomplete(user_id_autoComp_opt);

        $("#user_id_autoComp").keydown(function (e) {
                   $("#user_id").val("0");
                });
                
                

</script>

