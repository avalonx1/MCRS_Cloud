
<%@include file="../../../includes/check_auth_layer2.jsp"%>
<%
               
    String itemname = request.getParameter("itemname");
    String itemCat = request.getParameter("itemCat");
    String itemgroup = request.getParameter("itemgroup");
    String itemtype = request.getParameter("itemtype");
    String itemmachine = request.getParameter("itemmachine");
    String ipaddr = request.getParameter("ipaddr");
    String loginuser = request.getParameter("loginuser");
    String loginpass = request.getParameter("loginpass");
    String sourcepath = request.getParameter("sourcepath");
    String scriptname = request.getParameter("scriptname");
    String docstatus = request.getParameter("docstatus");
    String handoverdate = request.getParameter("handoverdate");
    String handoverpic = request.getParameter("handoverpic");
    String launchdate = request.getParameter("launchdate");
    String sla_time = request.getParameter("sla_time");
    String sla_date = request.getParameter("sla_date");
    String item_showtime = request.getParameter("item_showtime");
    String item_showdate = request.getParameter("item_showdate");
    String inorder = request.getParameter("inorder");
    String report_day = request.getParameter("report_day");
    String itemStatus = request.getParameter("itemStatus");
    String itemGroupUnit = request.getParameter("itemgroupunit");
    String itemgrouping = request.getParameter("itemgrouping");
 




    boolean insert = true;
    String errorMessage = "";

    boolean cslatime = Pattern.matches("[\\d]+", sla_time);
    boolean csladate = Pattern.matches("[\\d]+", sla_date);
    boolean citem_showtime = Pattern.matches("[\\d]+", item_showtime);
    boolean citem_showdate = Pattern.matches("[\\d]+", item_showdate);
    
    
    boolean cipaddr = Pattern.matches("([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){1,3}(:\\d{1,3})?|", ipaddr);
    //boolean cemail = Pattern.matches("(([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})+)*$|", email);
    //out.println(sla_time+"-"+sla_date);

    
    
    if (itemname.equals("")) {
        insert = false;
        errorMessage += "-Field itemname must be filled! not null. <br>";
    }
    
    if (!sla_time.equals("")) {
    if (!cslatime) {
        insert = false;
        errorMessage += "-Field SLA must be filled with alpha numeric (XX), your type :"+sla_time+"<br>";
    }
    }
    
    if (!sla_date.equals("")) {
    if (!csladate) {
        insert = false;
        errorMessage += "-Field SLA must be filled with alpha numeric (XX), your type :"+sla_date+"<br>";
    }
    }
    
    
    
    if (!item_showtime.equals("")) {
    if (!citem_showtime) {
        insert = false;
        errorMessage += "-Field show time must be filled with alpha numeric (XX), your type :"+item_showtime+" <br>";
    }
    }
    
    if (!item_showdate.equals("")) {
    if (!citem_showdate) {
        insert = false;
        errorMessage += "-Field show time must be filled with alpha numeric (XX),your type :"+item_showdate+"<br>";
    }
    }

    if (!ipaddr.equals("")) {
    if (!cipaddr) {
        insert = false;
        errorMessage += "-Field IP address must be filled with proper standar {xxx.xxx.xxx.xxx} ,your type :"+ipaddr+"<br>";
    }
    }
    
    String SLA = "";
    String ShowTime="";
    if (itemCat.equals("1")) {
        SLA=sla_time;
        ShowTime=item_showtime;
        
    }else{
        SLA=sla_date;
        ShowTime=item_showdate;
    }
        

    if (insert) {
        try {
            Database db = new Database();
            try {
                db.connect(1);
                String sql;

                sql = "insert into t_items(id, ITEMS_NAME, ITEMS2JOBCAT, ITEMS2GROUP, ITEMS2TYPE, MACHINE_NAME, IP_ADDRESS, "
                        + "LOGIN_USER, LOGIN_PASS, SOURCE_PATH, SOURCE_FILENAME, DOC_STATUS, HANDOVER_DATE, HANDOVER_PIC, "
                        + "LAUNCH_DATE, SLA_TIME, STATUS_ITEMS, SYS_CREATION_DATE, TERMINATION_DATE, ACT_SHOW_TIME, INORDER, REPORT_DAY,ITEMS_GROUPING,ITEM2GROUPUNIT) "
                        + " values (nextval('t_items_seq'),'" + itemname + "',"+itemCat+","+itemgroup+","+itemtype+",'"+itemmachine+"','"+ipaddr
                        +"','"+loginuser+"','"+loginpass+"','"+sourcepath+"','"+scriptname+"','"+docstatus+"',to_date('"+handoverdate+"','YYYY/MM/DD'),'"
                        +handoverpic+"',to_date('"+launchdate+"','YYYY/MM/DD'),'"+SLA+"','"+itemStatus+"',current_date,'','"+ShowTime+"','"+inorder+"','"+report_day+"','"+itemgrouping+"',"+itemGroupUnit+") ";
                        
                db.executeUpdate(sql);
                
                     //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                //out.println(sql);
                out.println("<div class=info>Create Item  " + itemname + " Success <br></div>");
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
        url: "tracking/items/item_list_data.jsp",
        data: "",
        success: function(data) {
            $("#data_inner").empty();
            $('#data_inner').html(data);
            $("#data_inner").show();
            $("#status_msg").delay(3000).hide(400);
                  
        },
        complete: function(){
            $('#loading').hide();
            
        }
    })
    
</script>


