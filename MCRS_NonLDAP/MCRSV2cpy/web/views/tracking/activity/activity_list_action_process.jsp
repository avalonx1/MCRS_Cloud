<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
   
    String act_notes = request.getParameter("action_notes");
    String act_status = request.getParameter("action_status");
    String act_send_time = request.getParameter("action_send_time");
    String id = request.getParameter("id");
    
  
    boolean insert = true;
    boolean statcase = true;
    
    String errorMessage = "";
    
    // boolean cact_notes = Pattern.matches("[. ]+", act_notes);
     
    String cleanSpecialChar = act_notes.replaceAll("[^\\w\\s]", "");
    act_notes = cleanSpecialChar;
    
    String pic_main="";
    String item_name="";
    String statusBefore=""; 
    String statusAfter="";
    String requestorEmail="";
    String requestorName="";
    String status_code="";
                        
     
     if (insert) {
        String sql;
        
           try {
            ResultSet resultSet=null;
            ResultSet resultSet2=null;
            Database db = new Database();
            try {
                db.connect(1);
                
                
                sql = "SELECT t_code status_code from t_actstatus where id="+act_status+" ";
                
                resultSet = db.executeQuery(sql);
                while (resultSet.next()) {
                    status_code = resultSet.getString("status_code");
                }
                    
                
               
                sql = "SELECT ACT2USER,ACT_ITEMS_NAME,get_t_actstatus_byid("+act_status+") ACT_STAT,WORK_STARTTIME,"
                        + " pic_main,get_t_actstatus_byid(act2actstatus) ACT_STAT_BEF,REQ_NAME,REQ_EMAIL,b.t_code status_code "
                        + " from T_ACT_HIS a left join t_actstatus b on a.act2actstatus=b.id where a.ID="+id+" ";
                
                if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                    }
                        
                        
                    resultSet = db.executeQuery(sql);
                    while (resultSet.next()) {
                        
                        pic_main=resultSet.getString("pic_main");
                        item_name=resultSet.getString("act_items_name");
                        statusBefore = resultSet.getString("ACT_STAT_BEF"); 
                        statusAfter = resultSet.getString("ACT_STAT");
                        requestorEmail = resultSet.getString("REQ_EMAIL");
                        requestorName = resultSet.getString("REQ_NAME");
                      
                        
                    if ( (v_userLevel.equals("1") || resultSet.getString(1).equals(v_userID)) && statcase ) {

                        if ((status_code.equals("CANCEL") || status_code.equals("PENDINGUSR") || status_code.equals("PENDING") ) && statcase ) {
                        sql = "update T_ACT_HIS set ACT2USER=" + v_userID + ",ACT2ACTSTATUS="+act_status+",ACT_NOTE='['||TO_CHAR(CURRENT_TIMESTAMP,'YYYY/MM/DD HH24:MI:SS')||':"+v_userName+":"+resultSet.getString("ACT_STAT")+": '||'"+act_notes+"'||']'||case when ACT_NOTE is null then ' ' else ACT_NOTE END,"
                                + " SEND_TIME=case when '"+status_code+"'='DONE' then TO_DATE('"+act_send_time+"','YYYY/MM/DD HH24:MI') when '"+status_code+"'='CANCEL' then CURRENT_TIMESTAMP when '"+status_code+"'='PENDINGUSR' then CURRENT_TIMESTAMP else null end,LAST_UPDATE_TIME=CURRENT_TIMESTAMP,PICKUP_STAT=1,DISMISSED_SLA=1,WORK_STARTTIME=(case when WORK_STARTTIME>CURRENT_TIMESTAMP then CURRENT_TIMESTAMP else WORK_STARTTIME end) where ID=" + id + " ";
                           //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        db.executeUpdate(sql);
                        
                        
                        
                        String msgForm="";
                        String msgMail="Status Task has been modified by "+v_userFullName+" from "+statusBefore+" to "+statusAfter;
                                    
                         auth mail = new auth(v_clientIP);
                         try {
                             msgForm=mail.execSendMailNotif(pic_main,item_name,msgMail);
                             } catch (SQLException Sqlex) {
                          out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                          } finally {
                          mail.close();
                          }
                         
                         statcase = false;
                         

                        out.println("<div class=info>Update Activity "+resultSet.getString(2)+" to "+resultSet.getString(3)+" Success.. </div>");
                        
                        }else if (status_code.equals("REVIEW") && statcase ) {
                        sql = "update T_ACT_HIS set ACT2ACTSTATUS="+act_status+",ACT_NOTE='['||TO_CHAR(CURRENT_TIMESTAMP,'YYYY/MM/DD HH24:MI:SS')||':"+v_userName+":"+resultSet.getString("ACT_STAT")+": '||'"+act_notes+"'||']'||case when ACT_NOTE is null then ' ' else ACT_NOTE END,"
                                + " SEND_TIME=case when '"+status_code+"'='DONE' then TO_DATE('"+act_send_time+"','YYYY/MM/DD HH24:MI') when '"+status_code+"'='CANCEL' then CURRENT_TIMESTAMP when '"+status_code+"'='PENDINGUSR' then CURRENT_TIMESTAMP else null end,LAST_UPDATE_TIME=CURRENT_TIMESTAMP,PICKUP_STAT=1,DISMISSED_SLA=1,WORK_STARTTIME=(case when WORK_STARTTIME>CURRENT_TIMESTAMP then CURRENT_TIMESTAMP else WORK_STARTTIME end) where ID=" + id + " ";
                           //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        db.executeUpdate(sql);
                        
                        
                        
                        String msgForm="";
                        String msgMail="Status Task has been modified by "+v_userFullName+" from "+statusBefore+" to "+statusAfter;
                                    
                         auth mail = new auth(v_clientIP);
                         try {
                             msgForm=mail.execSendMailNotif(pic_main,item_name,msgMail);
                             } catch (SQLException Sqlex) {
                          out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                          } finally {
                          mail.close();
                          }
                         
                         statcase = false;
                         

                        out.println("<div class=info>Update Activity "+resultSet.getString(2)+" to "+resultSet.getString(3)+" Success.. </div>");
                        
                        }else if (status_code.equals("DONE") && statcase ) {
                            
                        boolean hasChild = false;
                        sql = " select * from (  "
                            +"WITH RECURSIVE tree AS (SELECT id, act_items_name, parent_id, CAST(act_items_name As varchar(1000)) As name_fullname, STATUS_ID  "
                            +"FROM V_ACT_DAILY WHERE parent_id="+id+" "
                            +"UNION ALL SELECT si.id,si.act_items_name, si.parent_id, CAST(sp.name_fullname || '->' || si.act_items_name As varchar(1000)) As name_fullname,si.STATUS_ID  "
                            +"FROM V_ACT_DAILY As si INNER JOIN tree AS sp ON (si.parent_id = sp.id) ) "
                            +"SELECT id,name_fullname,STATUS_ID FROM tree ORDER BY name_fullname ) a where status_id not in (4,6) ";
                        
                        resultSet2 = db.executeQuery(sql);
                        while (resultSet2.next()) {
                            hasChild = true;
                        }
                        
                        if (!hasChild) {
                            sql = "update T_ACT_HIS set ACT2USER=" + v_userID + ",ACT2ACTSTATUS="+act_status+",ACT_NOTE='['||TO_CHAR(CURRENT_TIMESTAMP,'YYYY/MM/DD HH24:MI:SS')||':"+v_userName+":"+resultSet.getString("ACT_STAT")+": '||'"+act_notes+"'||']'||case when ACT_NOTE is null then ' ' else ACT_NOTE END,"
                                    + "SEND_TIME=case when '"+status_code+"'='DONE' then TO_DATE('"+act_send_time+"','YYYY/MM/DD HH24:MI') when '"+status_code+"'='CANCEL' then CURRENT_TIMESTAMP when '"+status_code+"'='PENDINGUSR' then CURRENT_TIMESTAMP else null end,LAST_UPDATE_TIME=CURRENT_TIMESTAMP,PICKUP_STAT=1,"
                                    + "WORK_STARTTIME=(case when WORK_STARTTIME>CURRENT_TIMESTAMP then CURRENT_TIMESTAMP else WORK_STARTTIME end) where ID=" + id + " ";  
                               //debug mode            
                            if (v_debugMode.equals("1")) {
                            out.println("<div class=sql>"+sql+"</div>");
                            }
                            
                            db.executeUpdate(sql);
                            
                        String msgForm="";
                        String msgMail="";
                        
                                    
                         auth mail = new auth(v_clientIP);
                         try {
                             msgMail="Status Task has been modified by "+v_userFullName+" from "+statusBefore+" to "+statusAfter;
                             msgForm=mail.execSendMailNotif(pic_main,item_name,msgMail);
                             
                             try {
                                //thread to sleep for the specified number of milliseconds
                                Thread.sleep(2000);
                            } catch ( java.lang.InterruptedException ie) {
                                System.out.println(ie);
                            }
                             
                             msgMail="Your task request has been DONE. If you need to verify don't hesitate to contact "+v_userFullName+" by sending an email to "+v_mail ;
                             msgForm=mail.execSendMailNotifToRequester(requestorEmail,requestorName,item_name,msgMail);
                             
                             } catch (SQLException Sqlex) {
                          out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                          } finally {
                          mail.close();
                          }
                         
                        
                            out.println("<div class=info>Update Activity "+resultSet.getString(2)+" to "+resultSet.getString(3)+" Success.. </div>");
                         } else{
                            out.println("<div class=sql>this activity has sub-activity that still open. Please close it first.. </div>");
                        }
                        
                        
                        }else {
                        sql = "update T_ACT_HIS set ACT2USER=" + v_userID + ",ACT2ACTSTATUS="+act_status+",ACT_NOTE='['||TO_CHAR(CURRENT_TIMESTAMP,'YYYY/MM/DD HH24:MI:SS')||':"+v_userName+":"+resultSet.getString("ACT_STAT")+": '||'"+act_notes+"'||']'||case when ACT_NOTE is null then ' ' else ACT_NOTE END,"
                                + "SEND_TIME=case when '"+status_code+"'='DONE' then TO_DATE('"+act_send_time+"','YYYY/MM/DD HH24:MI') when '"+status_code+"'='CANCEL' then CURRENT_TIMESTAMP when '"+status_code+"'='PENDINGUSR' then CURRENT_TIMESTAMP else null end,"
                                + "LAST_UPDATE_TIME=CURRENT_TIMESTAMP,PICKUP_STAT=1,WORK_STARTTIME=(case when WORK_STARTTIME>CURRENT_TIMESTAMP then CURRENT_TIMESTAMP else WORK_STARTTIME end) where ID=" + id + " ";  
                        
                        statcase = false;
                        
                        // out.println(sql);
                           //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                                
                        db.executeUpdate(sql);
                        
                        String msgForm="";
                        String msgMail="Status Task has been modified by "+v_userFullName+" from "+statusBefore+" to "+statusAfter;
                                    
                         auth mail = new auth(v_clientIP);
                         try {
                             msgForm=mail.execSendMailNotif(pic_main,item_name,msgMail);
                             } catch (SQLException Sqlex) {
                          out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
                          } finally {
                          mail.close();
                          }
                         
                        out.println("<div class=info>Update Activity "+resultSet.getString(2)+" to "+resultSet.getString(3)+" Success.. </div>");
                        }
                        
                       
                        
                        
        
                 }else{
                                             
                                out.println("<div class=sql>this id is already pickup by id "+resultSet.getString(1).toString()+" </div>");
                            }
                
                    }
            
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                    if (resultSet != null) resultSet.close(); 
                    if (resultSet2 != null) resultSet2.close(); 
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
      }else {
        out.println("<div class=alert>" + errorMessage + "</div>");
    }
 %>



