<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String id = request.getParameter("id");
    
   
    if (id == null) {
            id = "0";
        }
    
    String filter_itemname = request.getParameter("filter_itemname");
    if (filter_itemname == null) {
            filter_itemname = "";
        }

   
         

    int i = 0;
%>
      
<div class="tablelist_wrap">
    <div id="refresh_data" class="add_optional">[refresh data] </div>
    <div id="addRecord" class="add_optional">[add records] </div>
</div>
<div >
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th width="50px">Action</th>
                <th width="100px">Group Name</th>
                <th width="200px">Level Name</th>
                <th>Inorder</th>
                <th>Created Name</th>
                <th>Created Time</th>
                <th>Status</th>
                <th>Message</th>
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

                        sql = "select a.id,b.group_name,c.level_name,a.message,case when a.status=1 then 'Active' else 'Not Active' end status,"
                              + "a.inorder, to_char(a.created_time,'YYYY-MM-DD HH24:MI:SS') created_time,d.first_name||' '||d.last_name fullname "
                              + " from t_notification a left join t_user_group b on a.group_id=b.id "
                              + "left join t_user_level c on a.level_id=c.id left join t_user d on a.userid=d.id "
                              + " where 1=1 ";
                              
                        
                        if (filter_itemname.equals("")==false) {
                        sql += " and (upper(message) like upper('%"+filter_itemname+"%') ) ";
                        }       
                        
                        sql += " order by inorder,2,3";
                        
                       //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>" + sql + "</div>");
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
                                        url: "administration/report_management/notification/notification_list_modify.jsp",
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
                                        url: "administration/report_management/notification/notification_list_delete_process.jsp",
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
                        
                             out.println("<td> " + resultSet.getString("group_name") + " </td>");
                             out.println("<td> " + resultSet.getString("level_name") + " </td>");
                             out.println("<td> " + resultSet.getString("inorder") + " </td>");
                             out.println("<td> " + resultSet.getString("fullname") + " </td>");
                             out.println("<td> " + resultSet.getString("created_time") + " </td>");
                             out.println("<td> " + resultSet.getString("status") + " </td>");
                             out.println("<td> " + resultSet.getString("message") + " </td>");
                             
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
            </tr>
        </tfoot>
    </table>
        
    <script type="text/javascript">
         $(document).ready(function() {
           
              $('#refresh_data').click(function() {
                  
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
             
             $('#addRecord').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/report_management/notification/notification_list_modify.jsp",
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


