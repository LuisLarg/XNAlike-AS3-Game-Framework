package com.luislarghi.myfirtsengine
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class Engine_GUIButton extends Sprite
	{
		protected var spriteSheet:Engine_SpriteSheet;
		protected var currentSpriteS:Bitmap;
		protected var currentAnimFrame:int = 0;
		
		protected var text:String;
		protected var btWidth:int;
		protected var btHeight:int;
		protected var state:int;
		
		protected var mainGame:Engine_Game;
		
		public function Engine_GUIButton(label:String, w:int, h:int, bM:Bitmap, s:int, g:Engine_Game)
		{
			btWidth = w;
			btHeight = h;		
			text = label;
			state = s;
			currentSpriteS = bM;
			mainGame = g;
			
			this.addEventListener(Event.ADDED_TO_STAGE, Init);
			this.addEventListener(Event.REMOVED_FROM_STAGE, Clear);
			
			InstantiateAllTF();
		}

		protected function Init(e:Event):void 
		{ 
			this.removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			spriteSheet = new Engine_SpriteSheet(currentSpriteS, false, btWidth, btHeight);
			this.addChild(spriteSheet);
		}
		
		protected function Clear(e:Event):void 
		{ 
			this.removeEventListener(Event.REMOVED_FROM_STAGE, Clear);
			
			this.removeChild(spriteSheet);
			spriteSheet = null;
		}
		
		protected function InstantiateAllTF():void {}
		
		public function Draw():void { spriteSheet.drawTile(currentAnimFrame); }
		public function Size():Point { return new Point(btWidth, btHeight); }
		public function ChangeAnimation(v:int):void { currentAnimFrame = v; }
	}
}