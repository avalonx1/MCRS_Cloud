<%@include file="../../../includes/check_auth_layer3.jsp"%>
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
    
    String name=request.getParameter("name");
    String value=request.getParameter("value");
    
   
    
    
    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
 
    if (name.equals("")){
    validate = false;
    errorMessage += "- Field nama tidak boleh null <br>";
    }
    
    if (value.equals("")){
    validate = false;
    errorMessage += "- Field value tidak boleh null <br>";
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
                sql = "insert into T_PARAM ("
                    +"id, name, value ) "
                    +"values (nextval('t_param_seq'),'"+name+"','"+value+"')";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update T_PARAM SET "
                    +"name='"+name+"',"
                    +"VALUE='"+value+"' "
                    +" where id="+id;
                 
                 actionDesc="Edit";
                   
               }
                //System.out.println(sql);
                
                //out.println(sql);
               
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
                        url: "administration/app_parameter/app_param_list_data.jsp",
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

