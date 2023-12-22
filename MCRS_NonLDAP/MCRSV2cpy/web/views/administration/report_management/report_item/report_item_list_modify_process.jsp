<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String id="0";
    
    String tableName="t_report_item";
    String tableNameSeq=tableName+"_seq";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
 
 String report_code=request.getParameter("report_code");
 String report_name=request.getParameter("report_name");
 String report_description=request.getParameter("report_description");
 String report_extension=request.getParameter("report_extension");
 String document_pathkey=request.getParameter("document_pathkey");
 String report_owner_nik=request.getParameter("report_owner_nik");
 String report_owner_name=request.getParameter("report_owner_name");
 String report_owner_contact=request.getParameter("report_owner_contact");
 String report_owner_dept_id=request.getParameter("report_owner_dept_id");
 String report_launch=request.getParameter("report_launch");
 String report_status=request.getParameter("report_status");
 String report_flag=request.getParameter("report_flag");
 String report_freq_id=request.getParameter("report_freq_id");  
 String report_group_id=request.getParameter("report_group_id"); 
 String uat_date=request.getParameter("uat_date"); 
  String doc_pathkey_id=request.getParameter("doc_pathkey_id"); 
    
    
    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (report_code.equals("")){
    report_code="NULL";
    validate = false;
    errorMessage += "- Field report_code tidak boleh null <br>";
    }
    
    if (report_name.equals("")){
    report_name="NULL";
    validate = false;
    errorMessage += "- Field report_name tidak boleh null <br>";
    }
    
    if (report_description.equals("")){
    report_description="NULL";
    //validate = false;
    errorMessage += "- Field report_description tidak boleh null <br>";
    }
    
    if (report_extension.equals("")){
    report_extension="NULL";
    validate = false;
    errorMessage += "- Field report_extension tidak boleh null <br>";
    }
      
    if (document_pathkey.equals("")){
    document_pathkey="NULL";
    validate = false;
    errorMessage += "- Field Report File Post Key tidak boleh null <br>";
    }
    
    if (report_owner_nik.equals("")){
    report_owner_nik="NULL";
    validate = false;
    errorMessage += "- Field report_owner_nik tidak boleh null <br>";
    }
       
    if (report_owner_name.equals("")){
    report_owner_name="NULL";
    validate = false;
    errorMessage += "- Field report_owner_name tidak boleh null <br>";
    }

    if (report_owner_contact.equals("")){
    report_owner_contact="NULL";
    validate = false;
    errorMessage += "- Field report_owner_contact tidak boleh null <br>";
    }
    
    String report_launchVal="";
    if (report_launch.equals("")){
    report_launchVal="NULL";
    validate = false;
    errorMessage += "- Field Publish Date tidak boleh null <br>";
    }else{
    report_launchVal="to_timestamp('"+report_launch+"','YYYY-MM-DD HH24:MI')";    
    }
    
    String uat_dateVal="";
    if (uat_date.equals("")){
    uat_dateVal="NULL";
    validate = false;
    errorMessage += "- Field UAT Date tidak boleh null <br>";
    }else{
    uat_dateVal="to_timestamp('"+uat_date+"','YYYY-MM-DD HH24:MI')";    
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
                      +" id,report_code, report_name, report_description, report_extension,document_pathkey,report_owner_nik,"
                      +" report_owner_name,report_owner_contact,report_owner_dept_id,report_launch,report_status, "
                      +" report_flag,report_freq_id,report_group_id,report_download,report_view,uat_date,doc_pathkey_id) " 
                      +" values (nextval('"+tableNameSeq+"'),"
                      + "'"+report_code+"',"
                      + "'"+report_name+"',"
                      + "'"+report_description+"',"
                      + "'"+report_extension+"',"
                      + "'"+document_pathkey+"',"
                      + "'"+report_owner_nik+"',"  
                      + "'"+report_owner_name+"',"
                      + "'"+report_owner_contact+"',"
                      + " "+report_owner_dept_id+","
                      + " "+report_launchVal+","  
                      + " "+report_status+","  
                      + " "+report_flag+","  
                      + " "+report_freq_id+", "
                      + " "+report_group_id+", "
                      + " 0,0,"
                      + " "+uat_dateVal+", "  
                      + " "+doc_pathkey_id+" "  
                      + " )";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +" report_code="  +"'"+report_code+"',"
                    +" report_name="  + "'"+report_name+"',"
                    +" report_description="  + "'"+report_description+"',"
                    +" report_extension="  + "'"+report_extension+"',"
                    +" document_pathkey="  + "'"+document_pathkey+"',"
                    +" report_owner_nik="  + "'"+report_owner_nik+"',"  
                    +" report_owner_name="  + "'"+report_owner_name+"',"
                    +" report_owner_contact="  + "'"+report_owner_contact+"',"
                    +" report_owner_dept_id="  + " "+report_owner_dept_id+","
                    +" uat_date="+ " "+uat_dateVal+","  
                    +" report_launch="  + " "+report_launchVal+"," 
                    +" report_status="  + " "+report_status+","  
                    +" report_flag="  + " "+report_flag+","  
                    +" report_freq_id="  + " "+report_freq_id+", "
                    +" report_group_id="  + " "+report_group_id+", "
                    +" doc_pathkey_id="  + " "+doc_pathkey_id+" "
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
                        url: "administration/report_management/report_item/report_item_list_data.jsp",
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

