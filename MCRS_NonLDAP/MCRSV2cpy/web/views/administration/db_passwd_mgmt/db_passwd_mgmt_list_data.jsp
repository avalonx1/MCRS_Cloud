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
    <%  if ( v_userLevelCode.equals("ITDSO") ||  v_userLevelCode.equals("SUPERADM") ) {  %> <div id="addRecord" class="add_optional">[add records] </div> <% } %>
    <div id="Paginginfo" class="recordinfotext">default record show <%=v_listrowlimit%> row(s) </div>
</div>

<div >
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th width="50px">Action</th>
                <th width="100px">DB Name</th>
                <th width="200px">DB Username</th>
                <th>2 Person Auth</th>
                <th>PIC 1 Name</th>
                <th>PIC 1 Email</th>
                <th>PIC 2 Name</th>
                <th>PIC 2 Email</th>
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

                        sql = "select id,db_name, db_username,is_4eyes, pic_name_1,pic_email_1,pic_name_2,pic_email_2 "
                              + " from t_dwh_dbmgmt_user_pic where 1=1 ";
                                
                        
                        if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(db_name) like upper('%"+filter_itemname+"%') "
                               + "OR upper(db_username) like upper('%"+filter_itemname+"%') "
                                + "OR upper(pic_name_1) like upper('%"+filter_itemname+"%') "
                                + "OR upper(pic_name_2) like upper('%"+filter_itemname+"%') "
                                + ") ";
                        }  
                       
                        sql +=" order by 2,3 ";
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
                                    
                               <%  if ( v_userLevelCode.equals("ITDSO") ||  v_userLevelCode.equals("SUPERADM") ) {  %>
                                <div class="action_menu" id="edit_<%=resultSet.getString("ID")%>" >
                                    <div class="edit_icon" title="edit this items username <%=resultSet.getString("db_username")%>"></div>
                                </div>
                                
                                <div class="action_menu" id="deactivate_<%=resultSet.getString("ID")%>" >
                                    <div class="delete_icon" title="delete this record username <%=resultSet.getString("db_username")%>"></div>
                                </div>
                                    
                                    <% } %>
                                 
                                 
                               
                                
                                <%  if ( v_userLevelCode.equals("ITDBA") ||  v_userLevelCode.equals("SUPERADM") ) {  %>
                                <div class="action_menu" id="reset_passwd_<%=resultSet.getString("ID")%>" >
                                    <div class="assign_icon" title="reset password username <%=resultSet.getString("db_username")%>"></div>
                                </div>
                                <% } %>
                                
                              </div>
                                
                                <script type="text/javascript">
                                    
                                         <%if (!id.equals("0")) {%>
                                         $("#rows_<%=id%>").attr("class", "mark");
                                         <%}%>
                                 
                                    $('#edit_<%=resultSet.getString("id")%>').click(function() {
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/db_passwd_mgmt/db_passwd_mgmt_list_modify.jsp",
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
                                        url: "administration/db_passwd_mgmt/db_passwd_mgmt_list_delete_process.jsp",
                                        data: {id:<%=resultSet.getString("ID")%>},
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
                                    
                                    
                                     $('#reset_passwd_<%=resultSet.getString(1)%>').click(function() {
                                    var answer = confirm('Are You Sure want to reset password for this User <%=resultSet.getString("db_username")%> ?');
                                    if (answer) {
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/db_passwd_mgmt/db_passwd_mgmt_list_reset_passwd_process.jsp",
                                        data: {id:<%=resultSet.getString("ID")%>},
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
                        
                             out.println("<td> " + resultSet.getString("db_name") + " </td>");
                             out.println("<td> " + resultSet.getString("db_username") + " </td>");
                             out.println("<td> " + resultSet.getString("is_4eyes") + " </td>"); 
                             out.println("<td> " + resultSet.getString("pic_name_1") + " </td>"); 
                             out.println("<td> " + resultSet.getString("pic_email_1") + " </td>");
                             out.println("<td> " + resultSet.getString("pic_name_2") + " </td>");
                             out.println("<td> " + resultSet.getString("pic_email_2") + " </td>");
                              
                               
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
                            url: "administration/db_passwd_mgmt/db_passwd_mgmt_list_data.jsp",
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
                            url: "administration/db_passwd_mgmt/db_passwd_mgmt_list_modify.jsp",
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


