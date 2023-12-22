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

         String filter_group_id = request.getParameter("filter_group_id");
         if (filter_group_id==null) {
           filter_group_id="0";
         }
         
         String filter_level_id = request.getParameter("filter_level_id");
         if (filter_level_id==null) {
           filter_level_id="0";
         }
    
    
    
    String filter_userstatus = request.getParameter("filter_userstatus");
         if (filter_userstatus==null) {
           filter_userstatus="-1";
         }
    

    int i = 0;
    
    //out.println(filter_userstatus);
    
%>
      
<div class="tablelist_wrap">
    <div id="refresh_data" class="add_optional">[refresh data] </div>
    <div id="addRecord" class="add_optional">[add records] </div>
    <div id="syncLDAP" class="add_optional">[Sync LDAP] </div>
</div>

<div >
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th width="50px">Action</th>
                <th>USERNAME</th>
                <th>FIRST_NAME</th>
                <th>LAST_NAME</th>
                <th>EMP_ID</th>
                <th>TITLE</th>
                <th>IP_ADDRESS</th>
                <th>LEVEL_NAME</th>
                <th>GROUP_NAME</th>
                <th>EMAIL</th>
                <th>CONTACT EXT</th>
                <th>STAT_LOGIN</th>
                <th>LAST_LOGIN</th>
                <th>CREATION_TIME</th>
                <th>CREATOR</th>
                
                <th>FIRST TIME LOGIN</th>
                <th>NDA CONFIRMED</th>
                <th>CHANGE PSWD NOTIF</th>
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
                                + "EMAIL, STAT_LOGIN, LAST_LOGIN, CREATION_TIME, CREATOR,FIRST_TIME_LOGIN,FIRST_TIME_LOGIN_NAME,"
                                + "NDA_CONFIRMED,NDA_CONFIRMED_NAME,CHANGE_PASWD_NOTIF,CHANGE_PASWD_NOTIF_NAME, "
                                + "STAT_USER,FLAG,TITLE,CONTACT_EXT,creator_name "
                                + "from V_USERS where 1=1 ";
                        
                        System.out.println("### Select v_users user_list_data.jsp "+sql);
                                
                        if (filter_itemname.equals("")==false) {
                        sql += " and (upper(USERNAME) like upper('%"+filter_itemname+"%') OR upper(First_name||last_name) like upper('%"+filter_itemname+"%') ) ";
                        }       
                        
                        
                        if (filter_userstatus.equals("-1")) {
                            sql += " ";
                        } else {
                        sql += " and flag = "+filter_userstatus+" ";
                        }
                    
                        if (filter_level_id.equals("0")) {
                            sql += " ";
                        } else {
                        sql += " and level_id = "+filter_level_id+" ";
                        }
                           
                        if (filter_group_id.equals("0")) {
                            sql += " ";
                        } else {
                        sql += " and group_id = "+filter_group_id+" ";
                        }
                        
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
                                <div class="action_menu" id="edit_<%=resultSet.getString(1)%>" >
                                    <div class="edit_icon" title="edit this items ID <%=resultSet.getString(1)%>"></div>
                                </div>
                                
                                <% 
                                 
                                 String recStat= resultSet.getString("FLAG");
                                 String recStatName="";
                                 
                                if ( recStat.equals("1")) {
                                    recStatName="Deactivate";
                                
                                %>
                                <div class="action_menu" id="recstat_<%=resultSet.getString(1)%>" >
                                    <div class="delete_icon" title="deactivate this item ID <%=resultSet.getString(1)%>"></div>
                                </div>
                                <% } else { recStatName="Activate";  %>
                                <div class="action_menu" id="recstat_<%=resultSet.getString(1)%>" >
                                    <div class="activate_icon" title="activate this item ID <%=resultSet.getString(1)%>"></div>
                                </div>
                                <% } %>
                                
                                <script type="text/javascript">
                                    
                                         <%if (id!=null) {%>
                                         $("#rows_<%=id%>").attr("class", "mark");
                                         <%}%>
                                 
                                    $('#edit_<%=resultSet.getString(1)%>').click(function() {
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/user_management/user/user_list_modify.jsp",
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
                                    
                                    
                                    
                                    $('#recstat_<%=resultSet.getString(1)%>').click(function() {
                                    
                                    var answer = confirm('Are You Sure want to <%=recStatName%> user <%=resultSet.getString(2)%> ?');
                                    
                                    if (answer) {
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/user_management/user/user_list_recstat_process.jsp",
                                        data: {id:<%=resultSet.getString("ID")%>,recstat:<%=recStat%>},
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
                      
                     
                             out.println("<td> " + resultSet.getString("USERNAME") + " </td>");
                             out.println("<td> " + resultSet.getString("FIRST_NAME") + " </td>");
                             out.println("<td> " + resultSet.getString("LAST_NAME") + " </td>");
                             out.println("<td> " + resultSet.getString("EMP_ID") + " </td>");
                             out.println("<td> " + resultSet.getString("TITLE") + " </td>");
                             out.println("<td> " + resultSet.getString("IP_ADDRESS") + " </td>");
                             out.println("<td> " + resultSet.getString("LEVEL_NAME") + " </td>");
                             out.println("<td> " + resultSet.getString("GROUP_NAME") + " </td>");
                             out.println("<td> " + resultSet.getString("EMAIL") + " </td>");
                             out.println("<td> " + resultSet.getString("CONTACT_EXT") + " </td>");
                             out.println("<td> " + resultSet.getString("STAT_LOGIN") + " </td>");
                             out.println("<td> " + resultSet.getString("LAST_LOGIN") + " </td>");
                             out.println("<td> " + resultSet.getString("CREATION_TIME") + " </td>");
                             out.println("<td> " + resultSet.getString("creator_name") + " </td>");
                              out.println("<td> " + resultSet.getString("FIRST_TIME_LOGIN_NAME") + " </td>");
                             out.println("<td> " + resultSet.getString("NDA_CONFIRMED_NAME") + " </td>");
                             out.println("<td> " + resultSet.getString("CHANGE_PASWD_NOTIF_NAME") + " </td>");
                             out.println("<td> " + resultSet.getString("STAT_USER") + " </td>");
                            
                             
                             
                            
                             
                              
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
                   filter_group_id= document.getElementById("filter_group_id").value;
                   filter_level_id= document.getElementById("filter_level_id").value;
                   filter_userstatus= document.getElementById("filter_userstatus").value;
                   
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/user_management/user/user_list_data.jsp",
                            data: {id:<%=id%>,
                                filter_itemname:filter_itemname,
                                filter_group_id:filter_group_id,
                                filter_level_id:filter_level_id,
                                filter_userstatus:filter_userstatus
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
             
             $('#syncLDAP').click(function() {
                  
                   filter_itemname= document.getElementById("filter_itemname").value;
                   filter_group_id= document.getElementById("filter_group_id").value;
                   filter_level_id= document.getElementById("filter_level_id").value;
                   filter_userstatus= document.getElementById("filter_userstatus").value;
                   
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/user_management/user/user_list_syncLDAP.jsp",
                            data: {id:<%=id%>,
                                filter_itemname:filter_itemname,
                                filter_group_id:filter_group_id,
                                filter_level_id:filter_level_id,
                                filter_userstatus:filter_userstatus
                            },
                            success: function(data) {
                                $('#status_msg').empty();
                                $('#status_msg').html(data);
                                $('#status_msg').show();
                            },
                            complete: function(){
                                $('#loading').hide(); 
                                
                                        $('#data_inner').hide();
                                        $('#loading').show();
                                        $.ajax({
                                            type: 'POST',
                                            url: "administration/user_management/user/user_list_data.jsp",
                                            data: {id:<%=id%>,
                                                filter_itemname:filter_itemname,
                                                filter_group_id:filter_group_id,
                                                filter_level_id:filter_level_id,
                                                filter_userstatus:filter_userstatus
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

                            }
                        });        
             });
             
             $('#addRecord').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/user_management/user/user_list_modify.jsp",
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


