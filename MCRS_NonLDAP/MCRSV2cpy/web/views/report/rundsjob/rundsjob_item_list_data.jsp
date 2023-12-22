<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String id = request.getParameter("id");
    
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

<div >
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th>Action</th>
                <th>Job ID</th>
                <th>Job<br/>Code</th>
                <th>Job Name</th>
                <th>Job<br/>Description</th>
                <th>Group Code</th>
                <th>Group Name</th>
                <th>Job<br/>Status</th>
                <th>Parameter Desc</th>
                <th>Jobname QA</th>
                <th>Jobname User</th>
            </tr> 
        </thead>

        <tbody>

            <%

                
                try {
                    ResultSet resultSet = null;
                    ResultSet resultSet2 = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "select id,job_code, job_name, job_desc,groupid,group_code,group_name,record_status,record_status_name,"
                            + "etljob_param,etljob_param_desc,etljob_runqa,etljob_runusr,status_process,status_info,status_process_color,status_process_name "
                            +" from v_rundsjob_item where 1=1 ";
                          
                        if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(job_code) like upper('%"+filter_itemname+"%') OR upper(job_name) like upper('%"+filter_itemname+"%') "
                                + " OR upper(job_desc) like upper('%"+filter_itemname+"%') ) ";
                        }  
                        
                       if (filter_groupid.equals("0")) {
                        sql += " ";
                        }
                        else {
                        sql += " and groupid = "+filter_groupid+" ";
                        } 
                       
                       if (filter_record_status.equals("-1")) {
                        sql += " ";
                        }
                        else {
                        sql += " and record_status = "+filter_record_status+" ";
                        } 
                       
                       
                       
                        
                        
                        
                         sql += " order by job_code ";
                         
                        sql += " OFFSET 0 LIMIT "+v_listrowlimit;
                    
               
                        //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }

                        resultSet = db.executeQuery(sql);
                        String rowstate = "even";
                        
                        while (resultSet.next()) {
                            i++;

                            
                            int statRun = 0;
                            sql = "select count(1) jml from v_rundsjob_item_log where status_process in (1) and id_dsjob="+resultSet.getString("ID")+" ";  
                              
                        
                            resultSet2 = db.executeQuery(sql);
                            while (resultSet2.next()) {
                                statRun = resultSet2.getInt("jml");
                            }

                        
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
                                
                               <% 
                                 
                                 String recStat= resultSet.getString("record_status");
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
                                
                                        <% if (statRun==0) {  %>
                               <div class="action_menu" id="rundsjob_qa_<%=resultSet.getString(1)%>" >
                                    <div class="assign_icon" title="Run report QA-Version <%=resultSet.getString("job_name")%>"></div>
                                </div> 
                                
                                <div class="action_menu" id="rundsjob_usr_<%=resultSet.getString(1)%>" >
                                    <div class="assign2_icon" title="Run report User-Version <%=resultSet.getString("job_name")%>"></div>
                                </div> 
                                      <% } else { %>
                                        <div class="action_menu_no_click" id="norun_<%=resultSet.getString(1)%>" >
                                    <div class="others_lock_icon" title="Can't Run Job <%=resultSet.getString("job_name")%>"></div>
                                </div> 
                                      <%}%>
                                      
                                <div class="action_menu" id="detail_runjob_<%=resultSet.getString(1)%>" >
                                    <div class="detail_icon" title="View Run Job History <%=resultSet.getString("job_name")%>"></div>
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
                                        url: "report/rundsjob/rundsjob_item_list_modify.jsp",
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
                                        url: "report/rundsjob/rundsjob_item_list_recstat_process.jsp",
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
                                    
                                    $('#rundsjob_qa_<%=resultSet.getString(1)%>').click(function() {
                                    
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "report/rundsjob/rundsjob_item_list_param_modify.jsp",
                                        data: {id:<%=resultSet.getString("ID")%>,action:1},
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
                                    
                                    $('#rundsjob_usr_<%=resultSet.getString(1)%>').click(function() {
                                    
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "report/rundsjob/rundsjob_item_list_param_modify.jsp",
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
                                    
                                    
                                     $('#detail_runjob_<%=resultSet.getString("id")%>').click(function() {
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "report/rundsjob/rundsjob_item_list_data_log.jsp",
                                        data: {id:<%=resultSet.getString("ID")%>},
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
                        
                             out.println("<td> " + resultSet.getString("id") + " </td>");   
                             out.println("<td> " + resultSet.getString("job_code") + " </td>");
                             out.println("<td> " + resultSet.getString("job_name") + " </td>");
                             out.println("<td> " + resultSet.getString("job_desc") + " </td>");
                             out.println("<td> " + resultSet.getString("group_code") + " </td>");
                             out.println("<td> " + resultSet.getString("group_name") + " </td>");
                             out.println("<td> " + resultSet.getString("record_status_name") + " </td>");
                             out.println("<td> " + resultSet.getString("etljob_param_desc") + " </td>");
                             out.println("<td> " + resultSet.getString("etljob_runqa") + " </td>");
                             out.println("<td> " + resultSet.getString("etljob_runusr") + " </td>");
                   
                            
                            
                             
                            out.println("</tr> ");
                        }

                    } catch (SQLException Sqlex) {
                        out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                    } finally {
                        db.close();
                            if (resultSet != null) resultSet.close(); 
                            if (resultSet2 != null) resultSet2.close(); 
                            
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
                            url: "report/rundsjob/rundsjob_item_list_data.jsp",
                            data: {filter_itemname:filter_itemname,
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
             
             $('#addRecord').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "report/rundsjob/rundsjob_item_list_modify.jsp",
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


