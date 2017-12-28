$("#signupForm").validate({
    submitHandler:function(form){ 
        form.submit();
    }    
});
$(document).ready(function() {
	$("#signupForm").validate({
	    rules: {
	      userName: {
	        required: true,
	        minlength: 5
	      },
	      pwd: {
	        required: true,
	        minlength: 8
	      },
	      repwd: {
	        required: true,
	        minlength: 8,
	        equalTo: "#pwd"
	      }
	    },
	    messages: {
	      userName: {
	        required: "请输入用户名",
	        minlength: "用户名至少5个字符"
	      },
	      pwd: {
	        required: "请输入密码",
	        minlength: "密码长度不能小于 8 个字母"
	      },
	      repwd: {
	        required: "请输入密码",
	        minlength: "密码长度不能小于 8 个字母",
	        equalTo: "两次密码输入不一致"
	      }
	     }
	  })
    
    
})