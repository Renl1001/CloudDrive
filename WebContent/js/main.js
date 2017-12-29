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
        //allowedFileExtensions: ['jpg', 'gif', 'png'],
        maxFileSize: 0,
        maxFileCount: 10
    });

    $('#uploadFile').on('filebatchuploadcomplete', function(event, files, extra) {
        $("#refresh").text("确定");
        console.log('File batch upload complete');
    });

    $("#CheckAll").click(function () {
        if (this.checked)
            $(':checkbox').attr('checked', true);
        else
            $(':checkbox').attr('checked', false);
    });

    $("tbody tr").bind({
        mouseover: function () {
            $(this).find(".disabled").show();
        },
        mouseout: function () {
            $(this).find(".disabled").hide();
        }
    });

    $("#refresh").click(function() {
    	window.location.href="ListFiles";
    });
    
    
})
