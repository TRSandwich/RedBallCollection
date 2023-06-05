/**
 *  Latest information on this project can be found at http://www.rogue-development.com/pulseParticles.xml
 * 
 *  Copyright (c) 2008 Marc Hughes 
 * 
 *  Permission is hereby granted, free of charge, to any person obtaining a 
 *  copy of this software and associated documentation files (the "Software"), 
 *  to deal in the Software without restriction, including without limitation 
 *  the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 *  and/or sell copies of the Software, and to permit persons to whom the Software 
 *  is furnished to do so, subject to the following conditions:
 * 
 *  The above copyright notice and this permission notice shall be included in all 
 *  copies or substantial portions of the Software.
 * 
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 *  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
 *  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
 *  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
 *  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 *  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
 * 
 * -------------------------------------------------------------------------------------------
 * 
 * Description:
 *    The Pulse Particle engine gives a simple way to create complex particle effects.
 * 
 * 
 * 
 **/
package com.roguedevelopment.pulse.rule
{
	import com.roguedevelopment.pulse.particle.IParticle;
	
	import flash.geom.Point;

	public final class PointSwarmRule implements IPulseRule
	{
		protected var dest:Point = new Point();
		public function PointSwarmRule(destination:Point = null)
		{
			super();
			if( destination != null )
			{
				dest = destination;
			}
		}
		
	

		public function applyRule(pulse:IParticle, currentMs:Number, lastMs:Number):void
		{
			var a:Number = Math.atan2(dest.y - pulse.y , dest.x - pulse.x ) ;
			
			if( a < 0 ) { a+=(2 * Math.PI); }
			if( pulse.params.angle < 0 ) { pulse.params.angle += (2 * Math.PI); }
			if( pulse.params.angle > (2 * Math.PI) ) { pulse.params.angle -= (2 * Math.PI); }
			
			
			var dif:Number = pulse.params.angle - a;
			
			if( dif > 0 && dif <= Math.PI || (dif < -Math.PI) )
			{
				pulse.params.angle -= Math.min(0.1,Math.abs(dif));
			}
			else if( (dif >= -Math.PI && dif < 0) || (dif > Math.PI) )
			{
				pulse.params.angle+= Math.min(0.1,Math.abs(dif));
			}
			
		}
		
		public function configure( params:Array ) : void
		{
			if( params[0] is Point )
			{
				dest = params[0] as Point;
			}
			else
			{
				dest.x = params[0] as Number;			
				dest.y = params[1] as Number;
			}
		}

		
	}
}