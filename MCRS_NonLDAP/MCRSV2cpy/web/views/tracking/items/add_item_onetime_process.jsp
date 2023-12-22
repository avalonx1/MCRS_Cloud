
<%@include file="../../../includes/check_auth_layer2.jsp"%>

<%
        
    String creator = (String) session.getAttribute("session_username");
    
    String activityname = request.getParameter("activityname");
    String itemname = request.getParameter("itemname");
    String sla_date = request.getParameter("sla_date");
    String inorder = request.getParameter("inorder");
    String additional_info = request.getParameter("additional_info");
    String work_starttime = request.getParameter("work_starttime");
    String req_starttime = request.getParameter("req_starttime");
    String ticket_number = request.getParameter("ticket_number");
    String priority = request.getParameter("priority");
    String importance = request.getParameter("importance");
    String weight = request.getParameter("weight");
    
   
    String requestor_name = request.getParameter("requestor_name");
    String requestor_div = request.getParameter("requestor_div");
    String requestor_email = request.getParameter("requestor_email");
    String pic_ba = request.getParameter("pic_ba");
    String pic_rpt_dev = request.getParameter("pic_rpt_dev");
    String pic_etl_dev = request.getParameter("pic_etl_dev");
      
                    
            
    boolean insert = true;
    String errorMessage = "";

    
    boolean csladate = Pattern.matches("[\\d/: ]+", sla_date);
    boolean cactivityname = Pattern.matches("[\\w\\s\\,\\.\\-\\*\\(\\)\\+\\:\\&\\/ ]+", activityname);
    //boolean cadditional_info = Pattern.matches("[\\w\\s\\,\\.\\-\\*\\(\\)\\+\\:\\&\\/\\? ]+", additional_info);
    boolean cwork_starttime = Pattern.matches("[\\d/: ]+", work_starttime);
    boolean creq_starttime = Pattern.matches("[\\d/: ]+", req_starttime);
    boolean crequestor_email = Pattern.matches("(([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})+)*$|", requestor_email);
    
   
    
    if (activityname.equals("")) {
        insert = false;
        errorMessage += "-Field activityname must be filled! not null. <br>";
    }
    
    if (!cactivityname) {
        insert = false;
        errorMessage += "-Field activityname must be filled with alpha numeric only [A-Z,0-9,-*,. ]<br>";
    }
    
    
    if (!csladate) {
        insert = false;
        errorMessage += "-Field SLA must be filled with with format date YYYY/MM/DD HH24:MI:SS <br>";
    }
    
    if (!requestor_email.equals("")) {
    if (!crequestor_email) {
        insert = false;
        errorMessage += "-Field Requestor Email must be filled with email standar { ex: xxx@xxx.xxx }<br>";
    }
    }
    
    /*
    if (!additional_info.equals("")) {
    if (!cadditional_info) {
        insert = false;
        errorMessage += "-Field Additional Info must be filled with alpha numeric a-zA-Z0-9,.* <br>";
    }
    } 
    */
    
    
    
    
    if (!cwork_starttime) {
        insert = false;
        errorMessage += "-Field Work Start Time must be filled with format date YYYY/MM/DD HH24:MI:SS <br>";
    }
    
    if (!creq_starttime) {
        insert = false;
        errorMessage += "-Field Request Date Time must be filled with format date YYYY/MM/DD HH24:MI:SS <br>";
    }
    
   
    if (insert) {
        try {
            Database db = new Database();
            try {
                db.connect();
                String sql;

                sql = "insert into T_ACT_HIS(objid, ACT_DATE, ACT_ITEMS_NAME,ACT2ITEMS,LAST_UPDATE_TIME,ACT2ACTSTATUS,"
                        + " ACT2USER,ADDL_INFO,INORDER,TICKET_NUMBER,ACT2PRIORITY,ACT2IMPORTANCE,ACT_WEIGHT,ACT_AUTH,REQ_NAME,REQ_EMAIL,REQ_DIVISION,PIC_BA,PIC_ETL_DEV,PIC_RPT_DEV,"
                        + "ACT_SLA_TARGET,ACT_SLA_NOTIF,ACT_DATE_TIME,PICKUP_STAT,DISMISSED_SLA,CREATE_TIME,WORK_STARTTIME,REQUEST_DATETIME ) "
                        + " values (t_act_his_seq.NEXTVAL,to_char(to_date('"+work_starttime+"','YYYY/MM/DD HH24:MI'),'YYYYMMDD'),'"+activityname+"',"+itemname+",sysdate,1, "
                        +pic_ba+",q'["+additional_info+"]','"+inorder+"','"+ticket_number+"',"+priority+","+importance+","+weight+",'N','"+requestor_name+"','"+requestor_email+"','"+requestor_div+"',  "
                        +pic_ba+","+pic_rpt_dev+","+pic_etl_dev+", "; 

                       if (sla_date.equals("")) {
                        sql += " '','', ";
                        } else {
                        sql += " to_date('"+sla_date+"','YYYY/MM/DD HH24:MI'), "
                                + " to_date('"+sla_date+"','YYYY/MM/DD HH24:MI')-((3*60*60)/(24*60*60)),";
                        }
                
                sql += " sysdate,0,0,sysdate,to_date('"+work_starttime+"','YYYY/MM/DD HH24:MI'),to_date('"+req_starttime+"','YYYY/MM/DD HH24:MI') )";
                      
                //out.println(sql);                 
                db.executeUpdate(sql);
                
                
                out.println("<div class=info>Create New Activity  " + activityname + " Success <br></div>");
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
    } else {
        out.println("<div class=alert>" + errorMessage + "</div>");
    }
    
  %>  
    
<script type="text/javascript">
 
    $.ajax({
        type: 'POST',
        url: "activity/items/add_item_onetime.jsp",
        data: "",
        success: function(data) {
            $("#data").empty();
            $('#data').html(data);
            $("#data").show();
            //$("#status_msg").delay(3000).hide(400);
                  
        },
        complete: function(){
            $('#loading').hide();
            
        }
    })
    
</script>



