<%@include file="../../../includes/check_auth_layer1.jsp"%>
<%

String username=request.getParameter("username");
String pass=request.getParameter("password");

String sql ="";
boolean update = true;
String errorMessage = "";

boolean cpass = Pattern.matches("[\\w\\@\\!\\*]+", pass);

if (!cpass){
    update=false;
    errorMessage+="-Field New Password must be filled with alpha numeric [a-z;A-z;0-9;_]<br>";
}



    if (update){
      
        try{
        Database db = new Database();
        try{
        db.connect(1);
        sql="update T_user set password=upper(md5('"+pass+"')) where  username='"+username+"'";
        db.executeUpdate(sql);
        out.println("<div class=info>Update Password User <b>"+username+"</b> Success<br></div>");
        }catch(SQLException Sqlex){
        out.println("<div class=sql>"+Sqlex.getMessage()+"</div>");
        }finally{
        db.close();
        }
        }catch(Exception except){
        out.println("<div class=sql>"+except.getMessage()+"</div>");
        }
 }else
    {
     out.println("<div class=alert>"+errorMessage+"</div>");
    }

%>


