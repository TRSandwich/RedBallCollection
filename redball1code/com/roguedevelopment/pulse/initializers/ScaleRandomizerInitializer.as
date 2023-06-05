package com.roguedevelopment.pulse.initializers
{
	import com.roguedevelopment.pulse.particle.IParticle;

	/**
	 * This class allows you to specify a minimum and maximum value for both the scaleX and scaleY properties of a
	 * newly created particle.  This will keep the two scales in sync so theres only scaling and now skewing.
	 **/
	public class ScaleRandomizerInitializer implements IPulseInitializer
	{
		protected var minValue:Number;
		protected var maxValue:Number;
		
		public function ScaleRandomizerInitializer( minValue:Number, maxValue:Number)
		{
			super();
			
			this.minValue = minValue;
			this.maxValue = maxValue;

			
		}

		public function init(particle:IParticle) : void
		{			
			var o:Object = particle;
			var v:Number = minValue + Math.random() * (maxValue - minValue);

			o["scaleX"] = v;
			o["scaleY"] = v;

		}
		
	}
}