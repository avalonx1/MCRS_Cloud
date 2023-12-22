<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%


    String objid = request.getParameter("objid");
    String filter_itemname = request.getParameter("filter_itemname");
    String filter_tanggal = request.getParameter("filter_tanggal");
    String filter_group_child_id = request.getParameter("filter_group_child_id");
    String report_extension = request.getParameter("report_extension");  
    String report_group_id = request.getParameter("report_group_id"); 
    String report_fileexist = request.getParameter("report_fileexist");  
    
    
    String sorting_column = request.getParameter("sorting_column");
    String sorting_type = request.getParameter("sorting_type"); 
    
    
    
    String filter_group_child_pathkey = "";
    if (objid == null) {
            objid = "0";
        }

    if (filter_itemname == null) {
            filter_itemname = "";
        }
    
     if (report_extension == null) {
            report_extension = "0";
        }
     
      if (report_group_id == null) {
            report_group_id = "0";
        }
      
      if (report_fileexist == null) {
            report_fileexist = "-1";
        }
      
      
      
    if (filter_tanggal == null) {
        
            filter_tanggal = v_currWorkDay;

    }
    
    
    
    
if (filter_group_child_id==null) {
            try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id "
                                                    + " FROM t_user_group where id="+v_userGroup+" "
                                                    + "  ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                               filter_group_child_id=resultSet.getString("id"); 
                                                
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
            
          //cek default group
    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id,document_pathkey "
                                                    + " FROM t_user_group where id="+filter_group_child_id+" "
                                                    + "  ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                               filter_group_child_id=resultSet.getString("id"); 
                                               filter_group_child_pathkey=resultSet.getString("document_pathkey"); 
                                               
                                                
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
    
    
    
          //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql> Group Acess : " + filter_group_child_id + "</div>");
                        }
                        
       if (sorting_column==null) {
           sorting_column="0";
         }
       
       if (sorting_type == null) {
            sorting_type = "ASC";
        }
            
       
    int i = 0;
%>
      
<div class="tablelist_wrap">
    <div id="refresh_data" class="add_optional">[refresh data] </div>
</div>


    <%
    
    
    if (!v_currETLStatus.equals("DONE")) {
        String msginfo = "";
        
        msginfo = "<div class=alert>Please be informed that Datawarehouse - ETL (Extract-Transform-Loading) Job for Report Generation Date <b>"+v_currWorkDay+"</b> is "+v_currETLStatus+". Please contact IT-Helpdesk for further information </div>";
        
        out.println(msginfo);
    }
    
    %>


