$(function () {

    $("#inboxUpload").fileinput({
        theme: 'fa',
        language: 'zh',
        uploadUrl: "UpLoad",
        allowedPreviewTypes: ['image', 'html', 'text', 'video', 'audio'],//预览类型
        //allowedFileExtensions: ['jpg', 'gif', 'png'], //文件上传类型
        maxFileSize: 0,
        maxFileCount: 10,
        uploadExtraData: function() {
        	var obj = {};
            $('form').find('.form-control-inline').each(function() {
                var id = $(this).attr('id'), val = $(this).val();
                obj[id] = val;
            });
            obj["path"] = $("#inboxName").text();
            obj["userName"] = $("#inboxName").attr("user");
            return obj;
        }
    });

    $("#mkInbox").click(function () {
        $.get("CreateInbox", {
            inboxName: $("#inboxName").val(),
            illustrate: $("#illustrate").val()
        }, handleShowLink);
        $("#newFolder").modal("hide");
    });
    $('#inboxLinkModal').on("hide.bs.modal", function() {    	
    	window.location.href="InboxManage";
    });
    var clipboard = new Clipboard('#copyLink');
    clipboard.on('success', function (e) {
        $("#copySuccess").show();
        e.clearSelection();
    });

    clipboard.on('error', function (e) {
        $("#copyError").show();
    });
    $('[data-toggle="popover"]').popover();   
});
function handleShowLink(data) {
    $("#linkText").val(data);
    $("#inboxLinkModal").modal("show");
};