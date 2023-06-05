package com.roguedevelopment.pulse.rule
{
	import com.roguedevelopment.pulse.particle.IParticle;
	
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;

	public class ColorTransformRule implements IPulseRule
	{
		public var startTime:Number;
		public var endTime:Number;
		public var rMult:Number = 1;
		public var gMult:Number = 1;
		public var bMult:Number = 1;
		public var rOffset:Number = 0;
		public var gOffset:Number = 0;
		public var bOffset:Number = 0;
		
		public function ColorTransformRule()
		{
			super();
			var c:ColorTransform = new ColorTransform();
		}

		public function applyRule(pulse:IParticle, currentMs:Number, lastMs:Number):void
		{
			var ds:Number = currentMs - pulse.birthTime;
			if( ( ds < startTime) || (ds > endTime) )
			{
				return;
			}
			
			var dob:DisplayObject = pulse as DisplayObject;
			
			if( dob == null ){return;}

			
			var percent:Number = (ds - startTime) /  (endTime - startTime);

			dob.transform.colorTransform = new ColorTransform(1 + (rMult - 1) * percent,
																1 + (gMult - 1) * percent,
																1 + (bMult - 1) * percent,
																1,
																rOffset  * percent,
																gOffset  * percent,
																bOffset  * percent,
																0);
			

		}

				
		
		
		
		public function configure(params:Array):void
		{
			if( params.length != 8 ) { return; }
			
			startTime = params.shift() as Number;
			endTime = params.shift() as Number;
			rMult = params.shift() as Number;
			gMult = params.shift() as Number;
			bMult = params.shift() as Number;
			rOffset = params.shift() as Number;
			gOffset = params.shift() as Number;
			bOffset = params.shift() as Number;
			
		}
		
	}
}