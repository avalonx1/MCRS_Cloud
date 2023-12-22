<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%
               
      String filter_itemname = request.getParameter("filter_itemname");
         if (filter_itemname==null) {
           filter_itemname="";
         }
         
         String filter_group_id = request.getParameter("filter_group_id");
         if (filter_group_id==null) {
           filter_group_id="0";
         }
         
         String filter_level_id = request.getParameter("filter_level_id");
         if (filter_level_id==null) {
           filter_level_id="0";
         }
         
         String filter_userstatus = request.getParameter("filter_userstatus");
         if (filter_userstatus==null) {
           filter_userstatus="-1";
         }
         
      
%>
<div  class="myformfilter">
    <form  id="filter_form" method="post" action="#">

        <table >
            <tr><th colspan="2">Filter </th></tr>
            <tr><td width="80px">Name </td><td>:<input id="filter_itemname" type="text" name="filter_itemname" value="<%=filter_itemname%>" size="20" maxlength="200" /></td>
            
             <tr><td width="80px">Group </td><td>:
                <select id="filter_group_id" name="filter_group_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ( SELECT 0 ID, '-All-' AS DESC ,1 AS ORD,-1 AS BRNCHFL UNION ALL SELECT id ID,group_code||' - '||group_name AS DESC, 2 ORD,branch_flag "
                                                    + " FROM t_user_group ) a "
                                                    + "  ORDER BY 3,4,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (filter_group_id.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
                                            }
                                            resultSet.close();
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
    </select></td></tr>
             
     <tr><td width="80px">Level </td><td>:
                <select id="filter_level_id" name="filter_level_id">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ( SELECT 0 ID, '-All-' AS DESC ,1 AS ORD UNION ALL SELECT id ID,level_code||' - '||level_name AS DESC, 2 ORD "
                                                    + " FROM t_user_level ) a "
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (filter_level_id.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
                                            }
                                            resultSet.close();
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
    </select></td></tr>
     
     
     <tr><td width="80px">status </td><td>:
                <select id="filter_userstatus" name="filter_userstatus">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ( SELECT -1 ID, '-All-' AS DESC,1 AS ORD UNION ALL SELECT 1 ID, 'Active' AS DESC,2 AS ORD UNION ALL SELECT 0 ID,'Not Active' AS DESC,3 AS ORD ) a"
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (filter_userstatus.equalsIgnoreCase(resultSet.getString(1))) {
                                                    out.println("<option value=" + resultSet.getString(1) + " selected=selected >" + resultSet.getString(2) + "</option>");
                                                } else {
                                                    out.println("<option value=" + resultSet.getString(1) + " >" + resultSet.getString(2) + "</option>");
                                                }
                                            }
                                            resultSet.close();
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
    </select></td></tr>
     
     
                 
             <tr><td colspan="2"><button type="submit">GO</button></td></tr>
        </table>
  
    </form>
</div>
<script type="text/javascript">

 
    
    $('#filter_form').submit(function(){
        $("#data").hide();
        $('#loading').show();
        $.ajax({
            type: 'POST',
            url: "administration/user_management/user/user_list_data.jsp",
            data: $(this).serialize(),
            success: function(data) {
                $("#data_inner").empty();
                $('#icon_panel_show_filter').fadeIn('slow');
                $('#icon_panel_hide_filter').fadeOut('slow');
                $('#filter_box_data').slideUp();
                $("#data_inner").html(data);
                $("#data_inner").show();
            },
            complete: function(){
                $('#loading').hide();
            }
                        
        });
        return false;
    });

    
</script>

