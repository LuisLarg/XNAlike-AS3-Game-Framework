package com.luislarghi.myfirtsengine
{
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public final class Engine_SoundManager
	{
		//private static var music:Sound;
		private static var soundChannel:SoundChannel;
		private static var musicChannel:SoundChannel;
		private static var isMusicPlaying:Boolean = false;
		
		public static function PlayMusic(music:Sound):void
		{
			if(!isMusicPlaying)
			{
				musicChannel = music.play(0, int.MAX_VALUE);
				isMusicPlaying = true;
			}
		}
		
		public static function StopMusic():void
		{
			musicChannel.stop();
			isMusicPlaying = false;
		}
		
		public static function PlaySound(sound:Sound):void
		{
			soundChannel = sound.play(0, 1);
		}
		
		public static function StopSound():void
		{
			soundChannel.stop();
		}
	}
}