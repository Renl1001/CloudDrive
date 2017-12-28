$(function () {
	$("#uploadFile").fileinput({
        theme: 'fa',
        language: 'zh', //设置语言
        showUpload: false,//显示上传按钮
        // uploadUrl: uploadUrl, //上传的地址
        //allowedFileExtensions: ['jpg', 'gif', 'png'], //接收的文件后缀
        // dropZoneEnabled: false,//是否显示拖拽区域
        // uploadAsync:false, //true同步上传，false异步上传
        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
        //minFileCount: 0,
        // maxFileCount: 10, //表示允许同时上传的最大文件个数
        // enctype: 'multipart/form-data',
        validateInitialCount: true,
        // msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
    });

	$("#CheckAll").click(function() {
		if (this.checked)
			$(':checkbox').attr('checked', true);
		else
			$(':checkbox').attr('checked', false);
    });

    $("tbody tr").bind({
        mouseover: function() {
            $(this).find(".disabled").show();
        },
        mouseout: function() {
            $(this).find(".disabled").hide();
        }
    });
})