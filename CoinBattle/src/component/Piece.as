package component
{
	/**
	 * 块类，场景中的对象
	 * @author yzpTsubasa
	 * @version 2013.12.21
	 */
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class Piece extends Sprite
	{
		[Embed(source="resource/wall.png")]
		private var CImageObject:Class;
		//图像实例
		private var imageobject:DisplayObject=new CImageObject();
		/**
		 * 块类的构造函数
		 */		
		public function Piece()
		{
			this.addChild(imageobject);
			imageobject.width=Scene.SIZE;
			imageobject.height=Scene.SIZE;
			//this.scrollRect=new Rectangle(0,0,Scene.SIZE,Scene.SIZE);
		}
	}
}