package com.luislarghi.myfirtsengine
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Engine_Game
	{
		protected var mainStage:Stage;
		
		protected var stateID:int = Engine_States.STATE_NULL;
		protected var nextState:int = Engine_States.STATE_NULL;
		protected var currentState:Engine_GameState = null;
		protected var screenBounds:Rectangle;
		
		public static var orgGameRes:Point;
		public static var newScaleX:Number = 1;
		public static var newScaleY:Number = 1;
		
		protected const LOW_FRAME_RATE:int = 10;
		protected var orgFrameRate:int;
		
		public function Engine_Game(s:Stage)
		{ 
			mainStage = s;
			
			orgFrameRate = mainStage.frameRate;
			
			mainStage.scaleMode = StageScaleMode.NO_SCALE;
			mainStage.align = StageAlign.TOP_LEFT;
			
			mainStage.addEventListener(Event.ENTER_FRAME, Update);
			mainStage.addEventListener(Event.RESIZE, AdjustScreenRes);
		}
		
		protected function Update(e:Event):void
		{
			ChangeState();
			
			// If the state is not a non-exit one
			if(stateID != Engine_States.STATE_EXITAPP && currentState)
			{
				currentState.Logic();
				currentState.Render();
			}
				// else quit the application
			else if(stateID == Engine_States.STATE_EXITAPP)
			{
				ExitApp();
			}
		}
		
		protected function ChangeState():void {}
		protected function ExitApp():void {}
		
		public function SetNextState(newState:int):void
		{
			// If player dont want to quit
			if(nextState != Engine_States.STATE_EXITAPP)
				nextState = newState;
		}
		
		private function AdjustScreenRes(e:Event):void
		{
			mainStage.removeEventListener(Event.RESIZE, AdjustScreenRes);
			
			var deviceSize:Point = new Point(
				Math.max(mainStage.fullScreenWidth, screenBounds.width),
				Math.min(mainStage.fullScreenHeight, (screenBounds.height + screenBounds.y))
			);
			
			newScaleX = deviceSize.x / orgGameRes.x;
			newScaleY = deviceSize.y / orgGameRes.y;
			
			trace("Device res: "+screenBounds+" | New device res: "+deviceSize+" | Stage res: "+"("+mainStage.fullScreenWidth+", "+mainStage.fullScreenHeight+")");
			trace("Game resolution: "+orgGameRes+" | New scale: ("+newScaleX+", "+newScaleY+")");
		}
	}
}