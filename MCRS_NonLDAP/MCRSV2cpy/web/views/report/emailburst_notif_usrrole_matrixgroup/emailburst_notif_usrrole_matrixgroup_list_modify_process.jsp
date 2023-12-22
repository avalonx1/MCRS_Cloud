<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_notif_role_matrix_usrgroup";
    String tableNameSeq=tableName+"_seq";
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
                                  
                                
                                
 String role_id=request.getParameter("role_id");
 String level_id=request.getParameter("level_id");
 String group_id=request.getParameter("group_id");

 
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (role_id.equals("")){
    role_id="NULL";
    validate = false;
    errorMessage += "- Field Role tidak boleh null <br>";
    }
    
    if (group_id.equals("")){
    group_id="NULL";
    validate = false;
    errorMessage += "- Field User Group tidak boleh null <br>";
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
                    +"id, id_role,id_user_group,id_user_level,maker_userid,maker_dt_stamp,maker_tag,modified_userid,modified_dt_stamp,record_stat) "
                    +"values (nextval('"+tableNameSeq+"'),"
                        + " "+role_id+","
                        + " "+group_id+","
                        + " "+level_id+","
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
                     + " id_role="+role_id+","
                        + "id_user_group="+group_id+","
                        + "id_user_level="+level_id+","
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
                        url: "report/emailburst_notif_usrrole_matrixgroup/emailburst_notif_usrrole_matrixgroup_list_data.jsp",
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

