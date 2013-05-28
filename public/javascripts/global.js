jQuery(document).ready(function() {
	//$("#map1").hide();
	//$("#map2").hide();
	
	$("#add1").click(function () {
		$("#map2").hide();
		$("#map1").slideDown("400");
	});
	$("#add2").click(function () {
		$("#map1").hide();
		$("#map2").slideDown("400");
	});
})