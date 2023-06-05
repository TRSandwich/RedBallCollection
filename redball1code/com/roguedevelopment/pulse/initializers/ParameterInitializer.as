package com.roguedevelopment.pulse.initializers
{
	import com.roguedevelopment.pulse.particle.IParticle;

	/**
	 * This class allows you to specify a minimum and maximum value that a particular property on
	 * a particle should be initialized to.  Use it in combination with the GenericEmitter
	 **/
	public class ParameterInitializer implements IPulseInitializer
	{
		protected var propName:String;
		protected var value:Object;

		
		public function ParameterInitializer(propName:String, value:Object)
		{
			super();
			
			
			this.propName = propName;
			this.value = value;
			
		}

		public function init(particle:IParticle) : void
		{			
			var o:Object = particle as Object;
			if( o.hasOwnProperty( propName ) )
			{
				o[propName]  = value;
			}
			else if( o.hasOwnProperty( "params" ) )
			{
				o.params[propName] = value;
			}

		}
		
	}
}