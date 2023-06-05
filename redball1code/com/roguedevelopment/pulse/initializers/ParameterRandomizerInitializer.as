package com.roguedevelopment.pulse.initializers
{
	import com.roguedevelopment.pulse.particle.IParticle;

	/**
	 * This class allows you to specify a minimum and maximum value that a particular property on
	 * a particle should be initialized to.  Use it in combination with the GenericEmitter
	 **/
	public class ParameterRandomizerInitializer implements IPulseInitializer
	{
		protected var propName:String;
		protected var minValue:Number;
		protected var maxValue:Number;
		protected var round:Boolean;
		
		public function ParameterRandomizerInitializer(propName:String, minValue:Number, maxValue:Number, round:Boolean = false)
		{
			super();
			
			this.minValue = minValue;
			this.maxValue = maxValue;
			this.propName = propName;
			this.round = round;
			
		}

		public function init(particle:IParticle) : void
		{			
			var o:Object = particle;
			var v:Number = minValue + Math.random() * (maxValue - minValue);
			if( round ) { v = Math.round(v); }

			if( o.hasOwnProperty( propName ) )
			{
				o[propName]  = v;
			}
			else if( o.hasOwnProperty( "params" ) )
			{
				o.params[propName] = v;
			}

		}
		
	}
}