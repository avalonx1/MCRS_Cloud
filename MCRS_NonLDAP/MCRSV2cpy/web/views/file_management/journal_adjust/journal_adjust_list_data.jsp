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
    <div id="addRecord" class="add_optional">[Upload File] </div>
</div>

<div >
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
               <th width="150">Action</th>
                <th width="50px">ID</th>
                <th width="100px">Journal Name</th>
                <th width="100px">Journal Desc</th>
                <th width="100px">Transaction Date</th>
                <th width="100px">Reverse Flag</th>
                <th width="100px">Adj Flag</th>
                <th width="100px">Status Process</th>
                <th width="100px">Status Desc</th>
                <th width="100px">File Name</th>
                <th width="100px">Size</th>
                <th width="100px">Last Modified</th>
                <th width="100px">Upload User</th>
                <th>Upload Time</th>
                <th>Shared Recipient</th>
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
                        
                        sql = "select count(1) jml from v_journal_adjust_file where status_process in (1,2)";  
                              
                        
                        resultSet = db.executeQuery(sql);
                        while (resultSet.next()) {
                            statRun = resultSet.getInt("jml");
                        }
                        
                        sql = "select id,journal_name,journal_desc,doc_path_key,trn_dt,reverse_flag,reverse_flag_name,status_process,status_process_name,status_desc,"
                                + "fullname,created_time,status_process_color,adj_flag "
                              + " from v_journal_adjust_file where 1=1 ";
                              //+ " where created_userid="+v_userID+" and 1=1 ";
                              
                           
                        
                      if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(journal_name) like upper('%"+filter_itemname+"%') OR upper(doc_path_key) like upper('%"+filter_itemname+"%') ) ";
                        }  
                     
                        sql +=" order by created_time desc ";
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
                        
                                <div class="action_menu" id="download_<%=resultSet.getString("ID")%>" >
                                    <div class="download_icon" title="download file <%=resultSet.getString("doc_path_key")%>"></div>
                                </div>
                               
                                <div class="action_menu" id="recstat_<%=resultSet.getString(1)%>" >
                                    <div class="delete_icon" title="delete file <%=resultSet.getString("doc_path_key")%>"></div>
                                </div>
                                
                                    <% 
                                    
                                        if (statRun==0 && vStatusProcess.equals("0")) {  %>
                                <div class="action_menu" id="runjob_<%=resultSet.getString(1)%>" >
                                    <div class="assign_icon" title="Run Job <%=resultSet.getString("doc_path_key")%>"></div>
                                </div>
                                    <% }else { %>
                                      <div class="action_menu_no_click" id="lock_<%=resultSet.getString(1)%>" >
                                       <div class="others_lock_icon" title="Can't RunJob File <%=resultSet.getString("doc_path_key")%>"></div>
                                      </div>
                                
                                    <% } 
                                     %>
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
                                        url: "file_management/journal_adjust/journal_adjust_list_recstat_process.jsp",
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
                                    
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "file_management/journal_adjust/journal_adjust_list_modify.jsp",
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
                                    
                                    
                                    
                               </script>
                       
                      </td>

                      <% 
                        
                             out.println("<td> " + resultSet.getString("id") + " </td>");
                             out.println("<td> " + resultSet.getString("journal_name") + " </td>"); 
                             out.println("<td> " + resultSet.getString("journal_desc") + " </td>");
                             out.println("<td> " + resultSet.getString("trn_dt") + " </td>");
                             out.println("<td> " + resultSet.getString("reverse_flag_name") + " </td>");
                             out.println("<td> " + resultSet.getString("adj_flag") + " </td>");
                             out.println("<td axis=" + resultSet.getString("status_process_color")  + "> " + resultSet.getString("status_process_name") + " </td>");
                             out.println("<td> " + resultSet.getString("status_desc") + " </td>");
                             
                             out.println("<td> " + resultSet.getString("doc_path_key") + " </td>");
                              if (vStatFile) {
                             out.println("<td> " + Math.round(vFileSize) + " "+ vFileSizeFlag+" </td>");
                             out.println("<td> " + lastmodified + " </td>");
                             } else {
                             out.println("<td> N/A </td>");
                             out.println("<td> N/A </td>");
                             }
                      
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
                            url: "file_management/journal_adjust/journal_adjust_list_data.jsp",
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
                        
                         popupwindow = window.open('file_management/journal_adjust/journal_adjust_list_upload.jsp?id=<%=v_userID%>&stat=0','Upload File','menubar=no,location=no,resizable=no,scrollbars=no,status=yes,width=800, height=300, left=0, top=0');
                         popupWindow.focus();
                         return false;
                                            
             });
             
            <% if (!id.equals("0") ) { %> 
             $('#content').animate({
             scrollTop: $("#rows_<%=id%>").offset().top
             }, 2000);
             <% } %>
             
             
           });
    </script>
</div>


