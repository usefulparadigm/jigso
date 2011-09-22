(function(b,c){var a;b.rails=a={linkClickSelector:"a[data-confirm], a[data-method], a[data-remote], a[data-disable-with]",inputChangeSelector:"select[data-remote], input[data-remote], textarea[data-remote]",formSubmitSelector:"form",formInputClickSelector:"form input[type=submit], form input[type=image], form button[type=submit], form button:not([type])",disableSelector:"input[data-disable-with], button[data-disable-with], textarea[data-disable-with]",enableSelector:"input[data-disable-with]:disabled, button[data-disable-with]:disabled, textarea[data-disable-with]:disabled",requiredInputSelector:"input[name][required]:not([disabled]),textarea[name][required]:not([disabled])",fileInputSelector:"input:file",linkDisableSelector:"a[data-disable-with]",CSRFProtection:function(e){var d=b('meta[name="csrf-token"]').attr("content");if(d){e.setRequestHeader("X-CSRF-Token",d)}},fire:function(g,d,f){var e=b.Event(d);g.trigger(e,f);return e.result!==false},confirm:function(d){return confirm(d)},ajax:function(d){return b.ajax(d)},handleRemote:function(h){var l,f,k,j=h.data("cross-domain")||null,d=h.data("type")||(b.ajaxSettings&&b.ajaxSettings.dataType),e;if(a.fire(h,"ajax:before")){if(h.is("form")){l=h.attr("method");f=h.attr("action");k=h.serializeArray();var g=h.data("ujs:submit-button");if(g){k.push(g);h.data("ujs:submit-button",null)}}else{if(h.is(a.inputChangeSelector)){l=h.data("method");f=h.data("url");k=h.serialize();if(h.data("params")){k=k+"&"+h.data("params")}}else{l=h.data("method");f=h.attr("href");k=h.data("params")||null}}e={type:l||"GET",data:k,dataType:d,crossDomain:j,beforeSend:function(n,m){if(m.dataType===c){n.setRequestHeader("accept","*/*;q=0.5, "+m.accepts.script)}return a.fire(h,"ajax:beforeSend",[n,m])},success:function(n,m,o){h.trigger("ajax:success",[n,m,o])},complete:function(n,m){h.trigger("ajax:complete",[n,m])},error:function(o,m,n){h.trigger("ajax:error",[o,m,n])}};if(f){e.url=f}a.ajax(e)}},handleMethod:function(h){var e=h.attr("href"),k=h.data("method"),f=b("meta[name=csrf-token]").attr("content"),j=b("meta[name=csrf-param]").attr("content"),g=b('<form method="post" action="'+e+'"></form>'),d='<input name="_method" value="'+k+'" type="hidden" />';if(j!==c&&f!==c){d+='<input name="'+j+'" value="'+f+'" type="hidden" />'}g.hide().append(d).appendTo("body");g.submit()},disableFormElements:function(d){d.find(a.disableSelector).each(function(){var e=b(this),f=e.is("button")?"html":"val";e.data("ujs:enable-with",e[f]());e[f](e.data("disable-with"));e.attr("disabled","disabled")})},enableFormElements:function(d){d.find(a.enableSelector).each(function(){var e=b(this),f=e.is("button")?"html":"val";if(e.data("ujs:enable-with")){e[f](e.data("ujs:enable-with"))}e.removeAttr("disabled")})},allowAction:function(d){var e=d.data("confirm"),f=false,g;if(!e){return true}if(a.fire(d,"confirm")){f=a.confirm(e);g=a.fire(d,"confirm:complete",[f])}return f&&g},blankInputs:function(j,f,h){var e=b(),g,d=f||"input,textarea";j.find(d).each(function(){g=b(this);if(h?g.val():!g.val()){e=e.add(g)}});return e.length?e:false},nonBlankInputs:function(e,d){return a.blankInputs(e,d,true)},stopEverything:function(d){b(d.target).trigger("ujs:everythingStopped");d.stopImmediatePropagation();return false},callFormSubmitBindings:function(e){var d=e.data("events"),f=true;if(d!==c&&d.submit!==c){b.each(d.submit,function(g,h){if(typeof h.handler==="function"){return f=h.handler(h.data)}})}return f},disableElement:function(d){d.data("ujs:enable-with",d.html());d.html(d.data("disable-with"));d.bind("click.railsDisable",function(f){return a.stopEverything(f)})},enableElement:function(d){if(d.data("ujs:enable-with")!==c){d.html(d.data("ujs:enable-with"));d.data("ujs:enable-with",false)}d.unbind("click.railsDisable")}};b.ajaxPrefilter(function(d,f,e){if(!d.crossDomain){a.CSRFProtection(e)}});b(a.linkDisableSelector).live("ajax:complete",function(){a.enableElement(b(this))});b(a.linkClickSelector).live("click.rails",function(f){var d=b(this);if(!a.allowAction(d)){return a.stopEverything(f)}if(d.is(a.linkDisableSelector)){a.disableElement(d)}if(d.data("remote")!==c){a.handleRemote(d);return false}else{if(d.data("method")){a.handleMethod(d);return false}}});b(a.inputChangeSelector).live("change.rails",function(f){var d=b(this);if(!a.allowAction(d)){return a.stopEverything(f)}a.handleRemote(d);return false});b(a.formSubmitSelector).live("submit.rails",function(j){var g=b(this),h=g.data("remote")!==c,f=a.blankInputs(g,a.requiredInputSelector),d=a.nonBlankInputs(g,a.fileInputSelector);if(!a.allowAction(g)){return a.stopEverything(j)}if(f&&g.attr("novalidate")==c&&a.fire(g,"ajax:aborted:required",[f])){return a.stopEverything(j)}if(h){if(d){return a.fire(g,"ajax:aborted:file",[d])}if(!b.support.submitBubbles&&a.callFormSubmitBindings(g)===false){return a.stopEverything(j)}a.handleRemote(g);return false}else{setTimeout(function(){a.disableFormElements(g)},13)}});b(a.formInputClickSelector).live("click.rails",function(f){var e=b(this);if(!a.allowAction(e)){return a.stopEverything(f)}var d=e.attr("name"),g=d?{name:d,value:e.val()}:null;e.closest("form").data("ujs:submit-button",g)});b(a.formSubmitSelector).live("ajax:beforeSend.rails",function(d){if(this==d.target){a.disableFormElements(b(this))}});b(a.formSubmitSelector).live("ajax:complete.rails",function(d){if(this==d.target){a.enableFormElements(b(this))}})})(jQuery);$(document).ready(function(){var a=$("ul.tabs");a.each(function(b){var c=$(this).find("> li > a");c.click(function(f){var d=$(this).attr("href");if(d.charAt(0)=="#"){f.preventDefault();c.removeClass("active");$(this).addClass("active");$(d).show().addClass("active").siblings().hide().removeClass("active")}})})});jQuery(function(a){a("form a.add_nested_fields").live("click",function(){var h=a(this).attr("data-association");var e=a("#"+h+"_fields_blueprint").html();var d=(a(this).closest(".fields").find("input:first").attr("name")||"").replace(new RegExp("[[a-z]+]$"),"");if(d){var g=d.match(/[a-z_]+_attributes/g)||[];var c=d.match(/(new_)?[0-9]+/g)||[];for(i=0;i<g.length;i++){if(c[i]){e=e.replace(new RegExp("(_"+g[i]+")_.+?_","g"),"$1_"+c[i]+"_");e=e.replace(new RegExp("(\\["+g[i]+"\\])\\[.+?\\]","g"),"$1["+c[i]+"]")}}}var f=new RegExp("new_"+h,"g");var b=new Date().getTime();e=e.replace(f,"new_"+b);a(this).before(e);a(this).closest("form").trigger("nested:fieldAdded");return false});a("form a.remove_nested_fields").live("click",function(){var b=a(this).prev("input[type=hidden]")[0];if(b){b.value="1"}a(this).closest(".fields").hide();a(this).closest("form").trigger("nested:fieldRemoved");return false})});(function(a){a.fn.hoverIntent=function(l,k){var m={sensitivity:7,interval:100,timeout:0};m=a.extend(m,k?{over:l,out:k}:l);var o,n,h,d;var e=function(f){o=f.pageX;n=f.pageY};var c=function(g,f){f.hoverIntent_t=clearTimeout(f.hoverIntent_t);if((Math.abs(h-o)+Math.abs(d-n))<m.sensitivity){a(f).unbind("mousemove",e);f.hoverIntent_s=1;return m.over.apply(f,[g])}else{h=o;d=n;f.hoverIntent_t=setTimeout(function(){c(g,f)},m.interval)}};var j=function(g,f){f.hoverIntent_t=clearTimeout(f.hoverIntent_t);f.hoverIntent_s=0;return m.out.apply(f,[g])};var b=function(p){var g=jQuery.extend({},p);var f=this;if(f.hoverIntent_t){f.hoverIntent_t=clearTimeout(f.hoverIntent_t)}if(p.type=="mouseenter"){h=g.pageX;d=g.pageY;a(f).bind("mousemove",e);if(f.hoverIntent_s!=1){f.hoverIntent_t=setTimeout(function(){c(g,f)},m.interval)}}else{a(f).unbind("mousemove",e);if(f.hoverIntent_s==1){f.hoverIntent_t=setTimeout(function(){j(g,f)},m.timeout)}}};return this.bind("mouseenter",b).bind("mouseleave",b)}})(jQuery);(function(e){e.fn.raty=function(s){if(this.length==0){a("Selector invalid or missing!");return}else{if(this.length>1){return this.each(function(){e.fn.raty.apply(e(this),[s])})}}var p=e.extend({},e.fn.raty.defaults,s),w=e(this),n=this.attr("id"),o=0,x=p.starOn,t="",v=p.target,m=(p.width)?p.width:(p.number*p.size+p.number*4);if(n===undefined){n="raty-"+w.index();w.attr("id",n)}if(p.number>20){p.number=20}else{if(p.number<0){p.number=0}}if(p.path.substring(p.path.length-1,p.path.length)!="/"){p.path+="/"}w.data("options",p);if(!isNaN(parseInt(p.start))&&p.start>0){o=(p.start>p.number)?p.number:p.start}for(var u=1;u<=p.number;u++){x=(o>=u)?p.starOn:p.starOff;t=(u<=p.hintList.length&&p.hintList[u-1]!==null)?p.hintList[u-1]:u;w.append('<img id="'+n+"-"+u+'" src="'+p.path+x+'" alt="'+u+'" title="'+t+'" class="'+n+'"/>').append((u<p.number)?"&nbsp;":"")}if(p.iconRange&&o>0){b(n,o,p)}var r=e("<input/>",{id:n+"-score",type:"hidden",name:p.scoreName}).appendTo(w);if(o>0){r.val(o)}if(p.half){c(w,e("input#"+n+"-score").val(),p)}if(!p.readOnly){if(v!==null){v=e(v);if(v.length==0){a("Target selector invalid or missing!")}}if(p.cancel){var q=e("img."+n),y='<img src="'+p.path+p.cancelOff+'" alt="x" title="'+p.cancelHint+'" class="button-cancel"/>';if(p.cancelPlace=="left"){w.prepend(y+"&nbsp;")}else{w.append("&nbsp;").append(y)}e("#"+n+" img.button-cancel").mouseenter(function(){e(this).attr("src",p.path+p.cancelOn);q.attr("src",p.path+p.starOff);d(v,"",p)}).mouseleave(function(){e(this).attr("src",p.path+p.cancelOff);w.mouseout()}).click(function(z){e("input#"+n+"-score").removeAttr("value");if(p.click){p.click.apply(w,[null,z])}});w.css("width",m+p.size+4)}else{w.css("width",m)}w.css("cursor","pointer");h(w,p,v)}else{w.css("cursor","default");l(w,o,p)}return w};function h(o,n,p){var r=o.attr("id"),q=e("input#"+r+"-score"),m=o.children("img."+r);o.mouseleave(function(){g(o,q.val(),n);f(p,q,n)});m.bind(((n.half)?"mousemove":"mouseover"),function(t){b(r,this.alt,n);if(n.half){var s=parseFloat(((t.pageX-e(this).offset().left)/n.size).toFixed(1));s=(s>=0&&s<0.5)?0.5:1;o.data("score",parseFloat(this.alt)+s-1);c(o,o.data("score"),n)}else{b(r,this.alt,n)}d(p,this.alt,n)}).click(function(s){q.val(n.half?o.data("score"):this.alt);if(n.click){n.click.apply(o,[q.val(),s])}})}function f(o,p,m){if(o!==null){var n="";if(m.targetKeep){n=p.val();if(m.targetType=="hint"){if(p.val()==""&&m.cancel){n=m.cancelHint}else{n=m.hintList[Math.ceil(p.val())-1]}}}if(j(o)){o.val(n)}else{o.html(n)}}}function b(m,o,n){var p=e("img."+m).length,u=0,s=0,t,q;for(var r=1;r<=p;r++){t=e("img#"+m+"-"+r);if(r<=o){if(n.iconRange&&n.iconRange.length>u){q=n.iconRange[u][0];s=n.iconRange[u][1];if(r<=s){t.attr("src",n.path+q)}if(r==s){u++}}else{t.attr("src",n.path+n.starOn)}}else{t.attr("src",n.path+n.starOff)}}}function l(n,p,m){var o="";if(p!=0){p=parseInt(p);o=(p>0&&m.number<=m.hintList.length&&m.hintList[p-1]!==null)?m.hintList[p-1]:p}else{o=m.noRatedMsg}n.attr("title",o).children("img").attr("title",o)}function j(m){return m.is("input")||m.is("select")||m.is("textarea")}function g(n,o,m){var p=n.attr("id");if(isNaN(parseInt(o))){n.children("img."+p).attr("src",m.path+m.starOff);e("input#"+p+"-score").removeAttr("value");return}if(o<0){o=0}else{if(o>m.number){o=m.number}}b(p,o,m);if(o>0){e("input#"+p+"-score").val(o);if(m.half){c(n,o,m)}}if(m.readOnly||n.css("cursor")=="default"){l(n,o,m)}}function d(p,o,m){if(p!==null){var n=o;if(m.targetType=="hint"){if(o==0&&m.cancel){n=m.cancelHint}else{n=m.hintList[o-1]}}if(j(p)){p.val(n)}else{p.html(n)}}}function c(o,q,n){var r=o.attr("id"),m=Math.ceil(q),p=(m-q).toFixed(1);if(p>0.25&&p<=0.75){m=m-0.5;e("img#"+r+"-"+Math.ceil(m)).attr("src",n.path+n.starHalf)}else{if(p>0.75){m--}else{e("img#"+r+"-"+m).attr("src",n.path+n.starOn)}}}e.fn.raty.cancel=function(m,o){var n=(o===undefined)?false:true;if(n){return e.fn.raty.click("",m,"cancel")}else{return e.fn.raty.start("",m,"cancel")}};e.fn.raty.click=function(p,n){var o=k(p,n,"click"),m=e(n).data("options");if(n.indexOf(".")>=0){return}g(o,p,m);if(m.click){m.click.apply(o,[p])}else{a('You must add the "click: function(score, evt) { }" callback.')}return o};e.fn.raty.readOnly=function(p,n){var o=k(p,n,"readOnly"),m=e(n).data("options"),q=o.children("img.button-cancel");if(n.indexOf(".")>=0){return}if(q[0]){(p)?q.hide():q.show()}if(p){e("img."+o.attr("id")).unbind();o.css("cursor","default").unbind()}else{h(o,m);o.css("cursor","pointer")}return o};e.fn.raty.start=function(p,n){var o=k(p,n,"start"),m=e(n).data("options");if(n.indexOf(".")>=0){return}g(o,p,m);return o};function k(q,n,m){var o=undefined;if(n==undefined){a("Specify an ID or class to be the target of the action.");return}if(n){if(n.indexOf(".")>=0){var p;return e(n).each(function(){p="#"+e(this).attr("id");if(m=="start"){e.fn.raty.start(q,p)}else{if(m=="click"){e.fn.raty.click(q,p)}else{if(m=="readOnly"){e.fn.raty.readOnly(q,p)}}}})}o=e(n);if(!o.length){a('"'+n+'" is a invalid identifier for the public funtion $.fn.raty.'+m+"().");return}}return o}function a(m){if(window.console&&window.console.log){window.console.log(m)}}e.fn.raty.defaults={cancel:false,cancelHint:"cancel this rating!",cancelOff:"cancel-off.png",cancelOn:"cancel-on.png",cancelPlace:"left",click:null,half:false,hintList:["bad","poor","regular","good","gorgeous"],noRatedMsg:"not rated yet",number:5,path:"img/",iconRange:[],readOnly:false,scoreName:"score",size:16,starHalf:"star-half.png",starOff:"star-off.png",starOn:"star-on.png",start:0,target:null,targetKeep:false,targetType:"hint",width:null}})(jQuery);(function(d){d.timeago=function(g){if(g instanceof Date){return a(g)}else{if(typeof g==="string"){return a(d.timeago.parse(g))}else{return a(d.timeago.datetime(g))}}};var f=d.timeago;d.extend(d.timeago,{settings:{refreshMillis:60000,allowFuture:false,strings:{prefixAgo:null,prefixFromNow:null,suffixAgo:"ago",suffixFromNow:"from now",seconds:"less than a minute",minute:"about a minute",minutes:"%d minutes",hour:"about an hour",hours:"about %d hours",day:"a day",days:"%d days",month:"about a month",months:"%d months",year:"about a year",years:"%d years",numbers:[]}},inWords:function(m){var n=this.settings.strings;var j=n.prefixAgo;var r=n.suffixAgo;if(this.settings.allowFuture){if(m<0){j=n.prefixFromNow;r=n.suffixFromNow}m=Math.abs(m)}var p=m/1000;var g=p/60;var o=g/60;var q=o/24;var k=q/365;function h(s,u){var t=d.isFunction(s)?s(u,m):s;var v=(n.numbers&&n.numbers[u])||u;return t.replace(/%d/i,v)}var l=p<45&&h(n.seconds,Math.round(p))||p<90&&h(n.minute,1)||g<45&&h(n.minutes,Math.round(g))||g<90&&h(n.hour,1)||o<24&&h(n.hours,Math.round(o))||o<48&&h(n.day,1)||q<30&&h(n.days,Math.floor(q))||q<60&&h(n.month,1)||q<365&&h(n.months,Math.floor(q/30))||k<2&&h(n.year,1)||h(n.years,Math.floor(k));return d.trim([j,l,r].join(" "))},parse:function(h){var g=d.trim(h);g=g.replace(/\.\d\d\d+/,"");g=g.replace(/-/,"/").replace(/-/,"/");g=g.replace(/T/," ").replace(/Z/," UTC");g=g.replace(/([\+\-]\d\d)\:?(\d\d)/," $1$2");return new Date(g)},datetime:function(h){var j=d(h).get(0).tagName.toLowerCase()==="time";var g=j?d(h).attr("datetime"):d(h).attr("title");return f.parse(g)}});d.fn.timeago=function(){var h=this;h.each(c);var g=f.settings;if(g.refreshMillis>0){setInterval(function(){h.each(c)},g.refreshMillis)}return h};function c(){var g=b(this);if(!isNaN(g.datetime)){d(this).text(a(g.datetime))}return this}function b(g){g=d(g);if(!g.data("timeago")){g.data("timeago",{datetime:f.datetime(g)});var h=d.trim(g.text());if(h.length>0){g.attr("title",h)}}return g.data("timeago")}function a(g){return f.inWords(e(g))}function e(g){return(new Date().getTime()-g.getTime())}document.createElement("abbr");document.createElement("time")}(jQuery));$(function(){$(".rating").raty({path:"/images/raty",start:3});$(".timeago").timeago();$(".dropdown .toggle").click(function(){$(this).toggleClass("active").next().slideToggle("fast")})});