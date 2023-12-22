<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String id="0";
    String tableName="t_report_pathkey";
    String tableNameSeq=tableName+"_seq";
    
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String doc_path_key=request.getParameter("doc_path_key");
   
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (doc_path_key.equals("")){
    doc_path_key="NULL";
    validate = false;
    errorMessage += "- Field doc_path_key tidak boleh null <br>";
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
                    +"id, doc_path_key,created_time,created_userid) "
                    +"values (nextval('"+tableNameSeq+"'),"
                        + "'"+doc_path_key+"',"
                        + "CURRENT_TIMESTAMP,"
                        + " "+v_userID+" "
                        + " )";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"doc_path_key='"+doc_path_key+"',"
                    +"created_time=CURRENT_TIMESTAMP, "
                    +"created_userid='"+v_userID+"' "
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
                        url: "administration/report_management/report_pathkey/report_pathkey_list_data.jsp",
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

