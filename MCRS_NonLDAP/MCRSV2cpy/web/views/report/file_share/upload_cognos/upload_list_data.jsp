<%@include file="../../../../includes/check_auth_layer3.jsp"%>
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
                <th width="100px">File Name</th>
                <th width="100px">URL Path</th>
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

                
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "select a.id,a.userid,a.doc_path_key,to_char(a.created_time,'YYYY-MM-DD HH24:MI:SS') created_time,b.username,b.first_name||' '||b.last_name fullname, sum(case when c.id is null then 0 else 1 end) sharedcount,path_url "
                              + " from t_usr_file_share_cognos a left join t_user b on a.userid=b.id left join t_usr_file_share_recipient c on a.id=c.fileid "
                              + " where a.userid="+v_userID+" and 1=1 ";
                              
                           
                        
                      if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(a.doc_path_key) like upper('%"+filter_itemname+"%') OR upper(b.username) like upper('%"+filter_itemname+"%') ) ";
                        }  
                      
                      sql+=" group by a.id,a.userid,a.doc_path_key,to_char(a.created_time,'YYYY-MM-DD HH24:MI:SS'),b.username,b.first_name||' '||b.last_name ";
                      
                        sql +=" order by a.created_time desc ";
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

                            
                             boolean vStatFile = false;
                             boolean vStatFileSwf = false;
                             String vFileSizeFlag = "";
                             double vFileSize =0;
                             String lastmodified = "";
                             
                             String fullpathfile = v_fileUploadDirCognos+"/"+resultSet.getString("doc_path_key");
                             
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
                                    <div class="others_lock_icon" title="file not Exist.. "></div>
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
                                        url: "report/file_share/upload_cognos/upload_list_recstat_process.jsp",
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
                             out.println("<td> <a href='"+resultSet.getString("path_url")+"' target='_blank' > "+ resultSet.getString("path_url")  + " </a>  </td>");
                             
                             
                              if (vStatFile) {
                             out.println("<td> " + Math.round(vFileSize) + " "+ vFileSizeFlag+" </td>");
                             out.println("<td> " + lastmodified + " </td>");
                             } else {
                             out.println("<td> N/A </td>");
                             out.println("<td> N/A </td>");
                             }
                             
                             out.println("<td> " + resultSet.getString("fullname") + " </td>");
                             out.println("<td> " + resultSet.getString("created_time") + " </td>");
                             out.println("<td> " + resultSet.getString("sharedcount") + " People(s) </td>");
                             
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
           
              $('#refresh_data').click(function() {
                  
                      filter_itemname= document.getElementById("filter_itemname").value;
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "report/file_share/upload_cognos/upload_list_data.jsp",
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
                        
                         popupwindow = window.open('report/file_share/upload_cognos/upload_list_upload.jsp?id=<%=v_userID%>&stat=0','Upload File','menubar=no,location=no,resizable=no,scrollbars=no,status=yes,width=800, height=300, left=0, top=0');
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


