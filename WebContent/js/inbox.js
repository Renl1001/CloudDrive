$(function () {
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

});
function handleShowLink(data) {
    $("#linkText").val(data);
    $("#inboxLinkModal").modal("show");
};