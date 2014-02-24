package component
{
	/**
	 * 主角类
	 * @author yzpTsubasa
	 * @version 2013.12.21
	 */
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.text.engine.SpaceJustifier;
	import flash.utils.Timer;
	
	import flashx.textLayout.elements.SpecialCharacterElement;
	
	import org.osmf.events.BufferEvent;
	import org.osmf.events.TimeEvent;
	
	public class Character extends Sprite
	{
		//导入图片
		[Embed(source="resource/cat.png")]
		private var CImageObject:Class;
		//图片实例
		private var imageobject:DisplayObject=new CImageObject();
	    //主角属性
		public var HP:Number=100;
		public var jumpForce:Number=-30;
		public var accelarateX:Number=0;
		public var accelarateY:Number=0;
		public var maxVx:Number=3;
		public var maxVy:Number=10;
		public var isOnGround:Boolean=undefined;
		public var friction:Number=0.9;
		public var gravity:Number=0.7;
		public var directionX:Boolean=true;//朝向是否为x轴正方向
		public var bullets:Vector.<Bullet>=new Vector.<Bullet>;
		private var fireNumber:int=3;//同时可存在多少粒子弹
		private var fireCurrent:int=0;//已存在子弹数
		private var _stage:Stage;
		//当前位移
		public var vx:Number=0;
		public var vy:Number=0;
        
		/**
		 * 主角类构造函数
		 */
		public function Character(stage:Stage)
		{
			_stage=stage;
			addChild(imageobject);
			
			//限制大小
			this.scrollRect=new Rectangle(0,0,Scene.SIZE-1,Scene.SIZE-1);
		}
		/**
		 * 发射子弹
		 */
		public function fire():void
		{
			if(fireCurrent>=fireNumber)
			{
				return;
			}
			fireCurrent++;
			trace("发射子弹");
			var bullet:Bullet=new Bullet;
			bullet.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			bullet.x=this.x+this.width/2-bullet.width/2;
			bullet.y=this.y+this.height/2-bullet.height/2;
			if(directionX)
			{
				bullet.vx=5.0;
			}else
			{
				bullet.vx=-5.0;
			}
			_stage.addChild(bullet);
			bullets.push(bullet);
		}
		private function onEnterFrame(e:Event):void
		{
			var bullet:Bullet=e.currentTarget as Bullet;
			bullet.vy+=bullet.gravity;
			if(Math.abs(bullet.vy)>bullet.maxY)
				bullet.vy=bullet.maxY*(bullet.vy/Math.abs(bullet.vy));
			bullet.x+=bullet.vx;
			bullet.y+=bullet.vy;
			if(bullet.becameUseless())
			{
				trace("清理子弹");
				bullet.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
				bullets.splice(bullets.indexOf(bullet),1);
				_stage.removeChild(bullet);
				bullet==null;
				fireCurrent--;
			}
		}
	}
}