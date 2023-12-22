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
 
 String user_group_id="";
 String user_group_child_id="";
 String user_level_id="";
 String report_id="";
 
 
 
 
 
               
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
                                
                            sql = "SELECT id,user_group_id,user_group_child_id,user_level_id,report_id "
                                 +" from v_report_permission_matrix where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                user_group_id = resultSet.getString("user_group_id");
                                user_group_child_id= resultSet.getString("user_group_child_id");
                                user_level_id = resultSet.getString("user_level_id");
                                report_id = resultSet.getString("report_id");
                                
                               
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
    <td width="100" align="left">Report </td>
    <td></td>
    <td width="100" align="left"><select id="report_id" name="report_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, report_code||' - '||report_name||' - ('||report_extension||')' AS DESC "
                                                    + " FROM t_report_item "
                                                    + " WHERE report_status=1 "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (report_id.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td width="100" align="left">User Group </td>
    <td></td>
    <td width="100" align="left"><select id="user_group_id" name="user_group_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * FROM (SELECT 0 ID, '-All Branch-' AS DESC, 1 AS ORD,-1 AS FL UNION ALL SELECT id ID, group_code||' - '||group_name AS DESC, 2 AS ORD,branch_flag AS FL "
                                                    + " FROM t_user_group ) a "
                                                    + "  ORDER BY 3,4,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (user_group_id.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td width="100" align="left">User Group Child </td>
    <td></td>
    <td width="100" align="left"><select id="user_group_child_id" name="user_group_child_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * FROM (SELECT 0 ID, '-All Branch-' AS DESC, 1 AS ORD,-1 AS FL UNION ALL SELECT id ID, group_code||' - '||group_name AS DESC, 2 AS ORD,branch_flag AS FL "
                                                    + " FROM t_user_group ) a "
                                                    + "  ORDER BY 3,4,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (user_group_child_id.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td width="100" align="left">User Level</td>
    <td></td>
    <td width="100" align="left"><select id="user_level_id" name="user_level_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, '['||level_code||'] - '||level_name AS DESC "
                                                    + " FROM t_user_level  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (user_level_id.equalsIgnoreCase(resultSet.getString(1))) {
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
                   
                   filter_itemname= document.getElementById("filter_itemname").value;
                    filter_report_id = document.getElementById("filter_report_id").value;
                    filter_group_master_id = document.getElementById("filter_group_master_id").value;
                    filter_group_child_id = document.getElementById("filter_group_child_id").value;
                    filter_userlevel_id = document.getElementById("filter_userlevel_id").value;
                    
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/report_management/report_access_matrix/report_access_matrix_list_data.jsp",
                            data: {id:<%=id%>,
                            filter_itemname:filter_itemname,
                            filter_report_id:filter_report_id,
                            filter_group_master_id:filter_group_master_id,
                            filter_group_child_id:filter_group_child_id,
                            filter_userlevel_id:filter_userlevel_id
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
            url: "administration/report_management/report_access_matrix/report_access_matrix_list_modify_process.jsp",
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

