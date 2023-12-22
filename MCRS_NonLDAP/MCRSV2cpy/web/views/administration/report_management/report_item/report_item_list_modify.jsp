<%@include file="../../../../includes/check_auth_layer3.jsp"%>

<%

 String action = request.getParameter("action");
 String actionCode = "";
 
 if (action==null) {
     actionCode="ADD";
 }else {
     actionCode="EDT";
 }

 //out.println(action);
 
 String header_title_act="";
 String id="0";
 
 String report_code="";
 String report_name="";
 String report_description="";
 String report_extension="";
 String document_pathkey="";
 String report_owner_nik="";
 String report_owner_name="";
 String report_owner_contact="";
 String report_owner_dept_id="";
 String doc_pathkey_id="";
 String report_launch="";
 String report_status="";
 String report_flag="";
 String report_freq_id="";
 String report_group_id="";
 String uat_date="";
 
 
 
 
               
 if (actionCode.equals("ADD") ) {
     header_title_act="Add";
 } else {
     header_title_act="Edit";
     id  = request.getParameter("id");
     
     

 
     String denom="999,999,999,999,999.99";
     
                      try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;
                                
                             sql = "select id,report_code, report_name, report_description, report_extension,document_pathkey,report_owner_nik, " 
                                +"report_owner_name,report_owner_contact,report_owner_dept_id,doc_pathkey_id,report_launch,report_status, "
                                +"report_flag,report_freq_id,report_group_id,uat_date "
                                +" from t_report_item where id="+id;

         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                report_code = resultSet.getString("report_code");
                                report_name = resultSet.getString("report_name");
                                report_description = resultSet.getString("report_description");
                                report_extension = resultSet.getString("report_extension");
                                document_pathkey = resultSet.getString("document_pathkey");
                                report_owner_nik = resultSet.getString("report_owner_nik");
                                report_owner_name = resultSet.getString("report_owner_name");
                                report_owner_contact = resultSet.getString("report_owner_contact");
                                report_owner_dept_id = resultSet.getString("report_owner_dept_id");
                                doc_pathkey_id = resultSet.getString("doc_pathkey_id");
                                report_launch = resultSet.getString("report_launch");
                                report_status = resultSet.getString("report_status");
                                report_flag = resultSet.getString("report_flag");
                                report_freq_id = resultSet.getString("report_freq_id");
                                report_group_id = resultSet.getString("report_group_id");
                                uat_date = resultSet.getString("uat_date");
                               
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
     
     
 }
 
%>
<div class="tablelist_wrap">
    <div id="back" class="add_optional">[back] </div>
    
</div>

