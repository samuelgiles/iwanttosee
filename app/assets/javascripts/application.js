// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
	if($("body").attr("data-background") != ""){
		$.backstretch($("body").attr("data-background"));
	}

	$(".add_wish input").keypress(function(e) {
	    if(e.which == 13) {
	        $(".add_wish").submit();
	    }
	});


	$(".wishes.user").sortable({
		axis: 'y',
		dropOnEmpty: false,
		handle: '.position',
		cursor: 'crosshair',
		items: '.wish',
		opacity: 0.4,
		scroll: true,
		update: function(){
		$.ajax({
		type: 'post',
		data: $(".wishes.user").sortable("serialize"),
		dataType: 'script',
		complete: function(request){
			if(request.status == 200){
				$(".wishes.user").effect('highlight');
			}
			else{
				alert("An error occured whilst sorting wishes.")
			}
			//resort();
		},
		url: '/sort'})
		}
	});

});