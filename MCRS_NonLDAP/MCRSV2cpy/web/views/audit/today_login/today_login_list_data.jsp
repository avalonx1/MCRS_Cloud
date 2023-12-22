<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
             

    String id = request.getParameter("id");
    String filter_itemname = request.getParameter("filter_itemname");
    //String filter_status = request.getParameter("filter_status");

    if (id == null) {
            id = "0";
        }
    
   
    if (filter_itemname == null) {
            filter_itemname = "";
        }
  
  
 
    int i = 0;
    
    
%>
    

<div class="tablelist_wrap">
    <div id="refresh_data" class="add_optional">[refresh data] </div>
</div>
    
<div >
    
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th>Username</th>
                <th>Full Name</th>
                <th>Title</th>
                <th>Email</th>
                <th>Extension</th>
                <th>Level</th>
                <th>Group</th>
                <th>last Login</th>
                <th>Duration</th>
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
                       
                        sql = " select username,fullname,title,email,contact_ext,level_name,group_name,last_login,duration "
                                + "from v_user_today_login where 1=1 ";

                        
                        if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(username) like upper('%"+filter_itemname+"%') "
                                + "OR upper(fullname) like upper('%"+filter_itemname+"%')  "
                                + "OR upper(group_name) like upper('%"+filter_itemname+"%') "
                                + "  ) ";
                        }  
                         
                        //sql +=" order by 1 ";
                        sql += " OFFSET 0 LIMIT 100";
                        
                         //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        
                        }
                        
                        
                        
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
                                             
                             out.println("<td> " + resultSet.getString("username") + " </td>");
                             out.println("<td> " + resultSet.getString("fullname") + " </td>");
                             out.println("<td> " + resultSet.getString("title") + " </td>");
                             out.println("<td> " + resultSet.getString("email") + " </td>");
                             out.println("<td> " + resultSet.getString("contact_ext") + " </td>");
                             out.println("<td> " + resultSet.getString("level_name") + " </td>");
                             out.println("<td> " + resultSet.getString("group_name") + " </td>");
                             out.println("<td> " + resultSet.getString("last_login") + " </td>");
                             out.println("<td> " + resultSet.getString("duration") + " </td>");
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
                <td><%=i%> Record(s)</td>
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
        
        
        <script type="text/javascript">
         $(document).ready(function() {
           
              $('#refresh_data').click(function() {
                  
                      filter_itemname= document.getElementById("filter_itemname").value;
                      
                        $('#data_inner').hide();
                        $('#loading').show();
                        $.ajax({
                            type: 'POST',
                            url: "audit/today_login/today_login_list_data.jsp",
                            data: {id:<%=id%>,
                                filter_itemname:filter_itemname},
                            success: function(data) {
                                $('#data_inner').empty();
                                $('#data_inner').html(data);
                                $('#data_inner').show();
                            },
                            complete: function(){
                                $('#loading').hide(); 
                            }
                        });        
             });
             
        
             
            <% if (!id.equals("0") ) { %> 
             $('#content').animate({
             scrollTop: $("#rows_<%=id%>").offset().top
             }, 2000);
             <% } %>
             
             
           });
    </script>
    
</div>


