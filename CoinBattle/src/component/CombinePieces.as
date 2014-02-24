package component
{
	/**
	 * 组合块
	 * @author yzpTsubasa
	 */
	import flash.display.Sprite;
	
	public class CombinePieces extends Sprite
	{
		public static const HORIZONTAL:int=0;
		public static const VERTICAL:int=1;
		/**
		 * 组合块类的构造函数 
		 * @param num
		 * @param dir
		 * 
		 */		
		public function CombinePieces(num:uint=1,dir:int=CombinePieces.HORIZONTAL)
		{
			//如果数量不满足1，则不执行。
			if(num<=0)
				return;
			if(dir==CombinePieces.HORIZONTAL)
				addSomeHorizontalPieces(num);
			else
				addSomeVerticalPieces(num);
		}
		private function addSomeHorizontalPieces(num:uint):void
		{
			for(var a:int=0;a<num;a++)
			{
				var piece:Piece=new Piece();
				piece.x=a*Scene.SIZE;
				piece.y=0;
				this.addChild(piece);
			}
		}
		private function addSomeVerticalPieces(num:uint):void
		{
			for(var a:int=0;a<num;a++)
			{
				var piece:Piece=new Piece();
				piece.x=0;
				piece.y=a*Scene.SIZE;
				this.addChild(piece);
			}
		}
		/**
		 * 传入数组添加组合块
		 * @param piecesArray 该数组中，1、2位为xy坐标，3第三个为数量，4为横纵类型
		 * @return 
		 * 
		 */		
		public static function addCombinePiece(piecesArray:Array):CombinePieces
		{
			var combinePiece:CombinePieces;
			switch(piecesArray.length)
			{
				case 2:
				{
					combinePiece=new CombinePieces();
					break;
				}
				case 3:
				{
					combinePiece=new CombinePieces(piecesArray[2]);
					break;
				}
				case 4:	
				{
					combinePiece=new CombinePieces(piecesArray[2],piecesArray[3]);
					break;
				}
				default:
				{
					break;
				}
					if(combinePiece!=null)
					{
						combinePiece.x=piecesArray[0]*Scene.SIZE;
						combinePiece.y=piecesArray[1]*Scene.SIZE;
						
					}	
			}
			return combinePiece;
		}
		
	}
}