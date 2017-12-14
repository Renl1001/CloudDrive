$(document).ready(function() {
	$("tr:even:gt(0)").addClass('tr_even');
	$("tr:odd").addClass('tr_odd');
	$("tr:gt(0)").mouseover(function() {
		$(this).addClass('tr_hover');
	}).mouseout(function() {
		$(this).removeClass('tr_hover');
	});

	$("#CheckAll").click(function() {
		if (this.checked)
			$(':checkbox').attr('checked', true);
		else
			$(':checkbox').attr('checked', false);
	});

	$("#sidebar li").mouseover(function() {
		$(this).addClass('tr_hover');
	}).mouseout(function() {
		$(this).removeClass('tr_hover')
	});

	//设置时间
	setInterval(getTime, 1000);

	function getTime() {
		var now, hour, min, sec;
		now = new Date();
		hour = now.getHours();
		min = now.getMinutes();
		sec = now.getSeconds();
		$("#time").html(
			now.getFullYear() + "年" + (now.getMonth() + 1) + "月" + now.getDate() + "日" + "  " + hour + ":" + min + ":" + sec
		);
	}

	
})