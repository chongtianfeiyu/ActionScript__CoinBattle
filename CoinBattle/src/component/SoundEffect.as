package component
{
	import flash.media.Sound;

	/**
	 * 总音效类，负责所有的游戏音效。
	 * @author yzpTsubasa
	 * @version 2014.01.09
	 */
	public class SoundEffect
	{
		// 音频采样率只支持如下四种：5500 Hz 11025 Hz 22050 Hz 44100 Hz
		
		//跳跃音效
		[Embed(source="resource/jumpSound2.mp3")]
		private static var JumpSound:Class;
		private static var jumpSound:Sound=new JumpSound();
		public function SoundEffect()
		{
		}
		/**
		 * 跳跃音效
		 */
		public static function jump():void
		{
			jumpSound.play();
		}
	}
}