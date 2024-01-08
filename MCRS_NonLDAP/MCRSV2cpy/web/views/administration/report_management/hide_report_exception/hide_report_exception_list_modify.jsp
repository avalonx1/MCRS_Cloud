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
 
 String id_ex="";
 String report_date_start="";
 String report_date_end="";
 String record_stat="";
 String created_userid = "";
 String created_time = "";
 
 String fullname="";
 String notes="";
 String username="";
               
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
//                            sql = "SELECT id, report_date_start, report_date_end, report_id, record_stat, created_userid, created_time"
//                            +" FROM t_report_item_hide"
//                            + " WHERE id = "+id;
//                                 +" from t_report_item_hide where id="+id;


                            sql = "SELECT a.id, b.id AS user_id, b.username,(b.first_name::text || ' ') || b.last_name::text AS fullname,"
                            +" a.notes, a.created_time "
                            +"FROM t_report_item_hide_exception a "
                            +"LEFT JOIN t_user b ON a.created_userid = b.id ORDER BY b.username";


                                   
         
                            out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                                id_ex = resultSet.getString("user_id");
//                                report_date_start = resultSet.getString("report_date_start");
                                report_date_end = resultSet.getString("report_date_end");
                                record_stat = resultSet.getString("record_stat");
                                
//                                created_userid = resultSet.getString("created_userid");
                                created_time = resultSet.getString("created_time");
                                username = resultSet.getString("username");
                                fullname = resultSet.getString("fullname");
                                notes = resultSet.getString("notes");
                                
                               
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
            <td width="100" align="left">User Name</td>
            <td><div class="markMandatory">*</div></td>
            <td width="100" align="left"><select id="id_ex" name="id_ex">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id, (username::text || ' - ') || (first_name::text || ' ') || Last_name::text "
                                                  + " FROM t_user  "
                                                  + " ORDER BY 1 ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (id_ex.equalsIgnoreCase(resultSet.getString(1))) {
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
            <td width="100" align="left">Notes</td>
            <td><div class="markMandatory">*</div></td>
            <td width="100" align="left"><select id="notes" name="notes">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "select id, (level_code::text || ' - ') || level_name::text as level_code " 
                                            +" from t_user_level order by 1";
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (id_ex.equalsIgnoreCase(resultSet.getString(1))) {
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

