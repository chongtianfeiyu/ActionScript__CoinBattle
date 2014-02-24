package component
{
	/**
	 * 子弹类
	 * @author yzpTsubasa
	 * @version 2013-12-27
	 */
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Bullet extends Sprite
	{
		[Embed(source="resource/stealpearl_bullet.png")]
		private var CImageObject:Class;
		private var imageobject:DisplayObject=new CImageObject();
		//属性
		private var _vx:Number=5.0;
		private var _vy:Number=3.0;
		//private var _accelarateY:Number=0.3;
		private var _gravity:Number=0.8;
		public const maxY:Number=6.0;
		public function Bullet()
		{
			addChild(imageobject);
			
		}
		/**
		 * 子弹水平速度
		 */
		public function set vx(speedX:Number):void
		{
			_vx=speedX;
		}
		public function get vx():Number
		{
			return _vx;
		}
		/**
		 * 子弹竖直速度
		 */
		public function set vy(speedY:Number):void
		{
			_vy=speedY;
		}
		public function get vy():Number
		{
			return _vy;
		}
		public function get gravity():Number
		{
			return _gravity;
		}
		/**
		 * 子弹没有用途时处理 
		 * @return 
		 * 
		 */		
		public function becameUseless():Boolean
		{
			if(this.visible==false||this==null||this.x>stage.stageWidth+this.width||this.x<0||this.y+this.height<0||this.y>stage.stageHeight)
			{
				return true;
			}
			return false;
		}
	}
}