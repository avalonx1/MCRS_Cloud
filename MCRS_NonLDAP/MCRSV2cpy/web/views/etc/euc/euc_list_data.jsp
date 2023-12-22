<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String id = request.getParameter("id");
    
    String filter_itemname = request.getParameter("filter_itemname");
    if (filter_itemname == null) {
            filter_itemname = "";
        }
   
    if (id == null) {
            id = "0";
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
                <th>Action</th>
                <th>EUC Name</th>
                <th width="200px">EUC Desc</th>
                <th width="200px">EUC Purpose</th>
                <th>EUC Type</th>
                <th>EUC Status</th>
                <th>EUC User PIC</th>
                <th>EUC User Group</th>
                <th>EUC Dev <br>Category</th>
                <th>EUC Dev <br>Info</th>
                <th>EUC Dev <br>Start</th>
                <th>EUC Dev <br>End</th>
                <th>EUC End User Info</th>
                <th>Created User</th>
                <th>Created Time</th>
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

                        sql = "select id,euc_name,euc_desc,euc_purpose,euc_type,type_code,type_name,euc_status,status_code,status_name,euc_dev_cat,devcat_code,devcat_name,euc_enduser, "
                                + "euc_userpic,userpic_fullname,userpic_group,euc_dev_info,euc_dev_start,euc_dev_start_name,euc_dev_end,euc_dev_end_name,created_userid,created_userid_fullname,created_time_name "
                              + " from v_euc where 1=1 ";
                        
                        
                        if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(euc_name) like upper('%"+filter_itemname+"%') "
                                + "OR upper(type_name) like upper('%"+filter_itemname+"%') "
                                + "OR upper(status_name) like upper('%"+filter_itemname+"%') "
                                + "OR upper(userpic_fullname) like upper('%"+filter_itemname+"%') "
                                + "OR upper(userpic_group) like upper('%"+filter_itemname+"%') "
                                + "OR upper(euc_purpose) like upper('%"+filter_itemname+"%') "
                                + "OR upper(devcat_name) like upper('%"+filter_itemname+"%') "
                                + ") ";
                        }  
                             
                        sql += " order by id";
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
                                    
                                         <%if (!id.equals("0")) {%>
                                         $("#rows_<%=id%>").attr("class", "mark");
                                         <%}%>
                                 
                                    $('#edit_<%=resultSet.getString("id")%>').click(function() {
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "etc/euc/euc_list_modify.jsp",
                                        data: {id:<%=resultSet.getString("id")%>,action:2},
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
                                        url: "etc/euc/euc_list_delete_process.jsp",
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
                        
                             out.println("<td> " + resultSet.getString("euc_name") + " </td>");
                             out.println("<td> " + resultSet.getString("euc_desc") + " </td>");
                             out.println("<td> " + resultSet.getString("euc_purpose") + " </td>");
                             out.println("<td> " + resultSet.getString("type_name") + " </td>");
                             out.println("<td> " + resultSet.getString("status_name") + " </td>");
                             out.println("<td> " + resultSet.getString("userpic_fullname") + " </td>");
                             out.println("<td> " + resultSet.getString("userpic_group") + " </td>");
                             out.println("<td> " + resultSet.getString("devcat_name") + " </td>");
                             out.println("<td> " + resultSet.getString("euc_dev_info") + " </td>");
                             out.println("<td> " + resultSet.getString("euc_dev_start_name") + " </td>");
                             out.println("<td> " + resultSet.getString("euc_dev_end_name") + " </td>");
                             out.println("<td> " + resultSet.getString("euc_enduser") + " </td>");
                             out.println("<td> " + resultSet.getString("created_userid_fullname") + " </td>");
                             out.println("<td> " + resultSet.getString("created_time_name") + " </td>");
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
                            url: "etc/euc/euc_list_data.jsp",
                            data: {id:<%=id%>,
                                filter_itemname:filter_itemname},
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
                            url: "etc/euc/euc_list_modify.jsp",
                            data: "id=<%=id%>",
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


