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
    
    String journal_name=request.getParameter("journal_name");
    String journal_desc=request.getParameter("journal_desc");
    String reverse_flag=request.getParameter("reverse_flag");
    String adj_flag=request.getParameter("adj_flag");
    String trn_dt=request.getParameter("trn_dt");
 
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (journal_name.equals("")){
    journal_name="NULL";
    validate = false;
    errorMessage += "- Field journal_name tidak boleh null <br>";
    }
    
    if (journal_desc.equals("")){
    journal_desc="NULL";
    validate = false;
    errorMessage += "- Field journal_desc tidak boleh null <br>";
    }
    
    
    String trn_dtVal="";
    if (trn_dt.equals("")){
    trn_dtVal="NULL";
    validate = false;
    errorMessage += "- Field trn_dt tidak boleh null <br>";
    }else{
    trn_dtVal="to_timestamp('"+trn_dt+"','YYYY-MM-DD HH24:MI')";    
    }
    
    
  
 
    
    if (validate) {
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                String sql;
                
                String filename = "";
                sql = "select doc_path_key from t_journal_adjust_file where id="+id+" ";
                resultSet = db.executeQuery(sql);
                
                while (resultSet.next()) {
                filename = resultSet.getString("doc_path_key");
                }
                
                //out.println("<div class=info>" +cabangGroupID +username+ "</div>");
                
               if (actionCode.equals("ADD")) {
                sql = "insert into t_journal_adjust_file ("
                    +"id, journal_name,journal_desc,reverse_flag,adj_flag,trn_dt,status_process,status_desc) "
                    +"values (nextval('t_journal_adjust_file_seq'),"
                        + "'"+journal_name+"',"
                        + "'"+journal_desc+"',"
                        + ""+reverse_flag+","
                        + "'"+adj_flag+"',"
                        + ""+trn_dtVal+",0,'File Ready' )";
                    
                actionDesc="Add";
                
  
               }else {
                   
                 sql = "update t_journal_adjust_file SET "
                    +"journal_name='"+journal_name+"',"
                    +"journal_desc='"+journal_desc+"', "
                    +"reverse_flag="+reverse_flag+", "
                    +"adj_flag='"+adj_flag+"', "
                    +"trn_dt="+trn_dtVal+", "
                    +"status_process=1, "
                    +"status_desc='Connecting to ETL Job..' "
                    +" where id="+id;
                 
                 actionDesc="Edit";
                     
                 
                 
                //remove file system
                
                
                //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql> filename deleted :"+filename+" </div>");
                        }
                        
                
                 String execScript="";
                 auth runScript = new auth(v_clientIP);
                    try { 

                     runScript.execRunDsJob(id); 

                     } catch (SQLException Sqlex) {
                     out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                     } 
                    catch (IOException ioex) {
                     out.println("<div class=sql>" + ioex.getMessage() + "</div>");
                     }
                    finally {
                     runScript.close();
                     }
                    
                 
                 
                 
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
                        url: "file_management/journal_adjust/journal_adjust_list_data.jsp",
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

