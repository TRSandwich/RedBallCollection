package com.roguedevelopment.pulse.emitter
{
	import com.roguedevelopment.pulse.PulseEngine;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapEmitter extends GenericEmitter
	{
		protected var bitmap:BitmapData;
		
		protected var fullRect:Rectangle ;
		protected var origin:Point = new Point(0,0);
		
		protected var fader:ColorMatrixFilter;
		
		
		public function BitmapEmitter(particlesPerSecond:Number, bitmap:BitmapData, fadeAmount:Number = 0.85)
		{
			fader = new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,fadeAmount,0 ] );
			super(particlesPerSecond);			
			this.bitmap = bitmap;
			fullRect = new Rectangle(0,0,bitmap.width,bitmap.height);			
			root = new Sprite();
		}
		
		protected function onEnterFrame(e:Event) : void
		{		
			bitmap.applyFilter( bitmap, fullRect, origin, fader );
			var copyMatrix:Matrix = new Matrix();
			copyMatrix.rotate( root.rotation * Math.PI / 180);
			copyMatrix.translate( root.x, root.y );
			copyMatrix.scale( root.scaleX, root.scaleY );

			bitmap.draw(root, copyMatrix);				
		}
		
		override public function stop() : void
		{
			
			//PulseEngine.instance.root.removeEventListener(Event.ENTER_FRAME, onEnterFrame );
			super.stop()
		}

		override public function start() : void
		{
			PulseEngine.instance.root.addEventListener(Event.ENTER_FRAME, onEnterFrame );
			super.start()
		}

	}
}