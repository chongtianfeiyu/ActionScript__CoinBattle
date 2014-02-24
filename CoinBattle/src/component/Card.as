package component
{
	/**
	 * 卡片类
	 * @author yzpTsubasa
	 * @version 2013.12.21
	 */
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Card extends Sprite
	{
		[Embed(source="resource/card.png")]
		private var CImageObject:Class;
		//图片实例
		private var imageobject:DisplayObject=new CImageObject();
		/**
		 * 卡片类构造函数
		 */
		public function Card()
		{
			this.addChild(imageobject);
		}
	}
}