package {
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import flash.net.SharedObject;

	public class Preloader extends MovieClip {
		public static  const ENTRY_FRAME:Number=3;
		private var progressText:TextField;
		public static var startLevelNum:int=1;
		public static var levelsAvaiable:int;
		
		public static var stageLink:Stage;
		public static var mySo:SharedObject;
		
		public function Preloader() {
			stop();
			progressText = getChildByName("loading_txt") as TextField;
			
			stage.showDefaultContextMenu=false;

			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			
			stageLink=stage; 
			mySo = SharedObject.getLocal("RedBallPlatformer1");
			if(mySo.data.levelsAvaiable) levelsAvaiable=mySo.data.levelsAvaiable;
			else levelsAvaiable=1;
			
			/*if(!isUrl(["flashgamelicense.com"])) {
  				this.alpha=0;
				this.x=5000;
				this.y=5000;
			}*/
		}
		
		public function isUrl(urls:Array):Boolean {
			  var url:String = this.stage.loaderInfo.loaderURL;
			  var urlStart:Number = url.indexOf("://")+3;
			  var urlEnd:Number = url.indexOf("/", urlStart);
			  var domain:String = url.substring(urlStart, urlEnd);
			  var LastDot:Number = domain.lastIndexOf(".")-1;
			  var domEnd:Number = domain.lastIndexOf(".", LastDot)+1;
			  domain = domain.substring(domEnd, domain.length);
		
			  for (var i:int = 0; i < urls.length; i++) {
				if (domain == urls[i]) {
				  return true;
				}
			  }
			  return false;
        }

		private function progressHandler(event:ProgressEvent):void {
			var loaded:uint = event.bytesLoaded;
			var total:uint = event.bytesTotal;

			var percentLoaded:Number = Math.round((loaded/total) * 100);
			boxLoaded.x=202+147*percentLoaded/100;
			boxLoaded.rotation=5*(boxLoaded.x-202);
			progressText.text = "Loading " + percentLoaded + "%";
		}
		
		private function completeHandler(event:Event):void {
			play();
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(event:Event):void {
			if (currentFrame >= Preloader.ENTRY_FRAME) {
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				stop();
			}
		}

	}
}