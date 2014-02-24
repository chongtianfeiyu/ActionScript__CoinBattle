package  component{
	/**
	 * 飘动文字类
	 * @version 2013-12-27
	 */
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	public class PointBurst extends Sprite{
       //文本样式
	   private static const m_fontFace:String="Arial";
	   private static const m_fontSize:int=20;
	   private static const m_fontColor:Number=0xFFFFFF;
	   private static const m_fontBold:Boolean=true;
	   //动画
	   private static const m_animSteps:int=20;
	   private static const m_animStepTime:int=40;
	   private static const m_startScale:Number=0.5;
	   private static const m_endScale:Number=1.5;
	   //成员
	   private var m_tField:TextField;
	   private var m_burstSprite:Sprite;
	   private var m_parentMC:Sprite;
	   //计时器
	   private var m_animTimer:Timer;
		public function PointBurst(mc:Sprite,msg:Object,posX:Number,posY:Number,fontColor:Number=m_fontColor,fontFace:String=m_fontFace,fontSize:int=m_fontSize,fontBold:Boolean=m_fontBold) {
			// constructor code
			//创建文本格式
			var tFormat:TextFormat=new TextFormat();
			tFormat.font=fontFace;
			tFormat.size=fontSize;
			tFormat.color=fontColor;
			tFormat.bold=fontBold;
			tFormat.align="center";
			//创建文本域
			m_tField=new TextField();
			//m_tField.embedFonts=true;
			m_tField.selectable=false;
			m_tField.defaultTextFormat=tFormat;
			m_tField.autoSize=TextFieldAutoSize.CENTER;
			m_tField.text=String(msg);
			m_tField.x=-(m_tField.width/2);
			m_tField.y=-(m_tField.height/2);
			//创建Sprite
			m_burstSprite=new Sprite();
			m_burstSprite.x=posX;
			m_burstSprite.y=posY;
			m_burstSprite.scaleX=m_startScale;
			m_burstSprite.scaleY=m_startScale;
			m_burstSprite.alpha=0;
			m_burstSprite.addChild(m_tField);
			m_parentMC=mc;
			m_parentMC.addChild(m_burstSprite);
			
			//开始动画
			m_animTimer=new Timer(m_animStepTime,m_animSteps);
			m_animTimer.addEventListener(TimerEvent.TIMER,rescaleBurst);
			m_animTimer.addEventListener(TimerEvent.TIMER_COMPLETE,removeBurst);
			m_animTimer.start();
		}
		//动画
		public function rescaleBurst(e:TimerEvent):void
		{
			
			//trace("动画进行中");
			//动画进度
			var percentDone:Number=e.target.currentCount/m_animSteps;
			//计算出缩放以及透明度
			m_burstSprite.scaleX=(1.0-percentDone)*m_startScale+percentDone*m_endScale;
			m_burstSprite.scaleY=(1.0-percentDone)*m_startScale+percentDone*m_endScale;
			m_burstSprite.alpha=1.0-percentDone;
		}
		//结束
		public function removeBurst(e:TimerEvent):void
		{
			m_burstSprite.removeChild(m_tField);
			m_parentMC.removeChild(m_burstSprite);
			m_tField=null;
			m_burstSprite=null;
			delete this;
		}

	}
	
}
