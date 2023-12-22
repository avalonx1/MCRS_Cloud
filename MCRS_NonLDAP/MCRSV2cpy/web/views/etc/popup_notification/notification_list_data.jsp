<%@include file="../../../includes/check_auth_layer3.jsp"%>
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
                <th width="100px">Notif Code</th>
                <th width="200px">Notif Title</th>
                <th>Notif Image <br>Path</th>
                <th>Notif Image <br>Width</th>
                <th>Notif Image <br>Height</th>
                <th>Notif <br>SWF Status</th>
                <th>Notif Description</th>
                <th>Created By</th>
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

                        sql = "select id,notif_code,notif_title,substr(notif_desc,1,50)||'...' notif_desc,image_file,img_height,img_width,fullname, "
                              + "created_time,stat_swfntf_name "
                              + " from v_popup_notif "
                              + " where 1=1 ";
                              
                        
                        if (filter_itemname.equals("")==false) {
                        sql += " and ( (upper(notif_code) like upper('%"+filter_itemname+"%') ) OR (upper(notif_title) like upper('%"+filter_itemname+"%') ) "
                                + "OR (upper(notif_title) like upper('%"+filter_itemname+"%') ) ) ";
                        }       
                        
                        sql += " order by 2,3";
                        
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
                                        url: "etc/popup_notification/notification_list_modify.jsp",
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
                                        url: "etc/popup_notification/notification_list_delete_process.jsp",
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
                        
                             out.println("<td> " + resultSet.getString("notif_code") + " </td>");
                             out.println("<td> " + resultSet.getString("notif_title") + " </td>");
                             out.println("<td> " + resultSet.getString("image_file") + " </td>");
                             out.println("<td> " + resultSet.getString("img_width") + " </td>");
                             out.println("<td> " + resultSet.getString("img_height") + " </td>");
                             out.println("<td> " + resultSet.getString("stat_swfntf_name") + " </td>");
                             out.println("<td> " + resultSet.getString("notif_desc") + " </td>");
                             out.println("<td> " + resultSet.getString("fullname") + " </td>");
                             out.println("<td> " + resultSet.getString("created_time") + " </td>");
                             
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
                            url: "etc/popup_notification/notification_list_data.jsp",
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
                            url: "etc/popup_notification/notification_list_modify.jsp",
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


