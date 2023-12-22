<%@include file="../../../includes/check_auth_layer2.jsp"%>

<%
           
    String objid = request.getParameter("objid");
    String filter_itemname = request.getParameter("filter_itemname");
    String filter_actDate_start = request.getParameter("filter_actDate_start");
    String filter_actDate_end = request.getParameter("filter_actDate_end");
    String filter_status = request.getParameter("filter_status");
    String filter_groupName = request.getParameter("filter_groupName");
    String filter_userName = request.getParameter("filter_userName");
    String filter_SLA = request.getParameter("filter_SLA");
    String filter_priority = request.getParameter("filter_priority");
   
    //SimpleDateFormat df = new SimpleDateFormat("YYYY/MM/dd");
    //String formattedDate_start = df.format(new java.util.Date());
    //String formattedDate_end = df.format(new java.util.Date());
    
    if (objid == null) {
            objid = "0";
        }
    
    if (filter_itemname == null) {
            filter_itemname = "";
        }
    if (filter_actDate_start == null) {
            filter_actDate_start = "";
    }
    if (filter_actDate_end == null) {
            filter_actDate_end = "";
    }
    
    if (filter_status == null) {
            filter_status = "-1";
        }
    
    if (filter_groupName == null) {
            filter_groupName = "0";
        }
    if (filter_userName == null) {
            filter_userName = "0";
        }
    
       if (filter_SLA==null) {
           filter_SLA="0";
         }
    
    if (filter_priority == null) {
            filter_priority = "0";
        }
    
   
    

    int i = 0;
    
%>
        
