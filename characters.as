package{
	import flash.events.*;
	import flash.display.*;
	
	public class characters extends MovieClip{
		
		var justAdd:Boolean = true;
		var w_orig:Number;
		var h_orig:Number;
		var x_orig:Number;
		var y_orig:Number;
		var cost:int;
		var range:Number;
		var go:Boolean = false;
		
		public function characters():void{
			this.addEventListener(Event.ADDED, added);
			
		}
		
		function added(e:Event){
			if (this.justAdd){
			this.w_orig = this.width;
			this.h_orig = this.height;
			removeEventListener(Event.ADDED, added);
			this.addEventListener(Event.ENTER_FRAME, moveChar);
			this.addEventListener(MouseEvent.CLICK, placeChar);
	
			}
		}
		
		function moveChar(e:Event){
			this.x = stage.mouseX;
			if (stage.mouseX>900){
				this.x = 900;
			}
			this.y = stage.mouseY;
			this.width = this.w_orig*.6;
			this.height = this.h_orig*.6;
			this.alpha = .50;
			
		}
		
		function placeChar(e:Event){
			MovieClip(root).munny-=cost;
			
			var myCircle:Shape = new Shape();
				myCircle.graphics.beginFill(0xFFFFFF);
				myCircle.graphics.drawCircle(this.x, this.y, range);
				myCircle.graphics.endFill();
				myCircle.alpha=.30;
				this.parent.parent.addChild(myCircle);			
			
			removeEventListener(Event.ENTER_FRAME, moveChar);
			
			this.alpha = 1;
			this.width = this.w_orig;
			this.height = this.h_orig;
			this.x_orig = this.x;
			this.y_orig = this.y;
			startUp();
			removeEventListener(MouseEvent.CLICK, placeChar);
			
		}
		
		function startUp(){
			;
		}
		
	}
}
		