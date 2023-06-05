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
package  com.roguedevelopment.pulse.rule
{
	import com.roguedevelopment.PennerEasing;
	import com.roguedevelopment.pulse.particle.IParticle;

	public final class ScaleRule implements IPulseRule
	{
		protected var maxAge:Number;
		protected var startScale:Number;
		protected var targetScale:Number;
		public function ScaleRule(maxAge:Number = 3000, startScale:Number = 1, targetScale:Number = 5)
		{
			
			super();
			this.maxAge = maxAge;
			this.targetScale = targetScale;
			this.startScale = startScale;
		}
		public function applyRule(pulse:IParticle, currentMs:Number, lastMs:Number):void
		{
			
			var age:Number = (currentMs - pulse.birthTime);
			if( age > maxAge ) 
			{
				pulse.rules.splice( pulse.rules.indexOf(this),1 );
				return;
			}			

			if( startScale > targetScale )
			{
				pulse.scaleX = startScale - PennerEasing.sineEaseInOut( age, targetScale,startScale, maxAge );
			}
			else
			{
				pulse.scaleX = PennerEasing.sineEaseInOut( age, startScale, targetScale, maxAge );
			}
			pulse.scaleY = pulse.scaleX;
		}
		
		public function configure( params:Array ) : void
		{
			maxAge = params[0] as Number;			
			startScale = params[1] as Number;
			targetScale = params[2] as Number;
		}

	
		
	}
}