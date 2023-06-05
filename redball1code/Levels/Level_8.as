package Levels{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.media.*;

	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;

	public class Level_8 extends Level {				
		private var killer1Body:b2Body;
		private var killer2Body:b2Body;
		private var killer3Body:b2Body;
		
		private var killer1Up:Boolean;
		private var killer2Up:Boolean;
		private var killer3Up:Boolean;
		
		private var killSpuskBody:b2Body;
		private var killSpusk2Body:b2Body;
		
		private var carBody:b2Body;
		private var carSound:Sound=new CarSound();
		private var carSoundChannel:SoundChannel;
			
		public function Level_8() {
			super();
			id=8;
									
			CreateBody("firstRampa","Polygon",0,defaultFriction,defaultRestitution,[[[217, 189], [247, 270], [84, 4], [102, 11], [115, 24], [127, 37], [145, 60], [174, 100], [197, 143]], [[247, 270], [288, 338.95], [0, 480.95], [0, 0], [68, 0], [84, 4]], [[288, 338.95], [315.95, 365.95], [0, 480.95]], [[315.95, 365.95], [348.95, 380.95], [0, 480.95]], [[348.95, 380.95], [390.95, 386.95], [478.95, 480.95], [0, 480.95]], [[478.95, 354.95], [478.95, 480.95], [428.95, 378.95]], [[428.95, 378.95], [478.95, 480.95], [390.95, 386.95]]]);
			CreateBody("pol","Polygon",0,defaultFriction,defaultRestitution,[[[683, 0], [683, 34.05], [500, 34.05], [0, 0]], [[0, 200.05], [0, 0], [500, 34.05], [500, 200.05]]]);
			CreateBody("potolok1","Polygon",0,defaultFriction,defaultRestitution,[[[198, 0], [198, 200.05], [0, 200.05], [0, 0]]]);
			CreateBody("potolok2","Polygon",0,defaultFriction,defaultRestitution,[[[0, 0], [45, 0], [45, 200], [0, 200]]]);
			CreateBody("potolok3","Polygon",0,defaultFriction,defaultRestitution,[[[0, 0], [45, 0], [45, 200], [0, 200]]]);
			CreateBody("potolok4","Polygon",0,defaultFriction,defaultRestitution,[[[0, 0], [125, 0], [125, 200], [0, 200]]]);
			killSpuskBody = CreateBody("killSpusk","Polygon",0,defaultFriction,defaultRestitution,[[[954.95, 494.95], [963.95, 524.95], [874.95, 514.95]], [[874.95, 514.95], [963.95, 524.95], [882.95, 547.95], [792.95, 547.95], [798.95, 514.95]], [[182.95, 26], [544.95, 393.95], [522.95, 419.95], [164, 53.95], [115.95, 0]], [[0, 0], [115.95, 0], [111, 33.95], [0, 33.95]], [[111, 33.95], [115.95, 0], [164, 53.95]], [[544.95, 393.95], [646.95, 458.95], [522.95, 419.95]], [[646.95, 458.95], [798.95, 514.95], [792.95, 547.95], [632.95, 491], [522.95, 419.95]]]);
			carBody= CreateBody("car","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[98, 40.75], [91.5, 41.75], [91.5, 39.25], [98, 24.25]], [[62, 0], [68, 16.5], [65.75, 17], [59.75, 0]], [[68, 16.5], [98, 24.25], [65.75, 26], [65.75, 17]], [[17.25, 0.5], [20.5, 21.75], [13.5, 28.5], [9.5, 31.5], [0, 0.5]], [[0, 41.5], [0, 0.5], [6.5, 36.25], [5.5, 41.5]], [[6.5, 36.25], [0, 0.5], [9.5, 31.5]], [[13.5, 28.5], [20.5, 21.75], [17.25, 27.5]], [[20.5, 21.75], [33.25, 26], [17.25, 27.5]], [[33.25, 26], [65.75, 26], [21.25, 27.5], [17.25, 27.5]], [[21.25, 27.5], [65.75, 26], [25.5, 28.5]], [[65.75, 26], [98, 24.25], [28.5, 30.25], [25.5, 28.5]], [[28.5, 30.25], [98, 24.25], [75.25, 27.5], [30.75, 32.75]], [[33.75, 41.5], [33.5, 39.25], [63.5, 41.5]], [[33.5, 39.25], [32.25, 35.5], [63.5, 41.5]], [[32.25, 35.5], [30.75, 32.75], [64.5, 36.25], [63.5, 41.5]], [[64.5, 36.25], [30.75, 32.75], [67.5, 31.5]], [[67.5, 31.5], [30.75, 32.75], [71.5, 28.5]], [[71.5, 28.5], [30.75, 32.75], [75.25, 27.5]], [[75.25, 27.5], [98, 24.25], [79.25, 27.5]], [[79.25, 27.5], [98, 24.25], [83.5, 28.5]], [[83.5, 28.5], [98, 24.25], [86.5, 30.25]], [[86.5, 30.25], [98, 24.25], [88.75, 32.75]], [[88.75, 32.75], [98, 24.25], [90.25, 35.5]], [[90.25, 35.5], [98, 24.25], [91.5, 39.25]]]);
			killSpusk2Body = CreateBody("killSpusk2","Polygon",0,defaultFriction,defaultRestitution,[[[290, 76], [631.05, 409.05], [275, 105.95], [199, 34]], [[0, 0], [199, 34], [191, 65.95], [-6, 34.95]], [[191, 65.95], [199, 34], [275, 105.95]], [[275, 105.95], [631.05, 409.05], [618, 439.95]], [[631.05, 409.05], [717.05, 457.05], [618, 439.95]], [[717.05, 457.05], [891.05, 494.05], [882.95, 523.95], [705.95, 485.95], [618, 439.95]], [[891.05, 494.05], [965.05, 494.05], [964.95, 523.95], [882.95, 523.95]], [[964.95, 523.95], [965.05, 494.05], [1049.05, 468.05], [1057.95, 493.95]]]);
			var koleco1Body:b2Body = CreateBody("koleco1","Circle",defaultDensity,defaultFriction,defaultRestitution,[23.3]);
			var koleco2Body:b2Body = CreateBody("koleco2","Circle",defaultDensity,defaultFriction,defaultRestitution,[23.3]);
			killer1Body = CreateBody("killer1","Polygon",10*defaultDensity,defaultFriction,defaultRestitution,[[[8.9, 0], [34.9, 0], [34.9, 200], [22.2, 218.5], [8.9, 200]]]);
			killer2Body = CreateBody("killer2","Polygon",10*defaultDensity,defaultFriction,defaultRestitution,[[[8.9, 0], [34.9, 0], [34.9, 200], [22.2, 218.5], [8.9, 200]]]);
			killer3Body = CreateBody("killer3","Polygon",10*defaultDensity,defaultFriction,defaultRestitution,[[[8.9, 0], [34.9, 0], [34.9, 200], [22.2, 218.5], [8.9, 200]]]);
			CreateBody("finishPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[482.85, -107], [500.05, -107], [500.05, 20], [482.85, 0]], [[0, 0], [482.85, 0], [500.05, 20], [0, 20]]]);
			CreateBody("barier","Polygon",0,defaultFriction,defaultRestitution,[[[24.75, 0], [34.5, 33.75], [0, 33.75], [10, 0]]]);
				
			var revoluteJointDef:b2RevoluteJointDef=new b2RevoluteJointDef();
			var prismaticJointDef:b2PrismaticJointDef=new b2PrismaticJointDef();
												
			prismaticJointDef.Initialize(killer1Body, m_ground, killer1Body.GetWorldCenter(), new b2Vec2(0,1));
			m_world.CreateJoint(prismaticJointDef);
			prismaticJointDef.Initialize(killer2Body, m_ground, killer2Body.GetWorldCenter(), new b2Vec2(0,1));
			m_world.CreateJoint(prismaticJointDef);
			prismaticJointDef.Initialize(killer3Body, m_ground, killer3Body.GetWorldCenter(), new b2Vec2(0,1));
			m_world.CreateJoint(prismaticJointDef);
			
			revoluteJointDef.Initialize(carBody, koleco1Body, new b2Vec2((koleco1.x+11.65)/m_physScale,(koleco1.y+11.65)/m_physScale));
			m_world.CreateJoint(revoluteJointDef);
			revoluteJointDef.Initialize(carBody, koleco2Body, new b2Vec2((koleco2.x+11.65)/m_physScale,(koleco2.y+11.65)/m_physScale));
			m_world.CreateJoint(revoluteJointDef);
			
			addEventListener(Event.REMOVED_FROM_STAGE,onRemovedHandler);
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>1800 ||
				 myContactListener.playerContactBodies.indexOf(killer1Body)!=-1 || myContactListener.playerContactBodies.indexOf(killer2Body)!=-1 ||
				 myContactListener.playerContactBodies.indexOf(killer3Body)!=-1 ||
				 myContactListener.playerContactBodies.indexOf(killSpuskBody)!=-1 || myContactListener.playerContactBodies.indexOf(killSpusk2Body)!=-1) {
					if(playerBox.IsLive()) PlayerDie();
			}
			
			if(myContactListener.playerContactBodies.indexOf(carBody)!=-1) {
				if(Game.soundIs && !carSoundChannel) {
					carSoundChannel=carSound.play(0,int.MAX_VALUE,new SoundTransform(0.8,0));
				}
			} 
			
			if(!Game.soundIs) {
				if(carSoundChannel) {
					carSoundChannel.stop();
					carSoundChannel=null;
				}
			}			
						
			if(killer1.y>70) killer1Up=true;
			if(killer1.y<-4) killer1Up=false;
			if(killer1Up) killer1Body.SetLinearVelocity(new b2Vec2(0,-4));
			
			if(killer2.y>70) killer2Up=true;
			if(killer2.y<-4) killer2Up=false;
			if(killer2Up) killer2Body.SetLinearVelocity(new b2Vec2(0,-4));
			
			if(killer3.y>70) killer3Up=true;
			if(killer3.y<-4) killer3Up=false;
			if(killer3Up) killer3Body.SetLinearVelocity(new b2Vec2(0,-4));
		}
		
		private function onRemovedHandler(e:Event):void {
			if(carSoundChannel) {
				carSoundChannel.stop();
				carSoundChannel=null;
			}
		}
	}
}