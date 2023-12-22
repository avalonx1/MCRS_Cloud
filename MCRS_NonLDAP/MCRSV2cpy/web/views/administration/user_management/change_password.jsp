<%@include file="../../../includes/check_auth_layer3.jsp"%>

<div id="stylized" class="myform">
<form class="cmenu" id="changePassFormAdm" method="post" action="#">
        <h1>Change password</h1>
        <p>Just type your new password on the new password field</p>
         <label>Username
            <span class="small"></span>
        </label>
         <%  if (v_userLevel.equals("1")) {%>
                <select id="username" name="username">
             <%
                try {
                    ResultSet resultSet=null;
                    Database db = new Database();
                    try {
                        db.connect(1);
                        String sql;

                        sql = " SELECT USERNAME OBJID,USERNAME FROM T_USER WHERE FLAG=1 "
                                + "ORDER BY 2";
                        resultSet = db.executeQuery(sql);
                        while (resultSet.next()) {
                            out.println("<option value='" + resultSet.getString(1) + "' selected=selected >" + resultSet.getString(2) + "</option>");
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
        </select>
        <%} else {%>
        <input type="text" name="username" maxlength="30" value="<%=v_userName%>" readonly="true" >
        <%}%>
        <label>New Password *
            <span class="small"></span>
        </label>
        <input type="password"  name="password" maxlength="50">
        
       <span class="small">*) mandatory</span>
        <button type="submit">Submit</button>
        <div class="spacer"></div>
        <!--<button type="reset">Reset</button> -->
        <div class="spacer"></div>
        
        


 </form>
</div>
<script type="text/javascript">
    
    
    var widthform = $(".myform").css("width");
    var widthfill=widthform.substr(0, widthform.length-2)-300;
    $("#stylized input").css("width",widthfill);   
    $("#stylized select").css("width",widthfill);    
    $("#stylized textarea").css("width",widthfill);   
    
    
 $('#changePassFormAdm').submit(function() {
 $("#data").hide();
 $('#loading').show();
		$.ajax({
			type: 'POST',
			url: "administration/user_management/change_password_proses.jsp",
			data: $(this).serialize(),
			success: function(data) {
                $('#data').html(data);
                $("#changePassFormAdm").hide();
                 $("#data").show();
                        },
            complete: function(){
                 $('#loading').hide();
            }

		})
		return false;
	});
</script>