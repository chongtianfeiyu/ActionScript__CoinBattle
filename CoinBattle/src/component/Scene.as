package component
{
	/**
	 * 场景类
	 * @author yzpTsubasa
	 */
	import avmplus.getQualifiedClassName;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.ReturnKeyLabel;
	import flash.utils.getDefinitionByName;
	
	import org.osmf.net.StreamingURLResource;
	
	public class Scene extends Sprite
	{
		//单位长度
		public static var SIZE:int=25;
		//其他类实例
		private var _card:Card;
		private var _piece:Piece;
		
		/**
         * 场景类构造函数
		 * @param background
		 * @version 2013.12.21
		 */
		public function Scene(background:DisplayObject=null)
		{
			if(background!=null)
				this.addChild(background);
		}
		/**
		 * 向场景中添加对象
		 * @param type
		 * @param pos
		 */		
//		public function addPieceToScene(pos:Array):Piece
//		{
//			if(pos==null||pos.length!=2)
//				return null;
//			var imageobject:Piece=new Piece;
//			this.addChild(imageobject);
//			imageobject.x=pos[0]*SIZE;
//			imageobject.y=pos[1]*SIZE;
//			return imageobject;
//		}
		/**
		 * 公用静态方法，一个对象捕获另一个对象,标准为有边界碰撞，同时x轴中间点在容错值范围内(容错值为0时，则必须相等)
		 * @param 对象1
		 * @param 对象2
		 * @param 容错值
		 * @return true表明捕获成功
		 */
		public static function checkHunting(hunter:DisplayObject,hunted:DisplayObject,range:int=0):Boolean
		{
			if(hunter.hitTestObject(hunted))
			{
				trace(hunter.x+hunter.width>>1-hunted.x-hunted.width>>1);
				if(Math.abs(hunter.x+hunter.width>>1-hunted.x-hunted.width>>1)<=range)
					return true;
			}
			return false;
		}
		
	}
}