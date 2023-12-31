<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String report_id=request.getParameter("report_id");
    String report_date_start=request.getParameter("report_date_start");
    String report_date_end=request.getParameter("report_date_end");
    String record_stat=request.getParameter("record_stat");
   
    
    
    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    String report_date_startVal="";
    if (report_date_start.equals("")){
    report_date_startVal="NULL";
    validate = false;
    errorMessage += "- Field report_date_start tidak boleh null <br>";
    }else{
    report_date_startVal="to_timestamp('"+report_date_start+"','YYYY-MM-DD HH24:MI')";    
    }
    
     String report_date_endVal="";
    if (report_date_start.equals("")){
    report_date_endVal="NULL";
    validate = false;
    errorMessage += "- Field report_date_start tidak boleh null <br>";
    }else{
    report_date_endVal="to_timestamp('"+report_date_end+"','YYYY-MM-DD HH24:MI')";    
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
                   
                    sql = "delete from t_report_item_hide where report_id="+report_id+" and report_date_start="+report_date_startVal+" "
                           + "and report_date_end="+report_date_endVal+" and record_stat="+record_stat+" ";
                       
                       db.executeUpdate(sql);
                       
                    sql = "insert into t_report_item_hide ("
                        +"id, report_id, report_date_start,report_date_end,record_stat) "
                        +"values (nextval('t_report_item_hide_seq'),"+report_id+","+report_date_startVal+","+report_date_endVal+","+record_stat+" )";

                actionDesc="Add";
                        
               }else {
                   
                 sql = "update t_report_item_hide SET "
                    +"report_id='"+report_id+"',"
                    +"report_date_start="+report_date_startVal+", "
                    +"report_date_end="+report_date_endVal+", "
                    +"record_stat="+record_stat+" "
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
                        url: "administration/report_management/hide_report/hide_report_list_data.jsp",
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

