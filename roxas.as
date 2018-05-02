package{
	import flash.events.*;
	import flash.display.*;
	
	public class roxas extends characters{

		var framespassed: int = 0;
		var shortestDistance:Number;
		var nearestEnemy:enemies;
		var mySpeed:int = 2;
		var busy:Boolean = false;

		public function roxas():void{
			cost = 450;
			range = 100;
		}
		
		override function startUp(){
				this.addEventListener(Event.ENTER_FRAME, enemyCheck);
		}
		
		function enemyCheck(e:Event){
			this.justAdd = false;
			
			
			if (!busy){
			this.shortestDistance = range*range;
			
			//search nearest enemy
			for(var i:int=0; i<MovieClip(root).enemyList.length; i++){
				var enemy: enemies = MovieClip(root).enemyList[i];
					var distance:Number = Math.pow((enemy.x - this.x_orig), 2) + Math.pow((enemy.y - this.y_orig), 2);
					if(distance<range*range && distance<this.shortestDistance){
						this.shortestDistance = distance;
						this.nearestEnemy = enemy;
					}
			}
			
			if (this.shortestDistance <range*range) {
				busy = true;
				this.addEventListener(Event.ENTER_FRAME, approachEnemy);
				removeEventListener(Event.ENTER_FRAME, enemyCheck);
			}
			
			else{
				
				this.gotoAndPlay("stand");
				if (this.x < this.x_orig){
					this.x+=mySpeed;
				}
				if (this.y < this.y_orig){
					this.y+=mySpeed;
				}
				if (this.x > this.x_orig){
					this.x-=mySpeed;
				}
				if (this.y > this.y_orig){
					this.y-=mySpeed;
				}
			}
		}
		}
		
		function followEnemy(){
			if (this.x < this.nearestEnemy.x-15){
				this.x+=mySpeed;
			}
			if (this.y < this.nearestEnemy.y-30){
				this.y+=mySpeed;
			}
			if (this.x > this.nearestEnemy.x-15){
				this.x-=mySpeed;
			}
			if (this.y > this.nearestEnemy.y-30){
				this.y-=mySpeed;
			}
			
			if (this.hitTestObject(nearestEnemy)){
				nearestEnemy.getHit = true;
				this.nearestEnemy.livesCount -=3;
			}
			
			if (Math.pow((this.nearestEnemy.x - this.x_orig), 2) + Math.pow((this.nearestEnemy.y - this.y_orig), 2) > range*range){
				busy = false;
				this.gotoAndPlay("stand");
				nearestEnemy.gotoAndPlay(1);
				nearestEnemy.getHit = false;
				removeEventListener(Event.ENTER_FRAME, attack);
				this.addEventListener(Event.ENTER_FRAME, enemyCheck);
			}
			
		}
		
		function approachEnemy(e:Event){
			this.gotoAndPlay("stand");
			
			followEnemy();
			
			if (Math.abs(this.x - (this.nearestEnemy.x-15))<5){
				this.gotoAndPlay(5);
				this.addEventListener(Event.ENTER_FRAME, attack);
				removeEventListener(Event.ENTER_FRAME, approachEnemy);
				
			}
			
		}
		
		
		function attack(e:Event){
			
			followEnemy();
			
			
			if (nearestEnemy.livesCount<0){
				busy = false;
				this.gotoAndPlay("stand");
				removeEventListener(Event.ENTER_FRAME, attack);
				this.addEventListener(Event.ENTER_FRAME, enemyCheck);
			}
		}
		
		public function remove(){
			
			removeEventListener(Event.ENTER_FRAME, enemyCheck);
			this.parent.removeChild(this);
			
		}
		
	}
	
}