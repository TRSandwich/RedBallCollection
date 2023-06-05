package {
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	
	public class LevelButton extends MovieClip {
		private var levelNum:int;
		private var textNum:TextField;
		public var avaliable:Boolean;
		
		public function LevelButton(_num:int):void {
			levelNum=_num;
			if(levelNum<=Preloader.levelsAvaiable) {
				avaliable=true;
				gotoAndStop(1);
			} else {
				avaliable=false;
				gotoAndStop(4);
			}
			textNum = new TextField();
			textNum.x=1;
			textNum.y=1;
			textNum.width=25;
			textNum.height=25;
			textNum.embedFonts=true;
			textNum.selectable=false;
			var myTextFormat:TextFormat=new TextFormat("Kronika", 14, 0x000000);
			myTextFormat.align=	TextFormatAlign.CENTER;
			textNum.defaultTextFormat=myTextFormat;
			textNum.text=num.toString();
			this.mouseChildren = false;
			addChild(textNum);
		}
		
		public function get num():int {
			return levelNum;
		}
	}
}