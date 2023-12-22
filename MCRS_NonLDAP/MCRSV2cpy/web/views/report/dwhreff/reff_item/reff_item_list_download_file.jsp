<%@include file="../../../../includes/check_auth_layer3.jsp"%>
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
                <th>Status File</th>
                <th>Info</th>
                <th>File Name</th>
                <th>Size</th>
                <th>Last Modified</th>
                <th>Reff Name</th>
                <th>Upload User</th>
                <th>Upload Time</th>
                <th></th>
            </tr>
        </thead>

        <tbody>

            <%

                int statRun = 0;
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;
                        
                        sql = "select count(1) jml from v_dwhreff_item_file where status_process in (1,2) and fileid="+id+"";  
                              
                        
                        resultSet = db.executeQuery(sql);
                        while (resultSet.next()) {
                            statRun = resultSet.getInt("jml");
                        }
                        

                        sql = "select a.id,a.fileid,a.userid,a.doc_path_key,to_char(a.created_time,'YYYY-MM-DD HH24:MI:SS') created_time,a.reff_code||' - '||a.reff_name REFFNAME,a.username,a.first_name||' '||a.last_name fullname,"
                              + "a.status_process,a.status_process_name,a.status_process_color,a.status_info,a.etljob_name "
                              + " from v_dwhreff_item_file a "
                              + "where a.fileid="+id+" "
                              + " order by a.created_time desc";
                        
                    
               
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
                            
                            
                            
                             boolean vStatFile = false;
                             boolean vStatFileSwf = false;
                             String vFileSizeFlag = "";
                             double vFileSize =0;
                             String lastmodified = "";
                             
                             String fullpathfile = v_fileUploadDir+"/"+resultSet.getString("doc_path_key");
                             
                                    
                             File checkfile = new File(fullpathfile);
                            
                            if(checkfile.exists()){
 
                                    vStatFile=true;
                                    
                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                    lastmodified = sdf.format(checkfile.lastModified()).toString();
                             
                                    double bytes = checkfile.length();
                                    double kilobytes = (bytes / 1024);
                                    double megabytes = (kilobytes / 1024);
                                    double gigabytes = (megabytes / 1024);
                                    double terabytes = (gigabytes / 1024);
                                    double petabytes = (terabytes / 1024);
                                    double exabytes = (petabytes / 1024);
                                    double zettabytes = (exabytes / 1024);
                                    double yottabytes = (zettabytes / 1024);


                                    if (gigabytes<1) {

                                        if (megabytes<1) {
                                           if (kilobytes<1) {
                                           vFileSize=bytes;
                                            vFileSizeFlag="Bytes";
                                            }else {
                                               vFileSize=kilobytes;
                                               vFileSizeFlag="KB";
                                            }  

                                        }else {
                                            vFileSize=megabytes;
                                           vFileSizeFlag="MB";
                                        }    
                                    } else {
                                        vFileSize=gigabytes;

                                        vFileSizeFlag="GB";
                                    }

                            } // end check file
                        

                            out.println("<tr id=rows_"+resultSet.getString("ID")+" class=" + rowstate + "> ");
                            
                            
                      %>
                      
                      
                      <td>
                        
                                <div class="action_menu_wrap">
                                    
                                   <%   
                              if (!vStatFile) {
                                  %>
                                <div class="action_menu_no_click"  >         
                                    <div class="others_lock_icon" title="file not Exist"></div>
                                </div>
                               <%   
                                } else {
                                 %>
                        
                                 <% if (statRun==0 && vStatusProcess.equals("0")) {  %>
                                <div class="action_menu" id="runjob_<%=resultSet.getString(1)%>" >
                                    <div class="assign_icon" title="Run Job <%=resultSet.getString("doc_path_key")%>"></div>
                                </div>
                                    <% }else { %>
                                      <div class="action_menu_no_click" id="lock_<%=resultSet.getString(1)%>" >
                                       <div class="others_lock_icon" title="Can't RunJob File <%=resultSet.getString("doc_path_key")%>"></div>
                                      </div>
                                
                                    <% } %>
                                    
                                <div class="action_menu" id="download_<%=resultSet.getString("ID")%>" >
                                    <div class="download_icon" title="download ID <%=resultSet.getString("ID")%>"></div>
                                </div>
                                
                                <div class="action_menu" id="recstat_<%=resultSet.getString(1)%>" >
                                    <div class="delete_icon" title="delete file <%=resultSet.getString("doc_path_key")%>"></div>
                                </div>
                                
                                
                                  
                                     
                                <% } %>
                                </div>
                                
                                
                                <script type="text/javascript">
                                    
                                         <%if (id!=null) {%>
                                         $("#rows_<%=id%>").attr("class", "mark");
                                         <%}%>
                                 
                              
                                    $('#download_<%=resultSet.getString("id")%>').click(function() {
                                    window.location="file_management/download_file.jsp?filename=<%=resultSet.getString("doc_path_key")%>";
                                    return false;
                                    });
                                    
                                    
                                     $('#recstat_<%=resultSet.getString(1)%>').click(function() {
                                    var answer = confirm('Are You Sure want to delete File with ID <%=resultSet.getString("ID")%> (<%=resultSet.getString("doc_path_key")%>) ?');
                                    if (answer) {
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "report/dwhreff/reff_item/reff_item_list_download_file_recstat_process.jsp",
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
                                    
                                    $('#runjob_<%=resultSet.getString(1)%>').click(function() {
                                    var answer = confirm('Are You Sure want to run this ETL Job ID <%=resultSet.getString("ID")%> (<%=resultSet.getString("doc_path_key")%>) ?');
                                    if (answer) {
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "report/dwhreff/reff_item/reff_item_list_download_file_etljob_process.jsp",
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
                        
                             out.println("<td> " + resultSet.getString("id") + " </td>");
                             out.println("<td axis=" + resultSet.getString("status_process_color")  + " > " + resultSet.getString("status_process_name") + " </td>");
                             out.println("<td> " + resultSet.getString("status_info") + " </td>");
                             out.println("<td> " + resultSet.getString("doc_path_key") + " </td>");
                              if (vStatFile) {
                             out.println("<td> " + Math.round(vFileSize) + " "+ vFileSizeFlag+" </td>");
                             out.println("<td> " + lastmodified + " </td>");
                             } else {
                             out.println("<td> N/A </td>");
                             out.println("<td> N/A </td>");
                             }
                              
                             out.println("<td> " + resultSet.getString("REFFNAME") + " </td>");
                             out.println("<td> " + resultSet.getString("fullname") + " </td>");
                             out.println("<td> " + resultSet.getString("created_time") + " </td>");
                             
                             out.println("<td>  </td>");
                              
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
                            url: "report/dwhreff/reff_item/reff_item_list_download_file.jsp",
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
                            url: "report/dwhreff/reff_item/reff_item_list_data.jsp",
                            data: {
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


