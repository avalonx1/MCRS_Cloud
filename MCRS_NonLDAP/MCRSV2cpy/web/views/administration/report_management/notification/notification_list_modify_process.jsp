<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_notification";
    String seqTableName=tableName+"_seq";
    
    String tableName2="t_view_menu";
    String seqTableName2=tableName2+"_seq";
    
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String group_id=request.getParameter("group_id");
    String level_id=request.getParameter("level_id");
    String message=request.getParameter("message");
    String inorder=request.getParameter("inorder");
    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
   
    
    if (message.equals("")){
    message="NULL";
    validate = false;
    errorMessage += "- Field message tidak boleh null <br>";
    }
    
    if (inorder.equals("")){
    inorder="NULL";
    validate = false;
    errorMessage += "- Field inorder tidak boleh null <br>";
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
                    +"id, group_id,level_id,message,inorder,status,userid,created_time) "
                    +"values ( "
                    + "nextval('"+seqTableName+"'),"
                    + "'"+group_id+"',"
                    + "'"+level_id+"', "
                    + "'"+message+"', "
                    + " "+inorder+", "
                    + " 1, "
                    + " "+v_userID+", "
                    + " CURRENT_TIMESTAMP " 
                    + " )";
                    
                actionDesc="Add";
                        
              
                 db.executeUpdate(sql);
                 
                 
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"group_id='"+group_id+"',"
                    +"level_id='"+level_id+"', "
                    +"message='"+message+"', "
                    +"inorder='"+inorder+"', "
                    +"userid='"+v_userID+"', "
                    +"created_time=CURRENT_TIMESTAMP "
                    +" where id="+id;
                 
                 actionDesc="Edit";
                   
                  db.executeUpdate(sql);
               }
               
               
               //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
               
                out.println("<div class=info>"+actionDesc+" "+formName+" Success<br></div>");
                
                 %>
                <script type="text/javascript">
                    
                     filter_itemname= document.getElementById("filter_itemname").value;
                     
                    $("#data").empty();
                    $('#loading').show();
                    $.ajax({
                        type: 'POST',
                        url: "administration/report_management/notification/notification_list_data.jsp",
                        data: {id:<%=id%>,
                                filter_itemname:filter_itemname
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

