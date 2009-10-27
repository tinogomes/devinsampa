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
})