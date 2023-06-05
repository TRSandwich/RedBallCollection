package Levels{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;

	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;

	public class Level_2 extends Level {
		private var movePlatformBody:b2Body;
		private var movePlatformBodyDirection:int;
				
		public function Level_2() {
			super();
			id=2;
			
			CreateBody("firstPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[166, 0], [166, 20], [0, 20], [0, 0]]]);
			CreateBody("platformTriangle","Polygon",0,defaultFriction,defaultRestitution,[[[166, 0], [166, 20], [0, 20], [0, 0]]]);
			CreateBody("triangleBarier","Polygon",0,defaultFriction,defaultRestitution,[[[68, 67], [0, 67], [68, 15]]]);
			CreateBody("ballPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[166, 0], [166, 20], [0, 20], [0, 0]]]);
			var kickBallBody:b2Body = CreateBody("kickBall","Circle",3*defaultDensity,defaultFriction,defaultRestitution,[54]);
			CreateBody("jump1","Polygon",0,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			movePlatformBody = CreateBody("movePlatform","Polygon",defaultDensity,3*defaultFriction,defaultRestitution,[[[40, -5], [40, 5], [-40, 5], [-40, -5]]]);
			CreateBody("exitPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[166, 0], [166, 20], [0, 20], [0, 0]]]);
			var distanceJointDef:b2DistanceJointDef=new b2DistanceJointDef();
			var prismaticJointDef:b2PrismaticJointDef=new b2PrismaticJointDef();
			var mouseJointDef:b2MouseJointDef = new b2MouseJointDef();
			
			distanceJointDef.Initialize(kickBallBody, m_ground, new b2Vec2(148/m_physScale,305/m_physScale), new b2Vec2(87/m_physScale,209/m_physScale));
			m_world.CreateJoint(distanceJointDef);
			
			prismaticJointDef.Initialize(movePlatformBody, m_ground, movePlatformBody.GetWorldCenter(), new b2Vec2(1,0));
			prismaticJointDef.enableLimit = false;
			prismaticJointDef.enableMotor = false;
			movePlatformBodyDirection=1;
			m_world.CreateJoint(prismaticJointDef);
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>550) {
					if(playerBox.IsLive()) PlayerDie();
			}

			if(movePlatform.x<390) movePlatformBodyDirection=1;
			if(movePlatform.x>550) movePlatformBodyDirection=-1;
			
			movePlatformBody.SetLinearVelocity(new b2Vec2(2*movePlatformBodyDirection,0));
		}
	}
}