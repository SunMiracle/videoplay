<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>s
<!DOCTYPE html>
<html lang="ch">
<head>
	<title>個人作品詳情頁</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="content-type" content="text/html;charset=utf-8">
	<meta content="always" name="referrer">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="theme-color" content="#2932e1">
	<%@ include file="/home/js/All.inc" %>
	<%@ include file="/home/js/login.inc" %>
	<script>
		window.onload = function(){
			var loadTime = window.performance.timing.domContentLoadedEventEnd-window.performance.timing.navigationStart; 
			console.log("加载时间:".concat(loadTime));
		}
    </script>
</head>ss
<body id="body">
	<script type="text/javascript">
		var loading_window = function( key , str ){
			var page_body = document.getElementsByTagName("body");

			var tag = document.createElement("div");
			var textnode = document.createTextNode(str);
			tag.appendChild(textnode);
			
			page_body[0].appendChild(tag);
		}
	</script>
	<nav class="menu">
		<div class="time">
			<span>{{ day }} {{ time }}</span>
		</div>
		<ul>
			<li v-for="todo in nav">{{ todo.text }}</li>
		</ul>
	</nav>
	<!-- swipe -->
	<section id="swipe">
		<div class="custom1 owl-carousel owl-theme"></div>
	</section>
	<!-- ///////////////// -->
	<div class="centent">
		<div class="account">
			<img src="\home\common\up.gif">
			<div>
				<div class="content">
					<p>2年工作经验</p>
					<p></p>
				</div>
			</div>
		</div>
		<div class="code code-layout"></div>
	</div>
	<section class="show_code_all">
		<pre><button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button><code class="language-javascript" data-lang="javascript"></code></pre>
	</section>

	<%@ include file="/home/js/footer.inc" %>
	<script type="text/javascript">
		var owl =  $('.custom1');
		// var banner_vue = new Vue({
		// 	el: ".custom11",
		// 	data: {
		// 		banner: [

		// 		]
		// 	}
		// });
		$(document).ready(function(){
			var loadTime = window.performance.timing.domContentLoadedEventEnd-window.performance.timing.navigationStart; 
			console.log("加载时间:".concat(loadTime));
			var time_length = 1;
			var time_plus = 0;
			var eve_day = ['星期天', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
			nav_top.day = eve_day[new Date().getDay()];
			function add_time(){
				var now_time = new Date();
				nav_top.time = now_time.getHours() + ":" + now_time.getMinutes() + ":";
				/* 秒数 */
				nav_top.time += (now_time.getSeconds() < 10) ? "0" + now_time.getSeconds() : now_time.getSeconds();
			}
			/* 让一开始就渲染时间 */
			add_time();
			setInterval(add_time,1000);				
				/* 昆特牌式自动添加牌 */
				// if(nav_top.time >= 10){
				// 	var span_length = $(".time").children("span").length;
				// 	for(var i = 0; i < span_length; i++){
				// 		if( i+1 == $(".time").children("span").length && $(".time").children("span:eq(" + ($(".time").children("span").length-1) + ")").html() > 8 ){
				// 			if( $(".time").children("span:eq("+ ($(".time").children("span").length-1) + ")").html() ){

				// 			} else{
				// 				$(".time").children("span:eq("+ ($(".time").children("span").length-1) + ")").before("<span>1</span>");
				// 			}
				// 			console.log(true)
				// 		}
				// 	}	

			/* swip */
			var banner_json;
			$.ajax({
				url:"/home/js/banner.json",
				cache:false,
				success:function( request ){
					console.log(request)
					if( typeof request == "string"  )
						banner_json = JSON.parse(request);
					else
						banner_json = request;
					var banner_code = "";

					/* js 写法 */
					for(var i = 0; i < banner_json.banner.length; i++){
						banner_code += "<div class=\"item\" data-background=\"" + banner_json.banner[i].item.background_color + "\">";
						banner_code += "<img src=\"" + banner_json.banner[i].item.background + "\">";
						try{
							for(var k =0; k < banner_json.banner[i].item.image.length; k++){
								banner_code += "<img class=\"animated\" data-delay=\"" + banner_json.banner[i].item.image[k][2] + "\" data-animation=\"" + banner_json.banner[i].item.image[k][1] + "\" src=\"" + banner_json.banner[i].item.image[k][0]+ "\">";
							}
						} catch(err){
							console.log(err)
						}
						banner_code += "</div>";
					}
					console.log(banner_code)
					$(".custom1").append(banner_code);
					/* Vue 写法 */					// for(var i = 0; i < banner_json.banner.length; i++){
					// 	banner_vue.banner.push({ img_src_background : banner_json.banner[i].item.background});
					// }

					/* 注意这个插件loop:true时 前后各添加两个实现无限循环 */

					owl.owlCarousel({
					    items: 1,
					    /* loop:ture 前后各加二个  */
		                loop: true,
		                rewindNav : true,
		                nav:true,
					    smartSpeed:450,
					    lazyLoad : true,
					    responsiveClass : true,
					    /* 初始化的时候调用 */
					    onInitialized:function(){
					    	console.log("once");
							owl_event_open()
						}
					});
				}
			});
			/* 滑动结束 开始执行动画 
			owl.on('translated.owl.carousel',owl_event_open);*/
			/*owl.on('translated.owl.carousel',owl_event_open);*/
			function owl_event_open(){
				console.log($(".owl-item.active .item").children("img"));
				$(".owl-item.active .item").children("img").each(function(){
					$(this).addClass( $(this).attr("data-animation") );
					$(this).attr("style", "animation-delay:" + $(this).attr("data-delay") + ";-webkit-animation-delay:" + $(this).attr("data-delay")  )
				});
				$("#swipe").css( "background",$(".owl-item.active .item").attr("data-background") );
			}

			/* 移动开始前 */
			owl.on('translate.owl.carousel',function(event){
				console.log($(".owl-item.active .item").children("img"))
				$(".owl-item.active .item").children("img").each(function(){
					$(this).removeClass( $(this).attr("data-animation") );
				});
				/* 滚动后立马触发消除原先图片原形开始新的动画 */
				setTimeout(owl_event_open,10);
			});
			/* banner end */


		});
		var nav_top = new Vue({
			el: '.menu',
			data:{
				nav:[
					{ text :"个人简介" },
					{ text :"分享代码" },
					{ text :"参加/获得事项" }
				],
				time: "",
				day: ""
			},
			completed:{
				time:function(){
					console.log("太I壳牌了")
				}
			}
		});
		/*  code get */
		var show_code_button = new Array();
		$.ajax({
			url: "/home/admin/code.jsp",
			type:"get",
			cache: false,
			success: function( request ){
				var i = 0;
				var code = "";
				var index = 0;
				$(request).find(".tab-content").children(".tab-pane").each(function(){
					show_code_button[i] = new Array();
					show_code_button[i][0] = $(this).find("textarea[name=code]").val();
					show_code_button[i][1] = $(this).find("textarea[name=descript]").val();
					i++;
				})
				i = 0;
				$(request).find(".nav-tabs").children("li").each(function(){
					code += "<div class=\"code-button\">" + "<div class=\"code-content\"><b>" + $(this).find("input").val() + "</b><p>" + show_code_button[i][1] + "</div></div>";
					i++;
				});
				i = 0;

				$(".code").html(code);

				var code_button_max_width = new Array();

				$(".code-content").each(function(){
					code_button_max_width[i] = $(this).height();
					console.log($(this).height())
					i++;
				});
				$(".code-content").height(Math.max(parseInt(code_button_max_width.toString())));
				
				i=0;

				$(".code").children(".code-button").on("click",function(){
					var index = $(".code").children(".code-button").index(this);
					$(".show_code_all").css({"opacity":1,"top":"20%"});
					$(".show_code_all pre code").html(show_code_button[index][0]);
				});
			}
		});
		$(".show_code_all .close").on("click",function(){
			$(".show_code_all").css({"opacity":0,"top":"-100%"});
		});
	</script>
</body>
</html>