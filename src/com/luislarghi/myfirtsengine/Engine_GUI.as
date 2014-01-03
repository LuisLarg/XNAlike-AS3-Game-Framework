package com.luislarghi.myfirtsengine
{
	import flash.display.Stage;
	
	public class Engine_GUI
	{
		protected var mainStage:Stage;
		protected var mainGame:Engine_Game;
		
		function Engine_GUI(s:Stage, g:Engine_Game)
		{ 
			mainStage = s;
			mainGame = g;
			InstantiateAllTF();
		}
		
		protected function InstantiateAllTF():void {}
		
		public function Init():void {}
		public function Clear():void {}
		public function Logic():void {}
		public function Draw():void {}
	}
}