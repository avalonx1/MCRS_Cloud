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
    
    String div_code=request.getParameter("div_code");
    String div_name=request.getParameter("div_name");
    String div_description=request.getParameter("div_description");
 
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (div_code.equals("")){
    div_code="NULL";
    validate = false;
    errorMessage += "- Field div_code tidak boleh null <br>";
    }
    
    if (div_name.equals("")){
    div_name="NULL";
    validate = false;
    errorMessage += "- Field div_name tidak boleh null <br>";
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
                sql = "insert into t_division ("
                    +"id, div_code,div_name,div_description) "
                    +"values (nextval('t_division_seq'),'"+div_code+"','"+div_name+"','"+div_description+"' )";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update t_division SET "
                    +"div_code='"+div_code+"',"
                    +"div_name='"+div_name+"', "
                    +"div_description='"+div_description+"' "
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
                        url: "administration/user_management/division/div_list_data.jsp",
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

