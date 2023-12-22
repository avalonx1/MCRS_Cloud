<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
    

 %>   

<div >
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th width="10">No</th>
                <th width="20">Username</th>
                <th width="40">Employee Name</th>
                <th width="10">Employee ID</th>
                <th width="10">Group Name</th>
                <th width="30">Last Login</th>
                <th>Info</th>
            </tr>
        </thead>

        <tbody>

            <%
               int i=0;
              
                
                try {
                    ResultSet resultSet=null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = "select USERNAME,FIRST_NAME, LAST_NAME, EMP_ID, GROUP_NAME, LEVEL_NAME,IP_ADDRESS, "
                                + "LAST_LOGIN,LAST_LOGIN_DATE,TODAY "
                              +"from LOGIN_INFO ";
                              
                        
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


                            String user_warna = "";

                            if (resultSet.getString("USERNAME").equals(v_userName)) {
                                user_warna = "green_user";
                            } else {
                                user_warna = "";
                            }
                            
                            String login_warna = "";

                            if (resultSet.getString("TODAY").equals(resultSet.getString("LAST_LOGIN_DATE"))) {
                                login_warna = "purple";
                            } else {
                                login_warna = "";
                            }
                            
                            

                            out.println("<tr id=rows_"+resultSet.getString(1)+" class=" + rowstate + "> ");
                            out.println("<td> " + i + "</td>");
                         
                            out.println("<td> " + resultSet.getString("USERNAME") + " </td>"); 
                            out.println("<td axis='"+user_warna+"' > " + resultSet.getString("FIRST_NAME")+" "+resultSet.getString("LAST_NAME") + " </td>");
                            out.println("<td> " + resultSet.getString("EMP_ID") + " </td>");
                            out.println("<td> " + resultSet.getString("GROUP_NAME") + " </td>");
                            out.println("<td axis='"+login_warna+"' > " + resultSet.getString("LAST_LOGIN") + " </td>");
                            out.println("<td>IP Client : "+resultSet.getString("IP_ADDRESS")+"</td>");
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

                <td> -</td>
                <td> <%=i%> Record(s)</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
                <td> -</td>
      
            </tr>
        </tfoot>
    </table>
</div>
<script type="text/javascript">
    
   $("#title_box").empty();
    $("#title_box").html("<h1>Login info  </h1><p>All user login info</p>");
    $("#title_box").show();
</script>

