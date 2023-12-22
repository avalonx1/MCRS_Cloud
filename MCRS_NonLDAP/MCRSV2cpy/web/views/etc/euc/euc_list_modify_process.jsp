<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_euc";
    String tableNameSeq=tableName+"_seq";
    
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
 String euc_name=request.getParameter("euc_name");
 String euc_desc=request.getParameter("euc_desc");
 String euc_purpose=request.getParameter("euc_purpose");
 String euc_type=request.getParameter("euc_type");
 String euc_status=request.getParameter("euc_status");
 String euc_userpic=request.getParameter("euc_userpic");
 String euc_dev_cat=request.getParameter("euc_dev_cat");
 String euc_dev_info=request.getParameter("euc_dev_info");
 String euc_dev_start=request.getParameter("euc_dev_start");
 String euc_dev_end=request.getParameter("euc_dev_end");
 String euc_enduser =request.getParameter("euc_enduser");
    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (euc_name.equals("")){
    euc_name="NULL";
    validate = false;
    errorMessage += "- Field euc name tidak boleh null <br>";
    }
    
    if (euc_desc.equals("")){
    euc_desc="NULL";
    validate = false;
    errorMessage += "- Field euc desc tidak boleh null <br>";
    }
    
       
    if (euc_purpose.equals("")){
    euc_purpose="NULL";
    validate = false;
    errorMessage += "- Field euc purpose tidak boleh null <br>";
    }
    
    
       
    if (euc_enduser.equals("")){
    euc_enduser="NULL";
    validate = false;
    errorMessage += "- Field end user info tidak boleh null <br>";
    }
    
    String euc_dev_startVal="";
    if (euc_dev_start.equals("")){
    euc_dev_startVal="NULL";
    validate = false;
    errorMessage += "- Field Development Start Time tidak boleh null <br>";
    }else{
    euc_dev_startVal="to_timestamp('"+euc_dev_start+"','YYYY-MM-DD HH24:MI')";    
    }
    
    
    String euc_dev_endVal="";
    if (euc_dev_end.equals("")){
    euc_dev_endVal="NULL";
    validate = false;
    errorMessage += "- Field Development End Time tidak boleh null <br>";
    }else{
    euc_dev_endVal="to_timestamp('"+euc_dev_end+"','YYYY-MM-DD HH24:MI')";    
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
                    +"id, euc_name,euc_desc,euc_purpose,euc_type,euc_status,euc_userpic,euc_dev_cat,euc_dev_info,euc_dev_start,euc_dev_end,euc_enduser,created_userid,created_time) "
                    +"values (nextval('"+tableNameSeq+"'),"
                        + " '"+euc_name+"',"
                        + "'"+euc_desc+"',"
                        + "'"+euc_purpose+"',"
                        + " "+euc_type+","
                        + " "+euc_status+","
                        + " "+euc_userpic+","
                        + " "+euc_dev_cat+","
                        + "'"+euc_dev_info+"',"
                        + " "+euc_dev_startVal+", "
                        + " "+euc_dev_endVal+", "
                        + " '"+euc_enduser+"', "
                        + " "+v_userID+", "
                        + " CURRENT_TIMESTAMP "
                        + " )";
                    
                
                     //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                        
                actionDesc="Add";
                        
               }else {
                   
                   
                 sql = "update "+tableName+" SET "
                     + " euc_name='"+euc_name+"',"
                        + "euc_desc='"+euc_desc+"',"
                        + "euc_purpose='"+euc_purpose+"',"
                        + "euc_type="+euc_type+","
                        + "euc_status="+euc_status+","
                        + "euc_userpic="+euc_userpic+","
                        + "euc_dev_cat="+euc_dev_cat+","
                        + "euc_dev_info='"+euc_dev_info+"',"
                        + "euc_dev_start="+euc_dev_startVal+", "
                        + "euc_dev_end="+euc_dev_endVal+", "
                        + "euc_enduser='"+euc_enduser+"' "
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
                        url: "etc/euc/euc_list_data.jsp",
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

