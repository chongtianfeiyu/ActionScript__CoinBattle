package component
{
	/**
	 * 背景图类
	 */
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Background extends Sprite
	{
		[Embed(source="resource/coinbg.png")]
		private var CImageObject:Class;
		private var _alpha:Number=0.8;
		private var imageobject:DisplayObject=new CImageObject();
		public function Background()
		{
		   this.addChild(imageobject);
		   imageobject.alpha=_alpha;
		}
	}
}