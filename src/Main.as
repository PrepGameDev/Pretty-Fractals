package {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class Main extends Sprite {
		
		public var containers:Vector.<Container> = new Vector.<Container>		
		
		public function Main():void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown)
			stage.addEventListener(Event.ENTER_FRAME, loop)
		}
		public function mouseDown(e:MouseEvent):void {
			var container:Container = new Container
			drawSquare(e.stageX, e.stageY, 65, 0, container, container)
			stage.addChild(container)
			containers.push(container)
		}		
		
		public function drawSquare(	X:Number, Y:Number, size:Number = 50, angle:Number = 0,
									canvas:DisplayObjectContainer = null, container:Container = null, count:int = 0):void {
			var s:Sprite = new Sprite
			s.graphics.beginFill(Math.random() * 0xFFFFFF, .75)
			s.graphics.drawRect(0, 0, size, size)			
			s.x = X
			s.y = Y
			s.rotation = angle * (180 / Math.PI)					
			canvas.addChild(s)
			count++
			s.visible = false	
			container.squares.push(s)
			if (size > 0) {
				var i:int = 0
				var len:int = 4
				if(count != 1){
					if (Math.random() < (size * 3) / 100) len = 1
					if (len == 1 && Math.random() < .5) i = 1; len = 2;
				}
				for (; i < len; i++) {					
					var fracAngle:Number = (angle +i*90) * (Math.PI/180)
					var fracX:Number =  (Math.cos(fracAngle) + 1) * size * .5 
					var fracY:Number =  (Math.sin(fracAngle) + 1) * size * .5 
					drawSquare(fracX, fracY, size-7.5,fracAngle-45 * (Math.PI/180),s,container, count)
				}				
				
			}
		}		
		
		public function loop(e:Event):void {		
			
			for (var i:int = 0; i < containers.length; i++) {
				var container:Container = containers[i]
				if(!container.done){
					if(container.index < container.squares.length){
						var square:Sprite = container.squares[container.index++]
						square.visible = true
					}else {
						container.done = true					
					}
				}else{
					container.alpha = container.alpha - .01
					if (container.alpha <= 0) {
						stage.removeChild(container)
						containers.splice(i, 1)
					}
				}
			}
		}
	}	
}