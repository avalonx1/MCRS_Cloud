<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_file_extension";
    String tableNameSeq=tableName+"_seq";
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
  
    String file_extension=request.getParameter("file_extension");
    String case_sensitive=request.getParameter("case_sensitive");
    String tag_code=request.getParameter("tag_code");
  
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (file_extension.equals("")){
    file_extension="NULL";
    validate = false;
    errorMessage += "- Field file_extension tidak boleh null <br>";
    }
    
    if (tag_code.equals("")){
    tag_code="NULL";
    validate = false;
    errorMessage += "- Field tag_code tidak boleh null <br>";
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
                    +"id, file_extension,case_sensitive,tag_code,created_userid,created_time) "
                    +"values (nextval('"+tableNameSeq+"'),'"+file_extension+"',"+case_sensitive+",'"+tag_code+"',"+v_userID+",CURRENT_TIMESTAMP)";
                    
                
                     //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                        
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"file_extension='"+file_extension+"',"
                    +"case_sensitive="+case_sensitive+", "
                    +"tag_code='"+tag_code+"', "
                    +"created_userid="+v_userID+", "
                    +"created_time=CURRENT_TIMESTAMP "
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
                        url: "file_management/extension/ext_list_data.jsp",
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

