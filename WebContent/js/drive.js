$(function() {
    $("#uploadFile").fileinput({
        theme: 'fa',
        language: 'zh',
        uploadUrl: "UpLoad",
        allowedPreviewTypes: ['image', 'html', 'text', 'video', 'audio'],//预览类型
        //allowedFileExtensions: ['jpg', 'gif', 'png'], //文件上传类型
        maxFileSize: 0,
        maxFileCount: 10
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

    $(".share").click(function() {
        $.get($(this).attr("url"), {}, handleShowLink);
    });
    var clipboard = new Clipboard('#copyLink');
    clipboard.on('success', function(e) {
        $("#copySuccess").show();
        e.clearSelection();
    });
    clipboard.on('error', function(e) {
        $("#copyError").show();
    });
});
function handleShowLink(data) {
    $("#linkText").val(data);
    $("#shareModal").modal("show");
};