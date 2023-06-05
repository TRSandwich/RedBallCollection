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
	
	import flash.geom.Rectangle;

	/**
	 * The bounding box rule constrains particles to a rectangular area.  If they stray outside the rectangle, they'll be rotated.
	 * This simulates a bounce effect when they hit the "walls".
	 **/
	public final class BoundingBoxRule implements IPulseRule
	{
		protected var box:Rectangle;
		
		public function BoundingBoxRule(box:Rectangle = null)
		{
			super();
			
			this.box = box;
			
		}

		/**
		 * This is used to auto-configure this rule when used through the SimpleParticles interface.
		 **/
		public function configure( params:Array ) : void
		{
			if( params.length != 4 ) { return; }
			box = new Rectangle(params[0],params[1],params[2],params[3]);			
		}
		
		public function applyRule(pulse:IParticle, currentMs:Number, lastMs:Number):void
		{
			var a:Number = pulse.params.angle;
			var s:Number;
			var dx:Number;
			var dy:Number;
		
		
			if( ( (pulse.x <= box.x ) && (a > (Math.PI/2) ) && ( a < (3 * Math.PI / 2) ) ) ||
				( (pulse.x >= box.right) && ((a > (3 * Math.PI / 2) ) || ( a < (Math.PI / 2) )) ) )
			{
				s = pulse.params.speed;
				dx = Math.cos( a ) * s;
				dy = Math.sin( a ) * s;
				dx *= -1;
				a = Math.atan2(dy,dx) ;
				if( a < 0 ) a+=(2 * Math.PI);
				if( a > (2 * Math.PI) ) a-=(2 * Math.PI);
				pulse.params.angle = a;
			}
			if( ( (pulse.y <= box.y ) && (a >  Math.PI ) && ( a < (2 * Math.PI) ) ) ||
				( (pulse.y >= box.bottom) && (a > 0 ) && ( a < Math.PI ) ) )
			{
				s = pulse.params.speed;
				dx = Math.cos( a ) * s;
				dy = Math.sin( a ) * s;
				dy *= -1;
				a=Math.atan2(dy,dx) ;
				if( a < 0 ) a+=(2 * Math.PI);
				if( a > 360 ) a-=(2 * Math.PI);				
				pulse.params.angle = a;
			}
			
		}
		
	}
}
