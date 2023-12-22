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
    
    String fileid=request.getParameter("fileid");
    String userid=request.getParameter("userid");
    
 
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    
  
 
    
    if (validate) {
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                String sql;
                
                //out.println("<div class=info>" +cabangGroupID +username+ "</div>");
                
               if (actionCode.equals("ADD")) {
                sql = "insert into t_usr_file_share_recipient ("
                    +"id, fileid,userid,created_time) "
                    +"values (nextval('t_usr_file_share_recipient_seq'),"+fileid+","+userid+",current_timestamp )";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update t_usr_file_share_recipient SET "
                    +"fileid='"+fileid+"',"
                    +"userid='"+userid+"', "
                    +"created_time=current_timestamp "
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
                        url: "report/file_share/share/share_list_data.jsp",
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

