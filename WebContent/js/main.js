$(function () {
	if($("#loginError")[0]) {
		$("#login").modal("show");
	}
	if($("#registerError")[0]) {
		$("#signup").modal("show");
	}
    $("#uploadFile").fileinput({
        theme: 'fa',
        language: 'zh',
        uploadUrl: "UpLoad",
        allowedPreviewTypes: ['image', 'html', 'text', 'video', 'audio'],//预览类型
        //allowedFileExtensions: ['jpg', 'gif', 'png'], //文件上传类型
        maxFileSize: 0,
        maxFileCount: 10
    });
    
    $("tbody tr").bind({
        mouseover: function () {
            $(this).find(".disabled").show();
        },
        mouseout: function () {
            $(this).find(".disabled").hide();
        }
    });
    
    $('#CheckAll').click(function(){
		if(this.checked){
			$('tbody :checkbox').attr('checked',true);
		}else{
			$('tbody :checkbox').attr('checked',false);
		}
	});
    
	$('tbody :checkbox').click(function(){
		
		var checkArry = document.getElementsByName("subBox");
		for (var i = 0; i < checkArry.length; i++) {
	        if(checkArry[i].checked == false){
	            $('#CheckAll').attr('checked',false);
	            return;
	        }
   		}
		$('#CheckAll').attr('checked',true);

	});

    $('#uploadFile').on('filebatchuploadcomplete', function(event, files, extra) {
    	$("#uploadModal").find(".modal-footer").find(".btn").text("确定");
        console.log('File batch upload complete');
    });
    $('#uploadModal').on("hide.bs.modal", function() {
    	if($("#uploadModal").find(".modal-footer").find(".btn").text() == "确定") {
    		window.location.href="ListFiles";
    	}
    });
    
    $("#shareModal").on("hide.bs.modal", function() {
    	window.location.href="ListFiles";
    });
    
})
