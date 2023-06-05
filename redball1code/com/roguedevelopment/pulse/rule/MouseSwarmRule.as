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
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public final class MouseSwarmRule implements IPulseRule
	{
		protected var mouse:Point = new Point();
		public function MouseSwarmRule(stage:Stage = null)
		{
			super();
			if( stage != null )
			{
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove );
			}
		}
		
		protected function onMouseMove(event:MouseEvent) : void
		{
			mouse.x = event.stageX;
			mouse.y = event.stageY;			
			
		}

		public function applyRule(pulse:IParticle, currentMs:Number, lastMs:Number):void
		{
			var a:Number = Math.atan2(mouse.y - pulse.y , mouse.x - pulse.x ) ;
			
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
			(params[0] as Stage).addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove );			
		}

		
	}
}