<div >
    <div id="back_button" class="add_optional">[back] </div>
   
    
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th width="100">No </th>
                
                <th>Act Date</th>
                <th>Ticket</th>
                <th width="250">Item Name</th>
                <th>Act.Item Group</th>
                <th>Item Group</th>
                <th>Status</th>
                <th>Priority</th>
                <th>SLA Target Date</th>
                <th>Request Date Time</th>
                <th>Planned Work Time</th>
                <th>Complete Time</th>
                <th>PIC</th>
            </tr>
        </thead>

        <tbody>

            <%

              
                try {
                    ResultSet resultSet=null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "select OBJID, ACT_DATE, ACT_ITEMS_NAME,case when REPORT_DATE=0 then ' ' else ' ('||REPORT_DATE||')' end REPORT_DATE,STATUS_NAME,NVL(SEND_TIME,'-') SEND_TIME, "
                                + "ACT_SLA_TARGET,NVL(username,'-') username,"
                                + "STATUS_SLA,nvl(ACT_NOTE,'-') ACT_NOTE, "
                                + " GROUP_NAME,PICKUP_STAT,nvl(ADDL_INFO,'-') ADDL_INFO,WORK_STARTTIME,REQUEST_DATETIME,CAT_ID,"
                                + " STATUS_ID,PRIORITY_NAME,nvl(TICKET_NUMBER,'-') TICKET_NUMBER,rownum NO_ORDER,ITEMS_NAME"
                                + " from V_ACT_DAILY where ITEM2GROUPUNIT in "
                                + " (select ITEMGROUP2GROUPUNIT from T_ITEMGROUPUNIT_USER "
                                + " where ITEMGROUP2USER="+v_userID+" ) ";
                        
                        if (filter_itemname.equals("")==false) {
                        sql += " and (upper(ITEMS_NAME) like upper('%"+filter_itemname+"%') or upper(ACT_ITEMS_NAME) like upper('%"+filter_itemname+"%'))";
                        }

                        if (filter_actDate_start.equals("")==false ) {
                        
                            sql += " and ACT_DATE >= '"+filter_actDate_start+"' ";
                        }

                        if (filter_actDate_end.equals("")==false) {
                        
                            sql += " and ACT_DATE <= '"+filter_actDate_end+"' ";
                            
                        }                                                                                                                    
                         
                        if (filter_status.equals("0")) {
                        sql += " ";
                        }else if (filter_status.equals("-1")) {
                        sql += " and status_id not in (4,6) ";
                        }else {
                        sql += " and status_id ="+filter_status+" ";
                        }
                        
                        // 1 OPEN 2 RUNNING 3 WAITING 4 DONE 5 PENDING 6 CANCEL 
                        
                        if (filter_groupName.equals("0")) {
                        sql += " ";
                        }else {
                        sql += " and group_id ="+filter_groupName+" ";
                        }
                        
                        if (filter_userName.equals("0")) {
                        sql += " ";
                        }else {
                        sql += " and user_id ="+filter_userName+" ";
                        }
                        
                        if (filter_SLA.equals("0")) {
                        sql += " ";
                        }else {
                        sql += " and STATUS_SLA='"+filter_SLA+"' ";
                        }
                        
                        if (filter_priority.equals("0")) {
                        sql += " ";
                        }else {
                        sql += " and PRIORITY_ID='"+filter_priority+"' ";
                        }
                        
                        
                        
                        //out.println(sql);

                        resultSet = db.executeQuery(sql);
                        String rowstate = "even";
                        
                        while (resultSet.next()) {
                            i++;

                            if (i % 2 == 0) {
                                rowstate = "even";
                            } else {
                                rowstate = "odd";
                            }


                            String sla_warna = "";
                            String sla_warna_text = "";
                            String title_SLA="";

                            if (resultSet.getString("STATUS_SLA").equals("red")) {
                                sla_warna = "red";
                                sla_warna_text="red_text";
                                title_SLA="SLA Breach for this Activity Oh Nooooo !!!!";
                            } else if (resultSet.getString("STATUS_SLA").equals("yellow")) {
                                sla_warna = "yellow";
                                sla_warna_text="yellow_text";
                                title_SLA="SLA Warning for this Activity!!!!";
                            } else if (resultSet.getString("STATUS_SLA").equals("green")) {
                                sla_warna = "green";
                                sla_warna_text="";
                                title_SLA="SLA Good :)";
                            } else {
                                sla_warna = "";
                                sla_warna_text="";
                                title_SLA="";
                            }
                            
                            String status_warna = "green";

                            if (resultSet.getString("STATUS_ID").equals("4")) {
                                status_warna = "green";
                            } else if (resultSet.getString("STATUS_ID").equals("3")) {
                                status_warna = "yellow";
                            } else if (resultSet.getString("STATUS_ID").equals("2")) {
                                status_warna = "orange";
                            } else if (resultSet.getString("STATUS_ID").equals("5")) {
                                status_warna = "purple";
                            } else if (resultSet.getString("STATUS_ID").equals("6")) {
                                status_warna = "brown";
                            } else {
                                status_warna = "";
                            }
                            
                            
                            String user_warna = "";

                            if (resultSet.getString("username").equals(v_userName)) {
                                user_warna = "green_user";
                            } else {
                                user_warna = "";
                            }

                       //TR ROW DATA
                       out.println("<tr id=rows_"+resultSet.getString(1)+" class=" + rowstate + "> ");
                            
                      
                      
                      
                            out.println("<td> " + resultSet.getString("NO_ORDER") + " </td>");
                            out.println("<td> " + resultSet.getString(2) + " </td>");
                            out.println("<td>" + resultSet.getString("TICKET_NUMBER") + " </td>");
                            out.println("<td axis="+sla_warna_text +" > " + resultSet.getString(3) + " </td>");
                            out.println("<td> " + resultSet.getString("ITEMS_NAME") + " </td>");
                            out.println("<td> " + resultSet.getString("GROUP_NAME") + " </td>");
                            out.println("<td axis=" + status_warna + "   title='" + resultSet.getString(10) + "' > " + resultSet.getString(5) + " </td>");
                            out.println("<td> " + resultSet.getString("PRIORITY_NAME") + " </td>");
                            out.println("<td axis="+sla_warna +" title='" +title_SLA+ "'  > " + resultSet.getString("ACT_SLA_TARGET") + " </td>");
                            out.println("<td> " + resultSet.getString("REQUEST_DATETIME") + " </td>");
                            out.println("<td> " + resultSet.getString("WORK_STARTTIME") + " </td>");
                            out.println("<td> " + resultSet.getString("SEND_TIME") + " </td>");
                            out.println("<td axis="+user_warna+"> " + resultSet.getString("USERNAME") + " </td>");
                            //out.println("<td axis=wrapit title='" + resultSet.getString("ACT_NOTE") + "'><textarea class=notes_info rows=5 cols=100 maxlength=4000 readonly=true >" + resultSet.getString("ACT_NOTE") + " </textarea> </td>");
                            //out.println("<td axis=wrapit title='" + resultSet.getString("ADDL_INFO") + "'><textarea class=notes_info rows=5 cols=100 maxlength=4000 readonly=true >" + resultSet.getString("ADDL_INFO") + " </textarea> </td>");
                         
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

                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> <%=i%> Record(s)</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                
            </tr>
        </tfoot>
    </table> 
</div>
                
<script type="text/javascript">
         $(document).ready(function() {
          
  
            $('#back_button').click(function() {
                        filter_itemname= document.getElementById("filter_itemname").value;
                        filter_actDate_start= document.getElementById("filter_actDate_start").value;
                        filter_actDate_end= document.getElementById("filter_actDate_end").value;
                        filter_status= document.getElementById("filter_status").value;
                        filter_groupName= document.getElementById("filter_groupName").value;
                        filter_userName= document.getElementById("filter_userName").value;
                        filter_SLA= document.getElementById("filter_SLA").value;
                        filter_priority= document.getElementById("filter_priority").value;

                        
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "dashboard/daily_activities/activity_list_data.jsp",
                            data: {filter_itemname:filter_itemname,
                                filter_status:filter_status,
                                filter_actDate_start:filter_actDate_start,
                                filter_actDate_end:filter_actDate_end,
                                filter_groupName:filter_groupName,
                                filter_userName:filter_userName,
                                filter_SLA:filter_SLA,
                                filter_priority:filter_priority
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
             
             
                            

            <%
            if (i==0) {
                %>
                $("#select_check_all").attr("disabled", "");
                <%
            }
            %>
                
        $("#select_check_all").click(function()
            {
                var checked_status = this.checked;
                $(".checkboxSelect_act").each(function()
                {
                    this.checked = checked_status;
                });
            });
           });

</script>


