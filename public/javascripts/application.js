// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {

	$('.rating').raty({path: '/images/raty', start: 3});
	$(".timeago").timeago();	
	$("ul.sf-menu").superfish(); 
	$(":text").labelify();

	// button link
	// <button class="link" data-href="url">Click</button>
	$('button.link').live('click', function() { window.location.href = $(this).data('href'); });

});