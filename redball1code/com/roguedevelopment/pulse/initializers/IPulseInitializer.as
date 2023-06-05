package com.roguedevelopment.pulse.initializers
{
	import com.roguedevelopment.pulse.particle.IParticle;
	
	public interface IPulseInitializer
	{
		function init( particle:IParticle ) : void;
	}
}