<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
String id  = request.getParameter("id");

 
String header_title_act="";

 
String  act_date = "";
String  act2items = "";
String  send_time = "";
String  last_update_time = "";
String  act2actstatus = "";
String  act2user = "";
String  act_sla_target = "";
String  act_sla_notif = "";
String  act_note = "";
String  act2issue = "";
String  act_notif = "";
String  act_weight = "";
String  act_date_time = "";
String  report_date = "";
String  act_items_name = "";
String  addl_info = "";
String  ref_table = "";
String  inorder = "";
String  pickup_stat = "";
String  dismissed_sla = "";
String  create_time = "";
String  work_starttime = "";
String  request_datetime = "";
String  ticket_number = "";
String  act2priority = "";
String  act2importance = "";
String  act_auth = "";
String  act_auth_time = "";
String  req_name = "";
String  req_email = "";
String  division_id = "";
String  pic_ba = "";
String  pic_etl_dev = "";
String  pic_rpt_dev = "";
String  pic_main="";

     
              try {
                        ResultSet resultSet = null;
                        Database db = new Database();
                        try {
                            db.connect(1);
                            String sql;
                                
                              sql = " select id, act_date, act2items, send_time, last_update_time, act2actstatus, act2user, "
                                      + "to_char(act_sla_target,'YYYY-MM-DD HH24:MI:SS') act_sla_target, act_sla_notif, act_note, act2issue, act_notif, act_weight, act_date_time, "
                                      + "report_date, act_items_name, addl_info, ref_table, inorder, pickup_stat, dismissed_sla, create_time, "
                                      + "to_char(work_starttime,'YYYY-MM-DD HH24:MI:SS') work_starttime, to_char(request_datetime,'YYYY-MM-DD HH24:MI:SS') request_datetime, "
                                      + "ticket_number, act2priority, act2importance, act_auth, act_auth_time, "
                                      + "req_name, req_email, division_id, pic_main,pic_ba, pic_etl_dev, pic_rpt_dev "
                                      + "from t_act_his"
                                + "  where id="+id;
                                   
         
                           // out.println(sql);
                                
                            resultSet = db.executeQuery(sql);
                            String rowstate = "even";
                                
                            while (resultSet.next()) {
                                                                
                                act_date = resultSet.getString("act_date");
                                act2items = resultSet.getString("act2items");
                                send_time = resultSet.getString("send_time");
                                last_update_time = resultSet.getString("last_update_time");
                                act2actstatus = resultSet.getString("act2actstatus");
                                act2user = resultSet.getString("act2user");
                                act_sla_target = resultSet.getString("act_sla_target");
                                act_sla_notif = resultSet.getString("act_sla_notif");
                                act_note = resultSet.getString("act_note");
                                act2issue = resultSet.getString("act2issue");
                                act_notif = resultSet.getString("act_notif");
                                act_weight = resultSet.getString("act_weight");
                                act_date_time = resultSet.getString("act_date_time");
                                report_date = resultSet.getString("report_date");
                                act_items_name = resultSet.getString("act_items_name");
                                addl_info = resultSet.getString("addl_info");
                                ref_table = resultSet.getString("ref_table");
                                inorder = resultSet.getString("inorder");
                                pickup_stat = resultSet.getString("pickup_stat");
                                dismissed_sla = resultSet.getString("dismissed_sla");
                                create_time = resultSet.getString("create_time");
                                work_starttime = resultSet.getString("work_starttime");
                                request_datetime = resultSet.getString("request_datetime");
                                ticket_number = resultSet.getString("ticket_number");
                                act2priority = resultSet.getString("act2priority");
                                act2importance = resultSet.getString("act2importance");
                                act_auth = resultSet.getString("act_auth");
                                act_auth_time = resultSet.getString("act_auth_time");
                                req_name = resultSet.getString("req_name");
                                req_email = resultSet.getString("req_email");
                                division_id = resultSet.getString("division_id");
                                pic_ba = resultSet.getString("pic_ba");
                                pic_etl_dev = resultSet.getString("pic_etl_dev");
                                pic_rpt_dev = resultSet.getString("pic_rpt_dev");
                                pic_main = resultSet.getString("pic_main");

                               
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
<div class="tablelist_wrap">
    <div id="back" class="add_optional">[back] </div>
    
</div>

<form id="modifyForm" method="post" action="#" >
   
   
    <div id="stylized" class="myform">
        <h1>View Record </h1>
        <p></p>
   <table class="formtable" border="0"><tr><td>
   <table class="formtable" border="0">
   
    
    <tr>
    <td>Activity Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input type="text" readonly="true" id="act_items_name" name="act_items_name" size="30" maxlength="50" value="<% out.println((act_items_name == null) ? "" : act_items_name); %>" /></td>
    </tr>
    
    <tr>
    <td width="100" align="left">Item Name</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="act2items" name="act2items" readonly="true" >
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                           sql = "SELECT a.ID,ITEMS_NAME FROM T_ITEMS A,T_itemcat b "
                                                + "WHERE a.items2jobcat = b.id and A.STATUS_ITEMS=1 and b.CAT_CODE='ADHOC' "
                                                + "and ITEM2GROUPUNIT in "
                                                + " (select ITEMGROUP2GROUPUNIT from T_ITEMGROUPUNIT_USER "
                                                + " where ITEMGROUP2USER="+v_userID+" )  "
                                                + " ORDER BY INORDER ";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (act2items.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
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
    <td>Request Date Time</td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date"><input readonly=true type="text" id="request_datetime" name="request_datetime"  size="30" maxlength="10" value="<% out.println((request_datetime == null) ? "" : request_datetime); %>"  /></div></td>
    </tr>
    
    <tr>
    <td>Activity Plan Date Time</td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date"><input readonly=true type="text" id="work_starttime" name="work_starttime"  size="30" maxlength="10" value="<% out.println((work_starttime == null) ? "" : work_starttime); %>"  /></div></td>
    </tr>
    
    <tr>
    <td>Target Date Time</td>
    <td><div class="markMandatory">*</div></td>
    <td><div class="form_input_date"><input readonly=true type="text" id="act_sla_target" name="act_sla_target" size="30" maxlength="10" value="<% out.println((act_sla_target == null) ? "" : act_sla_target); %>"  /></div></td>
    </tr>
    
  
    <tr>
    <td>Ticket Number/ CR No</td>
    <td><div class="markMandatory"></div></td>
    <td><input readonly="true"  type="text" id="ticket_number" name="ticket_number" size="30" maxlength="50" value="<% out.println((ticket_number == null) ? "" : ticket_number); %>"  /></td>
    </tr>
    
    
    
    <tr>
    <td>Requestor Name</td>
    <td><div class="markMandatory">*</div></td>
    <td><input readonly="true" type="text" id="req_name" name="req_name" size="30" maxlength="50" value="<% out.println((req_name == null) ? "" : req_name); %>"  /></td>
    </tr>
        
     <tr>
    <td>Requestor Email</td>
    <td><div class="markMandatory">*</div></td>
    <td><input readonly="true" type="text" id="req_email" name="req_email" size="30" maxlength="50" value="<% out.println((req_email == null) ? "" : req_email); %>"  /></td>
    </tr>
    
   <tr>
    <td width="100" align="left">Requestor Division</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="division_id" name="division_id" readonly="true">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT id ID, '['||div_code||'] - '||div_name AS DESC "
                                                    + " FROM t_division  "
                                                    + "  ORDER BY 2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (division_id.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
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
    <td width="100" align="left">Priority </td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="act2priority" name="act2priority" readonly="true">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT a.ID,T_NAME FROM  T_ACTPRIORITY A "
                                                    + " ORDER BY INORDER ";
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (act2priority.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
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
    <td width="100" align="left">Importance </td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="act2importance" name="act2importance" readonly="true">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT a.ID,T_NAME FROM  T_ACTIMPORTANCE A "
                                                    + " ORDER BY INORDER ";
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (act2importance.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
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
    <td width="100" align="left">Weight </td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="act_weight" name="act_weight" readonly="true">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT a.ID,T_NAME FROM  T_ACTWEIGHT A "
                                                    + " ORDER BY INORDER ";
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (act_weight.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
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
    <td>Sort Number</td>
    <td><div class="markMandatory"></div></td>
    <td><input readonly="true" type="text" id="inorder" name="inorder" size="10" maxlength="2" value="<% out.println((inorder == null) ? "" : inorder); %>"  /></td>
    </tr>
  
    
    <tr>
    <td>Score</td>
    <td><div class="markMandatory"></div></td>
    <td><input readonly="true" type="text" id="inorder" name="inorder" size="10" maxlength="2" value="<% out.println((inorder == null) ? "" : inorder); %>"  /></td>
    </tr>
  
    <tr>
    <td>Additional Info</td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea readonly="true" class="notes_info" id="addl_info" name="addl_info"  rows="10" cols="50" maxlength="4000"><% out.println((addl_info == null) ? "" : addl_info); %></textarea>
    </tr>
    
    <tr>
    <td width="100" align="left">PIC Main Responsible </td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="pic_main" name="pic_main" readonly="true">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                                    sql = "select distinct a.id ID,first_name||' '||last_name AS DESC "
                                                        + "from t_user a join T_ITEMGROUPUNIT_USER b on a.id=b.ITEMGROUP2USER "
                                                        +" left join t_user_title c on a.user_title_id=c.id "
                                                        + "where ITEMGROUP2GROUPUNIT in ( "
                                                        + "select ITEMGROUP2GROUPUNIT from T_ITEMGROUPUNIT_USER "
                                                        + "where ITEMGROUP2USER="+v_userID+") "
                                                        + "ORDER BY 2";
                                            
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (pic_main.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
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
    <td width="100" align="left">PIC Analyst</td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="pic_ba" name="pic_ba" readonly="true">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                           sql = "SELECT * FROM (select 0 as ID,'-No PIC-' AS DESC, 1 AS ORD,'1' AS LEV UNION ALL select distinct a.id,first_name||' '||last_name||' ('||c.t_name||') ' AS DESC,2 AS ORD,c.t_name AS LEV "
                                                        + "from t_user a join T_ITEMGROUPUNIT_USER b on a.id=b.ITEMGROUP2USER "
                                                        +" left join t_user_title c on a.user_title_id=c.id "
                                                        + "where ITEMGROUP2GROUPUNIT in ( "
                                                        + "select ITEMGROUP2GROUPUNIT from T_ITEMGROUPUNIT_USER "
                                                        + "where ITEMGROUP2USER="+v_userID+") ) a "
                                                        + "ORDER BY 3,4,2";
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (pic_ba.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
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
    <td width="100" align="left">PIC Developer 1 </td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="pic_rpt_dev" name="pic_rpt_dev" readonly="true">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                           sql = "SELECT * FROM (select 0 as ID,'-No PIC-' AS DESC, 1 AS ORD,'1' AS LEV UNION ALL select distinct a.id,first_name||' '||last_name||' ('||c.t_name||') ' AS DESC,2 AS ORD,c.t_name AS LEV "
                                                        + "from t_user a join T_ITEMGROUPUNIT_USER b on a.id=b.ITEMGROUP2USER "
                                                        +" left join t_user_title c on a.user_title_id=c.id "
                                                        + "where ITEMGROUP2GROUPUNIT in ( "
                                                        + "select ITEMGROUP2GROUPUNIT from T_ITEMGROUPUNIT_USER "
                                                        + "where ITEMGROUP2USER="+v_userID+") ) a "
                                                        + "ORDER BY 3,4,2";
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (pic_rpt_dev.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
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
    <td width="100" align="left">PIC Developer 2 </td>
    <td><div class="markMandatory">*</div></td>
    <td width="100" align="left"><select id="pic_etl_dev" name="pic_etl_dev" readonly="true">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                           sql = "SELECT * FROM (select 0 as ID,'-No PIC-' AS DESC, 1 AS ORD,'1' AS LEV UNION ALL select distinct a.id,first_name||' '||last_name||' ('||c.t_name||') ' AS DESC,2 AS ORD,c.t_name AS LEV "
                                                        + "from t_user a join T_ITEMGROUPUNIT_USER b on a.id=b.ITEMGROUP2USER "
                                                        +" left join t_user_title c on a.user_title_id=c.id "
                                                        + "where ITEMGROUP2GROUPUNIT in ( "
                                                        + "select ITEMGROUP2GROUPUNIT from T_ITEMGROUPUNIT_USER "
                                                        + "where ITEMGROUP2USER="+v_userID+") ) a "
                                                        + "ORDER BY 3,4,2";
                                            
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (pic_etl_dev.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
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
    <td>Notes Info</td>
    <td><div class="markMandatory">*</div></td>
    <td><textarea class="notes_info" id="act_note" name="act_note"  rows="10" cols="50" maxlength="4000"><% out.println((act_note == null) ? "" : act_note); %></textarea>
    </tr>
  
</table></td></tr>
            <tr>
                <td>
                   
                </td>
            </tr>
            <tr><td align="left"> <p></p>
                   
                </td>
            </tr>
        </table>


                                
    </div>
</form>

<script type="text/javascript">
             
               $('#back').click(function() {
                   
                   
                   filter_itemname= document.getElementById("filter_itemname").value;
                        filter_actDate_start= document.getElementById("filter_actDate_start").value;
                        filter_actDate_end= document.getElementById("filter_actDate_end").value;
                        filter_status= document.getElementById("filter_status").value;
                        filter_groupName= document.getElementById("filter_groupName").value;
                        filter_userName= document.getElementById("filter_userName").value;
                        filter_SLA= document.getElementById("filter_SLA").value;
                        filter_priority= document.getElementById("filter_priority").value;
                        filter_act_auth= document.getElementById("filter_act_auth").value;
                        
                        
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "tracking/activity/activity_list_data.jsp",
                            data: {filter_itemname:filter_itemname,
                                filter_status:filter_status,
                                filter_actDate_start:filter_actDate_start,
                                filter_actDate_end:filter_actDate_end,
                                filter_groupName:filter_groupName,
                                filter_userName:filter_userName,
                                filter_SLA:filter_SLA,
                                filter_priority:filter_priority,
                                filter_act_auth:filter_act_auth},
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
             
    




</script>

