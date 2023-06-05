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

	public class Level_10 extends Level {	
		private var jumpPlatform1Body:b2Body;
		private var jumpPlatform1Joint:b2PrismaticJoint;
		private var jumpPlatform2Body:b2Body;
		private var jumpPlatform2Joint:b2PrismaticJoint;
		private var jumpPlatform3Body:b2Body;
		private var jumpPlatform3Joint:b2PrismaticJoint;
		private var cube1Body:b2Body;
		private var cube2Body:b2Body;
		private var cube3Body:b2Body;
		private var roundBlockBody:b2Body;
	
		public function Level_10() {
			super();
			id=10;
						
			CreateBody("firstPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[112, 0], [112, 20], [0, 20], [0, 0]]]);
			CreateBody("barierPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[610, 0], [610, 20], [0, 20], [0, 0]]]);
			CreateBody("firstBarier","Polygon",0,defaultFriction,defaultRestitution,[[[23.5, 0], [20, 3.55], [0, 3.55], [-3.75, 0]], [[0, 3.55], [20, 3.55], [20, 30], [0, 30]]]);
			CreateBody("secondBarier","Polygon",0,defaultFriction,defaultRestitution,[[[23.5, 0], [20, 4], [0, 3.75], [-3.5, 0]], [[0, 3.75], [20, 4], [20, 50], [0, 50]]]);
			CreateBody("thirdBarier","Polygon",0,defaultFriction,defaultRestitution,[[[23.5, 0], [20, 3.75], [0, 4], [-3.75, 0]], [[0, 4], [20, 3.75], [20, 70], [0, 70]]]);
			CreateBody("forthBarier","Polygon",0,defaultFriction,defaultRestitution,[[[27.25, 0], [23.75, 4.8], [3.75, 5.15], [0, 0]], [[3.75, 5.15], [23.75, 4.8], [23.75, 90], [3.75, 90]]]);
			jumpPlatform1Body = CreateBody("jumpPlatform1","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			jumpPlatform2Body = CreateBody("jumpPlatform2","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			jumpPlatform3Body = CreateBody("jumpPlatform3","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			CreateBody("afterJump","Polygon",0,defaultFriction,defaultRestitution,[[[301.45, -0.25], [372.45, -0.25], [301.45, 20.25], [232.95, 30]], [[71, 0], [138.95, 30], [71, 20.5], [0, 0]], [[0, 20.5], [0, 0], [71, 20.5]], [[71, 20.5], [138.95, 30], [139.45, 50]], [[138.95, 30], [232.95, 30], [232.95, 50], [139.45, 50]], [[232.95, 50], [232.95, 30], [301.45, 20.25]], [[372.45, 20.25], [301.45, 20.25], [372.45, -0.25]]]);
			cube1Body = CreateBody("cube1","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-50, 50], [-50, -50], [50, -50], [50, 50]]]);
			cube2Body = CreateBody("cube2","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-50, 50], [-50, -50], [50, -50], [50, 50]]]);
			cube3Body = CreateBody("cube3","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-50, 50], [-50, -50], [50, -50], [50, 50]]]);
			CreateBody("mainRampa","Polygon",0,defaultFriction,defaultRestitution,[[[1285.9, 164.95], [1287.9, 174.45], [1276.4, 177.95], [1282.9, 153.95]], [[1287.9, 174.45], [1290.9, 182.45], [1276.4, 177.95]], [[1290.9, 182.45], [1294.9, 189.45], [1276.4, 177.95]], [[1294.9, 189.45], [1298.4, 193.45], [1271.4, 188.95], [1276.4, 177.95]], [[1298.4, 193.45], [1303.4, 196.45], [1265.9, 194.95], [1271.4, 188.95]], [[1265.9, 194.95], [1303.4, 196.45], [1257.9, 198.95]], [[1257.9, 198.95], [1303.4, 196.45], [1309.65, 199.2], [1243.95, 200.95]], [[434.45, 165.5], [436.45, 175], [424.95, 178.5], [431.45, 154.5]], [[436.45, 175], [439.45, 183], [424.95, 178.5]], [[439.45, 183], [443.45, 190], [424.95, 178.5]], [[443.45, 190], [446.95, 194], [419.95, 189.5], [424.95, 178.5]], [[446.95, 194], [451.95, 197], [419.95, 189.5]], [[451.95, 197], [458.2, 199.75], [414.45, 195.5], [419.95, 189.5]], [[414.45, 195.5], [458.2, 199.75], [406.45, 199.5]], [[458.2, 199.75], [476.2, 200.95], [392.5, 201.5], [406.45, 199.5]], [[476.2, 200.95], [1243.95, 200.95], [1388.9, 223], [0, 223], [392.5, 201.5]], [[161.5, 109.5], [183, 148.5], [103.95, 39], [140.95, 78.95], [150.5, 91.5]], [[183, 148.5], [192, 163], [58, 4], [76, 14], [103.95, 39]], [[192, 163], [202, 175], [0, 223], [0, 0], [42, 0], [58, 4]], [[202, 175], [215.5, 186.5], [0, 223]], [[215.5, 186.5], [236, 196.5], [0, 223]], [[236, 196.5], [256, 201.5], [0, 223]], [[256, 201.5], [392.5, 201.5], [0, 223]], [[1388.9, 223], [1243.95, 200.95], [1327.4, 200.4], [1388.9, 200.4]], [[1327.4, 200.4], [1243.95, 200.95], [1309.65, 199.2]]]);
			CreateBody("goBall","Circle",defaultDensity/2,defaultFriction,defaultRestitution,[80]);
			roundBlockBody = CreateBody("roundBlock","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[127.3, 26.5], [122, 33.3], [107, 20.8], [109.7, 12.85]], [[84.2, 2.4], [109.7, 12.85], [82, 10.3], [54, 0]], [[24.95, 6.5], [54, 0], [27.5, 13.8], [0, 21.7]], [[3.75, 28.05], [0, 21.7], [27.5, 13.8]], [[27.5, 13.8], [54, 0], [54.5, 8.3]], [[54.5, 8.3], [54, 0], [82, 10.3]], [[82, 10.3], [109.7, 12.85], [107, 20.8]]]);
			//CreateBody("","Polygon",defaultDensity,defaultFriction,defaultRestitution,);
			
			
			var prismaticJointDef:b2PrismaticJointDef=new b2PrismaticJointDef();
			var revoluteJointDef:b2RevoluteJointDef=new b2RevoluteJointDef();
			
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
			
			prismaticJointDef.Initialize(jumpPlatform3Body, m_ground, jumpPlatform3Body.GetWorldCenter(), new b2Vec2(0,1));
			prismaticJointDef.lowerTranslation = 0;
			prismaticJointDef.upperTranslation = 1;
			prismaticJointDef.enableLimit = true;
			prismaticJointDef.maxMotorForce = 0;
			prismaticJointDef.motorSpeed = 200;
			prismaticJointDef.enableMotor = true; 
			jumpPlatform3Joint=m_world.CreateJoint(prismaticJointDef) as b2PrismaticJoint;
			
			revoluteJointDef.Initialize(cube1Body, m_ground, cube1Body.GetPosition());
			revoluteJointDef.motorSpeed = 0.3*Math.PI;
			revoluteJointDef.maxMotorTorque = 5000.0;
			revoluteJointDef.enableMotor = true;
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(cube2Body, m_ground, cube2Body.GetPosition());
			revoluteJointDef.motorSpeed = -0.3*Math.PI;
			revoluteJointDef.maxMotorTorque = 5000.0;
			revoluteJointDef.enableMotor = true;
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(cube3Body, m_ground, cube3Body.GetPosition());
			revoluteJointDef.motorSpeed = 0.3*Math.PI;
			revoluteJointDef.maxMotorTorque = 5000.0;
			revoluteJointDef.enableMotor = true;
			m_world.CreateJoint(revoluteJointDef);
			
			revoluteJointDef.Initialize(roundBlockBody, m_ground, new b2Vec2(-675/m_physScale,-152/m_physScale));
			revoluteJointDef.motorSpeed = -0.9*Math.PI;
			revoluteJointDef.maxMotorTorque = 5000.0;
			revoluteJointDef.enableMotor = true;
			m_world.CreateJoint(revoluteJointDef);
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>500 ||
			   myContactListener.playerContactBodies.indexOf(roundBlockBody)!=-1) {
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
				jumpPlatform2Joint.SetMaxMotorForce(150);
				if(Game.soundIs && !jumpPlatformSoundChannel) {
					jumpPlatformSoundChannel=jumpPlatformSound.play(0,1); 
					jumpPlatformSoundChannel.addEventListener(Event.SOUND_COMPLETE, jumpPlatformSoundCompleteHandler);
				}
			} else {
				jumpPlatform2Joint.SetMaxMotorForce(0);
			}
			
			if(myContactListener.playerContactBodies.indexOf(jumpPlatform3Body)!=-1) {
				jumpPlatform3Joint.SetMaxMotorForce(150);
				if(Game.soundIs && !jumpPlatformSoundChannel) {
					jumpPlatformSoundChannel=jumpPlatformSound.play(0,1); 
					jumpPlatformSoundChannel.addEventListener(Event.SOUND_COMPLETE, jumpPlatformSoundCompleteHandler);
				}
			} else {
				jumpPlatform3Joint.SetMaxMotorForce(0);
			}
		}
		
		private function jumpPlatformSoundCompleteHandler(e:Event):void {
			jumpPlatformSoundChannel=null;
		}
	}
}