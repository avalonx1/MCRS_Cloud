<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String id="0";
    
    String tableName="t_rundsjob_item";
    String tableNameSeq=tableName+"_seq";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
 
 String job_code=request.getParameter("job_code");
 String job_name=request.getParameter("job_name");
 String job_desc=request.getParameter("job_desc");
 
 String groupid=request.getParameter("groupid");
 String etljob_runqa=request.getParameter("etljob_runqa");
 String etljob_runusr=request.getParameter("etljob_runusr");
 String etljob_param_desc=request.getParameter("etljob_param_desc");

    
    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (job_code.equals("")){
    job_code="NULL";
    validate = false;
    errorMessage += "- Field job code tidak boleh null <br>";
    }
    
    if (job_name.equals("")){
    job_name="NULL";
    validate = false;
    errorMessage += "- Field job name tidak boleh null <br>";
    }
    
    if (job_desc.equals("")){
    job_desc="NULL";
    validate = false;
    errorMessage += "- Field job description tidak boleh null <br>";
    }
    
    if (etljob_runqa.equals("")){
    etljob_runqa="NULL";
    validate = false;
    errorMessage += "- Field ETL Job QA tidak boleh null <br>";
    }
    
    if (etljob_runusr.equals("")){
    etljob_runusr="NULL";
    validate = false;
    errorMessage += "- Field ETL Job User tidak boleh null <br>";
    }
    
    
    if (etljob_param_desc.equals("")){
    etljob_param_desc="NULL";
    validate = false;
    errorMessage += "- Field ETL Job Param Desc tidak boleh null <br>";
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
                      +" id,job_code, job_name, job_desc,groupid,"
                      +" created_time,created_userid,record_status,etljob_runqa,etljob_runusr,etljob_param_desc ) " 
                      +" values (nextval('"+tableNameSeq+"'),"
                      + "'"+job_code+"',"
                      + "'"+job_name+"',"
                      + "'"+job_desc+"',"
                      + ""+groupid+","  
                      + "CURRENT_TIMESTAMP,"
                      + " "+v_userID+","
                      + "1,"
                      + "'"+etljob_runqa+"', "
                      + "'"+etljob_runusr+"', "
                      + "'"+etljob_param_desc+"' "
                      + " )";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +" job_code="  +"'"+job_code+"',"
                    +" job_name="  + "'"+job_name+"',"
                    +" job_desc="  + "'"+job_desc+"',"
                    +" etljob_runqa="  + "'"+etljob_runqa+"',"
                    +" etljob_runusr="  + "'"+etljob_runusr+"',"
                    +" etljob_param_desc="  + "'"+etljob_param_desc+"',"
                    +" groupid="+groupid+" "  
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
                     filter_groupid= document.getElementById("filter_groupid").value;
                     filter_record_status= document.getElementById("filter_record_status").value;
                     
                     
                    $("#data").empty();
                    $('#loading').show();
                    $.ajax({
                        type: 'POST',
                        url: "report/rundsjob/rundsjob_item_list_data.jsp",
                        data: {id:<%=id%>,filter_itemname:filter_itemname,filter_groupid:filter_groupid,filter_record_status:filter_record_status},
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

