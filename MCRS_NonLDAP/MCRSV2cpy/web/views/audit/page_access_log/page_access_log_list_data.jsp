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

<div>
    <table class="tablewrap" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <th>ID</th>
                <th>USER</th>
                <th>FULLNAME</th>
                <th>TIME</th>
                <th>ACTIVITY</th>
                <th>DESC</th>
                <th>IP ADDRESS</th>
                <th>HOST</th>
                <th>REFF ID</th>
                <th>REFF DESC</th>
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
                       
                        sql = " select id,act_tag,act_desc,ip_addr,host_addr,reff_id,reff_desc,username,fullname,created_time_name "
                                + "from v_user_audit where 1=1 ";

                        
                        if (filter_itemname.equals("")==false) {
                        sql += " and ( upper(act_tag) like upper('%"+filter_itemname+"%') "
                                + "OR upper(act_desc) like upper('%"+filter_itemname+"%')  "
                                + "OR upper(ip_addr) like upper('%"+filter_itemname+"%') "
                                + "OR upper(host_addr) like upper('%"+filter_itemname+"%') "
                                + "OR upper(username) like upper('%"+filter_itemname+"%') "
                                + "OR upper(fullname) like upper('%"+filter_itemname+"%') "
                                + "OR upper(created_time_name) like upper('%"+filter_itemname+"%') "
                                + "  ) ";
                        }  
                         
                        //sql +=" order by 1 ";
                        sql += " OFFSET 0 LIMIT 100";
                        
                        //out.println("<div class=sql>"+sql+"</div>");
                        
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

                            String act_desc_warna ="brown";
                           if ( resultSet.getString("act_tag").equals("PAGE_ACCESS") && v_url.equals(resultSet.getString("act_desc")) ) {
                               act_desc_warna = "orange";
                           } 
                             
                            String fullname_warna ="brown";
                            if ( resultSet.getString("act_tag").equals("PAGE_ACCESS") && v_url.equals(resultSet.getString("act_desc")) && !v_userName.equals(resultSet.getString("username").trim()) ) {
                                fullname_warna = "red";
                            }
                            
                            
                                
                             out.println("<tr id=rows_"+resultSet.getString(1)+" class=" + rowstate + "> ");
                             out.println("<td> " + resultSet.getString("id") + " </td>");                                             
                             out.println("<td> " + resultSet.getString("username") + " </td>");
                             out.println("<td axis=" + fullname_warna + " > " + resultSet.getString("fullname") + " </td>");
                             out.println("<td> " + resultSet.getString("created_time_name") + " </td>");
                             out.println("<td> " + resultSet.getString("act_tag") + " </td>");
                             out.println("<td axis=" + act_desc_warna + " > " + resultSet.getString("act_desc")+ " </td>");
                             out.println("<td> " + resultSet.getString("ip_addr") + " </td>");
                             out.println("<td> " + resultSet.getString("host_addr") + " </td>");
                             out.println("<td> " + resultSet.getString("reff_id") + " </td>");
                             out.println("<td> " + resultSet.getString("reff_desc") + " </td>");
                             
                             
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
                            url: "audit/page_access_log/page_access_log_list_data.jsp",
                            data: {id:<%=id%>,
                                filter_itemname:filter_itemname,url:'<%=v_url%>'},
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


