package com.luislarghi.myfirtsengine
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Engine_Game
	{
		protected var mainStage:Stage;
		
		protected var stateID:int = Engine_States.STATE_NULL;
		protected var nextState:int = Engine_States.STATE_NULL;
		protected var currentState:Engine_GameState = null;
		
		public static var orgGameRes:Point;
		public static var newScale:Number = 1;
		
		protected const LOW_FRAME_RATE:int = 10;
		protected var orgFrameRate:int;
		
		public function Engine_Game(s:Stage)
		{ 
			mainStage = s;
			
			mainStage.addEventListener(Event.ENTER_FRAME, Update);
			mainStage.addEventListener(Event.RESIZE, AdjustScreenRes);
			
			//AdjustScreenRes(null);
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
			var deviceSize:Point = new Point(
				Math.max(mainStage.fullScreenWidth, mainStage.fullScreenHeight),
				Math.min(mainStage.fullScreenWidth, mainStage.fullScreenHeight)
			);
			
			var newScaleX:Number = deviceSize.x / orgGameRes.x;
			var newScaleY:Number = deviceSize.y / orgGameRes.y;
			newScale = Math.min(newScaleX, newScaleY, 1);
			
			trace("Device resolution: "+deviceSize);
			trace("Game resolution: "+orgGameRes);
			trace("New scale = "+newScale);
		}
	}
}