package{
	import flash.events.*;
	import flash.display.*;
	
	public class gem extends MovieClip{
		
			var i:Number = 0;
			var worth:Number;
			var circleSpeed:Number;
			var lifeSpan:Number;
			var gemSpeed:Number;
			
		public function gem():void{
			
			gemSpeed = 1;
			lifeSpan = 2;
			worth = Math.random() + 0.5; // worth from 0.5 - 1.5
			this.width *= worth;
			this.height *= worth;
			this.addEventListener(Event.ENTER_FRAME, circle);
			this.addEventListener(MouseEvent.ROLL_OVER, addMoney);
			this.circleSpeed = Math.random()*2 - 1;
		
		}
		
		
		
		function circle(e:Event):void{
			
			this.x += circleSpeed*Math.cos(i);
			this.y += circleSpeed*Math.sin(i);
			
			i+=.1;
			
			if (i>lifeSpan){
				disappear();
			}
			
		}
		
		function disappear(){
				removeEventListener(Event.ENTER_FRAME, circle);
				removeEventListener(MouseEvent.MOUSE_OVER, addMoney);
				for(var i:int=0; i<MovieClip(root).gemList.length; i++){
					if (this == MovieClip(root).gemList[i]){
						MovieClip(root).gemList.splice(i, 1);
					}
				}
				this.parent.removeChild(this);
				
				
		}
		
		function addMoney(e:Event):void{
			
			MovieClip(root).munny+=2*(int(6*worth));
			MovieClip(root).collectSound.play();
			disappear();
			
		}
		
	}
	
}