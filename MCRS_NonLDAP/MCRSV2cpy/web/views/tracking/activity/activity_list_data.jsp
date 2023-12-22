<%@include file="../../../includes/check_auth_layer3.jsp"%>

<%
           
    String id = request.getParameter("id");
    String filter_itemname = request.getParameter("filter_itemname");
    String filter_actDate_start = request.getParameter("filter_actDate_start");
    String filter_actDate_end = request.getParameter("filter_actDate_end");
    String filter_status = request.getParameter("filter_status");
    String filter_groupName = request.getParameter("filter_groupName");
    String filter_userName = request.getParameter("filter_userName");
    String filter_SLA = request.getParameter("filter_SLA");
    String filter_priority = request.getParameter("filter_priority");
    String filter_act_auth = request.getParameter("filter_act_auth");
   
   
    //SimpleDateFormat df = new SimpleDateFormat("YYYY/MM/dd");
    //String formattedDate_start = df.format(new java.util.Date());
    //String formattedDate_end = df.format(new java.util.Date());
    
    if (id == null) {
            id = "0";
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
            filter_userName = v_userID;
        }
    
       if (filter_SLA==null) {
           filter_SLA="0";
         }
    
    if (filter_priority == null) {
            filter_priority = "0";
        }
    
        
    if (filter_act_auth == null) {
            filter_act_auth = "0";
        }
    
   
    

    int i = 0;
    
%>
    
<div class="tablelist_wrap">
    <div id="refresh_data" class="add_optional">[refresh data] </div>
    <div id="addRecord" class="add_optional">[add records] </div>
</div>

