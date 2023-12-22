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
 
 String report_id="";
 String report_date_start="";
 String report_date_end="";
 String record_stat="";
 String created_userid = "";
 String created_time = "";
               
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
                                
//                            sql = "SELECT id,report_id,report_date_start,report_date_end, record_stat "
                            sql = "SELECT id, report_date_start, report_date_end, report_id, record_stat, created_userid, created_time"
                            +" FROM t_report_item_hide"
                            + " WHERE id = "+id;
//                                 +" from t_report_item_hide where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                report_id = resultSet.getString("report_id");
                                report_date_start = resultSet.getString("report_date_start");
                                report_date_end = resultSet.getString("report_date_end");
                                record_stat = resultSet.getString("record_stat");
                                
                                created_userid = resultSet.getString("created_userid");
                                created_time = resultSet.getString("created_time");
                                
                               
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
            <td width="100" align="left">Report Name</td>
            <td><div class="markMandatory">*</div></td>
            <td width="100" align="left"><select id="report_id" name="report_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, '['||report_code||'] - '||report_name AS DESC "
                                                    + " FROM t_report_item  "
                                                    + " where report_status=1 ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (report_id.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td>Start Date</td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date"><input readonly=true type="text" id="report_date_start" name="report_date_start" class="datetimepicker"  size="30" maxlength="10" value="<% out.println((report_date_start == null) ? "" : report_date_start); %>"  /></div></td>
    
    </tr>
    
    
    <tr>
    <td>End Date</td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date"><input readonly=true type="text" id="report_date_end" name="report_date_end" class="datetimepicker"  size="30" maxlength="10" value="<% out.println((report_date_end == null) ? "" : report_date_end); %>"  /></div></td>
    
    </tr>
    
        
    <tr>
            <td width="100" align="left">Status</td>
            <td><div class="markMandatory">*</div></td>
            <td width="100" align="left"><select id="record_stat" name="record_stat">
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
                                                if (record_stat.equalsIgnoreCase(resultSet.getString(1))) {
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
            <tr><td align="left"> <p></p>
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
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "administration/report_management/hide_report_exception/hide_report_exception_list_data.jsp",
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
             
             
    $('#modifyForm').submit(function () {
        $("#status_msg").empty();
        $('#loading').show();
        $.ajax({
            type: 'POST',
            url: "administration/report_management/hide_report_exception/hide_report_exception_list_modify_process.jsp",
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

