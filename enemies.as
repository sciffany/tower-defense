package{
	import flash.events.*;
	import flash.display.*;
	
	public class enemies extends MovieClip{
		
		var livesCount:Number;
		var livesMax:Number;
		var lives:myText;
		var xSpeed:Number=1;
		var ySpeed:Number=1;
		var frames:int=0;
		var getHit:Boolean = false;
		
		public function enemies():void{
			
			var rand1:Number = Math.random();
			var rand2:Number = Math.random();
			
			if (rand1>0.5){
				xSpeed*=-1;
			}
			if (rand2>0.5){
				ySpeed*=-1;
			}
			
			lives = new myText();
			lives.y = -30;
			lives.textShown.text = "";
			addChild(lives);
			this.addEventListener(Event.ENTER_FRAME, showLife);
			this.addEventListener(Event.ADDED, setup);
								
		}
		
		function setup(e:Event){
			;
		}
		
		function produceGem(){
			
				MovieClip(root).gemSound.play();	
				var someGem:gem = new gem();
				someGem.gotoAndStop(int(Math.random()*3 + 1));
				someGem.x = Math.random()*200-100+this.x;
				someGem.y = Math.random()*200-100+this.y;
				this.parent.addChild(someGem);
				MovieClip(root).gemList.push(someGem);
		}
		
		function showLife(e:Event):void{
			
			removeEventListener(Event.ADDED, setup);
			
			frames++;
			lives.y = -60;
			
			if (this.hitTestObject(MovieClip(root).tower)){
				MovieClip(root).citizens -=1;
				this.x=0;
			}
			this.x+=xSpeed;
			this.y+=ySpeed;
			
			if (this.x+this.width/2>900){
				this.xSpeed*=-1;
			}
			
			if (this.x-this.width/2<0){
				this.x=this.width/2;
				this.xSpeed*=-1;
			}
			
			if (this.y+this.height/2>800){
				this.y=799 - this.height/2;
				this.ySpeed*=-1;
			}
			
			if (this.y-this.height/2<0){
				this.y=this.height/2;
				this.ySpeed*=-1;
			}
			
			//show life count
			if (frames%10==0 && this.getHit){
				lives.textShown.text = ""+livesCount;
				// get hit and produce gems;
				if (livesCount<livesMax){
					MovieClip(root).hitSound.play();
					this.gotoAndPlay("hit");
					if (frames%4==0)
					{produceGem()}
				}
				livesCount-=1;
				lives.y = -30;
			}
			
			if (livesCount<0){
				MovieClip(root).enemyDead.push(this);
			
				for(var i:int=0; i<MovieClip(root).enemyList.length; i++){
					if (this == MovieClip(root).enemyList[i]){
						MovieClip(root).enemyList.splice(i, 1);
					}
				}
			
				for (var j:int; j<5; j++){
					produceGem();
				}
			
				remove();
			}
			
		}
			
		public function remove(){
			
			removeEventListener(Event.ENTER_FRAME, showLife);
			this.parent.removeChild(this);
			
		}
		
	}
	
}