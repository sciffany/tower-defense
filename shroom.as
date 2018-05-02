package{
	import flash.events.*;
	import flash.display.*;
	
	public class shroom extends characters{
		
		var shortestDistance:Number;
		var nearestGem:gem;
		var myGems: Array;
		
		public function shroom():void{
			
			cost = 150;
			myGems = [];
			range = 100;
		}
		
		override function startUp(){
									
				this.addEventListener(Event.ENTER_FRAME, gemCheck);
			
		}
		
		function gemCheck(e:Event){
			var x:Number = Math.random();
			
			this.play();
			this.justAdd = false;
			
			for(var i:int=0; i<MovieClip(root).gemList.length; i++){
				var gem1: gem = MovieClip(root).gemList[i];
				if(this.hitTestObject(gem1) && gem1.worth < 1){
					var gem_out:Boolean = true;
					//check if gem1 is out
					for(var k:int=0; k<myGems.length; k++){
						if (myGems[k] == gem1){
							gem_out = false;
						}
					}
					if (gem_out){
						myGems.push(gem1);
					}
					else{
						gem1.gemSpeed+=0.5;
					}
					
				}

			}
			for(var j:int=0; j<myGems.length; j++){
				var myGem: gem = myGems[j];

					if (myGem.x>this.x+15){myGem.x-=myGem.gemSpeed;}
					if (myGem.x<this.x+5){myGem.x+=myGem.gemSpeed;}
					if (myGem.y>this.y-5){myGem.y-=myGem.gemSpeed;}
					if (myGem.y<this.y-25){myGem.y+=myGem.gemSpeed;}
					
					myGem.lifeSpan = 30;
					//myGem.rotation+=1;
				
			}
					
			
		}
		
		public function remove(){
			
			removeEventListener(Event.ENTER_FRAME, gemCheck);
			removeEventListener(Event.ENTER_FRAME, startUp);	
			this.parent.removeChild(this);
			
		}
		
		
			
	}
}