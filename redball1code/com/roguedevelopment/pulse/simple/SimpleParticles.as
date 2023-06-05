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
 
 
package com.roguedevelopment.pulse.simple
{
	import com.adobe.serialization.json.JSONDecoder;
	import com.roguedevelopment.pulse.PulseEngine;
	import com.roguedevelopment.pulse.emitter.BitmapEmitter;
	import com.roguedevelopment.pulse.emitter.GenericEmitter;
	import com.roguedevelopment.pulse.emitter.IParticleEmitter;
	import com.roguedevelopment.pulse.initializers.AngleRandomizerInitializer;
	import com.roguedevelopment.pulse.initializers.ParameterInitializer;
	import com.roguedevelopment.pulse.initializers.ParameterRandomizerInitializer;
	import com.roguedevelopment.pulse.initializers.RandomFrameInit;
	import com.roguedevelopment.pulse.initializers.ScaleRandomizerInitializer;
	import com.roguedevelopment.pulse.particle.DotParticle;
	import com.roguedevelopment.pulse.particle.GenericFactory;
	import com.roguedevelopment.pulse.particle.IParticleFactory;
	import com.roguedevelopment.pulse.particle.ImageParticle;
	import com.roguedevelopment.pulse.particle.LineParticle;
	import com.roguedevelopment.pulse.rule.AccelerationRule;
	import com.roguedevelopment.pulse.rule.BoundingBoxRule;
	import com.roguedevelopment.pulse.rule.ColorTransformRule;
	import com.roguedevelopment.pulse.rule.DeathRule;
	import com.roguedevelopment.pulse.rule.FadeRule;
	import com.roguedevelopment.pulse.rule.GravityRule;
	import com.roguedevelopment.pulse.rule.IPulseRule;
	import com.roguedevelopment.pulse.rule.MouseSwarmRule;
	import com.roguedevelopment.pulse.rule.MovementRule;
	import com.roguedevelopment.pulse.rule.MovementStopRule;
	import com.roguedevelopment.pulse.rule.PointSwarmRule;
	import com.roguedevelopment.pulse.rule.RotateRule;
	import com.roguedevelopment.pulse.rule.RotateToAngleRule;
	import com.roguedevelopment.pulse.rule.ScaleRule;
	import com.roguedevelopment.pulse.rule.TweenRule;
	import com.roguedevelopment.pulse.rule.XOscillatorRule;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * This class makes creating particle emitters designed with the particle explorer easy by using the configuration string it gives you.
	 * 
	 * The createEmitter method is where most of the magic is in this class.
	 **/
	public class SimpleParticles
	{

			
		protected static var rules:Object = 
			{
				scale:ScaleRule,
				fade:FadeRule,	
				gravity:GravityRule,
				movement:MovementRule,
				lifespan:DeathRule,
				mouseSwarm:MouseSwarmRule,
				rotateToAngle:RotateToAngleRule,
				xOscillate:XOscillatorRule,
				tween:TweenRule,
				pointSwarm:PointSwarmRule,
				rotate:RotateRule,	
				accel:AccelerationRule,	
				bound:BoundingBoxRule,
				stop:MovementStopRule,
				colorTransform:ColorTransformRule
				
			};
			
		/**
		 * <pre>
		 * Creates and returns a new particle emitter. 
		 * 
		 * @param params - An associative object with a combination of any of the following options.
		 * 
		 * Available options:
		 * 
		 * pps - Particles Per Second - How many particles to spew out every second.
		 *  Paramaters: amount
		 *  Example     createEmitter({ pps:50 });
		 * 
		 * scale - Creates a scale rule that causes the particles to change size over time. 
		 *  Paramaters: [ time, start scale, end scale ]
		 *  Example     createEmitter({ scale:[3000,1,0.2] });
		 *  
		 * lifespan - Determines how long each particle will live for, in milliseconds.
		 *  Paramaters: time
		 *  Example     createEmitter({ lifespan:8000 });
		 *  
		 * gravity - Causes the particles to suffer from gravity effects.
		 *  Paramaters: amount
		 *  Example     createEmitter({ gravity:3 }); 
		 * 
		 * fade - Causes the particle tofade out over time.
		 * Paramaters: time
		 *  Example     createEmitter({ fade:8000 });
		 *  
		 * image - Causes the particle to be rendered as a bitmap image.
		 *  Paramaters - a Class object of an embedded bitmap.
		 *  Example
		 *     [Embed(source="man.png")]
		 *     var man:Class;     
		 *     createEmitter({ image:man });
		 *  
		 * x - Sets the source X coordinate of the particles.
		 *  Example    createEmitter({  x:100 });
		 *
		 * y - Sets the source Y coordinate of the particles.  
		 *  Example    createEmitter({ y:100 });
		 *  
		 * movement - Determines whether or not the Movement rule should be applied to particles, this rule
		 *            looks at the speed & angle of the particle and causes it to move.
		 *  Example    createEmitter({ movement:true });
		 *  
		 * minAngle / maxAngle - Determines the minimum and maximum angle that the particle will be pointed in to start with, individual particles will have
		 *  values between these assigned randomly.
		 *  Example    createEmitter({ minAngle:0 });
		 *  Example    createEmitter({ maxAngle:360 });
		 *  
		 * minSpeed / maxSpeed - Determines the minimum and maximum speed that the particle will start with (in pixels per second), individual particles will have
		 *  values between these assigned randomly.
		 *  Example    createEmitter({ minSpeed:10 });
		 *  Example    createEmitter({  maxSpeed:150 });
		 *  
		 * size - For dot or line particles, this determines the size of the particle.
		 *  Example    createEmitter({  size:5 });
		 *
		 * color - For dot or line particles, this determines the color of the particle.  
		 *  Example    createEmitter({  color:0xff0000 });
		 * 
		 * dot - Causes the particles to be a dot shape (circle)
		 *  Example    createEmitter({  dot:true });
		 * 
		 * line - Causes the particles look like a straight line
		 *  Example    createEmitter({  line:true });
		 * 
		 * start - Specifies whether or not the emitter should be started right away.
		 *  Example    createEmitter( { start:true } );
		 *                or
		 *             var emitter = createEmitter( { start:false } );
		 *             // sometime later...
		 *             emitter.start();
 		 * 
 		 * pointSwarm - Causes the particles to swarm towards a certain point.
 		 *  Paramaters: point
 		 *  Example: createEmitter( { pointSwarm:[x,y]} );
 		 * 
 		 * mouseSwarm - Causes the particles to swarm towards the mouse.
		 *  Paramaters: stage 
		 *    This paramter requires a reference to the stage so it can set up a mouse listener. 
		 *  Example 	   mouseSwarm:stage,
		 * 
		 * rotateToAngle - Causes the RotateToAngleRule to be executed, this causes the particles to rotate in the direction they're traveling.
		 *   Example: createEmitter( { rotateToAngleRule:false } );
		 * 
		 * xOscillate - Causes the XOscillatorRule rule to be executed, this causes the particle to oscillate back and forth in the X direction.
		 *   Paramaters: [ amount, dampen ]
		 *   Example: createEmitter( {xOscillate:[5,100]} );
		 * 
		 * tween - Causes the TweenRule to be executed for the particles, this can tween arbitrary values of the particles.
		 *   Paramaters - [ paramater, start value, end value, duration]
		 *   Example: createEmitter( {tween:["x",1,100,3000]} ); 			
		 * </pre>
		 **/
		public static function createEmitter( params:Object ) : IParticleEmitter
		{
			var emitter:GenericEmitter;
			var pps:int = 10;
			
			if( params.hasOwnProperty("pps" ) )
			{
			 	pps = params.pps;
			}

			if( params.hasOwnProperty("bme") && params.bme )
			{			
				var bmd:BitmapData = new BitmapData( PulseEngine.instance.root.stage.width,PulseEngine.instance.root.stage.height, true, 0);
				var bm:Bitmap = new Bitmap(bmd);
				PulseEngine.instance.root.addChild( bm );
				emitter = new BitmapEmitter(pps,bmd);
			}
			else
			{
				emitter = new GenericEmitter(pps);
			}
			configureEmitterByObject(emitter,params);
			return emitter;		
		}
		
		public static function configureEmitter(emitter:GenericEmitter, params:String ) : IParticleEmitter
		{							  
			try
			{           
           		var r:RegExp = /([a-zA-Z0-9_]+):/g;            
            	params = params.replace ( r, "\"$1\":"); // quote the keys
            	var d:JSONDecoder = new JSONDecoder(params);    	        
        		var o:Object = d.getValue()
   			}
   			catch(e:Error) {return emitter;}
        	
        	 return configureEmitterByObject(emitter,o);			
		}
		
		
		
		public static function configureEmitterByObject(emitter:GenericEmitter, params:Object ) : IParticleEmitter
		{
			var start:Boolean = true;		
			var factory:IParticleFactory = emitter.getFactory() ;
			var rules:Array = [];
			var initializers:Array = [];

			// These are for backwards compatibility			
			if( params.hasOwnProperty("minSpeed") && params.hasOwnProperty("maxSpeed") )
			{
				initializers.push( new ParameterRandomizerInitializer("speed", params.minSpeed, params.maxSpeed, true) );
			}
			if( params.hasOwnProperty("minAngle") && params.hasOwnProperty("maxAngle") )
			{
				initializers.push( new AngleRandomizerInitializer( params.minAngle, params.maxAngle) );
			}
			if( params.hasOwnProperty("minScale") && params.hasOwnProperty("maxScale") )
			{
				initializers.push( new ScaleRandomizerInitializer(params.minScale, params.maxScale) );
			}

			 
			// And the more modern functionality...
			for( var param:String in params )
			{
				
				switch( param )
				{
					case "start": start = params.start; break;
					case "x": emitter.x = params.x; break;
					case "y": emitter.y = params.y; break;
					case "dot": factory = createDotFactory( params[param], rules, initializers  ); break;
					case "line": factory = createLineFactory( params[param], rules, initializers ); break;
					case "image": 	initializers.push( new ParameterInitializer("image", params[param]));					
									factory = createImageFactory( params[param] , rules, initializers); break;
					case "width": emitter.width = params[param] as Number; break;
					case "height": emitter.height = params[param] as Number; break;
					case "limit":emitter.particleLimit = params[param] as Number; break;					
					 
					default:
						 
						if( (! doRule( param, params[param] , rules) ) &&
						    (! doInitializer(param, params[param], initializers) )
						  )
						{	
							if( params[param] is Array )
							{		
								var aparam:Array = params[param] as Array;				
								initializers.push( new ParameterRandomizerInitializer(param, aparam[0], aparam[1], true) );
							}
							if( params[param] is Number )
							{											
								initializers.push( new ParameterInitializer(param, params[param] as Number) );
							}
							
						} 
						break;
					
				}
			}
			
			if( factory == null )
			{
				factory = createDotFactory( null, rules, initializers  );
			}
			else
			{
				factory.rules = rules;
				factory.initializers = initializers;
			}
			emitter.setFactory( factory );
			if( start) { emitter.start(); }
			return emitter;		
		}

		
		protected static function doInitializer( ruleName:String, params:Object , currentInits : Array) : Boolean
		{
			var a:Array = params as Array;
			switch( ruleName )
			{
				case "startScale":	currentInits.push( new ScaleRandomizerInitializer( a[0], a[1] ) );	return true;
				case "angle": currentInits.push( new AngleRandomizerInitializer( a[0], a[1] ));	return true;
				case "randomFrame": currentInits.push( new RandomFrameInit() ); return true;
			}
			
			return false;
		}
		protected static function doRule( ruleName:String, params:Object , currentRules : Array) : Boolean
		{
			if( ! rules.hasOwnProperty(ruleName) )
			{
				return false;
			}
			
			var ruleClass:Class = rules[ruleName];
			
			var rule:IPulseRule = new ruleClass();
			if(  params is Array )
			{
				rule.configure( params as Array );
			}
			else
			{
				rule.configure( [ params ] );
			}

			
			currentRules.push(rule);
			return true;
		}
		
		protected static function createDotFactory( param:Object , rules:Array, initializers:Array ) : IParticleFactory
		{
			return new GenericFactory( DotParticle, rules, initializers );	
		}

		protected static function createLineFactory( param:Object , rules:Array, initializers:Array  ) : IParticleFactory
		{
			return new GenericFactory( LineParticle, rules, initializers );
		}

		protected static function createImageFactory( param:Object , rules:Array, initializers:Array  ) : IParticleFactory
		{
			return new GenericFactory( ImageParticle, rules, initializers );
		}
		
	
	}
}