package component
{
	/**
	 * 门类
	 * @author yzpTsubasa
	 * @version 2014.01.14
	 */
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Door extends Sprite
	{
		[Embed(source="resource/mat_door.png")]
		private var ImageObject:Class;
		private var imageobject:DisplayObject=new ImageObject();
		public function Door()
		{
			addChild(imageobject);
			imageobject.width=Scene.SIZE;
			imageobject.height=Scene.SIZE*1.2;
		}
	}
}