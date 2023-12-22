<%@ page language="java" import="Database.*,java.util.*,java.sql.*,javax.naming.*,javax.sql.*,java.text.SimpleDateFormat"%>
<h3>SERVICE REVENUE - DAILY</h3>

<form id="a" class="cmenu"  method="post" action="#">
    <div class="featurebox">
        <%
    Calendar cal = Calendar.getInstance();
    SimpleDateFormat simpledate = new SimpleDateFormat("dd-MM-yyyy");
    String date = simpledate.format(cal.getTime());
        %>
        <table class="table_form" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr><td width="50px"></td><td></td></tr>
            <tr><td >DATE</td><td colspan="2" ><input type="text" id="tanggal" name="tanggal" size="20" maxlength="30" value="<%=date%>" readonly >&nbsp;</td></tr>
           
            <tr><td>POSTPAID </td><td colspan="2" axis="ket_form"></td></tr>
            <tr><td>&nbsp;&nbsp;BILL<td colspan="2" axis="ket_form">:&nbsp;&nbsp;1,229,221.00</td></tr>
            <tr><td>&nbsp;&nbsp;E/R<td colspan="2" axis="ket_form">:&nbsp;&nbsp;2,111.98</td></td></tr>
            <tr><td>&nbsp;&nbsp;DEPOSIT<td colspan="2" axis="ket_form">:&nbsp;&nbsp;10,222,222.00</td></tr>
            <tr><td colspan="2">&nbsp;</td></tr>
        </table>

    </div>
</form>
