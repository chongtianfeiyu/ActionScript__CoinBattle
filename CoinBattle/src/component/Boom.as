package component
{
	/**
	 * 爆炸效果类
	 * @author yzpTsubasa
	 * @version 2013-12-27
	 */
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.osmf.events.LoadEvent;
	
	public class Boom extends Sprite
	{
		private var loader:Loader;
		private var _parent:Sprite;
		private var mc:MovieClip;
		private var _x:Number;
		private var _y:Number;
		public function Boom(parent:Sprite,x:Number,y:Number)
		{
			_parent=parent;
			_x=x;
			_y=y;
			loader=new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			loader.load(new URLRequest("resource/boom.swf"));
		}
		private function loadComplete(e:Event):void
		{
			if(_parent==null)
				return;
			mc=loader.content as MovieClip;
			mc.gotoAndPlay(1);
			mc.addEventListener(Event.ENTER_FRAME,checkOver);
			_parent.addChild(mc);
			mc.x=_x;
			mc.y=_y;
			trace("boom.swf的总帧数为："+mc.totalFrames);
		}
		//检查播放结束
		private function checkOver(e:Event):void
		{
			if(mc.currentFrame==7)
			{
				mc.removeEventListener(Event.ENTER_FRAME,checkOver);
				_parent.removeChild(mc);
				mc=null;
				loader=null;
				delete this;
			}
		}
	}
}