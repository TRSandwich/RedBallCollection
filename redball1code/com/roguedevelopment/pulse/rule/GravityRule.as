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

	public final class GravityRule implements IPulseRule
	{
		protected var gravityAmount:Number;
		public function GravityRule(gravityAmount:Number = 5)
		{
			super();
			this.gravityAmount = gravityAmount;
		}

		public function applyRule(pulse:IParticle, currentMs:Number, lastMs:Number):void
		{
			//pulse.y +=(currentMs - pulse.birthTime) / 10000 * Math.abs(gravityAmount) * gravityAmount ;
			var s:Number = pulse.params.speed;
			var a:Number = pulse.params.angle;
			var dx:Number = Math.cos( a ) * s  ;
			var dy:Number = Math.sin( a ) * s + gravityAmount;			
			a = Math.atan2(dy,dx) ;			
			if( a < 0 ) a+=(2 * Math.PI);
			if( a > (2 * Math.PI) ) a-=(2 * Math.PI);
			pulse.params.angle = a;
			pulse.params.speed = Math.sqrt( dx * dx + dy * dy );
			
		}
		
		public function configure( params:Array ) : void
		{
			gravityAmount = params[0] as Number;			
		}

		
	}
}