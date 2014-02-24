package
{
	/**
	 * 游戏应用类，主程序
	 * @author yzpTsubasa
	 * @version 2013.12.21
	 */
	import component.Background;
	import component.Boom;
	import component.Bullet;
	import component.CColision;
	import component.Character;
	import component.Coin;
	import component.CombinePieces;
	import component.Door;
	import component.Piece;
	import component.PointBurst;
	import component.Scene;
	import component.SoundEffect;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	//舞台背景
	[SWF(backgroundColor="#000")]
	public class CoinBattle extends Sprite
	{
		//游戏场景
		private var _scene:Scene;
		//游戏主角
		private var _character:Character;
		//游戏中的piece块集合
		private var _pieces:Vector.<CombinePieces>;
		//金币集合
		private var _coins:Vector.<Coin>;
		//门
		private var _door:Door;
		//记录按键
		private var _isDown:Boolean=false;
		//爆炸
	    private var boom:Boom;
		/**
		 * 游戏入口
		 */
		public function CoinBattle()
		{
			initData();
			initScene();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		/**
		 * 数据初始化
		 */
		public function initData():void
		{
			_scene=new Scene(new Background);
			_character=new Character(stage);
			_character.isOnGround=false;
			addChild(_scene);
			_scene.addChild(_character);
			_character.x=25;
		}
		//初始化场景
		public function initScene():void
		{
			addPiece();
			addCoin();
			addDoor();
		}

		 // 碰撞检测

		private function characterCollision():void
		{
			if(_pieces==null||_pieces.length<=0||_character==null)
				return;
			//添加碰撞
			for(var a:int=0;a<_pieces.length;a++)
			{
				CColision.block(_character,_pieces[a]);
				if(CColision.collisioinSide==CColision.BOTTOM)
				{
					_character.isOnGround=true;
					_character.vy=0;
					_character.accelarateY=0;
				}
				else if(CColision.collisioinSide==CColision.TOP)
				{
					_character.vy=0;
					_character.accelarateY=0;
				}
				//左右两边碰撞，速度归零，但存在加速度
				else if(CColision.collisioinSide==CColision.LEFT||CColision.collisioinSide==CColision.RIGHT)
				{
					_character.vx=0;
					//_character.accelarateX=0;
				}
			}
			
		    
		}
		/**
		 * 使主角运动
		 */
		private function moveCharacter():void
		{
			//加速度
			_character.vx+=_character.accelarateX;
			_character.vy+=_character.accelarateY;
			//摩擦
			if(_character.isOnGround)
				_character.vx*=_character.friction;
			//重力
			_character.vy+=_character.gravity;
			//限制速度
			if(Math.abs(_character.vx)>_character.maxVx)
				_character.vx=_character.maxVx*(_character.vx/Math.abs(_character.vx));
			if(Math.abs(_character.vy)>_character.maxVy)
				_character.vy=_character.maxVy*(_character.vy/Math.abs(_character.vy));
			if(Math.abs(_character.vx)<0.1)
				_character.vx=0;
			//移动
			_character.x+=_character.vx;
			_character.y+=_character.vy;
		}
		/**
		 * 添加帧监听
		 */
		private function onEnterFrame(e:Event):void
		{
			//【注意】要先移动对象
			moveCharacter();
			//【注意】再进行碰撞检测
			characterCollision();
			
			//检查金币
			checkCoin();
			//检查子弹
			checkBullet();
			//检查门
			checkDoor();
		}
		private function keyDownHandler(e:KeyboardEvent):void
		{
			//向左
			if(e.keyCode==Keyboard.A||e.keyCode==Keyboard.LEFT)
			{
				_character.accelarateX=-0.5;
				_character.directionX=false;
			}
			//向右
			else if(e.keyCode==Keyboard.D||e.keyCode==Keyboard.RIGHT)
			{
				_character.accelarateX=0.5;
				_character.directionX=true;
			}
			//向上
			else if(/*e.keyCode==Keyboard.K*/e.keyCode==Keyboard.W||e.keyCode==Keyboard.UP)
			{
				if(_character.isOnGround&&!_isDown)
				{
					_character.vy+=_character.jumpForce;
					_character.isOnGround=false;
					SoundEffect.jump();
					trace("Jump");
				}
				_isDown=true;
			}
			//fire
			else if(e.keyCode==Keyboard.SPACE)
			{
				_character.fire();
			}
		}
		private function keyUpHandler(e:KeyboardEvent):void
		{
			if(e.keyCode==Keyboard.A||e.keyCode==Keyboard.LEFT||e.keyCode==Keyboard.D||e.keyCode==Keyboard.RIGHT)
				_character.accelarateX=0;
			else if(e.keyCode==Keyboard.W||e.keyCode==Keyboard.UP)
				_isDown=false;
		}
		/**
		 * 添加块
		 */
		private function addPiece():void
		{
			_pieces=new Vector.<CombinePieces>;
			var piecePos:Array=[[0,6,4],[6,1],[9,1,2],[12,4,2],[10,7,4],[6,9,5],[2,12,2],[11,11,3],[0,14,20],[0,0,14,CombinePieces.VERTICAL],[19,0,14,CombinePieces.VERTICAL]];
			for(var a:int=0;a<piecePos.length;a++)
			{
				var combinePiece:CombinePieces=CombinePieces.addCombinePiece(piecePos[a]);
				if(combinePiece!=null)
				{
					combinePiece.x=piecePos[a][0]*Scene.SIZE;
					combinePiece.y=piecePos[a][1]*Scene.SIZE;
					_scene.addChild(combinePiece);
					//添加入块集合中
					_pieces.push(combinePiece);
				}	
			}
		}
		/**
		 * 添加金币
		 */
		private function addCoin():void
		{
			_coins=new Vector.<Coin>;
			var coinPos:Array=[[6,0],[6,8],[12,3]];
			for(var a:int=0;a<coinPos.length;a++)
			{
				var coin:Coin=new Coin();
				_scene.addChild(coin);
				coin.x=coinPos[a][0]*Scene.SIZE;
				coin.y=coinPos[a][1]*Scene.SIZE;
				_coins.push(coin);
			}
		}
		/**
		 * 添加门
		 */
		private function addDoor():void
		{
			var doorPos:Array=[11,14];
			_door=new Door();
			_scene.addChild(_door);
			_door.x=doorPos[0]*Scene.SIZE;
			_door.y=doorPos[1]*Scene.SIZE-_door.height;
		}
		/**
		 * 检查金币
		 */
		private function checkCoin():void
		{
			var range:int=10;
			for(var i:int=0;i<_coins.length;i++)
			{
				var coin:Coin=_coins[i];
				if(Scene.checkHunting(_character,coin))
				{
					var pointburst:PointBurst=new PointBurst(this,"金币+100",_character.x+_character.width/2,_character.y,0xffff00);
					_scene.removeChild(coin);
					_coins.splice(i,1);
					trace("获得一枚金币");		
				}
			}
		}
		/**
		 * 检查子弹
		 */
		private function checkBullet():void
		{
			if(_character.bullets==null)
				return;
			if(_character.bullets.length<=0)
				return;
			var len:int=_character.bullets.length;
			var len2:int=_pieces.length;
			for(var a:int=0;a<len;a++)
			{
				for(var b:int=0;b<len2;b++)
				{
					CColision.block(_character.bullets[a],_pieces[b]);
					if(CColision.collisioinSide==CColision.LEFT||CColision.collisioinSide==CColision.RIGHT)
					{
						//添加爆炸效果
						boom=new Boom(this,_character.bullets[a].x-42,_character.bullets[a].y-42);
						_character.bullets[a].visible=false;			
					}else if(CColision.collisioinSide==CColision.BOTTOM||CColision.collisioinSide==CColision.TOP)
					{
						_character.bullets[a].vy*=-1;
					}
				}
			}
		}
		/**
		 * 检查门
		 */
		private function checkDoor():void
		{
			var coinNum:int=_coins.length;
			if(coinNum<=0)
			{
				_door.visible=true;
				
			}
			else
				_door.visible=false;
		}
	}
}