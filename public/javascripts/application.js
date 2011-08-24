var fbPageURL = "http%3A%2F%2Fwww.facebook.com%2Fpages%2FDev-in-Sampa%2F227427707295333";
var fbLikeURL = "http://www.facebook.com/plugins/likebox.php?href=" + fbPageURL + "&amp;width=200&amp;colorscheme=light&amp;show_faces=true&amp;border_color=%23ccc&amp;stream=false&amp;header=false&amp;height=100";
var fbIFrame = '<iframe src="' + fbLikeURL + '" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:200px; height:100px;" allowTransparency="true"></iframe>';

$(function() {
	$('.box').corners('10px');
	$('#warning').corners('10px');

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

	$("#fb-iframe").replaceWith(fbIFrame);
	
	$("#gplus").replaceWith("<g:plusone href='http://devinsampa.com.br'></g:plusone>");
});
