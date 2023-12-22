<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String objid = request.getParameter("objid");
    String filter_username = request.getParameter("filter_username");
    String filter_status = request.getParameter("filter_status");

    if (objid == null) {
            objid = "0";
        }
    
   
    if (filter_username == null) {
            filter_username = "";
        }
    if (filter_status == null) {
            filter_status = "0";
        }
    int i = 0;
%>
        
<div >
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th width="40">Action</th>

                <th>USERNAME</th>
                <th>FIRST_NAME</th>
                <th>LAST_NAME</th>
                <th>EMP_ID</th>
                <th>IP_ADDRESS</th>
                <th>LEVEL_NAME</th>
                <th>GROUP_NAME</th>
                <th>EMAIL</th>
                <th>STAT_LOGIN</th>
                <th>LAST_LOGIN</th>
                <th>CREATION_TIME</th>
                <th>CREATOR</th>
                <th>STAT_USER</th>
                
                


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

                        sql = "select  ID, USERNAME, FIRST_NAME, LAST_NAME, EMP_ID, IP_ADDRESS, LEVEL_NAME, GROUP_NAME, "
                                + "EMAIL, STAT_LOGIN, LAST_LOGIN, CREATION_TIME, CREATOR, STAT_USER "
                                + "from V_USERS where 1=1 ";
                        if (filter_username.equals("")==false) {
                        sql += " and upper(USERNAME) like upper('%"+filter_username+"%')";
                        }       
                        
                        if (filter_status.equals("0")==false) {
                        sql += " and STAT_USER ='"+filter_status+"' ";
                        }                                                                 
                                       
                                               
                        
                        //out.println(sql);

                        resultSet = db.executeQuery(sql);
                        String rowstate = "even";
                        
                        while (resultSet.next()) {
                            i++;

                            if (i % 2 == 0) {
                                rowstate = "even";
                            } else {
                                rowstate = "odd";
                            }


                            out.println("<tr id=rows_"+resultSet.getString(1)+" class=" + rowstate + "> ");
                            
                            
                      %>
                      
                      
                      <td>
                        
                                
                                <div class="action_menu" id="edit_<%=resultSet.getString(1)%>" >
                                    <div class="edit_icon" title="edit this items <%=resultSet.getString(2)%>"></div>
                                </div>
                                
                                 <% 
                                if (resultSet.getString("STAT_USER").equals("Active") ) {
                                    
                                
                                %>
                                <div class="action_menu" id="deactivate_<%=resultSet.getString(1)%>" >
                                    <div class="delete_icon" title="deactivate this item <%=resultSet.getString(2)%>"></div>
                                </div>
                                <% } else { %>
                                <div class="action_menu" id="activate_<%=resultSet.getString(1)%>" >
                                    <div class="activate_icon" title="activate this item <%=resultSet.getString(2)%>"></div>
                                </div>
                                <% } %>
                                <script type="text/javascript">
                                    
                                         <%if (objid!=null) {%>
                                         $("#rows_<%=objid%>").attr("class", "mark");
                                         <%}%>
                                 
                                    $('#edit_<%=resultSet.getString(1)%>').click(function() {
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/user_management/user_list_edit.jsp",
                                        data: "objid=<%=resultSet.getString(1)%>",
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
                                    
                                    
                                    $('#activate_<%=resultSet.getString(1)%>').click(function() {
                                    
                                    var answer = confirm('Are You Sure want to activate user <%=resultSet.getString(2)%> ?');
                                    
                                    if (answer) {
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/user_management/user_list_activate_process.jsp",
                                        data: "objid=<%=resultSet.getString(1)%>",
                                        success: function(data) {
                                            $('#status_msg').empty();
                                            $('#status_msg').html(data);
                                            $('#status_msg').show();

                                        },
                                        complete: function(){
                                            
                                        }
                                        });
                                        
                                     }
                                        
                                    return false;
                                    });
                                    
                                    $('#deactivate_<%=resultSet.getString(1)%>').click(function() {
                                    
                                    var answer = confirm('Are You Sure want to deactivate user <%=resultSet.getString(2)%> ?');
                                    
                                    if (answer) {
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/user_management/user_list_delete_process.jsp",
                                        data: "objid=<%=resultSet.getString(1)%>",
                                        success: function(data) {
                                            $('#status_msg').empty();
                                            $('#status_msg').html(data);
                                            $('#status_msg').show();

                                        },
                                        complete: function(){
                                           
                                        }
                                        });
                                        
                                     }
                                        
                                    return false;
                                    });
                                    
                               </script>
                       
                      </td>
                      
                      
                      <%
                             
                             out.println("<td> " + resultSet.getString(2) + " </td>");
                             out.println("<td> " + resultSet.getString(3) + " </td>");
                             out.println("<td> " + resultSet.getString(4) + " </td>");
                             out.println("<td> " + resultSet.getString(5) + " </td>");
                             out.println("<td> " + resultSet.getString(6) + " </td>");
                             out.println("<td> " + resultSet.getString(7) + " </td>");
                             out.println("<td> " + resultSet.getString(8) + " </td>");
                             out.println("<td> " + resultSet.getString(9) + " </td>");
                             out.println("<td> " + resultSet.getString(10) + " </td>");
                             out.println("<td> " + resultSet.getString(11) + " </td>");
                             out.println("<td> " + resultSet.getString(12) + " </td>");
                             out.println("<td> " + resultSet.getString(13) + " </td>");
                             out.println("<td> " + resultSet.getString(14) + " </td>");
                            
                             
                        

                            
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
            </tr>
        </tfoot>
    </table>

        
    <script type="text/javascript">
         $(document).ready(function() {
            <% if (!objid.equals("0") ) { %> 
             $('#content').animate({
             scrollTop: $("#rows_<%=objid%>").offset().top
             }, 2000);
             <% } %>
           });
    </script>
</div>


