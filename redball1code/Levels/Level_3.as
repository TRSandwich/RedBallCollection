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

	public class Level_3 extends Level {	
		private var movePlatform1Body:b2Body;
		private var movePlatform2Body:b2Body;
		
		private var movePlatform1BodyDirection:int;
		private var movePlatform2BodyDirection:int;
			
		public function Level_3() {
			super();
			id=3;
									
			CreateBody("firstPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[150, 0], [150, 20], [0, 20], [0, 0]]]);
			CreateBody("shipPlatform1","Polygon",0,defaultFriction,defaultRestitution,[[[250, 0], [250, 20], [0, 20], [0, 0]]]);
			CreateBody("shipPlatform2","Polygon",0,defaultFriction,defaultRestitution,[[[250, 0], [250, 20], [0, 20], [0, 0]]]);
			movePlatform1Body = CreateBody("movePlatform1","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[150, 0], [150, 10], [0, 10], [0, 0]]]);
			movePlatform2Body = CreateBody("movePlatform2","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[150, 0], [150, 10], [0, 10], [0, 0]]]);
			CreateBody("exitPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[450, 0], [450, 20], [0, 20], [0, 0]]]);
			
			var prismaticJointDef:b2PrismaticJointDef=new b2PrismaticJointDef();
						
			prismaticJointDef.Initialize(movePlatform1Body, m_ground, movePlatform1Body.GetWorldCenter(), new b2Vec2(0,1));
			prismaticJointDef.enableLimit = false;
			prismaticJointDef.enableMotor = false; 
			m_world.CreateJoint(prismaticJointDef);
			movePlatform1BodyDirection=1;
			
			prismaticJointDef.Initialize(movePlatform2Body, m_ground, movePlatform2Body.GetWorldCenter(), new b2Vec2(0,1));
			prismaticJointDef.enableLimit = false;
			prismaticJointDef.enableMotor = false; 
			m_world.CreateJoint(prismaticJointDef);
			movePlatform2BodyDirection=1;
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>650) {
					 if(playerBox.IsLive()) PlayerDie();
			}
			
			if(movePlatform1.y<270) movePlatform1BodyDirection=1;
			if(movePlatform1.y>425) movePlatform1BodyDirection=-1;
			movePlatform1Body.SetLinearVelocity(new b2Vec2(0,3*movePlatform1BodyDirection));
			
			if(movePlatform2.y<116) movePlatform2BodyDirection=1;
			if(movePlatform2.y>271) movePlatform2BodyDirection=-1;
			movePlatform2Body.SetLinearVelocity(new b2Vec2(0,3*movePlatform2BodyDirection));
		}
	}
}