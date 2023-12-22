<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String id = request.getParameter("id");
    
     String filter_itemname = request.getParameter("filter_itemname");
      String filter_report_id = request.getParameter("filter_report_id");
      String filter_group_master_id = request.getParameter("filter_group_master_id");
      String filter_group_child_id = request.getParameter("filter_group_child_id");
      String filter_userlevel_id = request.getParameter("filter_userlevel_id");
      
        
         if (filter_itemname==null) {
           filter_itemname="";
         }
      
         if (filter_report_id==null) {
           filter_report_id="0";
         }
         
         if (filter_group_master_id==null) {
           
           try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "select id "
                                                    + " FROM t_user_group where id="+v_userGroup+" "
                                                    + "  ORDER BY 1";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                               
                                                filter_group_master_id=resultSet.getString("ID");
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
           
         }
         
          if (filter_group_child_id==null) {
           filter_group_child_id="0";
         }
          
             if (filter_userlevel_id==null) {
           filter_userlevel_id="0";
         }
      
             
   
    if (id == null) {
            id = "0";
        }

    int i = 0;
%>
      
<div class="tablelist_wrap">
    <div id="refresh_data" class="add_optional">[refresh data] </div>
    <div id="addRecord" class="add_optional">[add records] </div>
    <div id="Paginginfo" class="recordinfotext">default record show 100 row(s) </div>
</div>

<div >
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th width="50px">Action</th>
                <th>User Group<br/>Code</th>
                <th>User Group<br/>Name</th>
               
                <th>User Level<br/>Code</th>
                <th>User Level<br/>Name</th>
                 <th>User Group<br/>Child Code</th>
                <th>User Group<br/>Child Name</th>
                <th>Report<br/>Code</th>
                <th>Report<br/>Name</th>
                <th>Report<br/>Name Key</th>
                <th></th>
            </tr>
        </thead>

        <tbody>

            <%

                
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "select id, report_id,report_code,report_name, "
                              + "group_code_master, group_name_master,"
                              + "group_code_child, group_name_child,"
                              + "level_code, level_name,report_name_key "
                              + " from v_report_permission_matrix "
                              + " where 1=1 ";
                        
                        
                        if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(report_name) like upper('%"+filter_itemname+"%') OR upper(report_code) like upper('%"+filter_itemname+"%') ) ";
                        } 
                    
                        if (filter_report_id.equals("0")) {
                        sql += " ";
                        }
                        else {
                        sql += " and report_id = "+filter_report_id+" ";
                        } 
                    
                        if (filter_group_master_id.equals("0")) {
                            sql += " ";
                        } else {
                        sql += " and user_group_id = "+filter_group_master_id+" ";
                        }
                        
                        if (filter_group_child_id.equals("0")) {
                            sql += " ";
                        } else {
                        sql += " and user_group_child_id = "+filter_group_child_id+" ";
                        } 
                        
                         if (filter_userlevel_id.equals("0")) {
                            sql += " ";
                        } else {
                        sql += " and user_level_id = "+filter_userlevel_id+" ";
                        } 
                                
                                
                         sql += " order by group_code_master,group_code_child,level_code,report_name";
                        
                         sql += " OFFSET 0 LIMIT 100";
                         
                      //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }

                        resultSet = db.executeQuery(sql);
                        String rowstate = "even";
                        
                        while (resultSet.next()) {
                            i++;

                            if (i % 2 == 0) {
                                rowstate = "even";
                            } else {
                                rowstate = "odd";
                            }


                            out.println("<tr id=rows_"+resultSet.getString("ID")+" class=" + rowstate + "> ");
                            
                            
                      %>
                      
                      
                      <td>
                        
                                <div class="action_menu_wrap">
                                   
                                <div class="action_menu" id="edit_<%=resultSet.getString("ID")%>" >
                                    <div class="edit_icon" title="edit this items ID <%=resultSet.getString("ID")%>"></div>
                                </div>
                                
                                
                                <div class="action_menu" id="deactivate_<%=resultSet.getString("ID")%>" >
                                    <div class="delete_icon" title="delete this record ID <%=resultSet.getString("ID")%>"></div>
                                </div>
                                
                                </div>
                                
                                
                                <script type="text/javascript">
                                    
                                         <%if (id!=null) {%>
                                         $("#rows_<%=id%>").attr("class", "mark");
                                         <%}%>
                                 
                                    $('#edit_<%=resultSet.getString("id")%>').click(function() {
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/report_management/report_access_matrix/report_access_matrix_list_modify.jsp",
                                        data: {id:<%=resultSet.getString("ID")%>,action:2},
                                        success: function(data) {
                                            $('#data_inner').empty();
                                            $('#data_inner').html(data);
                                            $('#data_inner').show();

                                        },
                                        complete: function(){
                                            $('#loading').hide();
                                        }
                                        });
                                        
                                    return false;
                                    });
            
                                    $('#deactivate_<%=resultSet.getString(1)%>').click(function() {
                                    var answer = confirm('Are You Sure want to delete ID <%=resultSet.getString("ID")%> ?');
                                    if (answer) {
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/report_management/report_access_matrix/report_access_matrix_list_delete_process.jsp",
                                        data: "id=<%=resultSet.getString("ID")%>",
                                        success: function(data) {
                                            $('#status_msg').empty();
                                            $('#status_msg').html(data);
                                            $('#status_msg').show();

                                        },
                                        complete: function(){
                                           $('#loading').hide();
                                        }
                                        });
                                        
                                     }
                                        
                                    return false;
                                    });
                                    
                               </script>
                       
                      </td>

                      <% 
                        
                             out.println("<td> " + resultSet.getString("group_code_master") + " </td>");
                             out.println("<td> " + resultSet.getString("group_name_master") + " </td>");
                             out.println("<td> " + resultSet.getString("level_code") + " </td>");
                             out.println("<td> " + resultSet.getString("level_name") + " </td>");
                             out.println("<td> " + resultSet.getString("group_code_child") + " </td>");
                             out.println("<td> " + resultSet.getString("group_name_child") + " </td>"); 
                             out.println("<td> " + resultSet.getString("report_code") + " </td>");
                             out.println("<td> " + resultSet.getString("report_name") + " </td>");
                             out.println("<td> " + resultSet.getString("report_name_key") + " </td>"); 
                             
                            out.println("<td></td>"); 
                            out.println("</tr> ");
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

            %>
        </tbody>
        <tfoot>
            <tr>
                <td>-</td>
                <td> <%=i%> Record(s)</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                 <td>-</td>
                <td>-</td>
                <td>-</td>
            </tr>
        </tfoot>
    </table>
        
    <script type="text/javascript">
         $(document).ready(function() {
           
              $('#refresh_data').click(function() {
                  
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
                            data: {id:0,
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
             
             $('#addRecord').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/report_management/report_access_matrix/report_access_matrix_list_modify.jsp",
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
             
            <% if (!id.equals("0") ) { %> 
             $('#content').animate({
             scrollTop: $("#rows_<%=id%>").offset().top
             }, 2000);
             <% } %>
           });
    </script>
</div>


