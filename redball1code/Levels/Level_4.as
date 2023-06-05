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

	public class Level_4 extends Level {		
	
		private var killBoom1Body:b2Body;
		private var killBoom2Body:b2Body;
		private var killBoom3Body:b2Body;
		private var axe1Body:b2Body;
		private var axe2Body:b2Body;
		private var dropPlatformBody:b2Body;
		
		private var killBoom1Up:Boolean;
		private var killBoom2Up:Boolean;
		private var killBoom3Up:Boolean;
	
		public function Level_4() {
			super();
			id=4;
						
			CreateBody("mainPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[810, 0], [810, 20], [0, 20], [0, 0]]]);
			CreateBody("firstFloor","Polygon",0,defaultFriction,defaultRestitution,[[[200, 0], [200, 20], [0, 20], [0, 0]]]);
			CreateBody("secondFloor1","Polygon",0,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			CreateBody("secondFloor2","Polygon",0,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			CreateBody("secondFloor3","Polygon",0,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			CreateBody("step","Polygon",0,defaultFriction,defaultRestitution,[[[117, -10], [202, -10], [117, 12]], [[92, 12], [117, 12], [92, 34]], [[117, 12], [202, -10], [150, 16], [92, 34]], [[70, 34], [92, 34], [150, 122], [70, 57]], [[45, 57], [70, 57], [45, 76]], [[24, 76], [45, 76], [24, 99]], [[45, 76], [70, 57], [24, 99]], [[0, 99], [24, 99], [0, 122]], [[24, 99], [70, 57], [150, 122], [0, 122]], [[150, 122], [92, 34], [150, 16]], [[202, 16], [150, 16], [202, -10]]]);
			dropPlatformBody = CreateBody("dropPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[130, 0], [130, 10], [0, 10], [0, 0]]]);
			CreateBody("axePlatform","Polygon",0,defaultFriction,defaultRestitution,[[[850, 0], [850, 20], [0, 20], [0, 0]]]);
			killBoom1Body = CreateBody("killBoom1","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[19.5, -267.5], [19.5, -31.5], [-19.5, -31.5], [-19.5, -267.5]], [[-19.5, -31.5], [19.5, -31.5], [50.5, 0.5], [-47.5, 0.5]]]);
			killBoom2Body = CreateBody("killBoom2","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[19.5, -267.5], [19.5, -31.5], [-19.5, -31.5], [-19.5, -267.5]], [[-19.5, -31.5], [19.5, -31.5], [50.5, 0.5], [-47.5, 0.5]]]);
			killBoom3Body = CreateBody("killBoom3","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[19.5, -267.5], [19.5, -31.5], [-19.5, -31.5], [-19.5, -267.5]], [[-19.5, -31.5], [19.5, -31.5], [50.5, 0.5], [-47.5, 0.5]]]);
			axe1Body = CreateBody("axe1","Polygon",2*defaultDensity,defaultFriction,defaultRestitution,[[[25.5, -1.5], [40.5, -1.5], [40.5, 113.5], [25.5, 113.5]], [[0.5, 116.5], [25.5, 113.5], [40.5, 113.5], [67.5, 116.5], [67.5, 175.5], [0.5, 175.5]]]);		
			axe2Body = CreateBody("axe2","Polygon",2*defaultDensity,defaultFriction,defaultRestitution,[[[25.5, -1.5], [40.5, -1.5], [40.5, 113.5], [25.5, 113.5]], [[0.5, 116.5], [25.5, 113.5], [40.5, 113.5], [67.5, 116.5], [67.5, 175.5], [0.5, 175.5]]]);			
			
			var prismaticJointDef:b2PrismaticJointDef=new b2PrismaticJointDef();
			var revoluteJointDef:b2RevoluteJointDef=new b2RevoluteJointDef();
						
			prismaticJointDef.Initialize(killBoom1Body, m_ground, killBoom1Body.GetWorldCenter(), new b2Vec2(0,1));
			prismaticJointDef.enableLimit = false;
			prismaticJointDef.enableMotor = false; 
			m_world.CreateJoint(prismaticJointDef);
			killBoom1Up=true;
			
			prismaticJointDef.Initialize(killBoom2Body, m_ground, killBoom2Body.GetWorldCenter(), new b2Vec2(0,1));
			prismaticJointDef.enableLimit = false;
			prismaticJointDef.enableMotor = false; 
			m_world.CreateJoint(prismaticJointDef);
			killBoom1Up=true;


			prismaticJointDef.Initialize(killBoom3Body, m_ground, killBoom3Body.GetWorldCenter(), new b2Vec2(0,1));
			prismaticJointDef.enableLimit = false;
			prismaticJointDef.enableMotor = false; 
			m_world.CreateJoint(prismaticJointDef);
			killBoom1Up=true;
			
			revoluteJointDef.Initialize(axe1Body, m_ground, new b2Vec2(785/m_physScale,127/m_physScale)); 
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(axe2Body, m_ground, new b2Vec2(1077/m_physScale,127/m_physScale)); 
			m_world.CreateJoint(revoluteJointDef);
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>650 ||
			   myContactListener.playerContactBodies.indexOf(killBoom1Body)!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killBoom2Body)!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killBoom3Body)!=-1 ||
			   myContactListener.playerContactBodies.indexOf(axe1Body)!=-1 || 
			   myContactListener.playerContactBodies.indexOf(axe2Body)!=-1) {
					if(playerBox.IsLive()) PlayerDie();
			}
			
			if(myContactListener.playerContactBodies.indexOf(dropPlatformBody)!=-1) {
				m_world.DestroyBody(dropPlatformBody);
				dropPlatformBody = CreateBody("dropPlatform","Polygon",3*defaultDensity,defaultFriction,defaultRestitution,[[[130, 0], [130, 10], [0, 10], [0, 0]]]);
			}
						
			if(killBoom1.y>436) killBoom1Up=true;
			if(killBoom1.y<327) killBoom1Up=false;
			if(killBoom1Up) killBoom1Body.SetLinearVelocity(new b2Vec2(0,-2));
			
			if(killBoom2.y>436) killBoom2Up=true;
			if(killBoom2.y<327) killBoom2Up=false;
			if(killBoom2Up) killBoom2Body.SetLinearVelocity(new b2Vec2(0,-2));
			
			if(killBoom3.y>436) killBoom3Up=true;
			if(killBoom3.y<327) killBoom3Up=false;
			if(killBoom3Up) killBoom3Body.SetLinearVelocity(new b2Vec2(0,-2));
		}
	}
}