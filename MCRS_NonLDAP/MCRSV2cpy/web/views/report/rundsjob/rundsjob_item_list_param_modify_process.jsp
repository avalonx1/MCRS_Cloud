<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%  
              
    String id = request.getParameter("id");
    String etljob_run = request.getParameter("etljob_run");
    String etljob_param = request.getParameter("etljob_param");
    String RunType = request.getParameter("RunType");
    
    String RunTypeName = "";
    
                     if (RunType.equals("1")) {   
                     RunTypeName="QA";
                     } else {
                     RunTypeName="USR";
                     }
                     
    String tableName="t_rundsjob_item_log";
    String tableNameSeq=tableName+"_seq";
    String id_log  = "0";
    
    String sql;
    String fileid = "0";
                
        try {
            ResultSet resultSet = null;
            Database db = new Database();
            try {
                db.connect(1);
                
                boolean statRun = true;
                sql = "select status_process from "+tableName+" where id_dsjob="+id+" and status_process in (1,2)";
                resultSet = db.executeQuery(sql);
                
                while (resultSet.next()){
                statRun = true;
                }
                
                if (statRun) {
              
                    
                     
                    sql = "insert into "+tableName+" ("
                      +" id,id_dsjob, tag_code, created_userid, created_time,"
                      +" run_info,status_process,status_info ) " 
                      +" values (nextval('"+tableNameSeq+"'),"
                      + ""+id+","
                      + "'RUNDSJOB-"+RunTypeName+"',"
                      + ""+v_userID+","
                      + "CURRENT_TIMESTAMP,"                   
                      + "'"+etljob_run+" "+etljob_param+"',"
                      + "1,"
                      + "'Connecting to ETL Job..' "
                      + " )";
                    
                    
                 db.executeUpdate(sql);
                //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>SQL : "+sql+" </div>");
                        out.println("<div class=sql> execute DS Job :"+etljob_run+" ID:"+id+" PARAM:"+etljob_param+" </div>");
                        }
                        
                      
                
                        
                
                sql = "select max(id) as id from "+tableName+" where id_dsjob="+id+" and status_process=1 and created_userid="+v_userID+" ";
                resultSet = db.executeQuery(sql);
                
                while (resultSet.next()){
                id_log = resultSet.getString("id");
                }
                
                String RPT_TYPE_QA="";
               //runjob  
                    auth runScript = new auth(v_clientIP);
                    try {
                        
                     if (RunType.equals("1")) {   
                     RPT_TYPE_QA=runScript.getParamValue("ADHRPT_RPT_TYPE_QA");
                     } else {
                     RPT_TYPE_QA=runScript.getParamValue("ADHRPT_RPT_TYPE_USR");    
                     }
                     
                     runScript.execRunDsJob(id_log,etljob_run,etljob_param,RPT_TYPE_QA);
                     } catch (SQLException Sqlex) {
                     out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                     } 
                    catch (IOException ioex) {
                     out.println("<div class=sql>" + ioex.getMessage() + "</div>");
                     }
                    finally {
                     runScript.close();
                     }
                    
                out.println("<div class=info> Run ETL "+etljob_run+" ID "+id+" PARAM:"+etljob_param+" success..</div>");
                    
                
                }
                
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                    if (resultSet != null) resultSet.close(); 
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
%>
<script type="text/javascript">
 
    
    $.ajax({
        type: 'POST',
        url: "report/rundsjob/rundsjob_item_list_data_log.jsp",
        data: {id:<%=id%>},
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