<div >    
    
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th width="150">Action</th>
                <th width="10" axis="center"><input id="select_check_all" type="checkbox" name="select_check_all"   ></th>
                <th>Act Date</th>
                <th>Auth<br/>Stat</th>
                <th>Ticket</th>
                <th>Activity ID</th>
                <th width="250">Activity Name</th>
                
                <th>Status</th>
                <th>SLA Target Date</th>
                <th>Has<br/>Doc</th>
                <th>PIC Current</th>
                <th>PIC Business<br/>Analyst</th>
                <th>PIC Developer<br/>1</th>
                <th>PIC Developer<br/>2</th>
                <th>Requestor<br/>Name</th>
                <th>Requestor<br/>Email</th>  
                <th>Requestor<br/>Division</th>        
                
                <th>Request Date Time</th>
                <th>Planned Work Time</th>
                <th>Complete Time</th>
                <th>Priority</th>
                <th>Importance</th>
                <th>Weight</th>
                <th>Auth Time</th>
                <th>SCORE</th>
                <th width="250">Act.Item Group</th>
                <th>Item Group</th>
                <th>Note</th>
                <th>Addl Info</th>
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
                        
                        sql = " select * from ( "
                                +"WITH RECURSIVE tree AS "
                                +"(SELECT id, act_items_name, parent_id, CAST(act_items_name As varchar(1000)) As name_fullname, "
                                + "ACT_DATE,REPORT_DATE,STATUS_NAME,SEND_TIME,  "
                                + "ACT_SLA_TARGET,case when username is null then '-' else username end username,"
                                + "STATUS_SLA,ACT_NOTE, "
                                + " GROUP_NAME,GROUP_ID,PICKUP_STAT,ADDL_INFO,WORK_STARTTIME,REQUEST_DATETIME,CAT_ID,"
                                + " STATUS_ID,PRIORITY_NAME,TICKET_NUMBER,ITEMS_NAME,IMPORTANCE_NAME,WEIGHT_NAME,ACT_AUTH,"
                                + " ACT_AUTH_TIME,SCORE_FINAL, "
                                + " REQ_NAME,REQ_EMAIL,REQ_DIVISION,REQ_DIVISION_NAME,PIC_BA_NM,PIC_ETL_NM,PIC_RPT_NM, username_name,parent_act_name, "
                                + "ITEM2GROUPUNIT,user_id,jml_doc "
                                +"FROM V_ACT_DAILY "
                                +"WHERE parent_id=0 "
                                +"UNION ALL "
                                +"SELECT si.id,si.act_items_name, "
                                +"	si.parent_id, "
                                +"	CAST(sp.name_fullname || '->' || si.act_items_name As varchar(1000)) As name_fullname, "
                                + "si.ACT_DATE,si.REPORT_DATE,si.STATUS_NAME,si.SEND_TIME,  "
                                + "si.ACT_SLA_TARGET,case when si.username is null then '-' else si.username end username,"
                                + "si.STATUS_SLA,si.ACT_NOTE, "
                                + " si.GROUP_NAME,si.GROUP_ID,si.PICKUP_STAT,si.ADDL_INFO,si.WORK_STARTTIME,si.REQUEST_DATETIME,si.CAT_ID,"
                                + " si.STATUS_ID,si.PRIORITY_NAME,si.TICKET_NUMBER,si.ITEMS_NAME,si.IMPORTANCE_NAME,si.WEIGHT_NAME,si.ACT_AUTH,"
                                + " si.ACT_AUTH_TIME,si.SCORE_FINAL, "
                                + " si.REQ_NAME,si.REQ_EMAIL,si.REQ_DIVISION,si.REQ_DIVISION_NAME,si.PIC_BA_NM,si.PIC_ETL_NM,si.PIC_RPT_NM, si.username_name,si.parent_act_name,"
                                + " si.ITEM2GROUPUNIT,si.user_id,si.jml_doc "
                                +" FROM V_ACT_DAILY As si "
                                +"	INNER JOIN tree AS sp "
                                +"	ON (si.parent_id = sp.id) "
                                +") "
                                +"SELECT id,ACT_DATE,name_fullname ACT_ITEMS_NAME, "
                                + "REPORT_DATE,STATUS_NAME,SEND_TIME,  "
                                + "ACT_SLA_TARGET,username,"
                                + "STATUS_SLA,ACT_NOTE, "
                                + " GROUP_NAME,GROUP_ID,PICKUP_STAT,ADDL_INFO,WORK_STARTTIME,REQUEST_DATETIME,CAT_ID,"
                                + " STATUS_ID,PRIORITY_NAME,TICKET_NUMBER,ITEMS_NAME,IMPORTANCE_NAME,WEIGHT_NAME,ACT_AUTH,"
                                + " ACT_AUTH_TIME,SCORE_FINAL, "
                                + " REQ_NAME,REQ_EMAIL,REQ_DIVISION,REQ_DIVISION_NAME,PIC_BA_NM,PIC_ETL_NM,PIC_RPT_NM, username_name,parent_act_name,"
                                + "ITEM2GROUPUNIT,user_id,jml_doc "
                                +" FROM tree "
                                +"  ) a "
                                +" where ITEM2GROUPUNIT in "
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
                        
                        if (filter_act_auth.equals("0")) {
                        sql += " ";
                        }else {
                        sql += " and ACT_AUTH='"+filter_act_auth+"' ";
                        }
                        
                        
                        sql += " order by ACT_ITEMS_NAME,ACT_AUTH DESC,ACT_DATE ASC ";
                        
                        
                        //out.println(sql);
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
                                status_warna = "blue";
                            } else if (resultSet.getString("STATUS_ID").equals("7")) {
                                status_warna = "brown";
                            }  else {
                                status_warna = "";
                            }
                            
                            
                            String user_warna = "";

                            if (resultSet.getString("username").equals(v_userName)) {
                                user_warna = "green_user";
                            } else {
                                user_warna = "";
                            }
                            
                            String auth_warna = "";

                            if (resultSet.getString("ACT_AUTH").equals("Y")) {
                                auth_warna = "green_user";
                            } else {
                                auth_warna = "brown";
                            }


                       //TR ROW DATA
                       out.println("<tr id=rows_"+resultSet.getString("ID")+" class=" + rowstate + "> ");
                            
                            
                      %>
                      
               
                      
                      <td>
                          <div class="action_menu_wrap">
                              <% if (resultSet.getString("ACT_AUTH").equals("Y")) {
                              if (resultSet.getString("PICKUP_STAT").equals("0") ) {
                                %>
                                <div class="action_menu" id="pick_<%=resultSet.getString("ID")%>" >
                                    <div class="pickup_icon" title="pickup this act item <%=resultSet.getString("ACT_ITEMS_NAME")%> - New (id:<%=resultSet.getString("ID")%>) "></div>
                                </div>
                                   
                                <% } else if( (resultSet.getString("PICKUP_STAT").equals("1") && resultSet.getString("username").equals(v_userName) ) || v_userLevel.equals("1")){
                                %>
                                   <div class="action_menu" id="release_<%=resultSet.getString("ID")%>" >
                                       <div class="release_icon" title="Release this act item <%=resultSet.getString("ACT_ITEMS_NAME")%> (id:<%=resultSet.getString("ID")%>) "></div>
                                   </div>
                                   
                                   <div class="action_menu" id="ADDCHILD_<%=resultSet.getString("ID")%>" > 
                                       <div class="assign_icon" title="create sub-activity"></div>
                                   </div>
                                   
                                       
                                       
                                 <% } else if( (resultSet.getString("PICKUP_STAT").equals("1") && !resultSet.getString("username").equals(v_userName) && resultSet.getString("STATUS_ID").equals("1")) || v_userLevel.equals("1")){
                                %>
                                <div class="action_menu" id="pick_<%=resultSet.getString("ID")%>" >
                                    <div class="pickup_icon" title="Pickup this act item <%=resultSet.getString("ACT_ITEMS_NAME")%> (id:<%=resultSet.getString("ID")%>) "></div>
                                </div>
                                
                                
                                <%} else { %>
                                <div class="action_menu_no_click" id="lock_<%=resultSet.getString("ID")%>" >
                                    <div class="others_lock_icon" title="This act item already pickup by <%=resultSet.getString(8)%> (id;<%=resultSet.getString("ID")%>)"></div>
                                </div>
                                <%}} %>

                                <div class="action_menu" id="detail_<%=resultSet.getString("ID")%>" >
                                    <div class="detail_icon" title="View this Activity: <%=resultSet.getString("ACT_ITEMS_NAME")%>"></div>
                                </div>
                                
                                 <% /*if ( resultSet.getString("CAT_ID").equals("3") && (resultSet.getString("username").equals(v_userName) || v_userLevel.equals("1")) ) {*/
                                 if ( (resultSet.getString("ACT_AUTH").equals("N") && ( resultSet.getString("username").equals(v_userName)) ) || v_userLevel.equals("1") ) {
                                 %>
                                <div class="action_menu" id="edit_<%=resultSet.getString("ID")%>" >
                                    <div class="edit_icon" title="Edit this Activity: <%=resultSet.getString("ACT_ITEMS_NAME")%>"></div>
                                </div>
                                <%} %>
                                
                                
                                <% if (resultSet.getString("STATUS_SLA").equals("red") ) { %>
                                   <div class="action_menu_no_click" id="SLA_<%=resultSet.getString("ID")%>" > 
                                       <div class="warning_icon" title="<%=title_SLA%>"></div>
                                   </div>    
                                <%} else if (resultSet.getString("STATUS_SLA").equals("yellow")) {%>
                                <div class="action_menu_no_click" id="SLA_<%=resultSet.getString("ID")%>" > 
                                       <div class="warning_icon" title="<%=title_SLA%>"></div>
                                   </div>  
                                <%}%>
                                
                                <% if (v_userLevel.equals("1") ) { 
                                    if (resultSet.getString("ACT_AUTH").equals("N") ) { %>
                                   <div class="action_menu" id="AUTH_<%=resultSet.getString("ID")%>" > 
                                       <div class="activate_icon" title="Authorize this!"></div>
                                   </div>    
                                <%}else {
                                         %>
                                   <div class="action_menu" id="INAUTH_<%=resultSet.getString("ID")%>" > 
                                       <div class="others_lock_icon" title="Inauthorize this!"></div>
                                   </div>      
                                   <% }}
                                    %>
                                
                                   <div class="action_menu" id="UPLOAD_<%=resultSet.getString("ID")%>" > 
                                       <div class="upload_icon" title="Upload File"></div>
                                   </div> 
                                   
                                   <div class="action_menu" id="DOWNLOAD_<%=resultSet.getString("ID")%>" > 
                                       <div class="download_icon" title="Download File"></div>
                                   </div> 
                                       
                          </div>
                      </td>
                      <td axis="center">
                         <% if (resultSet.getString("ACT_AUTH").equals("Y") || v_userLevel.equals("1") ) { 
                             if (resultSet.getString("username").equals(v_userName) || v_userLevel.equals("1"))   {%>
                          <input class="checkboxSelect_act" type="checkbox" id="checkboxSelect_act<%=resultSet.getString("ID")%>" name="checkboxSelect_act<%=resultSet.getString("ID")%>" value="<%=resultSet.getString("ID")%>">
                          <% } else { out.println("-"); }   
                      } else { out.println("-"); } %>
                      </td>
                      <script type="text/javascript">
                          
                                  <%if (!id.equals("0")) {%>
                                   $("#rows_<%=id%>").attr("class", "mark");
                                  <%}%>
            
                            $('#pick_<%=resultSet.getString("ID")%>').click(function() {
                                                                
                                $("#data_inner").hide();
                                $("#loading").show();
                                
                                $.ajax({
                                    type: 'POST',
                                    url: "tracking/activity/activity_list_pickup.jsp",
                                    data: {id:"<%=resultSet.getString("ID")%>",item_name:"<%=resultSet.getString("ACT_ITEMS_NAME")%>" },
                                    success: function(data) {
                                        $('#status_msg').empty();
                                        $('#status_msg').html(data); 
                                    },
                                    complete: function(){
                                        //$('#loading').hide();
                                    }
                                });
                                return false;
                            });
                            
                            $('#release_<%=resultSet.getString("ID")%>').click(function() {
                            
                            
                                $("#data_inner").hide();
                                $('#loading').show();
                                
                                $.ajax({
                                    type: 'POST',
                                    url: "tracking/activity/activity_list_release.jsp",
                                    data: {id:"<%=resultSet.getString("ID")%>",item_name:"<%=resultSet.getString("ACT_ITEMS_NAME")%>" },
                                    success: function(data) {
                                       $('#status_msg').empty();
                                       $('#status_msg').html(data);
                                       
                                    },
                                    complete: function(){
                                        //$('#loading').hide();
                                    }
                                });
                                return false;
                            });
                            
                            $('#edit_<%=resultSet.getString("ID")%>').click(function() {
                                    $("#data_inner").hide();
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "tracking/activity/activity_list_modify.jsp",
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
                                    
                             $('#AUTH_<%=resultSet.getString("ID")%>').click(function() {                          
                                $("#data_inner").hide();
                                $("#loading").show();
                                $.ajax({
                                    type: 'POST',
                                    url: "tracking/activity/activity_list_auth.jsp",
                                    data: {id:"<%=resultSet.getString("ID")%>",item_name:"<%=resultSet.getString("ACT_ITEMS_NAME")%>" },
                                    success: function(data) {
                                        $('#status_msg').empty();
                                        $('#status_msg').html(data); 
                                    },
                                    complete: function(){
                                        //$('#loading').hide();
                                    }
                                });
                                return false;
                            });
                            
                                    $('#INAUTH_<%=resultSet.getString("ID")%>').click(function() {
                                       $("#data_inner").hide();
                                       $("#loading").show();

                                       $.ajax({
                                           type: 'POST',
                                           url: "tracking/activity/activity_list_inauth.jsp",
                                           data: {id:"<%=resultSet.getString("ID")%>",item_name:"<%=resultSet.getString("ACT_ITEMS_NAME")%>" },
                                           success: function(data) {
                                               $('#status_msg').empty();
                                               $('#status_msg').html(data); 
                                           },
                                           complete: function(){
                                               //$('#loading').hide();
                                           }
                                       });
                                       return false;
                                   });
                                    
                                  $('#detail_<%=resultSet.getString("ID")%>').click(function() {
                                    $("#data_inner").hide();
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "tracking/activity/activity_list_detail_info.jsp",
                                        data: "id=<%=resultSet.getString("ID")%>",
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
                                    
                                    
                                 $('#UPLOAD_<%=resultSet.getString("ID")%>').click(function() {
                                            
                                            popupwindow = window.open('tracking/activity/activity_list_upload.jsp?id=<%=resultSet.getString("ID")%>&stat=0','Upload File','menubar=no,location=no,resizable=no,scrollbars=no,status=yes,width=600, height=300, left=0, top=0');
                                            popupWindow.focus();
                                            return false;
                                        });
                                        
                                        
                                 $('#DOWNLOAD_<%=resultSet.getString("ID")%>').click(function() {
                                        
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "tracking/activity/activity_list_download_file.jsp",
                                        data: {id:<%=resultSet.getString("ID")%>},
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
                                 
                                 
                                 $('#ADDCHILD_<%=resultSet.getString("ID")%>').click(function() {
                                        
                                    $('#loading').show();
                                    $.ajax({
                                        type: 'POST',
                                        url: "tracking/activity/activity_list_modify.jsp",
                                        data: {id:<%=resultSet.getString("ID")%>,action:3},
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
                      
                      
                      
                      <%
                            
                            
                            out.println("<td> " + resultSet.getString("ACT_DATE") + " </td>");
                            out.println("<td  axis="+auth_warna+"  > " + resultSet.getString("ACT_AUTH") + " </td>");
                            out.println("<td>" + resultSet.getString("TICKET_NUMBER") + " </td>");
                            out.println("<td>" + resultSet.getString("ID") + " </td>");
                            out.println("<td axis="+sla_warna_text +" > " + resultSet.getString("ACT_ITEMS_NAME") + " </td>");
                            
                            out.println("<td axis=" + status_warna + "   title='" + resultSet.getString(10) + "' > " + resultSet.getString(5) + " </td>");
                            out.println("<td axis="+sla_warna +" title='" +title_SLA+ "'  > " + resultSet.getString("ACT_SLA_TARGET") + " </td>");
                            out.println("<td> " + resultSet.getString("JML_DOC") + " </td>");
                            out.println("<td axis="+user_warna+"> " + resultSet.getString("USERNAME_NAME") + " </td>");
                            out.println("<td> " + resultSet.getString("PIC_BA_NM") + " </td>");
                            out.println("<td> " + resultSet.getString("PIC_ETL_NM") + " </td>");
                            out.println("<td> " + resultSet.getString("PIC_RPT_NM") + " </td>");
                            out.println("<td> " + resultSet.getString("REQ_NAME") + " </td>");
                            out.println("<td> " + resultSet.getString("REQ_EMAIL") + " </td>");
                            out.println("<td> " + resultSet.getString("REQ_DIVISION_NAME") + " </td>");
                            
                            out.println("<td> " + resultSet.getString("REQUEST_DATETIME") + " </td>");
                            out.println("<td> " + resultSet.getString("WORK_STARTTIME") + " </td>");
                            out.println("<td> " + resultSet.getString("SEND_TIME") + " </td>");
                            out.println("<td> " + resultSet.getString("PRIORITY_NAME") + " </td>");
                            out.println("<td> " + resultSet.getString("IMPORTANCE_NAME") + " </td>");
                            out.println("<td> " + resultSet.getString("WEIGHT_NAME") + " </td>");
                           
                            out.println("<td> " + resultSet.getString("ACT_AUTH_TIME") + " </td>");
                            out.println("<td axis=number> " + resultSet.getString("SCORE_FINAL") + " </td>");
                            out.println("<td> " + resultSet.getString("ITEMS_NAME") + " </td>");
                            out.println("<td> " + resultSet.getString("GROUP_NAME") + " </td>");
                         
                            
                            if (resultSet.getString("ACT_NOTE").equals("-")) {
                                    out.println("<td title='" + resultSet.getString("ACT_NOTE") + "'>" + resultSet.getString("ACT_NOTE") + " </td>");
                                } else {
                                    if (resultSet.getString("ACT_NOTE").length() >= 100) {
                                        out.println("<td title='" + resultSet.getString("ACT_NOTE") + "'>" + resultSet.getString("ACT_NOTE").substring(0, 100) + "..." + " </td>");
                                    } else {
                                        out.println("<td title='" + resultSet.getString("ACT_NOTE") + "'>" + resultSet.getString("ACT_NOTE").substring(0, resultSet.getString("ACT_NOTE").length()) + " </td>");
                                    }
                                }
                            
                            
                            if (resultSet.getString("ADDL_INFO").equals("-")) {
                                    out.println("<td title='" + resultSet.getString("ADDL_INFO") + "'>" + resultSet.getString("ADDL_INFO") + " </td>");
                                } else {
                                    if (resultSet.getString("ADDL_INFO").length() >= 100) {
                                        out.println("<td title='" + resultSet.getString("ADDL_INFO") + "'>" + resultSet.getString("ADDL_INFO").substring(0, 100) + "..." + " </td>");
                                    } else {
                                        out.println("<td title='" + resultSet.getString("ADDL_INFO") + "'>" + resultSet.getString("ADDL_INFO").substring(0, resultSet.getString("ADDL_INFO").length()) + " </td>");
                                    }
                                }
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
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
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
          
  
            $('#refresh_data').click(function() {
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
                            data: {id:<%=id%>,filter_itemname:filter_itemname,
                                filter_status:filter_status,
                                filter_actDate_start:filter_actDate_start,
                                filter_actDate_end:filter_actDate_end,
                                filter_groupName:filter_groupName,
                                filter_userName:filter_userName,
                                filter_SLA:filter_SLA,
                                filter_priority:filter_priority,
                                filter_act_auth:filter_act_auth
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
             
             
             $('#reportview_data').click(function() {
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
                            url: "tracking/activity/activity_list_data_reportview.jsp",
                            data: {id:<%=id%>,filter_itemname:filter_itemname,
                                filter_status:filter_status,
                                filter_actDate_start:filter_actDate_start,
                                filter_actDate_end:filter_actDate_end,
                                filter_groupName:filter_groupName,
                                filter_userName:filter_userName,
                                filter_SLA:filter_SLA,
                                filter_priority:filter_priority,
                                filter_act_auth:filter_act_auth
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
             
              $('#addRecord').click(function() {
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "tracking/activity/activity_list_modify.jsp",
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
            
             <% if (!id.equals("0") ) { %> 
             $('#content').animate({
             scrollTop: $("#rows_<%=id%>").offset().top
             }, 2000);
             <% } %>
             
             
           });
           
           
           
           

</script>


