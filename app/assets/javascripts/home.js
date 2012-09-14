var app = function()
{

	
	
	var playlist = [];
	var _current = 0;
	var _total = 0;
	
	var pop;
	
	function clear_all()
	{
		$("#video iframe").each(function(){
			$(this).remove();
		});
	}
	
	return {


		alerty : function(par) 
		{

			console.log(par);

		},
		
		// dumb functions
		play : function(index)
		{
			
			if (index > _total-1) { index = 0; }
			if (index < 0) { index = 0; }
			
			_current = index;
			var url = playlist[_current].video.media_url 
			if (pop != undefined)
			{
				pop.destroy();
			}
			clear_all();
			pop =  Popcorn.smart( "#video", url );
			pop.play();
		 	pop.on("ended", function() { app.next(); });
		},
		
		pause : function()
		{
			pop.pause();
		},
		
		next : function()
		{
			_current++;
			app.play(_current);
		},
		
		prev : function()
		{
			_current--;
			app.play(_current);
		},
		
		
		
		init_player : function()
		{
			 
			app.play(_current);
			$("#next").click(function(){
				app.next();
			});
			  
		},
	
		init : function()
		{
			
		    $.getJSON('/data.js', function(data){
				playlist = data.station.videos;
				_total = playlist.length;
				console.log(playlist[0].video.media_url);
				app.init_player();
				
		  	});	
		},

	}
}();