<form id="modifyForm" method="post" action="#">
    <input type="hidden" id="id" name="id" value="<%=id%>" />
    <input type="hidden" id="actionCode" name="actionCode" value="<%=actionCode%>" />
    <div id="stylized" class="myform">
        <h1><%=header_title_act%> Record </h1>
        <p></p>
     <table class="formtable" border="0"><tr><td>
   <table class="formtable" border="0">
   
    <tr>
    <td>Report Code</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="report_code" name="report_code" size="20" maxlength="30" value="<% out.println((report_code == null) ? "" : report_code); %>"  /></td>
    </tr>
    
        
    <tr>
    <td>Report Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="report_name" name="report_name" size="50" maxlength="100" value="<% out.println((report_name == null) ? "" : report_name); %>"  /></td>
    
    </tr>
    
    
    <tr>
    <td>Report Desc</td>
    <td></td>
    <td><textarea class="notes_info" id="report_description" name="report_description"  rows="10" cols="50" maxlength="4000"><% out.println((report_description == null) ? "" : report_description); %></textarea>
    
    </tr>
    
    <tr>
    <td>Report Ext</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="report_extension" name="report_extension" size="20" maxlength="10" value="<% out.println((report_extension == null) ? "" : report_extension); %>"  /></td>
    
    </tr>
    
    <td width="100" align="left">Report Group</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="report_group_id" name="report_group_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, group_code||' - '||group_name AS DESC "
                                                    + " FROM t_report_group "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (report_group_id.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
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
                    %>
    </select></td>
  </tr>
  
     <tr>
    <td width="100" align="left">Report Frequency</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="report_freq_id" name="report_freq_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, freq_code||' - '||freq_name AS DESC "
                                                    + " FROM t_report_freq  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (report_freq_id.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
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
                    %>
    </select></td>
  </tr>
  
  <tr>
    <td width="100" align="left">Report Folder Group </td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="doc_pathkey_id" name="doc_pathkey_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, doc_path_key AS DESC "
                                                    + " FROM t_report_pathkey  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (doc_pathkey_id.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
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
                    %>
    </select></td>
  </tr>
    
    <tr>
    <td>Report File Post Key</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="document_pathkey" name="document_pathkey" size="30" maxlength="150" value="<% out.println((document_pathkey == null) ? "" : document_pathkey); %>"  /></td>
    
    </tr>
    
    
    <tr>
    <td>Report Owner - NIK</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="report_owner_nik" name="report_owner_nik" size="30" maxlength="15" value="<% out.println((report_owner_nik == null) ? "" : report_owner_nik); %>"  /></td>

    </tr>
    
        
    <tr>
    <td>Report Owner - Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="report_owner_name" name="report_owner_name" size="30" maxlength="50" value="<% out.println((report_owner_name == null) ? "" : report_owner_name); %>"  /></td>
    </tr>
    
    
        
    <tr>
    <td>Report Owner - Contact Number/Ext</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="report_owner_contact" name="report_owner_contact" size="30" maxlength="50" value="<% out.println((report_owner_contact == null) ? "" : report_owner_contact); %>"  /></td>
    </tr>
    
        
        
    <tr>
    <td width="100" align="left">Report Owner Dept</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="report_owner_dept_id" name="report_owner_dept_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT a.id ID, b.div_code||' - '||b.div_name||' -> '||a.dept_code||' - '||a.dept_name AS DESC "
                                                    + " FROM t_department a left join t_division b on a.div_id=b.id  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (report_owner_dept_id.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
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
                    %>
    </select></td>
  </tr>
  
   
  
   <tr>
    <td>UAT Date</td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date"><input readonly=true type="text" id="uat_date" name="uat_date" class="datetimepicker"  size="30" maxlength="10" value="<% out.println((uat_date == null) ? "" : uat_date); %>"  /></div></td>
    </tr>
    
    <tr>
    <td>Publish Date</td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date"><input readonly=true type="text" id="report_launch" name="report_launch" class="datetimepicker"  size="30" maxlength="10" value="<% out.println((report_launch == null) ? "" : report_launch); %>"  /></div></td>
    </tr>
  
    
    
        
    <tr>
            <td width="100" align="left">Record Status</td>
            <td><div class="markMandatory">*</div></td>
            <td width="100" align="left"><select id="report_status" name="report_status">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT 1 ID,'Activate' AS DESC UNION ALL SELECT 0 ID,'Deactivate' AS DESC ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (report_status.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
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
                    %>
    </select></td>
  </tr>
    
      
    <tr>
            <td width="100" align="left">Flag</td>
            <td><div class="markMandatory">*</div></td>
            <td width="100" align="left"><select id="report_flag" name="report_flag">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT 1 ID,'Publish' AS DESC UNION ALL SELECT 0 ID,'Unpublish' AS DESC ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (report_flag.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
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
                    %>
    </select></td>
  
  </tr>
    
 
</table></td>  
            </tr>
            <tr>
                <td>
                    <span class="small"><font color="red">*) Mandatory</span>
                </td>
            </tr>
            <tr><td align="left">
                    <p></p>
                    <button type="submit">Submit</button>
                    <button type="reset">Reset</button>
                    
                </td>
            </tr>
        </table>


                                
    </div>
</form>

<script type="text/javascript">

    
    $('.datetimepicker').datetimepicker({
            dateFormat: 'yy-mm-dd',
            timeFormat: 'hh:mm',
            buttonImage: '../images/date.png',
            buttonImageOnly: true,
            showOn:'button',
            buttonText: 'Click to show the calendar'
    });

    
    
    
    
    $( "#report_date_start" ).change(function(){ 
    
                var dateRequested_yyyy = $("#report_date_start").val().substr(0,4);
                var dateRequested_mm = $("#report_date_start").val().substr(5, 2);
                var dateRequested_dd = $("#report_date_start").val().substr(8, 2);
                var dateRequested_hh = $("#report_date_start").val().substr(11, 2);
                var dateRequested_min = $("#report_date_start").val().substr(14, 2);
                var dateFull=new Date(dateRequested_yyyy,dateRequested_mm-1,dateRequested_dd);
                
                $("#report_date_end").datetimepicker('option', 'minDate', dateFull);
                
                
                 });
    


    
               $('#back').click(function() {
                   
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
             
             
    $('#modifyForm').submit(function () {
        $("#status_msg").empty();
        $('#loading').show();
        $.ajax({
            type: 'POST',
            url: "administration/report_management/report_item/report_item_list_modify_process.jsp",
            data: $(this).serialize(),
            success: function (data) {

                $("#status_msg").empty();
                $("#status_msg").html(data);
                $("#status_msg").show();
            },
            complete: function () {
                $('#loading').hide();
            }
        });
        return false;
    });


</script>

