$(document).ready(function() {

    $("form").submit(function() {
        var username = $("#username").val();
        var password = $("#password").val();
        if(username=="") {
            $("#errorInfo").html("用户名不能为空");
            return false;
        } else if (password == "") {
            $("#errorInfo").html("密码不能为空");
            return false;
        }
        $("#errorInfo").html("");
        return true;
    });
    
})