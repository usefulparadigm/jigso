// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {

	$('.rating').raty({path: '/images/raty', start: 3});
	$(".timeago").timeago();	
	$("ul.sf-menu").superfish(); 
	$(":text").labelify();

	// $('#flash').delay(500).fadeIn('normal', function() {
	// 	$(this).delay(2500).fadeOut();
	// });

	// button link
	// <button class="link" data-href="url">Click</button>
	$('button.link').live('click', function() { window.location.href = $(this).data('href'); });

});