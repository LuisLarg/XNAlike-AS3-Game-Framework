package com.luislarghi.myfirtsengine
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Engine_GameState extends Sprite
	{
		protected var mainStage:Stage;
		protected var mainGame:Engine_Game;
		
		protected static var pause:Boolean;
		protected static var gameOver:Boolean;
		
		function Engine_GameState(s:Stage, g:Engine_Game)
		{
			mainStage = s;
			mainGame = g;
			
			this.scaleX = Engine_Game.newScaleX;
			this.scaleY = Engine_Game.newScaleY;
			
			this.addEventListener(Event.ADDED_TO_STAGE, Init);
			this.addEventListener(Event.REMOVED_FROM_STAGE, Clear);
		}
		
		public function Logic():void {}
		public function Render():void
		{
			BeginDraw();
			Draw();
			EndDraw();
		}
		
		protected function Init(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			pause = false;
			gameOver = false;
		}
		protected function Clear(e:Event):void { this.removeEventListener(Event.REMOVED_FROM_STAGE, Clear); }
		
		protected function BeginDraw():void {}
		protected function Draw():void {}
		protected function EndDraw():void {}

		public function GetGameOver():Boolean { return gameOver; }
		public function SetGameOver(v:Boolean):void { gameOver = v; }		
	}
}