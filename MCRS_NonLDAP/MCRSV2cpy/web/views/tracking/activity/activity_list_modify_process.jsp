<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String id="0";
    String tableName="t_act_his";
    String tableNameSeq=tableName+"_seq";
    
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
   String  act_date = request.getParameter("act_date");
String  act2items = request.getParameter("act2items");
String  send_time = request.getParameter("send_time");
String  last_update_time = request.getParameter("last_update_time");
String  act2actstatus = request.getParameter("act2actstatus");
String  act2user = request.getParameter("act2user");
String  act_sla_target = request.getParameter("act_sla_target");
String  act_sla_notif = request.getParameter("act_sla_notif");
String  act_note = request.getParameter("act_note");
String  act2issue = request.getParameter("act2issue");
String  act_notif = request.getParameter("act_notif");
String  act_weight = request.getParameter("act_weight");
String  act_date_time = request.getParameter("act_date_time");
String  report_date = request.getParameter("report_date");
String  act_items_name = request.getParameter("act_items_name");
String  addl_info = request.getParameter("addl_info");
String  ref_table = request.getParameter("ref_table");
String  inorder = request.getParameter("inorder");
String  pickup_stat = request.getParameter("pickup_stat");
String  dismissed_sla = request.getParameter("dismissed_sla");
String  create_time = request.getParameter("create_time");
String  work_starttime = request.getParameter("work_starttime");
String  request_datetime = request.getParameter("request_datetime");
String  ticket_number = request.getParameter("ticket_number");
String  act2priority = request.getParameter("act2priority");
String  act2importance = request.getParameter("act2importance");
String  act_auth = request.getParameter("act_auth");
String  act_auth_time = request.getParameter("act_auth_time");
String  req_name = request.getParameter("req_name");
String  req_email = request.getParameter("req_email");
String  division_id = request.getParameter("division_id");
String  pic_ba = request.getParameter("pic_ba");
String  pic_etl_dev = request.getParameter("pic_etl_dev");
String  pic_rpt_dev = request.getParameter("pic_rpt_dev");
String pic_main = request.getParameter("pic_main");
String parent_id = request.getParameter("parent_id");

    

 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    boolean creq_email = Pattern.matches("(([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})+)*$|", req_email);
    
    String cleanAddlInfo = addl_info.replaceAll("[^\\w\\s]", "");
    addl_info = cleanAddlInfo;
    
    if (act_items_name.equals("")){
    act_items_name="NULL";
    validate = false;
    errorMessage += "- Field Activity name tidak boleh null <br>";
    }
    
    
    String request_datetimeVal="";
    if (request_datetime.equals("")){
    request_datetimeVal="NULL";
    validate = false;
    errorMessage += "- Field Requset Date tidak boleh null <br>";
    }else{
    request_datetimeVal="to_timestamp('"+request_datetime+"','YYYY-MM-DD HH24:MI')";    
    }
    
    String work_starttimeVal="";
    if (work_starttime.equals("")){
    work_starttimeVal="NULL";
    validate = false;
    errorMessage += "- Field work starttime tidak boleh null <br>";
    }else{
    work_starttimeVal="to_timestamp('"+work_starttime+"','YYYY-MM-DD HH24:MI')";    
    }
    
    String act_sla_targetVal="";
    if (act_sla_target.equals("")){
    work_starttimeVal="NULL";
    validate = false;
    errorMessage += "- Field act sla target tidak boleh null <br>";
    }else{
    act_sla_targetVal="to_timestamp('"+act_sla_target+"','YYYY-MM-DD HH24:MI')";    
    }    
    
    if (req_name.equals("")){
    req_name="NULL";
    validate = false;
    errorMessage += "- Field requestor name tidak boleh null <br>";
    }
    
    
    if (!creq_email  || req_email.equals("") ) {
    req_email="NULL";
    validate = false;
    errorMessage += "- Field requestor email tidak boleh null atau harus diisi dengan benar i.e. emp@example.com <br>";
    }
    
    if (addl_info.equals("")){
    addl_info="NULL";
    validate = false;
    errorMessage += "- Field Additional Info tidak boleh null <br>";
    }
    
    if (act2items.equals("3") && ticket_number.equals("")) {
    validate = false;
    errorMessage += "- Field Ticket Number tidak boleh null jika item name MIS Change Request <br>";
        
    }
    
    
    if (validate) {
        
        
        
        
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                String sql;
                
                //out.println("<div class=info>" +cabangGroupID +username+ "</div>");
                
               if (actionCode.equals("ADD")) {
           
                   
                   
                   
                    sql = "insert into T_ACT_HIS(id, ACT_DATE, ACT_ITEMS_NAME,ACT2ITEMS,LAST_UPDATE_TIME,ACT2ACTSTATUS,"
                        + " ACT2USER,ADDL_INFO,INORDER,TICKET_NUMBER,ACT2PRIORITY,ACT2IMPORTANCE,ACT_WEIGHT,ACT_AUTH,REQ_NAME,REQ_EMAIL,DIVISION_ID,PIC_BA,PIC_ETL_DEV,PIC_RPT_DEV,PIC_MAIN,"
                        + "ACT_SLA_TARGET,ACT_SLA_NOTIF,ACT_DATE_TIME,PICKUP_STAT,DISMISSED_SLA,CREATE_TIME,WORK_STARTTIME,REQUEST_DATETIME,PARENT_ID,LEAF_STAT ) "
                        + " values (nextval('"+tableNameSeq+"'),to_char("+work_starttimeVal+",'YYYYMMDD'),"
                        + "'"+act_items_name+"',"+act2items+",current_timestamp,1, "
                        +pic_main+",'"+addl_info+"',1,'"+ticket_number+"',"+act2priority+","+act2importance+","+act_weight+",'N','"+req_name+"','"+req_email+"','"+division_id+"',  "
                        +pic_ba+","+pic_rpt_dev+","+pic_etl_dev+","+pic_main+", "; 

                       if (act_sla_target.equals("")) {
                        sql += " '','', ";
                        } else {
                        sql += " "+act_sla_targetVal+", "
                                + " "+act_sla_targetVal+" - INTERVAL '3 hours', ";
                        }
                
                sql += " current_timestamp,0,0,current_timestamp,"+work_starttimeVal+","+request_datetimeVal+",0,1 ) ";
                 
                
               String msgForm="";
               String msgMail="";
               if (v_userID.equals(pic_main)) {
               msgMail="New task/activity has been assigned to you by yourself. Please inform your direct supervisor for approval process";     
               } else {
               msgMail="New task/activity has been assigned to you by "+v_userFullName+". Please inform your direct supervisor for approval process";
               }
                auth mail = new auth(v_clientIP);
                try {
                    
                    msgForm=mail.execSendMailNotif(pic_main,act_items_name,msgMail);
                    //msgForm=mail.execSendMailNotif(pic_ba,act_items_name,msgMail);
                    //msgForm=mail.execSendMailNotif(pic_rpt_dev,act_items_name,msgMail);
                    //msgForm=mail.execSendMailNotif(pic_etl_dev,act_items_name,msgMail);
                    
                    } catch (SQLException Sqlex) {
                 out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                 } finally {
                 mail.close();
                 }

                
                
                
                
                
                
                
                actionDesc="Add";
                        
               } else if (actionCode.equals("ADDCHILD")) {
           
                   
                   sql = "update "+tableName+" SET "  
                    +" leaf_stat=0 "
                    +" where id="+parent_id;
                   
                    db.executeUpdate(sql);
                    
                   
                    sql = "insert into T_ACT_HIS(id, ACT_DATE, ACT_ITEMS_NAME,ACT2ITEMS,LAST_UPDATE_TIME,ACT2ACTSTATUS,"
                        + " ACT2USER,ADDL_INFO,INORDER,TICKET_NUMBER,ACT2PRIORITY,ACT2IMPORTANCE,ACT_WEIGHT,ACT_AUTH,REQ_NAME,REQ_EMAIL,DIVISION_ID,PIC_BA,PIC_ETL_DEV,PIC_RPT_DEV,PIC_MAIN,"
                        + "ACT_SLA_TARGET,ACT_SLA_NOTIF,ACT_DATE_TIME,PICKUP_STAT,DISMISSED_SLA,CREATE_TIME,WORK_STARTTIME,REQUEST_DATETIME,PARENT_ID,LEAF_STAT ) "
                        + " values (nextval('"+tableNameSeq+"'),to_char("+work_starttimeVal+",'YYYYMMDD'),"
                        + "'"+act_items_name+"',"+act2items+",current_timestamp,1, "
                        +pic_main+",'"+addl_info+"',1,'"+ticket_number+"',"+act2priority+","+act2importance+","+act_weight+",'N','"+req_name+"','"+req_email+"','"+division_id+"',  "
                        +pic_ba+","+pic_rpt_dev+","+pic_etl_dev+","+pic_main+", "; 

                       if (act_sla_target.equals("")) {
                        sql += " '','', ";
                        } else {
                        sql += " "+act_sla_targetVal+", "
                                + " "+act_sla_targetVal+" - INTERVAL '3 hours', ";
                        }
                
                sql += " current_timestamp,0,0,current_timestamp,"+work_starttimeVal+","+request_datetimeVal+","+parent_id+",1 ) ";
                 
                
               String msgForm="";
               String msgMail="";
               String parentItemName="";
       
               
            
                auth mail = new auth(v_clientIP);
                try {
                    
                    parentItemName=mail.getItemName(parent_id);
                    
                    if (v_userID.equals(pic_main)) {
                    msgMail="New task/activity related to "+parentItemName+" has been assigned to you by yourself. Please inform your direct supervisor for approval process";     
                    } else {
                    msgMail="New task/activity related to "+parentItemName+" has been assigned to you by "+v_userFullName+". Please disscuss with "+v_userFullName+" to get further information and inform your direct supervisor for approval process";
                    }
                    
                    msgForm=mail.execSendMailNotif(pic_main,act_items_name,msgMail);
                
                    
                    } catch (SQLException Sqlex) {
                 out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                 } finally {
                 mail.close();
                 }

                
                
                
                
                
                
                
                actionDesc="Add Child Activity";
                        
               }
               else {
                   
                 sql = "update "+tableName+" SET "  
                    +" act_date=to_char("+work_starttimeVal+",'YYYYMMDD'), "
                    +" ACT2USER="+pic_main+", "
                    +" act2items="+ act2items+", "
                    +" last_update_time=current_timestamp, "
                    +" act_sla_target="+ act_sla_targetVal+", "
                    +" act_sla_notif=("+act_sla_targetVal+" - INTERVAL '3 hours'), "
                    +" act_weight="+ act_weight+", "
                    +" act_items_name='"+ act_items_name+"', "
                    +" addl_info='"+addl_info+"', "
                    +" work_starttime="+ work_starttimeVal+", "
                    +" request_datetime="+ request_datetimeVal+", "
                    +" ticket_number='"+ ticket_number+"', "
                    +" act2priority="+ act2priority+", "
                    +" act2importance="+ act2importance+", "
                    +" req_name='"+ req_name+"', "
                    +" req_email='"+ req_email+"', "
                    +" division_id="+ division_id+", "
                    +" pic_ba="+ pic_ba+", "
                    +" pic_etl_dev="+ pic_etl_dev+", "
                    +" pic_rpt_dev="+ pic_rpt_dev+", "
                    +"pic_main="+pic_main+" "
                 +" where id="+id;
                 
                 actionDesc="Edit";
                 
                   String msgForm="";
               String msgMail="Task/activity has been updated by "+v_userFullName;

                auth mail = new auth(v_clientIP);
                try {
                    msgForm=mail.execSendMailNotif(pic_main,act_items_name,msgMail);
                    } catch (SQLException Sqlex) {
                 out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                 } finally {
                 mail.close();
                 }
                
                   
               }
               
           
            
             
                
                
               //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                db.executeUpdate(sql);
                out.println("<div class=info>"+actionDesc+" "+formName+" Success<br></div>");
                
                 %>
                <script type="text/javascript">
                    $("#data").empty();
                    $('#loading').show();
                    
                    filter_itemname= document.getElementById("filter_itemname").value;
                        filter_actDate_start= document.getElementById("filter_actDate_start").value;
                        filter_actDate_end= document.getElementById("filter_actDate_end").value;
                        filter_status= document.getElementById("filter_status").value;
                        filter_groupName= document.getElementById("filter_groupName").value;
                        filter_userName= document.getElementById("filter_userName").value;
                        filter_SLA= document.getElementById("filter_SLA").value;
                        filter_priority= document.getElementById("filter_priority").value;
                        filter_act_auth= document.getElementById("filter_act_auth").value;
                        
                    $.ajax({
                        type: 'POST',
                        url: "tracking/activity/activity_list_data.jsp",
                        data: {
                        filter_itemname:filter_itemname,
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
                            $("#data_inner").empty();
                            $('#data_inner').html(data);
                            $("#data_inner").show();
                            $("#status_msg").delay(5000).hide(400);                  
                        },
                        complete: function(){
                            $('#loading').hide();
                        }
                    });
                </script>
                    <%
                    
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                if (resultSet != null) resultSet.close(); 
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
        
        
    } else {
        out.println("<div class=alert>" + errorMessage + "</div>");
    }

    

    
    
%>

