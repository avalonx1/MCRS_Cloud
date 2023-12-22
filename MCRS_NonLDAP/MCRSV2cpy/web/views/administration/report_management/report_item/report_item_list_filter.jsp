<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%
               
      String filter_itemname = request.getParameter("filter_itemname");
       String filter_reportfreq = request.getParameter("filter_reportfreq");
        
         if (filter_itemname==null) {
           filter_itemname="";
         }
         
         if (filter_reportfreq==null) {
           filter_reportfreq="0";
         }
         
      
%>
<div  class="myformfilter">
    <form  id="filter_form" method="post" action="#">

        <table >
            <tr><th colspan="2">Filter </th></tr>
            <tr><td width="80px">Report Name </td><td>:<input id="filter_itemname" type="text" name="filter_itemname" value="<%=filter_itemname%>" size="20" maxlength="200" /></td>
            
              <tr><td width="80px">Report Freq </td><td>:
                <select id="filter_reportfreq" name="filter_reportfreq">
      <%

                                    try {
                                        ResultSet resultSet=null;
                                        Database db = new Database();
                                        try {
                                            db.connect(1);
                                            String sql;

                                            sql = "SELECT * from ( SELECT 0 ID, '-All-' AS DESC,1 AS ORD UNION ALL SELECT id, freq_code||' - '||freq_name AS DESC, 2 AS ORD "
                                                    + " FROM t_report_freq where record_stat=1) a "
                                                    + "  ORDER BY 3,2";
                                            resultSet = db.executeQuery(sql);
                                            while (resultSet.next()) {
                                                if (filter_reportfreq.equalsIgnoreCase(resultSet.getString(1))) {
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
            url: "administration/report_management/report_item/report_item_list_data.jsp",
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

