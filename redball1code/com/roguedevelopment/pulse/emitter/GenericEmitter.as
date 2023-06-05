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


package com.roguedevelopment.pulse.emitter
{
	import com.roguedevelopment.pulse.PulseEngine;
	import com.roguedevelopment.pulse.particle.IParticle;
	import com.roguedevelopment.pulse.particle.IParticleFactory;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * The GenericEmitter is responsible for creating particles on a schedule and adding them to the PulseEngine.
	 **/ 	
	public class GenericEmitter implements IParticleEmitter
	{
		protected var _x:Number = 10;
		protected var _y:Number = 10;
		protected var timer:Timer;
		protected var factory:IParticleFactory;
		public var width:Number = 1;
		public var height:Number = 1;
		public var particleLimit:uint = 0;
		protected var particleCount:uint = 0;
		
		public var root:DisplayObjectContainer = null;
		
		public var newParticlesOnTop:Boolean = true;
		
		public function GenericEmitter( particlesPerSecond:Number )
		{
			super();
			pps = particlesPerSecond;
			root = PulseEngine.instance.root;
		}

		[Inspectable]
		public function set pps(val:Number) : void
		{
			if( timer != null ) { timer.stop(); }
			timer = new Timer( 1000 / val );
			timer.addEventListener(TimerEvent.TIMER, emit);
			timer.start(); 
		}
		
		public function get pps():Number { return 10; }

		public function getFactory() : IParticleFactory { return factory; }
		public function setFactory( factory:IParticleFactory ) : void { this.factory = factory; }

		public function set x(v:Number):void
		{
			_x = v;
		}
		
		public function set y(v:Number):void
		{
			_y = v;	
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		protected function emit(event:TimerEvent) : void
		{
			if( factory == null ) { return; }
			if( particleLimit > 0 )
			{
				particleCount++;
				if( particleCount > particleLimit ) 
				{ 
					timer.stop();
					return; 
				}
			}
			var particle:IParticle = factory.newParticle();
			particle.x = x + Math.random() * width;
			particle.y = y + Math.random() * height;
			
			if( particle is DisplayObject )
			{
				if( newParticlesOnTop )
				{
					root.addChild( (particle as DisplayObject) );
				}
				else
				{
					root.addChildAt( (particle as DisplayObject) , 0);
				}
			}
			PulseEngine.instance.addParticle( particle );
		}
		

		public function start() : void
		{
			particleCount = 0;
			timer.start();
		}
		public function stop() : void
		{			
		
			if( factory != null )
			{
				factory.cleanup();			
			}
			timer.stop();
		}
		
		
	}
}