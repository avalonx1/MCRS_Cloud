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
 
 String group_id="";
 String level_id="";
 String message="";
 String inorder="";
 
 
 
               
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
                                
                            sql = "SELECT id,group_id,level_id,message,inorder "
                                 +" from t_notification where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                group_id = resultSet.getString("group_id");
                                level_id = resultSet.getString("level_id");
                                message = resultSet.getString("message");
                                inorder =  resultSet.getString("inorder");
                                
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
    <td width="100" align="left">User Group </td>
    <td></td>
    <td width="100" align="left"><select id="group_id" name="group_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * FROM (SELECT 0 ID, '-All Group-' AS DESC, 1 AS ORD,-1 AS FL UNION ALL SELECT id ID, '['||group_code||'] - '||group_name AS DESC, 2 AS ORD,branch_flag AS FL "
                                                    + " FROM t_user_group ) a "
                                                    + "  ORDER BY 3,4,2";
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
    <td width="100" align="left">User Level </td>
    <td></td>
    <td width="100" align="left"><select id="level_id" name="level_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * FROM (SELECT 0 ID, '-All Level-' AS DESC, 1 AS ORD UNION ALL SELECT id ID, '['||level_code||'] - '||level_name AS DESC, 2 AS ORD"
                                                    + " FROM t_user_level ) a "
                                                    + "  ORDER BY 3,2";
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
  
    
    <tr>
    <td>Notification</td>
    <td><div class="markMandatory"></div></td>
    <td><input type="text" id="message" name="message" size="100" maxlength="3000" value="<% out.println((message == null) ? "" : message); %>"  /></td>
    </tr>
    
    <tr>
    <td>Inorder</td>
    <td><div class="markMandatory"></div></td>
    <td><input type="text" id="inorder" name="inorder" size="10" maxlength="2" value="<% out.println((inorder == null) ? "" : inorder); %>"  /></td>
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
                   
                       filter_itemname= document.getElementById("filter_itemname").value;
                    
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/report_management/notification/notification_list_data.jsp",
                             data: {id:<%=id%>,
                                filter_itemname:filter_itemname
                            },
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
            url: "administration/report_management/notification/notification_list_modify_process.jsp",
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

