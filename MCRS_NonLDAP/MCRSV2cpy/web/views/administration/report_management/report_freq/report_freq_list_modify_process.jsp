<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String id="0";
    String tableName="t_report_freq";
    String tableNameSeq=tableName+"_seq";
    
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String freq_code=request.getParameter("freq_code");
    String freq_name=request.getParameter("freq_name");
    String freq_description=request.getParameter("freq_description");
    String document_pathkey=request.getParameter("document_pathkey");
    String record_stat=request.getParameter("record_stat");
 
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (freq_code.equals("")){
    freq_code="NULL";
    validate = false;
    errorMessage += "- Field freq_code tidak boleh null <br>";
    }
    
    if (freq_name.equals("")){
    freq_name="NULL";
    validate = false;
    errorMessage += "- Field freq_name tidak boleh null <br>";
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
                    +"id, freq_code,freq_name,freq_description,document_pathkey,record_stat) "
                    +"values (nextval('"+tableNameSeq+"'),"
                        + "'"+freq_code+"',"
                        + "'"+freq_name+"',"
                        + "'"+freq_description+"',"
                        + "'"+document_pathkey+"', "
                        + "1)";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"freq_code='"+freq_code+"',"
                    +"freq_name='"+freq_name+"', "
                    +"freq_description='"+freq_description+"', "
                    +"document_pathkey='"+document_pathkey+"' "
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
                        url: "administration/report_management/report_freq/report_freq_list_data.jsp",
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

