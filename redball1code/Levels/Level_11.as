package Levels{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.media.*;
	import flash.utils.*;

	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;

	public class Level_11 extends Level {	
		private var kolesoBody:Array=new Array();
		private var vagonBody:Array=new Array();
		private var kolesoTrain1Body, kolesoTrain2Body:b2Body;
		private var trainBody:b2Body;
		
		private var killCeil1Body:b2Body;
		private var killRotateBody:b2Body;
		private var killStarBody:Array=new Array();
		private var killBrevno:Array=new Array();
		
		private var kolesoTrain1Joint,kolesoTrain2Joint:b2RevoluteJoint;
		
		private var trainSound:TrainSound = new TrainSound();
		private var trainSoundChannel:SoundChannel;
		private var transformTrainSound:SoundTransform = new SoundTransform(0.5, 0);
		private var trainSoundTimer:Timer = new Timer(10000,2);
				
		public function Level_11() {
			super();
			id=11;
			
			trainSoundTimer.addEventListener(TimerEvent.TIMER,onTimerSoundHandler);
			trainSoundTimer.start();
			
			addEventListener(Event.REMOVED_FROM_STAGE,onRemovedHandler);
									
			CreateBody("levelAim","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[7.9, 12.9], [15.65, 30.15], [-9.6, 30.15], [-0.35, 12.9]]]);
			trainBody = CreateBody("train","Polygon",5*defaultDensity,defaultFriction,defaultRestitution,[[[23.75, -21.05], [23.75, -9.3], [3.35, -1.2], [3.35, -21.05]], [[0.45, -2.6], [3.35, -1.2], [3.35, 1.3], [0.45, 2.9]], [[3.35, -1.2], [23.75, -9.3], [3.35, 1.3]], [[3.35, 1.3], [23.75, -9.3], [41.75, -9.3], [46.15, -9.2], [58, 2.35], [61.75, 6.35], [3.35, 6.35]], [[58, -9.2], [58, 2.35], [46.15, -9.2]], [[47.25, -15.9], [46.15, -9.2], [41.75, -9.3], [40, -15.9]]]);
			kolesoTrain1Body = CreateBody("kolesoTrain1","Circle",defaultDensity,defaultFriction,defaultRestitution,[8]);
			kolesoTrain2Body = CreateBody("kolesoTrain2","Circle",defaultDensity,defaultFriction,defaultRestitution,[8]);
			for(var i:int=1;i<=11;i++) {
				switch(i) {
					case 3: 
					case 4: 
					case 5: 
					case 9:  vagonBody.push(CreateBody("vagon"+i.toString(),"Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-71.35, -20.45], [-3.4, -20.5], [-3.4, 5.6], [-71.35, 5.6]]]));
							 break;
					default: vagonBody.push(CreateBody("vagon"+i.toString(),"Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[-71.35, -20.45], [-66.4, -20.45], [-71.35, -1.2]], [[-74.15, -2.8], [-71.35, -1.2], [-71.35, 1.05], [-74.15, 2.7]], [[-71.35, -1.2], [-66.4, -20.45], [-71.35, 1.05]], [[-71.35, 1.05], [-66.4, -20.45], [-66.4, 1], [-71.35, 5.6]], [[-3.4, 5.6], [-71.35, 5.6], [-66.4, 1], [-8.15, 1], [-3.4, 1.05]], [[-0.6, 2.7], [-3.4, 1.05], [-3.4, -1.2], [-0.6, -2.8]], [[-3.4, -1.2], [-3.4, 1.05], [-3.4, -20.5]], [[-3.4, -20.5], [-3.4, 1.05], [-8.15, 1], [-8.15, -20.5]]]));
							 break;
				}
				kolesoBody.push(new Array());
				kolesoBody[i-1].push(CreateBody("koleso_"+i.toString()+"_1","Circle",defaultDensity,defaultFriction,defaultRestitution,[8]));
				kolesoBody[i-1].push(CreateBody("koleso_"+i.toString()+"_2","Circle",defaultDensity,defaultFriction,defaultRestitution,[8]));
			}
			CreateBody("platform","Polygon",0,defaultFriction,defaultRestitution,[[[2658.9, -33.95], [2857.8, -33.95], [3289.85, 0], [2100.95, 0]], [[0, 0], [2100.95, 0], [3718.9, 7.95], [3650, 20], [0, 20]], [[3793, 80.7], [3777.9, 60.65], [3808.7, 69.5]], [[3777.9, 60.65], [3755.7, 40.8], [3791.3, 45.7], [3808.7, 69.5]], [[3755.7, 40.8], [3714.1, 28.3], [3762.1, 21.5], [3791.3, 45.7]], [[3714.1, 28.3], [3650, 20], [3718.9, 7.95], [3762.1, 21.5]], [[3655.75, 0], [3718.9, 7.95], [3289.85, 0]], [[3718.9, 7.95], [2100.95, 0], [3289.85, 0]]]);		
			CreateBody("ceil1","Polygon",0,defaultFriction,defaultRestitution,[[[659.95, 0], [659.95, 20], [0, 20], [0, 0]]]);
			killCeil1Body = CreateBody("killCeil1","Polygon",0,defaultFriction,defaultRestitution,[[[250, 5], [250, 20], [37, 14.15], [16.05, 12.95], [0, 5]], [[0, 20], [0, 5], [16.05, 12.95], [9.1, 27.5]], [[22.4, 20], [16.05, 12.95], [22.4, 17]], [[29.35, 32.6], [22.4, 17], [37, 14.15]], [[22.4, 17], [16.05, 12.95], [37, 14.15]], [[48.9, 35.5], [37, 14.15], [53.15, 26.1]], [[57.25, 29.5], [53.15, 26.1], [62.15, 15.75]], [[53.15, 26.1], [37, 14.15], [62.15, 15.75]], [[37, 14.15], [250, 20], [111.05, 16.95], [62.15, 15.75]], [[71.25, 26.5], [62.15, 15.75], [84.5, 17.3]], [[91.5, 34.55], [84.5, 17.3], [95.75, 23.8]], [[102.65, 32.65], [95.75, 23.8], [111.05, 16.95]], [[95.75, 23.8], [84.5, 17.3], [111.05, 16.95]], [[84.5, 17.3], [62.15, 15.75], [111.05, 16.95]], [[118, 28.2], [111.05, 16.95], [121.5, 23.8]], [[125.75, 37.1], [121.5, 23.8], [137, 20]], [[121.5, 23.8], [111.05, 16.95], [137, 20]], [[142.45, 29], [137, 20], [148.75, 20]], [[137, 20], [111.05, 16.95], [148.75, 20]], [[153.65, 34], [148.75, 20], [166.25, 20], [161.45, 40.4]], [[148.75, 20], [111.05, 16.95], [166.25, 20]], [[173.2, 35.5], [166.25, 20], [179.2, 27.25], [179.2, 39.8]], [[184.3, 33.15], [179.2, 27.25], [189.95, 23.5]], [[179.2, 27.25], [166.25, 20], [189.95, 23.5]], [[199.15, 39.45], [189.95, 23.5], [209.9, 20]], [[189.95, 23.5], [166.25, 20], [209.9, 20]], [[166.25, 20], [111.05, 16.95], [209.9, 20]], [[111.05, 16.95], [250, 20], [209.9, 20]], [[209.9, 20], [250, 20], [232.15, 31], [219.3, 31]], [[242.3, 39], [235.55, 20], [250, 20]], [[235.55, 20], [250, 20], [232.15, 31]]]);
			CreateBody("ceil2_1","Polygon",0,defaultFriction,defaultRestitution,[[[100, 0], [100, 10], [0, 10], [0, 0]]]);
			CreateBody("ceil2_2","Polygon",0,defaultFriction,defaultRestitution,[[[100, 0], [100, 10], [0, 10], [0, 0]]]);
			killRotateBody = CreateBody("killRotate","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[5, -40], [5, 40], [-5, 40], [-5, -40]]]);
			for(var i:int=0;i<3;i++) {
				killStarBody.push(CreateBody("killStar"+i.toString(),"Circle",defaultDensity,defaultFriction,defaultRestitution,[40]));
			}
			for(var i:int=0;i<4;i++) {
				killBrevno.push(CreateBody("killBrevno"+i.toString(),"Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[52.75, 0], [52.75, 3], [0, 3], [0, 0]]]));
			}
			CreateBody("triangle","Polygon",0,defaultFriction,defaultRestitution,[[[0, 40], [185, 0], [187, 27]]]);
			CreateBody("upCeil","Polygon",0,defaultFriction,defaultRestitution,[[[-30.5, 34.5], [-13.5, 13.05], [0, 36], [-30.5, 38.5]], [[0, 36], [-13.5, 13.05], [175, 24]], [[175, 24], [-13.5, 13.05], [174.95, 0], [389, 0], [602.45, 18.6], [390.95, 24]], [[621.45, 41.5], [390.95, 24], [602.45, 18.6], [621.45, 36.65]]]);
			/*CreateBody("","Polygon",defaultDensity,defaultFriction,defaultRestitution,);*/
			
			var distanceJointDef:b2DistanceJointDef=new b2DistanceJointDef();
			var revoluteJointDef:b2RevoluteJointDef=new b2RevoluteJointDef();
			
			revoluteJointDef.Initialize(killRotateBody, m_ground, killRotateBody.GetPosition());
			revoluteJointDef.motorSpeed = -Math.PI;
			revoluteJointDef.maxMotorTorque = 5000.0;
			revoluteJointDef.enableMotor = true;
			m_world.CreateJoint(revoluteJointDef); 
			
			for(var i:int=0;i<3;i++) {
				revoluteJointDef.Initialize(killStarBody[i], m_ground, new b2Vec2(killStarBody[i].GetPosition().x+20/m_physScale,killStarBody[i].GetPosition().y+20/m_physScale));
				revoluteJointDef.motorSpeed = -5*Math.PI;
				revoluteJointDef.maxMotorTorque = 5000.0;
				revoluteJointDef.enableMotor = true;
				m_world.CreateJoint(revoluteJointDef); 
			}
			
			revoluteJointDef.Initialize(trainBody, kolesoTrain1Body, new b2Vec2(kolesoTrain1Body.GetPosition().x+4/m_physScale,kolesoTrain1Body.GetPosition().y+4/m_physScale));
			revoluteJointDef.motorSpeed = 7*Math.PI;
			revoluteJointDef.maxMotorTorque = 5000.0;
			revoluteJointDef.enableMotor = true;
			kolesoTrain1Joint=m_world.CreateJoint(revoluteJointDef)  as b2RevoluteJoint; 
			revoluteJointDef.Initialize(trainBody, kolesoTrain2Body, new b2Vec2(kolesoTrain2Body.GetPosition().x+4/m_physScale,kolesoTrain2Body.GetPosition().y+4/m_physScale));
			revoluteJointDef.motorSpeed = 7*Math.PI;
			revoluteJointDef.maxMotorTorque = 5000.0;
			revoluteJointDef.enableMotor = true;
			kolesoTrain2Joint=m_world.CreateJoint(revoluteJointDef) as b2RevoluteJoint; 
			revoluteJointDef.enableMotor = false;
			
			for(var i:int=1;i<=11;i++) {
				revoluteJointDef.Initialize(vagonBody[i-1], kolesoBody[i-1][0], new b2Vec2(kolesoBody[i-1][0].GetPosition().x+4/m_physScale,kolesoBody[i-1][0].GetPosition().y+4/m_physScale));
				m_world.CreateJoint(revoluteJointDef); 
				revoluteJointDef.Initialize(vagonBody[i-1], kolesoBody[i-1][1], new b2Vec2(kolesoBody[i-1][1].GetPosition().x+4/m_physScale,kolesoBody[i-1][1].GetPosition().y+4/m_physScale));
				m_world.CreateJoint(revoluteJointDef); 
			}
			
			distanceJointDef.Initialize(trainBody, vagonBody[0], trainBody.GetPosition(), vagonBody[0].GetPosition());
			m_world.CreateJoint(distanceJointDef);
			for(var i:int=1;i<=10;i++) {	
				distanceJointDef.Initialize(vagonBody[i-1], vagonBody[(i-1)+1], new b2Vec2(vagonBody[i-1].GetPosition().x-75/m_physScale,vagonBody[i-1].GetPosition().y), new b2Vec2(vagonBody[(i-1)+1].GetPosition().x,vagonBody[(i-1)+1].GetPosition().y));
				m_world.CreateJoint(distanceJointDef);
			}
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>500 ||
			   myContactListener.playerContactBodies.indexOf(killCeil1Body)!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killRotateBody)!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killStarBody[0])!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killStarBody[1])!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killStarBody[2])!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killStarBody[3])!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killStarBody[4])!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killStarBody[5])!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killBrevno[0])!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killBrevno[1])!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killBrevno[2])!=-1 ||
			   myContactListener.playerContactBodies.indexOf(killBrevno[3])!=-1) {
					if(playerBox.IsLive()) PlayerDie();
			}
			
			//kolesoTrain1Joint.SetMotorSpeed(kolesoTrain1Joint.GetMotorSpeed()+0.2/30);
			//kolesoTrain2Joint.SetMotorSpeed(kolesoTrain2Joint.GetMotorSpeed()+0.2/30);
		}
		
		private function onTimerSoundHandler(e:TimerEvent):void {
			if(Game.soundIs) trainSoundChannel=trainSound.play(0,1);
			if (trainSoundChannel) trainSoundChannel.soundTransform = transformTrainSound;
		}
		
		private function onRemovedHandler(e:Event):void {
			if(trainSoundChannel) {
				trainSoundChannel.stop();
				trainSoundChannel=null;
			}
			trainSoundTimer.stop();
		}
	}
}