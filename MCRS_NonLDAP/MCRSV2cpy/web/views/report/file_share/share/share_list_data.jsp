<%@include file="../../../../includes/check_auth_layer3.jsp"%>
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
                <th width="50px">Action</th>
                <th width="100px">File Name</th>
                <th width="200px">Recipient <br/>Username</th>
                <th>Recipient <br/>Full Name</th>
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

                        sql = "select a.id,a.fileid,a.userid,b.doc_path_key,c.username,c.first_name||' '||c.last_name fullname "
                              + " from t_usr_file_share_recipient a left join t_usr_file_share b on a.fileid=b.id left join t_user c on c.id=a.userid "
                              + " where b.userid="+v_userID+" ";
                                
                        
                        if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(b.doc_path_key) like upper('%"+filter_itemname+"%') OR upper(c.username) like upper('%"+filter_itemname+"%') ) ";
                        }  
                         
                        sql +=" order by a.id ";
                        sql += " OFFSET 0 LIMIT "+v_listrowlimit;
                        
                    
               
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
                                        url: "report/file_share/share/share_list_modify.jsp",
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
                                        url: "report/file_share/share/share_list_delete_process.jsp",
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
                        
                             out.println("<td> " + resultSet.getString("doc_path_key") + " </td>");
                             out.println("<td> " + resultSet.getString("username") + " </td>");
                             out.println("<td> " + resultSet.getString("fullname") + " </td>");
                             out.println("<td> </td>");
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
                            url: "report/file_share/share/share_list_data.jsp",
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
                            url: "report/file_share/share/share_list_modify.jsp",
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


