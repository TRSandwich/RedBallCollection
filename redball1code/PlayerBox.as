package {
	import flash.display.*;
	import flash.geom.Point;
	
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	
	import Levels.Level;
	
	public class PlayerBox extends MovieClip {	
		public var body:b2Body;
		
		private var m_worldIn:b2World;
		private var m_spriteIn:Sprite;
		private var live:Boolean=true;
		private var testPoints:Array=new Array();
	
		public function PlayerBox(_x:Number, _y:Number, _m_world:b2World, _parentSprite:Sprite) {	
			var bodyDef:b2BodyDef = new b2BodyDef();
			//var boxDef:b2PolygonDef = new b2PolygonDef();
			var circDef:b2CircleDef = new b2CircleDef();
			
			m_worldIn=_m_world;
			m_spriteIn=_parentSprite;
			
			x=_x;
			y=_y;
			_parentSprite.x = -this.x+Game.stageWidth/2;
			_parentSprite.y = -this.y+Game.stageHeight/2;
			
            /*bodyDef.position.x = _x/Level.m_physScale;
            bodyDef.position.y = _y/Level.m_physScale;
            boxDef.SetAsBox(width/Level.m_physScale/2, height/Level.m_physScale/2);
            boxDef.density = 1.0;
            boxDef.friction = 0.35;
            boxDef.restitution = 0.2;*/
						
			circDef.radius=width/Level.m_physScale/2;
			circDef.localPosition.Set(0,0);
			circDef.density = 1;
            circDef.friction = 0.4;
            circDef.restitution = 0.2;
						
			bodyDef.position.Set(_x/Level.m_physScale,_y/Level.m_physScale);
			//bodyDef.linearDamping = 0.1;
			//bodyDef.angularDamping = 1.5;
			bodyDef.userData=this;
            body = _m_world.CreateBody(bodyDef);
            body.SetBullet(true);
            body.CreateShape(circDef);
            body.SetMassFromShapes();
			_parentSprite.addChild(this);
			
			var testPointsNum:int=16;
			var radius:Number=this.width/2;
			var stepAngle:Number=2*Math.PI/testPointsNum;
			for(var i:int=0;i<testPointsNum;i++) {
				testPoints.push(new Point(radius*Math.cos(stepAngle*i),radius*Math.sin(stepAngle*i)));
			}
		}
		
		public function IsLive():Boolean {
			return live;
		}
		
		public function Kill():void {
			if(this.live) {
				m_worldIn.DestroyBody(this.body);
				m_spriteIn.removeChild(this);
				live=false;
			}
		}
		
		public function HitTestObjectControlPoints(obj:DisplayObject):Boolean {
			for(var i:int=0;i<16;i++) {
				var currentGlobalTestPoint:Point=this.localToGlobal(testPoints[i]);
				if(obj.hitTestPoint(currentGlobalTestPoint.x,currentGlobalTestPoint.y,true)) {
					return true;
				}
			}
			return false;
		}
	}
}