package component
{
	import flash.display.Sprite;

	public class CColision
	{
		/**
		 * 自定义的碰撞检测类，定义的block方法可以进行碰撞测试
		 */
		static public var collisioinSide:String="";
		public static const TOP:String="Top";
		public static const RIGHT:String="Right";
		public static const LEFT:String="Left";
		public static const BOTTOM:String="Bottom";
		//误差
		private static var deviation:Number=0; 
		public function CColision()
		{
			
		}
		/**
		 * 进行碰撞测试
		 * @param sprite1:Sprite 受影响的物体
		 * @param sprite2:Sprite 主动的对象
		 */
		public static function block(sprite1:Sprite,sprite2:Sprite):void
		{
			collisioinSide="";
			//计算矢量距离.sprite的坐标原点(0,0)在左上角
			var vx:Number=(sprite1.x+(sprite1.width/2))-(sprite2.x+(sprite2.width/2));
			var vy:Number=(sprite1.y+(sprite1.height/2))-(sprite2.y+(sprite2.height/2));
			//检查是否已经发生了碰撞
			if(Math.abs(vx)+deviation<(sprite1.width/2+sprite2.width/2))
			{
				if(Math.abs(vy)+deviation<(sprite1.height/2+sprite2.height/2))
				{
					//计算重叠部分
					var overlap_X:Number=sprite1.width/2+sprite2.width/2-Math.abs(vx);
					var overlap_Y:Number=sprite1.height/2+sprite2.height/2-Math.abs(vy);
					//判断X方向上的重叠挤压
					if(overlap_X>overlap_Y)
					{
						if(vy>0)
						{
							//sprite1的top
							collisioinSide="Top";
							sprite1.y=sprite1.y+overlap_Y;
							//trace("上面被阻挡");
						}else
						{
							collisioinSide="Bottom";
							sprite1.y=sprite1.y-overlap_Y;
							//trace("下面被阻挡");
						}
					}else if(overlap_X<overlap_Y)
					{
						if(vx>0)
						{
							//sprite1的left
							collisioinSide="Left";
							sprite1.x=sprite1.x+overlap_X;
							//trace("左边被阻挡");
						}else
						{
							collisioinSide="Right";
							sprite1.x=sprite1.x-overlap_X;
							//trace("右边被阻挡");
						}
					}
				}else
				{
					collisioinSide="No Collision";
				}
			}
		}
	}
}