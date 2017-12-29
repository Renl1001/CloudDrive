$(function () {
    $("#uploadFile").fileinput({
        theme: 'fa',
        language: 'zh',
        uploadUrl: "UpLoad",
        //allowedFileExtensions: ['jpg', 'gif', 'png'],
        maxFileSize: 0,
        maxFileCount: 10
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
    
    $(".refresh").click(function() {
    	window.location.href="ListFiles";
    });
})
