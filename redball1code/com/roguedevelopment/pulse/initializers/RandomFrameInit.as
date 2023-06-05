package com.roguedevelopment.pulse.initializers
{
	import com.roguedevelopment.pulse.particle.IParticle;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class RandomFrameInit implements IPulseInitializer
	{
		public function RandomFrameInit()
		{
		}

		public function init(particle:IParticle):void
		{			
			var mc:MovieClip;
			if( particle is MovieClip )
			{
				mc = (particle as MovieClip);
				mc.gotoAndStop( Math.round( Math.random() * mc.totalFrames ) );				
			}
			else if( particle is Sprite )
			{
				try
				{
					mc = (particle as Sprite).getChildAt(0) as MovieClip;
					if( mc != null ) mc.gotoAndStop( Math.round( Math.random() * mc.totalFrames ) );
				}
				catch(e:Error) {}
				
			}
		}
		
	}
}