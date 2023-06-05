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
package com.roguedevelopment.pulse.particle
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	

	public class GenericParticle extends Sprite implements IRecyleableParticle
	{
		protected var _rules:Array;
		protected var _birth:Number;
		protected var _params:Object = {angle:0, speed:0};
		protected var _factory:IParticleFactory;

		
		public function GenericParticle()
		{
			super();						
			_birth = ( new Date() ).time
		}
		public function get params() : Object { return _params; }
		public function get birthTime() : Number { return _birth; }
		public function get rules():Array
		{
			return _rules;
		}
		public function set rules(rules:Array) : void
		{
			_rules = rules;
		}

		public function get factory() : IParticleFactory { return _factory; }
		public function set factory(v:IParticleFactory) : void { _factory = v; }
		
		public function recycle() : void
		{
			_birth = (new Date()).time;
			scaleX = 1;
			rotation = 0;
			scaleY = 1;
			alpha = 1;
			visible = true;
			transform.colorTransform = new ColorTransform();
		}	
		
		public function remove() : void
		{
			if( parent != null )
			{
				parent.removeChild( this );	
			}
		}	

	}
}