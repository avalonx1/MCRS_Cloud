<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String id = request.getParameter("id");
    
    String filter_itemname = request.getParameter("filter_itemname");
    String filter_reportfreq = request.getParameter("filter_reportfreq");
    
    if (filter_itemname == null) {
            filter_itemname = "";
        }
    
    if (filter_reportfreq==null) {
           filter_reportfreq="0";
    }
         
   
    if (id == null) {
            id = "0";
        }

    int i = 0;
%>
      
<div class="tablelist_wrap">
    <div id="refresh_data" class="add_optional">[refresh data] </div>
    <div id="addRecord" class="add_optional">[add records] </div>
    <div id="Paginginfo" class="recordinfotext">default record show 100 row(s) </div>
</div>

<div >
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th>Action</th>
                <th>Report<br/>Code</th>
                <th>Report Name</th>
                <th>Report<br/>Description</th>
                <th>Report<br/>Ext</th>
                <th>Report<br/>Group</th>
                <th>Report<br/>Freq</th>
                <th>Report<br/>Doc Folder Group</th>
                <th>Report <br/>File Post Key</th>
                <th>Report Owner<br/>NIK</th>
                <th>Report Owner<br/>Name</th>
                <th>Report Owner<br/>Contact</th>
                <th>Report Owner<br/>Dept</th>
                <th>Report Owner<br/>Div</th>
                <th>Report Publish</th>
                <th>Report <br/>Record Status</th>
                <th>Report Flag</th>
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

                        sql = "select id,report_code, report_name, report_description, report_extension,report_freq_id,report_freq_name,document_pathkey,report_owner_nik, " 
                            +"report_owner_name,report_owner_contact,report_owner_dept_id,report_owner_division_id,report_launch,report_status, "
                            +"report_flag,dept_code,dept_name,div_code,div_name,report_group_id,report_group_code,report_group_name,doc_path_key as doc_folder_group "
                            +" from v_report_item where 1=1 ";
                          
                        if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(report_name) like upper('%"+filter_itemname+"%') OR upper(report_code) like upper('%"+filter_itemname+"%') "
                                + " OR upper(report_description) like upper('%"+filter_itemname+"%') "
                                + " OR upper(report_extension) like upper('%"+filter_itemname+"%') "
                                + " OR upper(report_owner_name) like upper('%"+filter_itemname+"%') "
                                + " OR upper(report_owner_nik) like upper('%"+filter_itemname+"%') "
                                + " OR upper(dept_name) like upper('%"+filter_itemname+"%') "
                                + " OR upper(div_name) like upper('%"+filter_itemname+"%') "
                                + " OR upper(dept_code) like upper('%"+filter_itemname+"%') "
                                + " OR upper(div_code) like upper('%"+filter_itemname+"%') "
                                + " OR upper(document_pathkey) like upper('%"+filter_itemname+"%') ) ";
                        }  
                        
                       if (filter_reportfreq.equals("0")) {
                        sql += " ";
                        }
                        else {
                        sql += " and report_freq_id = "+filter_reportfreq+" ";
                        } 
                       
                        
                        
                        
                         sql += " order by report_code,report_name,report_extension ";
                         
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
                                <div class="action_menu" id="edit_<%=resultSet.getString("ID")%>" >
                                    <div class="edit_icon" title="edit this items ID <%=resultSet.getString("ID")%>"></div>
                                </div>
                                
                               <% 
                                 
                                 String recStat= resultSet.getString("report_status");
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
                                
                                
                                <div class="action_menu" id="UPLOAD_<%=resultSet.getString("ID")%>" > 
                                       <div class="upload_icon" title="Upload File"></div>
                                   </div> 
                                
                                <div class="action_menu" id="DOWNLOAD_<%=resultSet.getString("ID")%>" > 
                                       <div class="download_icon" title="Download File"></div>
                                </div> 
                                
                                <script type="text/javascript">
                                    
                                         <%if (id!=null) {%>
                                         $("#rows_<%=id%>").attr("class", "mark");
                                         <%}%>
                                 
                                    $('#edit_<%=resultSet.getString("id")%>').click(function() {
                                    
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/report_management/report_item/report_item_list_modify.jsp",
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
                                        url: "administration/report_management/report_item/report_item_list_recstat_process.jsp",
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
                                    
                                     $('#UPLOAD_<%=resultSet.getString("ID")%>').click(function() {
                                            
                                            popupwindow = window.open('administration/report_management/report_item/report_item_list_upload.jsp?id=<%=resultSet.getString("ID")%>&stat=0','Upload File','menubar=no,location=no,resizable=no,scrollbars=no,status=yes,width=600, height=300, left=0, top=0');
                                            popupWindow.focus();
                                            return false;
                                        });
                                        
                                    $('#DOWNLOAD_<%=resultSet.getString("ID")%>').click(function() {
                                        
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/report_management/report_item/report_item_list_download_file.jsp",
                                        data: {id:<%=resultSet.getString("ID")%>,backurl:'administration/report_management/report_item/report_item_list_data.jsp'},
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
                        
                             out.println("<td> " + resultSet.getString("report_code") + " </td>");
                             out.println("<td> " + resultSet.getString("report_name") + " </td>");
                             out.println("<td> " + resultSet.getString("report_description") + " </td>");
                             out.println("<td> " + resultSet.getString("report_extension") + " </td>");
                             out.println("<td> " + resultSet.getString("report_group_name") + " </td>");
                             out.println("<td> " + resultSet.getString("report_freq_name") + " </td>");
                             out.println("<td> " + resultSet.getString("doc_folder_group") + " </td>");
                             out.println("<td> " + resultSet.getString("document_pathkey") + " </td>");
                             out.println("<td> " + resultSet.getString("report_owner_nik") + " </td>");
                             out.println("<td> " + resultSet.getString("report_owner_name") + " </td>");
                             out.println("<td> " + resultSet.getString("report_owner_contact") + " </td>");
                             out.println("<td> " + resultSet.getString("dept_name")+" ("+resultSet.getString("dept_code") +") "+" </td>");
                             out.println("<td> " + resultSet.getString("div_name")+" ("+resultSet.getString("div_code") +") "+ " </td>");
                             out.println("<td> " + resultSet.getString("report_launch") + " </td>");
                             out.println("<td> " + resultSet.getString("report_status") + " </td>");
                             out.println("<td> " + resultSet.getString("report_flag") + " </td>");
                            
                             
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
                            url: "administration/report_management/report_item/report_item_list_data.jsp",
                            data: {filter_itemname:filter_itemname},
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
                            url: "administration/report_management/report_item/report_item_list_modify.jsp",
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


