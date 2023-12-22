<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
     
    String id = request.getParameter("id");
    String filter_itemname = request.getParameter("filter_itemname");
    String filter_status = request.getParameter("filter_status");

    if (id == null) {
            id = "0";
        }
    
    if (filter_itemname == null) {
            filter_itemname = "";
        }
    
    if (filter_status == null) {
            filter_status = "-1";
        }
  
 
    int i = 0;
    
%>
        
<div >
    <div class="tablelist_wrap">
    <div id="refresh_data" class="add_optional">[refresh data] </div>
    <div id="addRecord" class="add_optional">[add records] </div>
</div>
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th width="40">Action</th>

                <th>ITEMS_NAME</th>
                <th>STATUS_ITEMS</th>
                <th>ITEMS_TAG</th>
                <th>CAT_NAME</th>
                <th>GROUP_NAME</th>
                <th>TYPE_NAME</th>
                <th>ACT_SHOW_TIME</th>
                <th>PIC</th>
                <th>SLA_TIME</th>
                <th>REPORT_DAY</th>
                <th>MACHINE_NAME</th>
                <th>IP_ADDRESS</th>
                <th>LOGIN_USER</th>
                <th>LOGIN_PASS</th>
                <th>SOURCE_PATH</th>
                <th>SOURCE_FILENAME</th>
                <th>DOC_STATUS</th>
                <th>HANDOVER_DATE</th>
                <th>HANDOVER_PIC</th>
                <th>LAUNCH_DATE</th>
                <th>INORDER</th>
                <th>TERMINATION_DATE</th>
                <th>ITEM GROUP UNIT</th>
                


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

                        sql = "select  ID,ITEMS_NAME,STATUS_ITEMS_NAME,ITEMS_GROUPING, CAT_NAME, GROUP_NAME, TYPE_NAME, ACT_SHOW_TIME,FULLNAME PIC, SLA_TIME, REPORT_DAY, "
                                + "MACHINE_NAME, IP_ADDRESS, LOGIN_USER,LOGIN_PASS, SOURCE_PATH SOURCE_PATH, SOURCE_FILENAME, "
                                + "CASE WHEN DOC_STATUS='Yes' then 'Available' else 'Not Available' end DOC_STATUS, "
                                + "HANDOVER_DATE, HANDOVER_PIC, LAUNCH_DATE,INORDER, TERMINATION_DATE,GROUP_NAME_UNIT,ITEM2GROUPUNIT,PIC_USER_ID,STATUS_ITEMS "
                                + "from V_ITEM where 1=1 ";
                        if (filter_itemname.equals("")==false) {
                        sql += " and upper(ITEMS_NAME) like upper('%"+filter_itemname+"%') ";
                        }                        
                            
                                                    
                        
                        if (filter_status.equals("-1")) {
                        sql += " ";
                        }
                        else {
                        sql += " and STATUS_ITEMS = "+filter_status+" ";
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
                                <div class="action_menu_wrap">
                                <div class="action_menu" id="edit_<%=resultSet.getString(1)%>" >
                                    <div class="edit_icon" title="edit this items <%=resultSet.getString(2)%>"></div>
                                </div>
                                
                                 <% 
                                 
                                 String recStat= resultSet.getString("STATUS_ITEMS");
                                 String recStatName="";
                                 
                                if ( recStat.equals("1")) {
                                    recStatName="Deactivate";
                                
                                %>
                                <div class="action_menu" id="recstat_<%=resultSet.getString(1)%>" >
                                    <div class="delete_icon" title="deactivate this item <%=resultSet.getString(2)%>"></div>
                                </div>
                                <% } else { recStatName="Activate";  %>
                                <div class="action_menu" id="recstat_<%=resultSet.getString(1)%>" >
                                    <div class="activate_icon" title="activate this item <%=resultSet.getString(2)%>"></div>
                                </div>
                                <% } %>
                                </div>
                               
                                <script type="text/javascript">
                                    
                                    
                                        <%
                                            if (id != null) {
                                        %>
                                            $("#rows_<%=id%>").attr("class", "mark");

                                        <%}
                                        %>
                                 
                                    $('#edit_<%=resultSet.getString(1)%>').click(function() {
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "tracking/items/items_list_modify.jsp",
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
                                    
                                    var answer = confirm('Are You Sure want to <%=recStatName%> ID <%=resultSet.getString("ID")%> ?');
                                    
                                    if (answer) {
                                    $('#loading').show();
                                    
                                    $.ajax({
                                        type: 'POST',
                                        url: "tracking/items/items_list_recstat_process.jsp",
                                        data: {id:<%=resultSet.getString("ID")%>,recstat:<%=recStat%>},
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
                             out.println("<td> " + resultSet.getString(15) + " </td>");
                             out.println("<td> " + resultSet.getString(16) + " </td>");
                             out.println("<td> " + resultSet.getString(17) + " </td>");
                             out.println("<td> " + resultSet.getString(18) + " </td>");
                             out.println("<td> " + resultSet.getString(19) + " </td>");
                             out.println("<td> " + resultSet.getString(20) + " </td>");
                             out.println("<td> " + resultSet.getString(21) + " </td>");
                             out.println("<td> " + resultSet.getString(22) + " </td>");
                             out.println("<td> " + resultSet.getString(23) + " </td>");
                             out.println("<td> " + resultSet.getString(24) + " </td>");
                            
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
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
            </tr>
        </tfoot>
    </table>
</div>
 <script type="text/javascript">
         $(document).ready(function() {

 $('#refresh_data').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "tracking/items/items_list_data.jsp",
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
             
             $('#addRecord').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "tracking/items/items_list_modify.jsp",
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
             


