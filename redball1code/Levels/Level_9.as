package Levels{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.*;

	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;

	public class Level_9 extends Level {	
		private var firstCrankBody:b2Body;
		private var greenPlatformBody:b2Body;
		private var greenPlatformBodyDirection:int=1;
		private var killRollBallBody:b2Body;
		private var killRollBallDirection:int=1;
		private var boomCrankBody:b2Body;
		//private var ballTimer:Timer;
	
		public function Level_9() {
			super();
			id=9;
						
			firstCrankBody = CreateBody("firstCrank","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[6.8, -7.65], [6.8, 7.35], [-73.2, 7.35], [-73.2, -7.65]]]);
			var secondCrankBody:b2Body =CreateBody("secondCrank","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[7.2, -6.6], [7.2, 8.4], [-142.8, 8.4], [-142.8, -6.6]]]);
			boomCrankBody=CreateBody("boomCrank","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[5, -15], [5, 15], [-53.5, 15], [-64.25, -0.25], [-53.5, -15]]]);			
			CreateBody("firstBigPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[1327.45, 378.95], [1327.45, 400.95], [0, 400.95], [1121.45, 378.95]], [[1121.45, 361.95], [1121.45, 378.95], [1103.9, 361.9]], [[1103.9, 342.9], [1103.9, 361.9], [1085.9, 342.9]], [[1085.9, 323.95], [1085.9, 342.9], [1067.9, 323.95]], [[1085.9, 342.9], [1103.9, 361.9], [953.4, 251.95], [1067.9, 323.95]], [[1067.9, 304.95], [1067.9, 323.95], [1049.9, 304.95]], [[1049.9, 281.95], [1049.9, 304.95], [1029.05, 281.95]], [[1029.05, 281.95], [1049.9, 304.95], [953.4, 251.95], [1001.6, 251.95]], [[1049.9, 304.95], [1067.9, 323.95], [953.4, 251.95]], [[1103.9, 361.9], [1121.45, 378.95], [953.4, 281.95], [953.4, 251.95]], [[953.4, 281.95], [1121.45, 378.95], [896.9, 281.95]], [[896.9, 281.95], [1121.45, 378.95], [850.9, 280.95]], [[850.9, 280.95], [1121.45, 378.95], [800.9, 273.95]], [[800.9, 273.95], [1121.45, 378.95], [0, 400.95], [777.95, 266.95]], [[441.95, 57], [458.95, 117], [190, 46]], [[458.95, 117], [755.95, 257.95], [190, 46]], [[755.95, 257.95], [777.95, 266.95], [0, 400.95], [0, 0], [190, 46]], [[196, 20], [190, 46], [0, 0]]]);
			greenPlatformBody = CreateBody("greenPlatform","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[49, -5], [49, 5], [-49, 5], [-49, -5]]]);
			var lowPlatformBody:b2Body = CreateBody("lowPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[-581.95, -109.1], [-522.95, -109.1], [-522.95, -9], [-705.95, -35]], [[-795.95, -35], [-705.95, -35], [-522.95, -9], [-795.95, -9]]]);
			var low2PlatformBody:b2Body = CreateBody("low2Platform","Polygon",0,defaultFriction,defaultRestitution,[[[286.95, -10.95], [399.95, -10.95], [286.95, 14.05]], [[262.95, 14.05], [286.95, 14.05], [262.95, 37.05]], [[286.95, 14.05], [399.95, -10.95], [262.95, 37.05]], [[239.95, 37.05], [262.95, 37.05], [239.95, 59.05]], [[262.95, 37.05], [399.95, -10.95], [239.95, 59.05]], [[215, 59.05], [239.95, 59.05], [215, 82]], [[239.95, 59.05], [399.95, -10.95], [399.95, 113], [215, 82]], [[-399.95, -112.95], [-288, -112.95], [-318, -13], [-399.95, -13]], [[-288, -112.95], [-288, 82], [-318, 113], [-318, -13]], [[-288, 82], [215, 82], [399.95, 113], [-318, 113]]]);
			CreateBody("upPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[163, -58], [163, -26], [29, 1.5], [-162.95, -58]], [[-162.95, 47], [-162.95, -58], [29, 1.5], [29, 58], [-150.95, 58]]]);
			CreateBody("middlePlatform","Polygon",0,defaultFriction,defaultRestitution,[[[-48.6, -81.9], [-48.6, -26.05], [-96, 81.9], [-96, -81.9]], [[-96, 81.9], [-48.6, -26.05], [96, -9.05], [96, 81.9]]]);
			CreateBody("finishPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[-58, -12.5], [58, -12.5], [58, 12.5], [-58, 12.5]]]);
			var bridgeElement1Body:b2Body = CreateBody("bridgeElement1","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-4, -4], [56, -4], [56, 4], [-4, 4]]]);
			var bridgeElement2Body:b2Body = CreateBody("bridgeElement2","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-4, -4], [56, -4], [56, 4], [-4, 4]]]);
			var bridgeElement3Body:b2Body = CreateBody("bridgeElement3","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-4, -4], [56, -4], [56, 4], [-4, 4]]]);
			var bridgeElement4Body:b2Body = CreateBody("bridgeElement4","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-4, -4], [56, -4], [56, 4], [-4, 4]]]);
			var bridgeElement5Body:b2Body = CreateBody("bridgeElement5","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-4, -4], [56, -4], [56, 4], [-4, 4]]]);
			var bridgeElement6Body:b2Body = CreateBody("bridgeElement6","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-4, -4], [56, -4], [56, 4], [-4, 4]]]);
			var bridgeElement7Body:b2Body = CreateBody("bridgeElement7","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-4, -4], [56, -4], [56, 4], [-4, 4]]]);
			var bridgeElement8Body:b2Body = CreateBody("bridgeElement8","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-4, -4], [56, -4], [56, 4], [-4, 4]]]);
			var bridgeElement9Body:b2Body = CreateBody("bridgeElement9","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-4, -4], [56, -4], [56, 4], [-4, 4]]]);
			var bridgeElement10Body:b2Body = CreateBody("bridgeElement10","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-4, -4], [56, -4], [56, 4], [-4, 4]]]);
			killRollBallBody = CreateBody("killRollBall","Circle",defaultDensity,defaultFriction,defaultRestitution,[50]);
			var jumpBall1Body:b2Body = CreateBody("jumpBall1","Circle",defaultDensity,defaultFriction,defaultRestitution,[75]);
			var jumpBall2Body:b2Body = CreateBody("jumpBall2","Circle",defaultDensity,defaultFriction,defaultRestitution,[75]);
			var jumpBall3Body:b2Body = CreateBody("jumpBall3","Circle",defaultDensity,defaultFriction,defaultRestitution,[75]);
			//CreateBody("","Polygon",defaultDensity,defaultFriction,defaultRestitution,);
			
			

			var distanceJointDef:b2DistanceJointDef=new b2DistanceJointDef();
			var revoluteJointDef:b2RevoluteJointDef=new b2RevoluteJointDef();
			var prismaticJointDef:b2PrismaticJointDef=new b2PrismaticJointDef();
			
			prismaticJointDef.Initialize(greenPlatformBody, m_ground, greenPlatformBody.GetWorldCenter(), new b2Vec2(1,0));
			m_world.CreateJoint(prismaticJointDef);
			
			revoluteJointDef.Initialize(lowPlatformBody, bridgeElement1Body, bridgeElement1Body.GetPosition());
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(bridgeElement1Body, bridgeElement2Body, bridgeElement2Body.GetPosition());
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(bridgeElement2Body, bridgeElement3Body, bridgeElement3Body.GetPosition());
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(bridgeElement3Body, bridgeElement4Body, bridgeElement4Body.GetPosition());
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(bridgeElement4Body, bridgeElement5Body, bridgeElement5Body.GetPosition());
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(bridgeElement5Body, bridgeElement6Body, bridgeElement6Body.GetPosition());
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(bridgeElement6Body, bridgeElement7Body, bridgeElement7Body.GetPosition());
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(bridgeElement7Body, bridgeElement8Body, bridgeElement8Body.GetPosition());
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(bridgeElement8Body, bridgeElement9Body, bridgeElement9Body.GetPosition());
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(bridgeElement9Body, bridgeElement10Body, bridgeElement10Body.GetPosition());
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(bridgeElement10Body, low2PlatformBody, new b2Vec2(bridgeElement10Body.GetPosition().x+50/m_physScale,bridgeElement10Body.GetPosition().y));
			m_world.CreateJoint(revoluteJointDef);
									
			revoluteJointDef.Initialize(firstCrankBody, m_ground, firstCrankBody.GetPosition());
			revoluteJointDef.motorSpeed = 1.8*Math.PI;
			revoluteJointDef.maxMotorTorque = 5000.0;
			revoluteJointDef.enableMotor = true;
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.enableMotor = false;
			
			revoluteJointDef.Initialize(secondCrankBody, firstCrankBody, secondCrankBody.GetPosition());
			m_world.CreateJoint(revoluteJointDef);
			
			revoluteJointDef.Initialize(boomCrankBody, secondCrankBody, boomCrankBody.GetPosition());
			m_world.CreateJoint(revoluteJointDef);
			
			prismaticJointDef.Initialize(boomCrankBody, m_ground, boomCrankBody.GetWorldCenter(), new b2Vec2(1,0));
			m_world.CreateJoint(prismaticJointDef);
			
			distanceJointDef.Initialize(jumpBall1Body, m_ground, new b2Vec2(2236/m_physScale,63/m_physScale), new b2Vec2(2172/m_physScale,-56/m_physScale));
			m_world.CreateJoint(distanceJointDef);
			distanceJointDef.Initialize(jumpBall2Body, m_ground, new b2Vec2(2370/m_physScale,63/m_physScale), new b2Vec2(2435/m_physScale,-56/m_physScale));
			m_world.CreateJoint(distanceJointDef);
			distanceJointDef.Initialize(jumpBall3Body, m_ground, new b2Vec2(2761/m_physScale,63/m_physScale), new b2Vec2(2698/m_physScale,-56/m_physScale));
			m_world.CreateJoint(distanceJointDef);
						
			
			greenCheck1.stop();
			greenCheck2.stop();
			greenCheck3.stop();
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>530 ||
			   myContactListener.playerContactBodies.indexOf(killRollBallBody)!=-1 ||
			   myContactListener.playerContactBodies.indexOf(boomCrankBody)!=-1) {
					if(playerBox.IsLive()) PlayerDie();
			}
						
			if(greenPlatform.x<55) greenPlatformBodyDirection=1;
			if(greenPlatform.x>387) greenPlatformBodyDirection=-1;
			
			greenPlatformBody.SetLinearVelocity(new b2Vec2(2*greenPlatformBodyDirection,0));
			
			if(playerBox.hitTestObject(greenCheck1) && greenCheck1.currentFrame==1) {
				greenCheck1.gotoAndStop(2);
				DestroyBody(greenPlatformBody);
				if(Game.soundIs && !checkBoxSoundChannel) {
					checkBoxSoundChannel=checkBoxSound.play(0,1); 
					checkBoxSoundChannel.soundTransform = transformCheckBoxSound;
					checkBoxSoundChannel.addEventListener(Event.SOUND_COMPLETE, checkBoxSoundCompleteHandler);
				}
			}
			
			if(playerBox.hitTestObject(greenCheck2) && greenCheck2.currentFrame==1) {
				greenCheck2.gotoAndStop(2);
				DestroyBody(greenPlatformBody);
				if(Game.soundIs && !checkBoxSoundChannel) {
					checkBoxSoundChannel=checkBoxSound.play(0,1); 
					checkBoxSoundChannel.soundTransform = transformCheckBoxSound;
					checkBoxSoundChannel.addEventListener(Event.SOUND_COMPLETE, checkBoxSoundCompleteHandler);
				}
			}
			
			if(playerBox.hitTestObject(greenCheck3) && greenCheck3.currentFrame==1) {
				greenCheck3.gotoAndStop(2);
				DestroyBody(greenPlatformBody);
				if(Game.soundIs && !checkBoxSoundChannel) {
					checkBoxSoundChannel=checkBoxSound.play(0,1); 
					checkBoxSoundChannel.soundTransform = transformCheckBoxSound;
					checkBoxSoundChannel.addEventListener(Event.SOUND_COMPLETE, checkBoxSoundCompleteHandler);
				}
			}
			
			if(killRollBall.x<740) killRollBallDirection=1;
			if(killRollBall.x>1200) killRollBallDirection=-1;
			killRollBallBody.SetAngularVelocity(5*killRollBallDirection);
		}
		
		private function checkBoxSoundCompleteHandler(e:Event):void {
			checkBoxSoundChannel=null;
		}
		
		/*private function ballTimerHandler(e:TimerEvent):void {
			var newBall:LittleKillBall=new LittleKillBall();
			newBall.x=1404;
			newBall.y=4;
			newBall.name="ball"+ballTimer.currentCount.toString();
			m_sprite.addChild(newBall);
			CreateBody(newBall.name,"Circle",defaultDensity,defaultFriction,defaultRestitution,[10]);		
		}*/
	}
	
}