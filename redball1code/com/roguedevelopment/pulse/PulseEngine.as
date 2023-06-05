
  
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
package com.roguedevelopment.pulse
{
	import com.roguedevelopment.pulse.particle.IParticle;
	import com.roguedevelopment.pulse.particle.IParticleFactory;
	import com.roguedevelopment.pulse.particle.IRecyleableParticle;
	import com.roguedevelopment.pulse.rule.*;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public final class PulseEngine
	{
		public static const PARTICLE_LOOP_TIME:Number = 30;
		
		protected static var _instance:PulseEngine;
		protected var timer:Timer;		
		protected var lastUpdate:Number;
		protected var emitters:Array = [];
		protected var particles:Array = [];
		
		public var updateAfterTimer:Boolean = false;
		
		public var root:DisplayObjectContainer;
		
		
		public function PulseEngine()
		{
			super();
			if( _instance != null ) { throw new Error("only one engine allowed");}			
			
			timer = new Timer(PARTICLE_LOOP_TIME);
			timer.addEventListener(TimerEvent.TIMER, onTime );	
			timer.start();
			
			lastUpdate = (new Date()).time;
			
		

			
		}
		
		public static function get instance() : PulseEngine
		{
			if( _instance == null ) { _instance = new PulseEngine(); }
			return _instance;
		}
		
		

		public function addEmitter(emitter:IParticleFactory) : void
		{
			emitters.push(emitter);
		}
		
		public function addParticle( particle:IParticle) : void
		{
			particle.visible = false;
			particles.push( particle );				
		}

		public function removeParticle( particle:IParticle ) : void
		{
			particles.splice( particles.indexOf(particle),1 );
			if( particle is IRecyleableParticle )
			{
				(particle as IRecyleableParticle ).factory.recycle( particle );
			}
			else
			{
				particle.remove();		
			}			
		}
		
		protected function onTime(event:TimerEvent) : void
		{
			var now:Date = new Date();
			
			for each (var particle:IParticle in particles )
			{
				particle.visible = true;
				for each ( var rule:IPulseRule in particle.rules )
				{
					rule.applyRule( particle, now.time, lastUpdate );
				}	
			}

			lastUpdate = now.time;
			
			if( updateAfterTimer )
			{
				event.updateAfterEvent();
			}												
		}
		
		public function stopAndRemoveAllParticles() : void
		{
			for each (var particle:IParticle in particles )
			{
				particle.remove();				
			}
			particles = [];
		}


	}
}