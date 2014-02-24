package component
{
	/**
	 * 硬币类
	 * @author yzpTsubasa
	 */
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Coin extends Sprite
	{
		[Embed(source="resource/coin.png")]
		private var CImageObject:Class;
		private var coin:DisplayObject=new CImageObject();
		public function Coin(posx:int=0,posy:int=0)
		{
			this.addChild(coin);
			coin.x=posx;
			coin.y=posy;
			coin.width=Scene.SIZE;
			coin.height=Scene.SIZE;
		}
	}
}