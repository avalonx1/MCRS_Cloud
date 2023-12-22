<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_notif_user_role";
    String tableNameSeq=tableName+"_seq";
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
                                  
                                
                                
 String user_id=request.getParameter("user_id");
 String key_data=request.getParameter("key_data");
 String role_id=request.getParameter("role_id");
 
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (user_id.equals("")){
    user_id="NULL";
    validate = false;
    errorMessage += "- Field user tidak boleh null <br>";
    }
    
    if (key_data.equals("")){
    key_data="NULL";
    validate = false;
    errorMessage += "- Field burst Key tidak boleh null <br>";
    }
    
       
    if (role_id.equals("")){
    role_id="NULL";
    validate = false;
    errorMessage += "- Field role_id tidak boleh null <br>";
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
                    +"id, user_id,burst_key,role_id,maker_userid,maker_dt_stamp,maker_tag,modified_userid,modified_dt_stamp,record_stat) "
                    +"values (nextval('"+tableNameSeq+"'),"
                        + " "+user_id+","
                        + "$$"+key_data+"$$,"
                        + ""+role_id+","
                        + " "+v_userID+","
                        + " current_timestamp,"
                        + " 'APPLICATION',"
                        + " "+v_userID+","
                        + " current_timestamp,"
                        + " 1 "
                        + " )";
                    
                
                     //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                        
                actionDesc="Add";
                        
               }else {
                   
                   
                 sql = "update "+tableName+" SET "
                     + " user_id="+user_id+","
                        + "burst_key=$$"+key_data+"$$,"
                        + "role_id="+role_id+","
                        + "modified_userid="+v_userID+","
                        + "modified_dt_stamp=current_timestamp "
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
                    
                    filter_itemname= document.getElementById("filter_itemname").value;
                    
                    $("#data").empty();
                    $('#loading').show();
                    $.ajax({
                        type: 'POST',
                        url: "report/emailburst_notif_usrrole/emailburst_notif_usrrole_list_data.jsp",
                        data: {id:<%=id%>,filter_itemname:filter_itemname},
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

