<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String id = request.getParameter("id");
    
   
    if (id == null) {
            id = "0";
        }

    int i = 0;
%>
      
<div class="tablelist_wrap">
    <div id="back" class="add_optional">[back] </div>
    
</div>

<div >
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th width="150">Action</th>
                <th width="50px">ID</th>
                <th width="100px">File Name</th>
                <th width="100px">Size</th>
                <th width="100px">Last Modified</th>
                <th width="100px">Knowledge Name</th>
                <th width="100px">Upload User</th>
                <th>Upload Time</th>
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

                        sql = "select a.id,a.knowledge_id,a.user_id,a.doc_path_key,to_char(a.created_time,'YYYY-MM-DD HH24:MI:SS') created_time, "
                                + "b.t_name,c.username,c.first_name||' '||c.last_name fullname "
                              + " from t_knowledge_bank_file a left join t_knowledge_bank b on a.knowledge_id=b.id "
                                + "left join t_user c on a.user_id=c.id where a.knowledge_id="+id+" "
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
                                        url: "tracking/knowledge_bank/knowledge_list_download_file_recstat_process.jsp",
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
                             out.println("<td> " + resultSet.getString("doc_path_key") + " </td>");
                              if (vStatFile) {
                             out.println("<td> " + Math.round(vFileSize) + " "+ vFileSizeFlag+" </td>");
                             out.println("<td> " + lastmodified + " </td>");
                             } else {
                             out.println("<td> N/A </td>");
                             out.println("<td> N/A </td>");
                             }
                              
                             out.println("<td> " + resultSet.getString("t_name") + " </td>");
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
            </tr>
        </tfoot>
    </table>
        
    <script type="text/javascript">
         $(document).ready(function() {
           
       
           
              $('#back').click(function() {
                  
                   filter_itemname= document.getElementById("filter_itemname").value;
                      
                        
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "tracking/knowledge_bank/knowledge_list_data.jsp",
                            data: {
                                filter_itemname:filter_itemname,
                               
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


