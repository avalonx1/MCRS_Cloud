<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
                     
      String filter_itemname = request.getParameter("filter_itemname");
      String filter_status = request.getParameter("filter_status");
        
         if (filter_itemname==null) {
           filter_itemname="";
         }
      
         if (filter_status==null) {
             filter_status="-1";
         }  
        
%>
<div  class="myformfilter">
    <form  id="filter_form" method="post" action="#">

        <table >
            <tr><th colspan="2">Filter </th></tr>
            <tr><td width="80px">Items </td><td>:<input id="filter_itemname" type="text" name="filter_itemname" value="<%=filter_itemname%>" size="20" maxlength="200" /></td>
             <tr><td>Status </td><td>:
             <select id="filter_status" name="filter_status">

            <%
                            
                            
                               if (filter_status.equalsIgnoreCase("-1")) {
                                        out.println("<option value='-1' selected=selected >-All Status-</option>");
                                        out.println("<option value='1' >Active</option>");
                                        out.println("<option value='0' >Not Active</option>");
                                    } else if (filter_status.equalsIgnoreCase("1")) {
                                        out.println("<option value='-1'  >-All Status-</option>");
                                        out.println("<option value='1' selected=selected >Active</option>");
                                        out.println("<option value='0' >Not Active</option>");
                                    }else {
                                        out.println("<option value='0'  >-All Status-</option>");
                                        out.println("<option value='Active'  >Active</option>");
                                        out.println("<option value='Not Active' selected=selected >Not Active</option>");
           
                                    }
                               
            %>

            </select>
            </td></tr>
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
            url: "tracking/items/items_list_data.jsp",
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


