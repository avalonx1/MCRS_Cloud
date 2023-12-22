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
     <div id="Paginginfo" class="recordinfotext">default record show <%=v_listrowlimit%> row(s) </div>
</div>

<div>
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th>Action</th>
                <th>NIK</th>
                <th>Nama</th>
                <th>Jabatan</th>
                <th>Unit</th>
                <th>Email</th>
                <th>Role Code</th>
                <th>Role Name</th>
                <th>Key Burst</th>
                <th>Created By</th>
                <th>Created Time</th>
                <th>Modified By</th>
                <th>Modified Time</th>
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

                        sql = "select id,USER_ID,NAMA,JABATAN,UNIT,DIRECTORATE,GENDER,EMAIL,PHONE1,PHONE2,ROLE_CODE,ROLE_NAME,KEY_DATA,"
                                + "maker_fullname||'('||maker_username||')' as maker_fullname,to_char(maker_dt_stamp,'YYYY/MM/DD HH24:MI:SS') maker_dt_stamp,"
                                + "modified_fullname||'('||modified_username||')' as modified_fullname,to_char(modified_dt_stamp,'YYYY/MM/DD HH24:MI:SS') modified_dt_stamp,"
                                + "maker_userid,modified_userid "
                              + " from v_notif_user_role where 1=1 ";
                        
                        
                        if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(USER_ID) like upper('%"+filter_itemname+"%') "
                                + "OR upper(NAMA) like upper('%"+filter_itemname+"%') "
                                + "OR upper(JABATAN) like upper('%"+filter_itemname+"%') "
                                + "OR upper(UNIT) like upper('%"+filter_itemname+"%') "
                                + "OR upper(DIRECTORATE) like upper('%"+filter_itemname+"%') "
                                + "OR upper(ROLE_CODE) like upper('%"+filter_itemname+"%') "
                                + "OR upper(ROLE_NAME) like upper('%"+filter_itemname+"%') "
                                + "OR upper(KEY_DATA) like upper('%"+filter_itemname+"%') "
                                + "OR upper(maker_username) like upper('%"+filter_itemname+"%') "
                                + "OR upper(maker_fullname) like upper('%"+filter_itemname+"%') "
                                + "OR upper(modified_username) like upper('%"+filter_itemname+"%') "
                                + "OR upper(modified_fullname) like upper('%"+filter_itemname+"%') "
                                + ") ";
                        }  
                             
                        sql += " order by ROLE_CODE,KEY_DATA,NAMA";
                        sql += " OFFSET 0 LIMIT "+v_listrowlimit;
                    
               //out.println("<div class=sql>"+sql+"</div>");
               
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
                                    
                              
                                
                                <% if ( resultSet.getString("maker_userid").equals(v_userID) || v_userLevelCode.equals("SUPERADM") || v_userLevelCode.equals("ITSEC") ) { %>
                                <div class="action_menu" id="edit_<%=resultSet.getString("ID")%>" >
                                    <div class="edit_icon" title="edit this items ID <%=resultSet.getString("ID")%>"></div>
                                </div>
                                
                                <div class="action_menu" id="deactivate_<%=resultSet.getString("ID")%>" >
                                    <div class="delete_icon" title="delete this record ID <%=resultSet.getString("ID")%>"></div>
                                </div>
                                </div>
                                
                                <%} %>
                            
                                
                                <script type="text/javascript">
                                    
                                         <%if (!id.equals("0")) {%>
                                         $("#rows_<%=id%>").attr("class", "mark");
                                         <%}%>
                                 
                                    $('#edit_<%=resultSet.getString("id")%>').click(function() {
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "report/emailburst_notif_usrrole/emailburst_notif_usrrole_list_modify.jsp",
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
                                        url: "report/emailburst_notif_usrrole/emailburst_notif_usrrole_list_delete_process.jsp",
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
                                    
                                    
                                  $('#detail_<%=resultSet.getString("ID")%>').click(function() {
                                    $("#data_inner").hide();
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "report/emailburst_notif_usrrole/emailburst_notif_usrrole_list_detail_info.jsp",
                                        data: "id=<%=resultSet.getString("ID")%>",
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
                                    
                               
                                        
                                        
                            
                                    
                               </script>
                       
                      </td>

                      <% 
                        
                      
                            //String status_warna = resultSet.getString("status_warna");
                        
                             out.println("<td> " + resultSet.getString("USER_ID") + " </td>");
                             out.println("<td> " + resultSet.getString("NAMA") + " </td>");
                             out.println("<td> " + resultSet.getString("JABATAN") + " </td>");
                             out.println("<td> " + resultSet.getString("UNIT") + " </td>");
                             out.println("<td> " + resultSet.getString("EMAIL") + " </td>");
                             out.println("<td> " + resultSet.getString("ROLE_CODE") + " </td>");
                             out.println("<td> " + resultSet.getString("ROLE_NAME") + " </td>");
                             out.println("<td> " + resultSet.getString("KEY_DATA") + " </td>");
                             
                             out.println("<td> " + resultSet.getString("maker_fullname") + " </td>");
                             out.println("<td> " + resultSet.getString("maker_dt_stamp") + " </td>");
                             out.println("<td> " + resultSet.getString("modified_fullname") + " </td>");
                             out.println("<td> " + resultSet.getString("modified_dt_stamp") + " </td>");
                            
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
                            url: "report/emailburst_notif_usrrole/emailburst_notif_usrrole_list_data.jsp",
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
                            url: "report/emailburst_notif_usrrole/emailburst_notif_usrrole_list_modify.jsp",
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


