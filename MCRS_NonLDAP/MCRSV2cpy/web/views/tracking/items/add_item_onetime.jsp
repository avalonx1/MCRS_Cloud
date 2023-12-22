<%@include file="../../../includes/check_auth_layer3.jsp"%>

<%

 String action = request.getParameter("action");
 String actionCode = "";
 String tableName="t_act_his";
 
 if (action==null) {
     actionCode="ADD";
 }else {
     actionCode="EDT";
 }

 //out.println(action);
 
 String header_title_act="";
 String id="";
 
String items_grouping = "";
String  items_name = "";
String  items2jobcat = "";
String  items2group = "";
String  items2type = "";
String  machine_name = "";
String  ip_address = "";
String  login_user = "";
String  login_pass = "";
String  source_path = "";
String  source_filename = "";
String  doc_status = "";
String  handover_date = "";
String  handover_pic = "";
String  launch_date = "";
String  sla_time = "";
String  status_items = "";
String  sys_creation_date = "";
String  termination_date = "";
String  act_show_time = "";
String  inorder = "";
String  report_day = "";
String  item2groupunit = "";


               
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
                                
                            sql = "SELECT id,items_grouping, items_name, items2jobcat, items2group, items2type, machine_name, ip_address, "
                                    + "login_user, login_pass, source_path, source_filename, doc_status, handover_date, handover_pic, launch_date, sla_time, "
                                    + "status_items, sys_creation_date, termination_date, act_show_time, inorder, report_day, item2groupunit"
                                 +" from "+tableName+" where id="+id;
                                   
         
                           //out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                
                                
                             items_grouping = resultSet.getString("items_grouping");
                            items_name = resultSet.getString("items_name");
                            items2jobcat = resultSet.getString("items2jobcat");
                            items2group = resultSet.getString("items2group");
                            items2type = resultSet.getString("items2type");
                            machine_name = resultSet.getString("machine_name");
                            ip_address = resultSet.getString("ip_address");
                            login_user = resultSet.getString("login_user");
                            login_pass = resultSet.getString("login_pass");
                            source_path = resultSet.getString("source_path");
                            source_filename = resultSet.getString("source_filename");
                            doc_status = resultSet.getString("doc_status");
                            handover_date = resultSet.getString("handover_date");
                            handover_pic = resultSet.getString("handover_pic");
                            launch_date = resultSet.getString("launch_date");
                            sla_time = resultSet.getString("sla_time");
                            status_items = resultSet.getString("status_items");
                            sys_creation_date = resultSet.getString("sys_creation_date");
                            termination_date = resultSet.getString("termination_date");
                            act_show_time = resultSet.getString("act_show_time");
                            inorder = resultSet.getString("inorder");
                            report_day = resultSet.getString("report_day");
                            item2groupunit = resultSet.getString("item2groupunit");


                                
                                
                               
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
    <td>Item Name </td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="items_name" name="items_name" size="30" maxlength="100" value="<% out.println((items_name == null) ? "" : items_name); %>"  /></td>
    </tr>
    
        
    <tr>
    <td>Item Grouping</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="items_grouping" name="items_grouping" size="30" maxlength="100" value="<% out.println((items_grouping == null) ? "" : items_grouping); %>"  /></td>
    </tr>
    
    <tr>
    <td width="100" align="left">Item Category </td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="items2jobcat" name="items2jobcat">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, '['||cat_code||'] - '||cat_name AS DESC "
                                                    + " FROM t_itemcat  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (items2jobcat.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td width="100" align="left">Item Group </td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="items2group" name="items2group">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, '['||group_code||'] - '||group_name AS DESC "
                                                    + " FROM t_itemgroup  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (items2group.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td width="100" align="left">Item Group Unit </td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="item2groupunit" name="item2groupunit">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                             sql = "SELECT ID,T_CODE||' - '||T_NAME FROM T_ITEMGROUPUNIT "
                                                + "WHERE ID in  (select ITEMGROUP2GROUPUNIT from T_ITEMGROUPUNIT_USER where ITEMGROUP2USER="+v_userID+" ) "
                                                + "ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (item2groupunit.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td width="100" align="left">Item Type </td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="items2type" name="items2type">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, '['||type_code||'] - '||type_name AS DESC "
                                                    + " FROM t_itemtype  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (items2type.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td>Server Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="machine_name" name="machine_name" size="30" maxlength="30" value="<% out.println((machine_name == null) ? "" : machine_name); %>"  /></td>
    </tr>
    
    <tr>
    <td>ip address</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="ip_address" name="ip_address" size="30" maxlength="30" value="<% out.println((ip_address == null) ? "" : ip_address); %>"  /></td>
    </tr>

        <tr>
    <td>login user</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="login_user" name="login_user" size="30" maxlength="30" value="<% out.println((login_user == null) ? "" : login_user); %>"  /></td>
    </tr>
    
        <tr>
    <td>login password</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="login_pass" name="login_pass" size="30" maxlength="30" value="<% out.println((login_pass == null) ? "" : login_pass); %>"  /></td>
    </tr>
    
        <tr>
    <td>source Dir path</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="source_path" name="source_path" size="30" maxlength="200" value="<% out.println((source_path == null) ? "" : source_path); %>"  /></td>
    </tr>
    
    <tr>
    <td>source filename</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="source_filename" name="source_filename" size="30" maxlength="100" value="<% out.println((source_filename == null) ? "" : source_filename); %>"  /></td>
    </tr>
    
    <tr>
    <td width="100" align="left">Document Handover</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="doc_status" name="doc_status">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT 'Yes' ID, 'Provided' AS DESC UNION ALL SELECT 'No' ID, 'Not Provided' AS DESC  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (doc_status.equalsIgnoreCase(resultSet.getString(1))) {
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
    <td>Handover Date</td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date"><input readonly=true type="text" id="handover_date" name="handover_date" class="datetimepicker"  size="30" maxlength="10" value="<% out.println((handover_date == null) ? "" : handover_date); %>"  /></div></td>
    </tr>
  
         <tr>
    <td>Handover pic</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" id="handover_pic" name="handover_pic" size="30" maxlength="30" value="<% out.println((handover_pic == null) ? "" : handover_pic); %>"  /></td>
    </tr>
    
     <tr>
    <td>Effective Date</td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date"><input readonly=true type="text" id="launch_date" name="launch_date" class="datetimepicker"  size="30" maxlength="10" value="<% out.println((launch_date == null) ? "" : launch_date); %>"  /></div></td>
    </tr>
    
    <tr>
    <td><div class="slatimerow">SLA Time (HH)</div><div class="sladayrow">SLA Day (DD)</div></td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date">
            <div class="slatimerow"><input readonly=true type="text" id="sla_time" name="sla_time" size="30" maxlength="10" value="<% out.println((sla_time == null) ? "" : sla_time); %>"  /></div>
            <div class="sladayrow"><input readonly=true type="text" id="sla_date" name="sla_time" size="30" maxlength="10" value="<% out.println((sla_time == null) ? "" : sla_time); %>"  /></div>
        </div></td>
    </tr>
    
    <tr>
    <td><div class="slatimerow">Show every Time (HH)</div><div class="sladayrow">Show every Day (DD)</div></td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date">
            <div class="slatimerow"><input readonly=true type="text" id="act_show_time" name="act_show_time" size="30" maxlength="10" value="<% out.println((act_show_time == null) ? "" : act_show_time); %>"  /></div>
            <div class="sladayrow"><input readonly=true type="text" id="act_show_date" name="act_show_date" size="30" maxlength="10" value="<% out.println((act_show_time == null) ? "" : act_show_time); %>"  /></div>
        </div></td>
    </tr>
    
    
    
    
  
  
  
</table></td></tr>
            <tr>
                <td>
                    <span class="small"><font color="red">*) Mandatory</span>
                </td>
            </tr>
            <tr><td align="left"> <p></p>
                    <button type="submit">Submit</button>
                    <button type="reset">Reset</button>
                </td>
            </tr>
        </table>


                                
    </div>
