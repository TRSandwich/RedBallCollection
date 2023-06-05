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

	public class Level_7 extends Level {	
		private var jumpPlatform1Body:b2Body;
		private var jumpPlatform1Joint:b2PrismaticJoint;
		private var jumpPlatform2Body:b2Body;
		private var jumpPlatform2Joint:b2PrismaticJoint;
		
		private var movePlatform1Body:b2Body;
		private var movePlatform2Body:b2Body;
		private var movePlatform1BodyDirection:int;
		private var movePlatform2BodyDirection:int;
		
		private var bluePlatformBody:b2Body;
		private var starBody:b2Body;
		
		private var redWallBody:b2Body;
		public static var redCheckLevel:Boolean=false;
	
		public function Level_7() {
			super();
			id=7;
						
			CreateBody("firstPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[150, 0], [150, 20], [0, 20], [0, 0]]]);
			jumpPlatform1Body=CreateBody("jumpPlatform1","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			CreateBody("bigPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[228.2, -82.45], [228.2, -59.45], [-264.8, -47.45], [-264.8, -82.45]], [[-264.8, -47.45], [228.2, -59.45], [-339.8, 11.55]], [[-441.75, 11.55], [-339.8, 11.55], [-527.75, 61.5]], [[-339.8, 11.55], [228.2, -59.45], [254.2, -59.45], [254.2, -36.45], [-527.75, 82.5], [-527.75, 61.5]], [[527.75, 29], [527.75, 82.5], [512.1, 42.5]], [[512.1, 42.5], [527.75, 82.5], [492.9, 51.2]], [[492.9, 51.2], [527.75, 82.5], [475.55, 53.2]], [[527.75, 82.5], [-527.75, 82.5], [457.5, 51.7], [475.55, 53.2]], [[457.5, 51.7], [-527.75, 82.5], [415.55, 41.25]], [[415.55, 41.25], [-527.75, 82.5], [309.2, 8.55]], [[309.2, 8.55], [-527.75, 82.5], [280.2, -14.45], [309.2, -14.45]], [[280.2, -14.45], [-527.75, 82.5], [254.2, -36.45], [280.2, -36.45]]]);
			var potolokBody:b2Body = potolokBody = CreateBody("potolok","Polygon",0,defaultFriction,defaultRestitution,[[[257, -78], [257, -19], [-200, 44], [-257, -10], [-257, -78]], [[-200, 44], [257, -19], [205, 33], [-200, 78]], [[205, 78], [-200, 78], [205, 33]]]);
			CreateBody("triangle","Polygon",0,defaultFriction,defaultRestitution,[[[-375.95, -58], [-155.95, -36.75], [257.1, 31.15], [-373.9, 55]], [[404, 55], [-373.9, 55], [257.1, 31.15], [404, 31.2]], [[257.1, 31.15], [-155.95, -36.75], [112.1, -53.75]], [[112.1, -53.75], [-155.95, -36.75], [-0.4, -126.95]]]);
			movePlatform1Body = CreateBody("movePlatform1","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[75, -5], [75, 5], [-75, 5], [-75, -5]]]);
			movePlatform2Body = CreateBody("movePlatform2","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[75, -5], [75, 5], [-75, 5], [-75, -5]]]);
			jumpPlatform2Body=CreateBody("jumpPlatform2","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			CreateBody("vanna","Polygon",0,defaultFriction,defaultRestitution,[[[415.5, -92.5], [415.5, -59.05], [194.55, 92.45], [164.55, 50.45], [234.55, -92.5]], [[-156.45, -89.5], [-63.45, 50.45], [-74.45, 92.45], [-415.45, -59.55], [-415.45, -89.5]], [[-63.45, 50.45], [164.55, 50.45], [194.55, 92.45], [-74.45, 92.45]]]);
			redWallBody =CreateBody("redWall","Polygon",0,defaultFriction,defaultRestitution,[[[1.5, -61.5], [1.5, 61.5], [-18.5, 61.5], [-18.5, -61.5]]]);
			if(redCheckLevel) DestroyBody(redWallBody);
			var bigMovePlatformBody:b2Body = CreateBody("bigMovePlatform","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-75, -5], [75, -5], [75, 5], [-75, 5]]]);
			CreateBody("endPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[150, 0], [150, 20], [0, 20], [0, 0]]]);
			for(var i:int=1;i<=18;i++) {
				CreateBody("box"+i.toString(),"Polygon",0.3,defaultFriction,defaultRestitution,[[[10, -10], [10, 10], [-10, 10], [-10, -10]]]);
			}
			bluePlatformBody = CreateBody("bluePlatform","Polygon",0,defaultFriction,defaultRestitution,[[[140, 0], [140, 20], [0, 20], [0, 0]]]);
			starBody = CreateBody("star","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-0.25, 15], [2, 27.85], [-2.15, 27.95]], [[2, 27.85], [15, 29.75], [2.1, 32], [-2.05, 32.1], [-15, 30.2], [-2.15, 27.95]], [[0.2, 45], [-2.05, 32.1], [2.1, 32]]]);
			
			
			var distanceJointDef:b2DistanceJointDef=new b2DistanceJointDef();
			var prismaticJointDef:b2PrismaticJointDef=new b2PrismaticJointDef();
						
			distanceJointDef.Initialize(bigMovePlatformBody, m_ground, new b2Vec2(3077/m_physScale,-190/m_physScale), new b2Vec2(3005/m_physScale,-305/m_physScale));
			m_world.CreateJoint(distanceJointDef);
			distanceJointDef.Initialize(bigMovePlatformBody, m_ground, new b2Vec2(2944/m_physScale,-190/m_physScale), new b2Vec2(2873/m_physScale,-305/m_physScale));
			m_world.CreateJoint(distanceJointDef);
			distanceJointDef.Initialize(starBody, potolokBody, new b2Vec2(619/m_physScale,-51.5/m_physScale), new b2Vec2(552/m_physScale,-111/m_physScale));
			m_world.CreateJoint(distanceJointDef);
						
			prismaticJointDef.Initialize(jumpPlatform1Body, m_ground, jumpPlatform1Body.GetWorldCenter(), new b2Vec2(0,1));
			prismaticJointDef.lowerTranslation = 0;
			prismaticJointDef.upperTranslation = 1;
			prismaticJointDef.enableLimit = true;
			prismaticJointDef.maxMotorForce = 0;
			prismaticJointDef.motorSpeed = 200;
			prismaticJointDef.enableMotor = true; 
			jumpPlatform1Joint=m_world.CreateJoint(prismaticJointDef) as b2PrismaticJoint;
			
			prismaticJointDef.Initialize(jumpPlatform2Body, m_ground, jumpPlatform2Body.GetWorldCenter(), new b2Vec2(0,1));
			prismaticJointDef.lowerTranslation = 0;
			prismaticJointDef.upperTranslation = 1;
			prismaticJointDef.enableLimit = true;
			prismaticJointDef.maxMotorForce = 0;
			prismaticJointDef.motorSpeed = 200;
			prismaticJointDef.enableMotor = true; 
			jumpPlatform2Joint=m_world.CreateJoint(prismaticJointDef) as b2PrismaticJoint;
			
			prismaticJointDef.Initialize(movePlatform1Body, m_ground, movePlatform1Body.GetWorldCenter(), new b2Vec2(0,1));
			prismaticJointDef.enableLimit = false;
			prismaticJointDef.enableMotor = false; 
			m_world.CreateJoint(prismaticJointDef);
			movePlatform1BodyDirection=1;
			
			prismaticJointDef.Initialize(movePlatform2Body, m_ground, movePlatform2Body.GetWorldCenter(), new b2Vec2(1,0));
			prismaticJointDef.enableLimit = false;
			prismaticJointDef.enableMotor = false; 
			m_world.CreateJoint(prismaticJointDef);
			movePlatform2BodyDirection=1;
			
			redCheck.stop();
			blueCheck.stop();
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>500 ||
			   myContactListener.playerContactBodies.indexOf(starBody)!=-1) {
					if(playerBox.IsLive()) PlayerDie();
			}
			
			if(myContactListener.playerContactBodies.indexOf(jumpPlatform1Body)!=-1) {
				jumpPlatform1Joint.SetMaxMotorForce(150);
				if(Game.soundIs && !jumpPlatformSoundChannel) {
					jumpPlatformSoundChannel=jumpPlatformSound.play(0,1); 
					jumpPlatformSoundChannel.addEventListener(Event.SOUND_COMPLETE, jumpPlatformSoundCompleteHandler);
				}
			} else {
				jumpPlatform1Joint.SetMaxMotorForce(0);
			}
			
			if(myContactListener.playerContactBodies.indexOf(jumpPlatform2Body)!=-1) {
				jumpPlatform2Joint.SetMaxMotorForce(170);
				if(Game.soundIs && !jumpPlatformSoundChannel) {
					jumpPlatformSoundChannel=jumpPlatformSound.play(0,1); 
					jumpPlatformSoundChannel.addEventListener(Event.SOUND_COMPLETE, jumpPlatformSoundCompleteHandler);
				}
			} else {
				jumpPlatform2Joint.SetMaxMotorForce(0);
			}
			
			if(movePlatform1.y<-30) movePlatform1BodyDirection=1;
			if(movePlatform1.y>115) movePlatform1BodyDirection=-1;
			movePlatform1Body.SetLinearVelocity(new b2Vec2(0,3*movePlatform1BodyDirection));
			
			if(movePlatform2.x<1495) movePlatform2BodyDirection=1;
			if(movePlatform2.x>1645) movePlatform2BodyDirection=-1;
			movePlatform2Body.SetLinearVelocity(new b2Vec2(3*movePlatform2BodyDirection,0));
			
			if(playerBox.hitTestObject(redCheck) && redCheck.currentFrame==1) {
				redCheck.gotoAndStop(2);
				DestroyBody(redWallBody);
				if(Game.soundIs && !checkBoxSoundChannel) {
					checkBoxSoundChannel=checkBoxSound.play(0,1); 
					checkBoxSoundChannel.soundTransform = transformCheckBoxSound;
					checkBoxSoundChannel.addEventListener(Event.SOUND_COMPLETE, checkBoxSoundCompleteHandler);
				}
				redCheckLevel=true;
			}
			
			if(playerBox.hitTestObject(blueCheck) && blueCheck.currentFrame==1) {
				blueCheck.gotoAndStop(2);
				DestroyBody(bluePlatformBody);
				if(Game.soundIs && !checkBoxSoundChannel) {
					checkBoxSoundChannel=checkBoxSound.play(0,1); 
					checkBoxSoundChannel.soundTransform = transformCheckBoxSound;
					checkBoxSoundChannel.addEventListener(Event.SOUND_COMPLETE, checkBoxSoundCompleteHandler);
				}
			}
		}
		
		private function jumpPlatformSoundCompleteHandler(e:Event):void {
			jumpPlatformSoundChannel=null;
		}
		
		private function checkBoxSoundCompleteHandler(e:Event):void {
			checkBoxSoundChannel=null;
		}
	}
}