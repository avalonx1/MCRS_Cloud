<%@ page language="java" import="Engines.*,Database.*,java.util.*,java.sql.*,javax.naming.*,javax.sql.*"%>
<%

String statSession = request.getParameter("stat_session");

String v_clientIP = request.getRemoteAddr();

if (statSession==null) {
    statSession="0";
}

%>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style/login.css" media="screen" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Password Reset|MCRS</title>
        <link rel="stylesheet" type="text/css" href="style/login.css" media="screen" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        
        <script type="text/javascript" src="js_file/jquery/jquery-1.3.2.js"></script>
        <script type="text/javascript" src="js_file/jquery/jquery-ui-1.7.1.custom.min.js"></script>
        <script type="text/javascript" src="js_file/jquery/jquery.li-scroller.1.0.js"></script>
        <script type="text/javascript" src="js_file/jquery/mbContainer.js"></script>
        <script type="text/javascript" src="js_file/jquery/jquery.metadata.js"></script>
        <script type="text/javascript" src="js_file/jquery.treeview.js" ></script>
        
        <script type="text/javascript">

            $(document).ready(function() {
      
            function mainFocus(){
                var a= document.getElementById('username1');
                a.focus();
            }
            
          
            $("#msgResetForm").hide();
            $('#formResetPassword').submit(function () {
        
     
                $.ajax({
                    type: 'POST',
                    url: "forget_password_process.jsp",
                    data: $(this).serialize(),
                    success: function (data) {

                        $(".login_back").empty();
                        $(".login_back").html(data);
                        $(".login_back").show();
                    },
                    complete: function () {
                        //$('#loading').hide();
                    }
                });
                return false;

            
            });
            
            });
      
                
        </script>
        
    </head>
    <body onload="mainFocus()">
        <div class="login_back">
            <div class="login_front">
                <div class="company_icon"></div>
                <div class="login_name">MCRS</div>
                
                <form id="formResetPassword" method="post" action="#">

                    <table border=0 width="">
                        <tr>
                            <td colspan="2">Reset Password</td>
                        </tr>
                        <tr>
                            <td>Username</td>
                            <td><input id="username1" size="15" type="text" name="username" ></td>
                        </tr>
                        
                        <tr>
                            
                            <td><input class="button" type="submit" name="login" value="Reset"></td>
                        </tr>
                    </table>
                </form>
                <div id="msgResetForm" class=info></div>
             
            </div>
        </div>
    </body>
</html>