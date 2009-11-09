(function($) {
	var conf = {},
		numMSG = 20, 
		containerDiv="juitterContainer", 
		loadMSG="Loading messages...", 
		imgName="loader.gif", 
		readMore="Read it on Twitter", 
		nameUser="image",
		live ="live-20",
		aURL="",
		msgNb=1;
	var mode,mainUser,param,time,lang,contDiv,gifName,fromID,ultID,filterWords;
	var running=false,
		apifMultipleUSER = "http://search.twitter.com/search.json?from%3A",
		apifUSER = "http://search.twitter.com/search.json?q=from%3A",
		apitMultipleUSER = "http://search.twitter.com/search.json?to%3A",
		apitUSER = "http://search.twitter.com/search.json?q=to%3A",
		apiSEARCH = "http://search.twitter.com/search.json?q=";
		_that=this;
	$.Juitter = {
		registerVar: function(opt){
			mode=opt.searchType;
			mainUser=opt.searchObject.split(",")[0];
			param=opt.searchObject;
			timer=opt.live;
			lang=opt.lang?opt.lang:"";
			contDiv=opt.placeHolder?opt.placeHolder:containerDiv;
			loadMSG=opt.loadMSG?opt.loadMSG:loadMSG;
			gifName=opt.imgName?opt.imgName:imgName;
			numMSG=opt.total?opt.total:numMSG;
			readMore=opt.readMore?opt.readMore:readMore;
			fromID=opt.nameUser?opt.nameUser:nameUser;
			filterWords=opt.filter;
			openLink=opt.openExternalLinks?"target='_blank'":"";
		},
		start: function(opt) {		
			ultID=0;
			tultID = 0;
			if($("#"+contDiv)){	
				this.registerVar(opt);
				this.loading();
				aURL = this.createURL();
				$("#"+contDiv).html("");		
			    $("<ul></ul>").attr('class','twittList').appendTo("#"+contDiv);
				this.conectaTwitter();		
				if(timer!=undefined&&!running) this.temporizador();
			}   
		},
		update: function(){
			this.conectaTwitter();		
			if(timer!=undefined) this.temporizador();
		},
		loading: function(){
			if(loadMSG=="image/gif"){
				$("<img></img>")
					.attr('src', gifName)
					.appendTo("#"+contDiv); 
			} else $("#"+contDiv).html(loadMSG);
		},
		createURL: function(){
			var url = "";
			jlg=lang.length>0?"&lang="+lang:jlg=""; 
			var seachMult = param.search(/,/);
			if(seachMult>0) param = "&ors="+param.replace(/,/g,"+");
			if(mode=="fromUser" && seachMult<=0) url=apifUSER+param;
			else if(mode=="fromUser" && seachMult>=0) url=apifMultipleUSER+param;
			else if(mode=="toUser" && seachMult<=0) url=apitUSER+param;
			else if(mode=="toUser" && seachMult>=0) url=apitMultipleUSER+param;
			else if(mode=="searchWord") url=apiSEARCH+param+jlg;
			url += "&rpp="+numMSG;		
			return url;
		},
		conectaTwitter: function(){
			$.ajax({
				url: aURL,
				type: 'GET',
				dataType: 'jsonp',
				timeout: 1000,
				error: function(){ $("#"+contDiv).html("fail#"); },
				success: function(json){
					var item;
					for (var i=json.results.length-1; i >= 0 ; i--) {
						item = json.results[i];
						if(item.id > ultID) {
							if(i==0){
								tultID = item.id;
							}
							if (item.text != "undefined") {
								var link =  "http://twitter.com/"+item.from_user+"/status/"+item.id;  
								
								var tweet = item.text;
								var dateTwt = new Date(item.created_at);
								var time = [(dateTwt.getHours().toString().length == 1 ? "0" : "") + dateTwt.getHours().toString(), (dateTwt.getMinutes().toString().length == 1 ? "0" : "") + dateTwt.getMinutes().toString(), (dateTwt.getSeconds().toString().length == 1 ? "0" : "") + dateTwt.getSeconds().toString()];
								
								mHTML = "";
								if(fromID=="image") {
							        mHTML="<a href='http://www.twitter.com/"+item.from_user+"'><img src='"+item.profile_image_url+"' alt='"+item.from_user+"' class='juitterAvatar' /></a>";
								} 
								mHTML += "<p><a href='http://www.twitter.com/"+item.from_user+"' "+openLink+">@"+item.from_user+":</a> ";
								mHTML += $.Juitter.textFormat(tweet)+" <span class='time'>(dia "+dateTwt.getDate()+" as "+time[0]+":"+time[1]+":"+time[2]+")</span></p><div></div>";
								
								li = $("<li></li>") 
									.html(mHTML)  
									.attr('class', 'twittLI');
								if (item.from_user == mainUser) {
									li.addClass("color-comment-bg");
								}
								li.hide().prependTo("#"+contDiv+" > ul").slideDown('slow');
								
								if ($("#"+contDiv+" > ul").children().length>numMSG) {
								    $("#"+contDiv+" > ul > li:last").remove();
								}
							}
						}
					};
					ultID=tultID;
				}
			});
		},	
		textFormat: function(texto){
			//make links
			var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
			texto = texto.replace(exp,"<a href='$1' class='extLink' "+openLink+">$1</a>"); 
			var exp = /[\@]+([A-Za-z0-9-_]+)/ig;
			texto = texto.replace(exp,"<a href='http://twitter.com/$1' class='profileLink' "+openLink+">@$1</a>"); 
			var exp = /[\#]+([A-Za-z0-9-_]+)/ig;
			texto = texto.replace(exp,"<a href=\"http://search.twitter.com/search?q=%23$1\"  class=\"hashLink\" "+openLink+">#$1</a>"); 
			return texto;
		},
		temporizador: function(){
			// live mode timer
			running=true;
			aTim = timer.split("-");
			if(aTim[0]=="live" && aTim[1].length>0){
				tempo = aTim[1]*1000;
				setTimeout("$.Juitter.update()",tempo);
			}
		}
	};	
})(jQuery);