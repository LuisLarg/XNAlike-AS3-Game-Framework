package com.luislarghi.myfirtsengine
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Engine_SpriteSheet extends Sprite
	{
		private var tileSheetBitmapData:BitmapData;
		private var canvasBitmapData:BitmapData;
		
		private var tileWidth:int;
		private var tileHeight:int;
		private var rowLength:int;
		
		private var tileRectangle:Rectangle;
		private var tilePoint:Point;
		
		private var triggerable:Boolean;
		private var colideable:Boolean;
		private var tileID:int;
		
		public function Engine_SpriteSheet(tileSheetBitmap:Bitmap, c:Boolean, width:Number = 16, height:Number = 16, id:int=0) 
		{   
			tileSheetBitmapData = tileSheetBitmap.bitmapData.clone();
			tileWidth = width;
			tileHeight = height;
			
			colideable = c;
			tileID = id;
			
			rowLength = int(tileSheetBitmap.width / width);
			
			tileRectangle = new Rectangle(0, 0, tileWidth, tileHeight);
			tilePoint = new Point(0, 0);
			
			canvasBitmapData = new BitmapData(tileWidth, tileHeight, true);
			var canvasBitmap:Bitmap = new Bitmap(canvasBitmapData);
			addChild(canvasBitmap);
			
			drawTile(0);
			
			addEventListener(Event.REMOVED_FROM_STAGE, remove);
		}
		
		public function drawTile(tileNumber:int):BitmapData
		{
			tileRectangle.x = int((tileNumber % rowLength)) * tileWidth;
			tileRectangle.y = int((tileNumber / rowLength)) * tileHeight;
			canvasBitmapData.copyPixels(tileSheetBitmapData, tileRectangle, tilePoint);
			
			return canvasBitmapData.clone();
		}
		
		public function tileBoard(boardIndex:Array):BitmapData
		{
			var wide:int = boardIndex[0].length;
			var tall:int = boardIndex.length;
			
			canvasBitmapData = new BitmapData((tileWidth * wide), (tileHeight * tall), true);
			var boardCanvas:Bitmap = Bitmap(getChildAt(0));
			boardCanvas.bitmapData = canvasBitmapData;
			
			tileRectangle = new Rectangle(0, 0,(tileWidth * wide), (tileHeight * tall));
			for (var i:int = 0; i < wide; i++) {
				for (var j:int = 0; j < tall; j++) {
					tilePoint = new Point((tileWidth * i), (tileHeight * j));
					
					drawTile(boardIndex[j][i]);
				}
			}
			return canvasBitmapData.clone();
		}
		
		public function remove(e:Event):void
		{
			removeChildren();
			tileSheetBitmapData.dispose();
			canvasBitmapData.dispose();
			canvasBitmapData = null;
			tileSheetBitmapData = null;
			
			//trace("Bitmap got removed!");
		}
		
		public function GetRowLength():int { return rowLength; }
		public function get IsColideable():Boolean { return colideable; }
		public function get ID():int { return tileID; }
	}
}