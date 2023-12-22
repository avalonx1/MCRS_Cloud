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
 
 String menu_id="";
 String user_level_id="";
 String user_group_id="";
 String modul="";
 String status_matrix="";
               
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
                                
                            sql = "SELECT id,menu_id,"
                                 + "user_level_id, modul, user_group_id,status_matrix "
                                 +" from v_menu_matrix where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                menu_id = resultSet.getString("menu_id");
                                user_level_id = resultSet.getString("user_level_id");
                                user_group_id = resultSet.getString("user_group_id");
                                modul = resultSet.getString("modul");
                                status_matrix = resultSet.getString("status_matrix");
                                
                                
                               //out.println(jangka_waktu_mulai);
                                        
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
   
   
            <td width="100" align="left">Tree menu</td>
            <td><div class="markMandatory">*</div></td>
            <td width="100" align="left"><select id="menu_id" name="menu_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            
                                            sql = "select * from (WITH RECURSIVE tree AS "
                                                    +"(SELECT id, name, parent_menu, CAST(name As varchar(1000)) As name_fullname,stat,urutan "
                                                    +"FROM t_menu "
                                                    +"WHERE parent_menu=0 "
                                                    +"UNION ALL "
                                                    +"SELECT si.id,si.name, "
                                                    +"	si.parent_menu, "
                                                    +"	CAST(sp.name_fullname || '->' || si.name As varchar(1000)) As name_fullname,si.stat,si.urutan "
                                                    +"FROM t_menu As si "
                                                    +"	INNER JOIN tree AS sp "
                                                    +"	ON (si.parent_menu = sp.id) "
                                                    +") "
                                                    +"SELECT id, name_fullname,stat "
                                                    +"FROM tree "
                                                    +"ORDER BY name_fullname ) a where stat=1 ";
                                                    
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (menu_id.equalsIgnoreCase(resultSet.getString(1))) {
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
            <td width="100" align="left">Group User</td>
            <td><div class="markMandatory">*</div></td>
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
            <td width="100" align="left">Level User</td>
            <td><div class="markMandatory">*</div></td>
            <td width="100" align="left"><select id="user_level_id" name="user_level_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT ID,LEVEL_CODE||' - '||LEVEL_NAME||' ' AS DESC FROM t_user_level a ORDER BY 2";
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
  
  <tr>
            <td width="100" align="left">Module</td>
            <td><div class="markMandatory">*</div></td>
            <td width="100" align="left"><select id="modul" name="modul">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT ID,NAME AS DESC FROM t_module a ORDER BY INORDER";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (modul.equalsIgnoreCase(resultSet.getString(1))) {
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
            <td width="100" align="left">Record Status </td>
            <td><div class="markMandatory">*</div></td>
            <td width="100" align="left"><select id="status_matrix" name="status_matrix">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT 1 ID, 'Active' AS DESC UNION ALL SELECT 0 ID, 'Not Active' AS DESC order by 1 desc";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (status_matrix.equalsIgnoreCase(resultSet.getString(1))) {
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
 
</table></td>  
            </tr>
            <tr>
                <td>
                    <span class="small"><font color="red">*) Mandatory</span>
                </td>
            <tr><td>
                    <button type="submit">Submit</button>
                    <button type="reset">Reset</button>
                </td>
            </tr>
        </table>


                                
    </div>
</form>

<script type="text/javascript">

    var widthform = $(".myform").css("width");
    var widthfill = widthform.substr(0, widthform.length - 2) - 300;
    

    $(".datePicker").datepicker({
        dateFormat: 'yy/mm/dd'
    });
    
    
    
               $('#back').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/menu_navigation/tree_permission_matrix/tree_permission_matrix_list_data.jsp",
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
            url: "administration/menu_navigation/tree_permission_matrix/tree_permission_matrix_list_modify_process.jsp",
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