<div >
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th width="40">Action</th>
                <th>Report<br/>Date</th>
                <th>Report<br/>Code</th>
                <th>Report Name</th>
                <th>Report<br/>Ext</th>
                <th>Report<br/>Group</th>
                <th>Report<br/>Status</th>
                <th>File Name</th>
                <th>File Size</th>
                <th>File Last<br/>Modified</th>
                <th>Report<br/>Owner</th>
                <th>Report Owner<br/>Dept</th>
                <th>Report Owner<br/>Div</th>
                <th>Popularity</th>

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

                    sql = "select * from ( select '"+filter_tanggal+"' report_date,a.report_id,user_group_id,user_level_id, report_code,report_name,report_extension,report_description, report_owner_name, "
                          +" report_owner_dept_name,report_owner_div_name, "
                          +" '"+v_dokDirPath+"'||'/'||doc_folder_group||'/'||'"+filter_tanggal+"'||'/'||'"+filter_group_child_pathkey+"'||'/'||report_head_file||'_'||'"+filter_tanggal+"'||'_'||'"+filter_group_child_pathkey+"'||'_'||report_tail_file report_full_path, "
                          +" report_head_file||'_'||'"+filter_tanggal+"'||'_'||'"+filter_group_child_pathkey+"'||'_'||report_tail_file report_filename,"
                          +" report_flag,report_flag_name,report_freq_code,report_launch,report_group_id,report_group_name,report_download,report_view,report_popularity "
                          +" from v_report_item_list a"
                          +" where user_group_id="+v_userGroup+" and user_level_id="+v_userLevel+" and user_group_child_id="+filter_group_child_id+" "
                          +" and NOT EXISTS ( select * from t_report_item_hide b "
                          +" where b.record_stat=1 and b.report_id=a.report_id and '"+filter_tanggal+"'>=to_char(b.report_date_start,'YYYYMMDD') and '"+filter_tanggal+"'<=to_char(b.report_date_end,'YYYYMMDD') ) "
                          +" UNION ALL "
                          +" select '"+filter_tanggal+"' report_date,a.report_id,user_group_id,user_level_id, report_code,report_name,report_extension,report_description, report_owner_name, "
                          +" report_owner_dept_name,report_owner_div_name, "
                          +" '"+v_dokDirPath+"'||'/'||doc_folder_group||'/'||'"+filter_tanggal+"'||'/'||'"+filter_group_child_pathkey+"'||'/'||report_head_file||'_'||'"+filter_tanggal+"'||'_'||'"+filter_group_child_pathkey+"'||'_'||report_tail_file report_full_path, "
                          +" report_head_file||'_'||'"+filter_tanggal+"'||'_'||'"+filter_group_child_pathkey+"'||'_'||report_tail_file report_filename,"
                          +" 0 report_flag,'Unpublished' report_flag_name,report_freq_code,report_launch,report_group_id,report_group_name,report_download,report_view,report_popularity  "
                          +" from v_report_item_list a"
                          +" where user_group_id="+v_userGroup+" and user_level_id="+v_userLevel+" and user_group_child_id="+filter_group_child_id+" "
                          +" and EXISTS ( select * from t_report_item_hide b "
                          +" where b.record_stat=1 and b.report_id=a.report_id and '"+filter_tanggal+"'>=to_char(b.report_date_start,'YYYYMMDD') and '"+filter_tanggal+"'<=to_char(b.report_date_end,'YYYYMMDD') ) ) a "
                          +", (select * from dim_time where  time_sid  = '"+filter_tanggal+"' ) b "
                          +"where 1=1 "
                          +"and ((report_freq_code ='WORKDAY'  AND b.HOLIDAY_FL = 'N' ) OR   report_freq_code ='DAILY'  ) "
                          +"and report_launch<=current_timestamp ";
                          


                               
                        if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(a.report_name) like upper('%"+filter_itemname+"%') OR upper(a.report_code) like upper('%"+filter_itemname+"%') ) ";
                        }     
                        
                         if (report_extension.equals("0")) {
                            sql += " ";
                        } else {
                        sql += " and report_extension = '"+report_extension+"' ";
                        }
                         
                        if (report_group_id.equals("0")) {
                            sql += " ";
                        } else {
                        sql += " and report_group_id = "+report_group_id+" ";
                        }
                        
                        
                         if (sorting_column.equals("0")) {
                           sql += " order by report_code "+sorting_type+",report_name "+sorting_type;
                        } else {
                        sql += " order by "+sorting_column+"  "+sorting_type;
                        }
                         
                        //add
                        sql += " OFFSET 0 LIMIT "+v_listrowlimit;
                        
                        //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        
                        }

                            
                        resultSet = db.executeQuery(sql);
                        String rowstate = "even";
                        
                        while (resultSet.next()) {
                           
                             boolean vStatFile = false;
                             boolean vStatFileSwf = false;
                             String vFileSizeFlag = "";
                             double vFileSize =0;
                             String lastmodified = "";
                        
                             
                        String vfilename = resultSet.getString("report_filename")+"."+resultSet.getString("report_extension");
                        String vfilenamefull = resultSet.getString("report_full_path")+"."+resultSet.getString("report_extension");
                        //add
                        Integer vreportFlag = resultSet.getInt("report_flag");
                        
                        
                        File checkfile = new File(vfilenamefull);
                            
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
                        
                            
                        String pathSwfFile=v_swfdir+"/"+filter_tanggal+"/"+filter_group_child_pathkey+"/"+vfilename+"."+v_swffileExt;
                        
                        
                        
                        checkfile = new File(pathSwfFile);
                           
                        if(checkfile.exists()){
                        vStatFileSwf=true;
                        
                        //debug mode            
                        //if (v_debugMode.equals("1")) {
                        //out.println("<div class=sql>"+pathSwfFile+"</div>");
                        //}
                        
                        
                        }
                            
                            String status_warna = "brown_text";
                            
                            if (!vStatFile) {
                                status_warna = "orange";
                            }
                            else if (resultSet.getString("report_flag").equals("1")) {
                                status_warna = "green";
                            } else {
                                status_warna = "brown";
                            }
                            
                            String rpticon = "rpticon_txt";
                            
                            if (resultSet.getString("report_extension").equalsIgnoreCase("pdf")) {
                                rpticon = "rpticon_pdf";
                            } else if (resultSet.getString("report_extension").equalsIgnoreCase("csv")) {
                                rpticon = "rpticon_csv";
                            } else if (resultSet.getString("report_extension").equalsIgnoreCase("xls")) {
                                rpticon = "rpticon_xls";
                            } else if (resultSet.getString("report_extension").equalsIgnoreCase("mht")) {
                                rpticon = "rpticon_xml";
                            } else {
                                rpticon = "rpticon_txt";
                            }
                            
                           //mulai baris
                            if ( report_fileexist.equals("-1") || (report_fileexist.equals("1") && vStatFile) ||   (report_fileexist.equals("0") && !vStatFile) ) { 
                                    

                            out.println("<tr id=rows_"+resultSet.getString(1)+" class=" + rowstate + "> ");
                                
                            i++;

                            if (i % 2 == 0) {
                                rowstate = "even";
                            } else {
                                rowstate = "odd";
                            }
                            
                            
                      %>
                      
                      <td>
                        
                          <div class="action_menu_wrap">
                              
                               <div class="action_menu" id="DESC_<%=resultSet.getString("report_id")%>" > 
                                    <div class="description_icon" title="Report Description"></div>
                               </div> 
                                       
                              <%  
                                if (!vStatFile) {
                                  %>
                                <div class="action_menu_no_click"  >         
                                    <div class="others_lock_icon" title="file not Exist"></div>
                                </div>
                               <%   
                                }
                                else if (resultSet.getString("report_flag").equals("1")) {
                                    
                                    
                               
                               %>
                               
                               
                                <div class="action_menu" id="download_<%=resultSet.getString("report_id")%>" >         
                                    <div class="download_icon" title="download"></div>
                                </div>
                                    
                                    <% if (resultSet.getString("report_extension").toLowerCase().equals("pdf") && vStatFileSwf ) { %>
                                <div class="action_menu" id="docview_<%=resultSet.getString("report_id")%>" >         
                                    <div class="detail_icon" title="view"></div>
                                </div>    
                               <%
                                    }
                            } else {
                               %>
                                <div class="action_menu_no_click" >         
                                    <div class="time_icon" title="Report Unpublished"></div>
                                </div>                               
                               <%  
                                
                            }
                              %>
                                
                                    
                               
                                    
                          </div>
                                
                              
                                <script type="text/javascript">
                                    
                                         <%if (objid!=null) {%>
                                         $("#rows_<%=objid%>").attr("class", "mark");
                                         <%}%>
                                 
                                    $('#download_<%=resultSet.getString("report_id")%>').click(function() {
                                    //Add
                                    window.location="<%=getPath%>/DownloadServlet?userid=<%=v_userID%>&objid=<%=resultSet.getString("report_id")%>&tglrpt=<%=filter_tanggal%>&filename=<%=vfilename%>&filenamefull=<%=vfilenamefull%>&downloadflag=1";
                                    return false;
                                    
                                    });
 
                                    $('#docview_<%=resultSet.getString("report_id")%>').click(function() {
                                        
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "file_management/docviewer.jsp",
                                        data: {objid:<%=resultSet.getString("report_id")%>,
                                            filename:'<%=vfilename%>',
                                            tglrpt:'<%=filter_tanggal%>',
                                            filter_group_child_pathkey:'<%=filter_group_child_pathkey%>',
                                            filenamefull:'<%=resultSet.getString("report_full_path")%>'},
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
                                    
                                    $('#DESC_<%=resultSet.getString("report_id")%>').click(function() {
                                        
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "administration/report_management/report_item/report_item_list_download_file.jsp",
                                        data: {id:<%=resultSet.getString("report_id")%>,backurl:'report/daily/daily_report_list_data.jsp'},
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
                             
                             out.println("<td> " + resultSet.getString("report_date") + " </td>");
                             out.println("<td> " + resultSet.getString("report_code") + " </td>");
                             out.println("<td title='"+resultSet.getString("report_description")+"' > " + resultSet.getString("report_name") + " </td>");
                             out.println("<td><div class="+rpticon+"> " + resultSet.getString("report_extension") + "</div> </td>");
                             out.println("<td> " + resultSet.getString("report_group_name") + " </td>");
                             
                             if (vStatFile) {
                             out.println("<td axis="+status_warna+" > " + resultSet.getString("report_flag_name") + " </td>");
                             out.println("<td> " + vfilename + " </td>");
                             out.println("<td> " + Math.round(vFileSize) + " "+ vFileSizeFlag+" </td>");
                             out.println("<td> " + lastmodified + " </td>");
                              
                             } else {
                             out.println("<td axis="+status_warna+" > File Not Exist </td>");
                             out.println("<td title='"+vfilename+"' > N/A </td>");
                             out.println("<td> N/A </td>");
                             out.println("<td> N/A </td>");
                             
                             }
                             
                             
                             
                             out.println("<td> " + resultSet.getString("report_owner_name") + " </td>");
                             out.println("<td> " + resultSet.getString("report_owner_dept_name") + " </td>");
                             out.println("<td> " + resultSet.getString("report_owner_div_name") + " </td>");
                             out.println("<td> " + resultSet.getString("report_popularity") + " </td>");
                             
                            out.println("</tr> ");
                            
                            }
                            
                            
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
                     filter_tanggal= document.getElementById("filter_tanggal").value;
                     filter_group_child_id= document.getElementById("filter_group_child_id").value;
                     report_group_id=document.getElementById("report_group_id").value;
                     report_extension=document.getElementById("report_extension").value;     
                     report_fileexist=document.getElementById("report_fileexist").value;    
                     sorting_column=document.getElementById("sorting_column").value;  
                     sorting_type =document.getElementById("sorting_type").value; 
                   
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "report/daily/daily_report_list_data.jsp",
                            data: {filter_itemname:filter_itemname,
                                 filter_tanggal:filter_tanggal,
                                 filter_group_child_id:filter_group_child_id,
                                 report_group_id:report_group_id,
                                 report_extension:report_extension,
                                 report_fileexist:report_fileexist,
                                 sorting_column:sorting_column,
                                 sorting_type:sorting_type},
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
             
             
             
            <% if (!objid.equals("0") ) { %> 
             $('#content').animate({
             scrollTop: $("#rows_<%=objid%>").offset().top
             }, 2000);
             <% } %>
           });
    </script>
</div>


