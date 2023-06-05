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
	import com.roguedevelopment.PennerEasing;
	import com.roguedevelopment.pulse.particle.IParticle;

	public final class TweenRule implements IPulseRule
	{
		protected var field:String;
		protected var start:Number;
		protected var end:Number;
		protected var maxAge:Number;
		protected var ease:Function;
		
		public function TweenRule(field:String = "", start:Number = 1, end:Number = 1, maxAge:Number = 1, ease:Function = null)
		{
			super();
			this.field = field;
			this.start = start;
			this.end = end;
			this.maxAge = maxAge;
			this.ease = ease;
			if ( this.ease == null )
			{
				this.ease = PennerEasing.linearEaseNone;
			}
			
			
		}

		public function applyRule(pulse:IParticle, currentMs:Number, lastMs:Number):void
		{
			var age:Number = currentMs - pulse.birthTime;
			if( age > maxAge ) 
			{
				pulse.rules.splice( pulse.rules.indexOf(this),1 );
				return;
			}
			
			var o:Object = pulse;	
			if( end > start )
			{	
				o[ field ] = ease( age, start, end, maxAge );
			}
			else
			{
				o[ field ] = start - ease( age,  end, start, maxAge );
			}
			
		}
		
		public function configure( params:Array ) : void
		{
			field = params[0];
			start = params[1];
			end = params[2];
			maxAge = params[3];
						
		}
		
	}
}