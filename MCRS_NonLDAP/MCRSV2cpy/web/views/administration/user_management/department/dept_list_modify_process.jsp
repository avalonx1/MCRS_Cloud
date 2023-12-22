<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_department";
    String tableNameSeq=tableName+"_seq";
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String dept_code=request.getParameter("dept_code");
    String dept_name=request.getParameter("dept_name");
    String dept_description=request.getParameter("dept_description");
    String div_id=request.getParameter("div_id");
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (dept_code.equals("")){
    dept_code="NULL";
    validate = false;
    errorMessage += "- Field dept_code tidak boleh null <br>";
    }
    
    if (dept_name.equals("")){
    dept_name="NULL";
    validate = false;
    errorMessage += "- Field dept_name tidak boleh null <br>";
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
                    +"id, dept_code,dept_name,dept_description,div_id) "
                    +"values (nextval('"+tableNameSeq+"'),'"+dept_code+"','"+dept_name+"','"+dept_description+"',"+div_id+" )";
                    
                
                     //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                        
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"dept_code='"+dept_code+"',"
                    +"dept_name='"+dept_name+"', "
                    +"dept_description='"+dept_description+"', "
                    +"div_id="+div_id+" "
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
                        url: "administration/user_management/department/dept_list_data.jsp",
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

