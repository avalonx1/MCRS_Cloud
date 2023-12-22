<%@include file="../../../includes/check_auth_layer3.jsp"%>
<%
    
  
            try{
                ResultSet resultSet = null;
            Database db = new Database();
            try{
            db.connect(1);
            String sql;
            
            sql="select a.id,username,first_name,last_name,emp_id,ip_address,email,b.group_code||' - '||b.group_name group_name,c.level_code||' - '||c.level_name level_name, title,contact_ext "
                    + " from T_USER a, T_USER_GROUP b,T_USER_LEVEL c where "
                    + " a.group_id=b.id and a.level_id=c.id and username='"+v_userName+"' ";
            resultSet = db.executeQuery(sql);
            //out.println(sql); 
            while(resultSet.next()){

%>
<div id="stylized" class="myform">
 <form class="cmenu" id="profileUser" method="post" action="#">
    <h1>Profile</h1>
    <p></p>
<table border="0" cellpadding="0" cellspacing="0" >
<tr><td width="100px"></td><td></td></tr>
<tr><td width="100px">Username</td><td><input type="text" name="username"  size="50" maxlength="30" disabled="disabled" value="<%=resultSet.getString("USERNAME")%>">&nbsp;</td></tr>
<tr><td>First Name</td><td><input type="text"  name="firstName" size="50" maxlength="50" disabled="disabled" value="<%=resultSet.getString(3)%>"></td></tr>
<tr><td>Last Name</td><td><input type="text"  name="lastName" size="50" maxlength="50" disabled="disabled" value="<%=resultSet.getString(4)%>"></td></tr>
<tr><td>Employee ID</td><td><input type="text"  name="empID" size="50" maxlength="20" disabled="disabled" value="<%=resultSet.getString(5)%>"></td></tr>
<tr><td>Title</td><td><input type="text"  name="firstName" size="50" maxlength="50" disabled="disabled" value="<%=resultSet.getString("title")%>"></td></tr>
<tr><td>Group</td><td><input type="text" name="group" size="50" maxlength="100" disabled="disabled" value="<%=resultSet.getString(8)%>">
<tr><td>Level</td><td><input type="text" name="level" size="50" maxlength="100" disabled="disabled" value="<%=resultSet.getString(9)%>">

    </td></tr>

<tr><td>Email</td><td><input type="text" name="email"  size="50" maxlength="100" disabled="disabled" value="<%=resultSet.getString(7)%>">&nbsp;</td></tr>

<tr><td>IP Phone</td><td><input type="text" name="ipphone"  size="50" maxlength="100" disabled="disabled" value="<%=resultSet.getString("contact_ext")%>">&nbsp;</td></tr>


<tr><td><td><div class="markMandatory">Cant Change Password LDAP</div><input disabled="true" id="changePass" type="button" name="changepass" value="Click for change your password" /></td></tr>
</table>

<p></p>
</form>
</div>

<%

}

}catch(SQLException Sqlex){
out.println("<div class=sql>" +Sqlex.getMessage()+"<br>");
}finally{
db.close();
if (resultSet != null) resultSet.close(); 
}
}catch(Exception except){
out.println("<div class=sql>" +except.getMessage()+"<br>");
}

%>

<script type="text/javascript">
 $('#changePass').click(function() {
 $("#data").hide();
 $('#loading').show();
		$.ajax({
			type: 'POST',
			url: "administration/user_management/change_password.jsp",
			data: "",
			success: function(data) {
                          $('#data').html(data);
                          $('#data').show();
                        },
            complete: function(){
                 $('#loading').hide();
            }

		})
		return false;
	});
</script>
    