</form>

<script type="text/javascript">
 $(document).ready(function() {
    
       $('.datetimepicker').datetimepicker({
            dateFormat: 'yy-mm-dd',
            timeFormat: 'hh:mm',
            buttonImage: '../images/date.png',
            buttonImageOnly: true,
            showOn:'button',
            buttonText: 'Click to show the calendar'
       });
    
    
    $( "#sla_time" ).timepicker(
        {  
            duration: '',  
            timeOnlyTitle:'Choose Time(HH)',
            hourText:'Hour',
            showTime: true,  
            constrainInput: false,  
            showMinute:false,
            stepMinutes: 1,  
            stepHours: 1,  
            altTimeField: '',  
            time24h: true,   
            timeFormat: 'h'
        }).focus(function() { $(".ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current").remove();
        });
        
        $( "#sla_date" ).datepicker({
            changeMonth: false,
            changeYear: false,
            stepMonths: 0,
            dateFormat: 'dd'
        }).focus(function() {
            $(".ui-datepicker-prev, .ui-datepicker-next").remove();
        });
        
                
                
          
          
        $( "#act_show_time" ).timepicker(
        {  
            duration: '', 
            timeOnlyTitle:'Choose Time(HH)',
            hourText:'Hour',
            showTime: true,  
            constrainInput: false,  
            showMinute:false,
            stepMinutes: 1,  
            stepHours: 1,  
            altTimeField: '',  
            time24h: true,   
            timeFormat: 'h'
        }).focus(function() { $(".ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current").remove();
        });
                
        $( "#act_show_date" ).datepicker({
            changeMonth: false,
            changeYear: false,
            stepMonths: 0,
            dateFormat: 'dd'
        }).focus(function() {
            $(".ui-datepicker-prev, .ui-datepicker-next").remove();
        });
            
       
       if ( $('#items2jobcat').val()==1   )
            {  
                $('.sladayrow').hide(); 
                $('.slatimerow').show();  
            }else{
               $('.sladayrow').show(); 
                $('.slatimerow').hide();
            }
            
        
            
           
        $('#items2jobcat').change(function() {
            var str = $('#items2jobcat').val();
            
            if(str==1) {
              $('.sladayrow').hide(); 
                $('.slatimerow').show();  
            }else{
               $('.sladayrow').show(); 
                $('.slatimerow').hide();
            }
        
        });



               $('#back').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "tracking/items/items_list_data.jsp",
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
            url: "tracking/items/items_list_modify_process.jsp",
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

    });
</script>

