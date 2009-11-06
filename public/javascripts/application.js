$(document).ready(function() {

	$('.box').corners('10px');

	$("#map-zoom-out").click(function () {
		$("#map-zoom-in").toggle();
		$("#map-zoom-out").toggle();
	});
  
	$("#map-zoom-in").click(function () {
		$("#map-zoom-out").toggle();
		$("#map-zoom-in").toggle();
	});

	$(".banner textarea, .banner-quadrado textarea").focus(function() {
		// only select if the text has not changed
    	if(this.value == this.defaultValue) {
     		this.select();
    	}
	});
	
	$(".banner textarea, .banner-quadrado textarea").click(function() {
		// only select if the text has not changed
		if(this.value == this.defaultValue) {
			this.select();
		}
	});
	
  // $("table.agenda tr:odd").addClass('odd');

})