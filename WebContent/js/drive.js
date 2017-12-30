$(function() {
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