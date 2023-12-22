<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String id="0";
    String tableName="t_items";
    String tableNameSeq=tableName+"_seq";
    
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String items_grouping = request.getParameter("items_grouping");
String  items_name = request.getParameter("items_name");
String  items2jobcat = request.getParameter("items2jobcat");
String  items2group = request.getParameter("items2group");
String  items2type = request.getParameter("items2type");
String  machine_name = request.getParameter("machine_name");
String  ip_address = request.getParameter("ip_address");
String  login_user = request.getParameter("login_user");
String  login_pass = request.getParameter("login_pass");
String  source_path = request.getParameter("source_path");
String  source_filename = request.getParameter("source_filename");
String  doc_status = request.getParameter("doc_status");
String  handover_date = request.getParameter("handover_date");
String  handover_pic = request.getParameter("handover_pic");
String  launch_date = request.getParameter("launch_date");
String  sla_time = request.getParameter("sla_time");
String  sla_date = request.getParameter("sla_date");
String  act_show_time = request.getParameter("act_show_time");
String  act_show_date = request.getParameter("act_show_date");
String  item2groupunit = request.getParameter("item2groupunit");
String  pic_user_id = request.getParameter("pic_user_id");

 
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (items_name.equals("")){
    items_name="NULL";
    validate = false;
    errorMessage += "- Field items name tidak boleh null <br>";
    }
    
    
    String handover_dateVal="";
    if (handover_date.equals("")){
    handover_dateVal="NULL";
    validate = false;
    errorMessage += "- Field Handover Date tidak boleh null <br>";
    }else{
    handover_dateVal="to_timestamp('"+handover_date+"','YYYY-MM-DD HH24:MI')";    
    }
    
    String launch_dateVal="";
    if (launch_date.equals("")){
    handover_dateVal="NULL";
    validate = false;
    errorMessage += "- Field Effective Date tidak boleh null <br>";
    }else{
    launch_dateVal="to_timestamp('"+launch_date+"','YYYY-MM-DD HH24:MI')";    
    }
    
    
    String SLA = "";
    String ShowTime="";
    if (items2jobcat.equals("1")) {
        SLA=sla_time;
        ShowTime=act_show_time;
        
    }else{
        SLA=sla_date;
        ShowTime=act_show_date;
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
                sql = "insert into "+tableName+" ("
                    +"id, ITEMS_NAME, ITEMS2JOBCAT, ITEMS2GROUP, ITEMS2TYPE, MACHINE_NAME, IP_ADDRESS, "
                    + "LOGIN_USER, LOGIN_PASS, SOURCE_PATH, SOURCE_FILENAME, DOC_STATUS, HANDOVER_DATE, HANDOVER_PIC, "
                    + "LAUNCH_DATE, SLA_TIME, STATUS_ITEMS, SYS_CREATION_DATE, TERMINATION_DATE, ACT_SHOW_TIME, INORDER, REPORT_DAY,ITEMS_GROUPING,ITEM2GROUPUNIT,pic_user_id) "
                    +"values (nextval('"+tableNameSeq+"'),"
                    + "'" + items_name + "',"+items2jobcat+","+items2group+","+items2type+",'"+machine_name+"','"+ip_address
                    +"','"+login_user+"','"+login_pass+"','"+source_path+"','"+source_filename+"','"+doc_status+"',"+handover_dateVal+",'"
                    +handover_pic+"',"+launch_dateVal+",'"+SLA+"','1',current_date,null,'"+ShowTime+"',1,1,'"+items_grouping+"',"+item2groupunit+","+pic_user_id+" ) ";
                        
                actionDesc="Add";
                        

                
        
               
                
                 
               }else {
                   
                 sql = "update "+tableName+" SET "  
                 +"items_grouping='"+items_grouping+"',"
                 +"items_name='"+items_name+"',"
                 +"items2jobcat="+items2jobcat+","
                 +"items2group="+items2group+","
                 +"items2type="+items2type+","
                 +"machine_name='"+machine_name+"',"
                 +"ip_address='"+ip_address+"',"
                 +"login_user='"+login_user+"',"
                 +"login_pass='"+login_pass+"',"
                 +"source_path='"+source_path+"',"
                 +"source_filename='"+source_filename+"',"
                 +"doc_status='"+doc_status+"',"
                 +"handover_date="+handover_dateVal+","
                 +"handover_pic='"+handover_pic+"',"
                 +"launch_date="+launch_dateVal+","
                 +"sla_time='"+SLA+"',"
                 +"act_show_time='"+ ShowTime+"',"
                 +"item2groupunit="+ item2groupunit+", "
                 +"pic_user_id="+pic_user_id+" "
                 +" where id="+id;
                 
                 actionDesc="Edit";
                   
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
                    $.ajax({
                        type: 'POST',
                        url: "tracking/items/items_list_data.jsp",
                        data: "id=<%=id%>",
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

