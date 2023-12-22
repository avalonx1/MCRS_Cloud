<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%


String filter_itemname = request.getParameter("filter_itemname");
String filter_groupid = request.getParameter("filter_groupid");
    
    if (filter_itemname == null) {
            filter_itemname = "";
        }
    
    if (filter_groupid==null) {
           
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
                                               
                                                filter_groupid=resultSet.getString("ID");
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
         
    String filter_record_status = request.getParameter("filter_record_status");
    if (filter_record_status==null) {
           filter_record_status="1";
    }
    
    String id = request.getParameter("id");
    
   
    if (id == null) {
            id = "0";
        }

    int i = 0;
%>
      
<div class="tablelist_wrap">
    <div id="refresh_data" class="add_optional">[refresh data] </div>
    <div id="back" class="add_optional">[back] </div>
    
</div>

<div >
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th>Action</th>
                <th>ID</th>
                <th>Tag Code</th>
                <th>Run Info</th>
                <th>Status Process</th>
                <th>Status Info</th>
                <th>Run Username</th>
                <th>Run Time</th>
                
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
                        
                       

                        sql = "select id,id_dsjob,tag_code,run_info,created_userid,created_user_name, "
                              + "status_process,status_process_name,status_process_color,status_info,created_time,created_time_name "
                              + "from v_rundsjob_item_log a "
                              + "where a.id_dsjob="+id+" "
                              + "order by a.created_time desc";
                        
                    
               
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

                            String vStatusProcess= resultSet.getString("status_process");
                            
                  
                            out.println("<tr id=rows_"+resultSet.getString("ID")+" class=" + rowstate + "> ");
                            
                            
                      %>
                      
                      
                      <td>
                        
                      </td>

                      <% 
                        
                             out.println("<td> " + resultSet.getString("id") + " </td>");
                             out.println("<td> " + resultSet.getString("tag_code") + " </td>");
                             out.println("<td> " + resultSet.getString("run_info") + " </td>");
                             out.println("<td axis=" + resultSet.getString("status_process_color")  + " > " + resultSet.getString("status_process_name") + " </td>");
                             out.println("<td> " + resultSet.getString("status_info") + " </td>");
                             out.println("<td> " + resultSet.getString("created_user_name") + " </td>");
                             out.println("<td> " + resultSet.getString("created_time_name") + " </td>");
                             
                            
                              
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
                   filter_groupid= document.getElementById("filter_groupid").value;
                   filter_record_status= document.getElementById("filter_record_status").value;
                   
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "report/rundsjob/rundsjob_item_list_data_log.jsp",
                            data: {id:<%=id%>,
                                   filter_itemname:filter_itemname,
                                   filter_groupid:filter_groupid,
                                   filter_record_status:filter_record_status
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
             
           
              $('#back').click(function() {
                  
                   filter_itemname= document.getElementById("filter_itemname").value;
                   filter_groupid= document.getElementById("filter_groupid").value;     
                   filter_record_status= document.getElementById("filter_record_status").value;     
                        
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "report/rundsjob/rundsjob_item_list_data.jsp",
                            data: {id:<%=id%>,
                                filter_itemname:filter_itemname,
                                filter_groupid:filter_groupid,
                                filter_record_status:filter_record_status
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
             
             
            
           });
    </script>
</div>


