package{
	import flash.events.*;
	import flash.display.*;
	
	public class nobody extends enemies{
		
		
		public function nobody():void{
			
			this.livesMax = 300;
			this.livesCount = 300;
			
		}
		
		override function setup(e:Event){
			this.livesMax = MovieClip(root).currentLvl*100;
			this.livesCount = MovieClip(root).currentLvl*100;
		}
		
		
		
	}
	
}