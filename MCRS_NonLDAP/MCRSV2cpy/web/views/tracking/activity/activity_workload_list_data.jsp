<%@include file="../../../includes/check_auth_layer2.jsp"%>
<%
             

    String id = request.getParameter("id");
    String filter_username = request.getParameter("filter_username");
    String filter_status = request.getParameter("filter_status");

    if (id == null) {
            id = "0";
        }
    
   
    if (filter_username == null) {
            filter_username = "";
        }
    if (filter_status == null) {
            filter_status = "Pending Approved";
        }
  
  
 
    int i = 0;
    
    
%>
    

    
<div >
    <div class="titlepages">RANK Top Score based on Running Task</div>
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th>USERNAME</th>
                <th>JML PENDING</th>
                 <th>SCORE</th>
                <th>RANK</th>
                <th></th>
                
            </tr>
        </thead>
        <tbody>

            <%

                String where_c ="";
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;
                       
                        where_c=" user_id<>2 and status_code not in ('DONE','CANCEL') and time_sid <= TO_CHAR(current_timestamp,'YYYYMMDD') "; //should be DONE and CANCEL
                        
                        sql = "select a.*,row_number() over() as INORDER  from ( "+
                        "select username||' - '||username_name as name, count(1) JML,"
                        +"ROUND(cast(sum(score_final) as numeric),2) SCORE, "
                        +"ROUND(cast(sum(case when status_code='DONE' then 1  else 0 end ) / count(1)*100 as numeric),2)||'%' PCT_SCORE "+
                        "from V_ACT_DAILY a "+
                        "where "+where_c+
                        "group by username||' - '||username_name "+
                        "order by SCORE desc "+
                        ") a";
                        
                        
                                                        
                        //out.println(sql);

                        resultSet = db.executeQuery(sql);
                        String rowstate = "even";
                        
                        while (resultSet.next()) {
                            i++;

                            if (i % 2 == 0) {
                                rowstate = "even";
                            } else {
                                rowstate = "odd";
                            }


                            out.println("<tr id=rows_"+resultSet.getString(1)+" class=" + rowstate + "> ");
                            
                                                                               
                                                   
                             out.println("<td width=10px> " + resultSet.getString("NAME") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("JML") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("SCORE") + " </td>"); 
                             out.println("<td width=10px> " + resultSet.getString("INORDER") + " </td>");
                             out.println("<td></td>");
                            out.println("</tr> ");
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
        </tbody>
        <tfoot>
            <tr>
         
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                
            </tr>
        </tfoot>
    </table>
</div>



   
<div >
    <div class="titlepages">RANK Top Score Based on 3 Month Workload</div>
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th width="50px">USERNAME</th>
                <th>DONE</th>
                <th>NOT DONE</th>
                <th>SCORE (OVERALL)</th>
                <th>SCORE (DONE)</th>
                <th>%COMPLETED</th>
                <th>RANK</th>
                <th></th>
              
            </tr>
        </thead>
        <tbody>

            <%

                
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        where_c="user_id<>2 and time_sid between TO_CHAR(current_timestamp - interval '3 month','YYYYMMDD')  and TO_CHAR(current_timestamp,'YYYYMMDD') and "
                                + " status_code<>'CANCEL' ";
                        
                        sql = "select a.*,row_number() over() as INORDER  from ( "+
                        "select  username||' - '||username_name AS name, sum(case when status_code='DONE' then 1  else 0 end ) JML_DONE,"+
                        "sum(case when status_code='DONE' then 0  else 1 end ) JML_NOT_DONE,"
                        + "ROUND(cast(sum(score_final) as numeric),2) SCORE,"
                        + "ROUND(cast(sum(case when status_code='DONE' then score_final else 0 end) as numeric),2) SCORE_DONE,"
                        + "ROUND(sum(case when status_code='DONE' then 1  else 0 end ) / count(1)::numeric*100,2)||'%' PCT_SCORE "+
                        "from V_ACT_DAILY a "
                        + "where "+where_c+
                        "group by username||' - '||username_name "+
                        "order by SCORE_DONE desc "+
                        ") a";
                        
                                                        
                       //out.println(sql);

                        resultSet = db.executeQuery(sql);
                        String rowstate = "even";
                        
                        while (resultSet.next()) {
                            i++;

                            if (i % 2 == 0) {
                                rowstate = "even";
                            } else {
                                rowstate = "odd";
                            }


                            out.println("<tr id=rows_"+resultSet.getString(1)+" class=" + rowstate + "> ");
                            
                                                                               
                                                   
                             out.println("<td width=10px> " + resultSet.getString("NAME") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("JML_DONE") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("JML_NOT_DONE") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("SCORE") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("SCORE_DONE") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("PCT_SCORE") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("INORDER") + " </td>");
                             out.println("<td></td>");
                            
                      
                            out.println("</tr> ");
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
        </tbody>
        <tfoot>
            <tr>
         
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
            </tr>
        </tfoot>
    </table>
</div>

        
        
<div >
    <div class="titlepages">RANK Top Score Based on 6 Month Workload</div>
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th>USERNAME</th>
                <th>DONE</th>
                <th>NOT DONE</th>
                <th>SCORE (OVERALL)</th>
                <th>SCORE (DONE)</th>
                <th>%COMPLETED</th>
                <th>RANK</th>
                <th></th>
            </tr>
        </thead>
        <tbody>

            <%

                
                try {
                    ResultSet resultSet = null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        where_c="user_id<>2 and time_sid between TO_CHAR(current_timestamp - interval '6 month','YYYYMMDD')  and TO_CHAR(current_timestamp,'YYYYMMDD') AND "
                                + " status_code<>'CANCEL' ";
                        
                        sql = "select a.*,row_number() over() as INORDER  from ( "+
                        "select  username||' - '||username_name as name, sum(case when status_code='DONE' then 1  else 0 end ) JML_DONE,"+
                        "sum(case when status_code='DONE' then 0  else 1 end ) JML_NOT_DONE,"
                        + "ROUND(cast(sum(score_final) as numeric),2) SCORE, "
                        + "ROUND(cast(sum(case when status_code='DONE' then score_final else 0 end) as numeric),2) SCORE_DONE,"
                        + "ROUND(sum(case when status_code='DONE' then 1  else 0 end ) / count(1)::numeric*100,2)||'%' PCT_SCORE  "+
                        "from V_ACT_DAILY a "
                        + "where "+where_c+
                        "group by username||' - '||username_name "+
                        "order by SCORE_DONE desc "+
                        ") a";
                        
                                                        
                        //out.println(sql);

                        resultSet = db.executeQuery(sql);
                        String rowstate = "even";
                        
                        while (resultSet.next()) {
                            i++;

                            if (i % 2 == 0) {
                                rowstate = "even";
                            } else {
                                rowstate = "odd";
                            }


                            out.println("<tr id=rows_"+resultSet.getString(1)+" class=" + rowstate + "> ");
                             out.println("<td width=10px> " + resultSet.getString("NAME") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("JML_DONE") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("JML_NOT_DONE") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("SCORE") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("SCORE_DONE") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("PCT_SCORE") + " </td>");
                             out.println("<td width=10px> " + resultSet.getString("INORDER") + " </td>");
                             out.println("<td> </td>");
                      
                            out.println("</tr> ");
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
        </tbody>
        <tfoot>
            <tr>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
               <td>-</td>
            </tr>
        </tfoot>
    </table>
</div>
