package com.roguedevelopment.pulse.initializers
{
	/**
	 * This class sets up a random angle that the particle should travel in to begin with.  It's identical to
	 * the ParamaterRandomizerInitizliaer, but handles converting from degrees to radians for you.
	 **/
	public class AngleRandomizerInitializer extends ParameterRandomizerInitializer
	{
		public function AngleRandomizerInitializer(minValue:Number, maxValue:Number)
		{
			super("angle", minValue * Math.PI / 180, maxValue * Math.PI / 180, round);
		}
		
	}
}