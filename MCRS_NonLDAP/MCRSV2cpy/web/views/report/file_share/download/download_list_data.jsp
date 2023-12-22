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
                <th width="100px">Shared From <br/> username</th>
                <th width="100px">Shared From <br/> Full Name</th>
                <th>Shared Time</th>
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

                        sql = "select a.id,a.userid,c.doc_path_key,to_char(a.created_time,'YYYY-MM-DD HH24:MI:SS') shared_time,b.username,b.first_name||' '||b.last_name fullname "
                              + " from t_usr_file_share_recipient a left join t_usr_file_share c on a.fileid=c.id left join t_user b on c.userid=b.id "
                              + " where a.userid="+v_userID+" and 1=1 ";
                              
                        
                         if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(doc_path_key) like upper('%"+filter_itemname+"%') OR upper(username) like upper('%"+filter_itemname+"%') ) ";
                        }  
                         
                        sql +=" order by a.created_time desc ";
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
                                    <div class="download_icon" title="download ID <%=resultSet.getString("ID")%>"></div>
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
                             out.println("<td> " + resultSet.getString("username") + " </td>");
                             out.println("<td> " + resultSet.getString("fullname") + " </td>");
                             out.println("<td> " + resultSet.getString("shared_time") + " </td>");
                             
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
                            url: "report/file_share/download/download_list_data.jsp",
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
             
             
            <% if (!id.equals("0") ) { %> 
             $('#content').animate({
             scrollTop: $("#rows_<%=id%>").offset().top
             }, 2000);
             <% } %>
             
             
           });
    </script>
</div>


