// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {

	$('.rating').raty({path: '/images/raty', start: 3});
	$(".timeago").timeago();	

	// dropdown
	$('.dropdown .toggle').click(function() {
		$(this).toggleClass("active").next().slideToggle("fast");
	});

	// button link
	// <button class="link" data-href="url">Click</button>
	$('button.link').live('click', function() { window.location.href = $(this).data('href'); });

});