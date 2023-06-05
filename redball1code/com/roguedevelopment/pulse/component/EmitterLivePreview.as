package com.roguedevelopment.pulse.component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class EmitterLivePreview extends MovieClip
	{
		private var _config:String;				
		protected var _clipName:String;		
		protected var _rootClip:Boolean;
		protected var previewComp:Sprite;

		public function EmitterLivePreview()
		{
			super();
		}
		
		public function set config(val:String) : void
		{
			_config = val;
			setupEmitter();
		}
		
		public function set rootEffect(val:Boolean ) : void
		{
			_rootClip = val;
			setupEmitter();
		}
		
		public function set pps(val:Number) : void
		{
			setupEmitter();
		}
		
		public function set movieClipName(val:String) : void
		{

			_clipName = val;	
			setupEmitter();
		} 	
		
		public function setSize(width:Number,height:Number):void
		{
			trace("Preview setSize: " + width + " " + height );
			this.width = width;
			this.height = height;
		}	
		
		protected function setupEmitter() : void
		{
			if( previewComp == null )
			{
				previewComp = new Sprite();
				addChild(previewComp);
			}
			
			previewComp.graphics.clear();
			previewComp.graphics.lineStyle(1,0xffff00,1);
			previewComp.graphics.drawCircle(width/2,height/2,Math.min(width/2,height/2));
			
			
			
		}
		
	}
}