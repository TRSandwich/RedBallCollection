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

	public class Level_12 extends Level {		
		private var killStarBody:b2Body;
		private var killStarDirection:int=1;
		private var boxStarBody:b2Body;
	
		public function Level_12() {
			super();
			id=12;
						
			var filterData:b2FilterData=new b2FilterData();
			filterData.groupIndex=-1;
			
			CreateBody("steps","Polygon",0,defaultFriction,defaultRestitution,[[[256, 0], [256, 18], [164, 18], [138, 0]], [[112, 18], [138, 18], [164, 106], [112, 37]], [[87, 37], [112, 37], [164, 106], [87, 55]], [[62, 55], [87, 55], [62, 72]], [[38.5, 72], [62, 72], [38.5, 88.5]], [[62, 72], [87, 55], [164, 106], [38.5, 88.5]], [[0, 88.5], [38.5, 88.5], [164, 106], [0, 106]], [[138, 18], [138, 0], [164, 18], [164, 106]]]);
			
			var mainPlatfromBody:b2Body = CreateBody("mainPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[1962.2, 0], [1962.2, 18.05], [1817.45, 7.75], [1817.45, 0]], [[1817.45, 7.75], [1962.2, 18.05], [1799.45, 15.75], [1799.45, 7.75]], [[1799.45, 15.75], [1962.2, 18.05], [1883.2, 18.05], [1779.95, 15.75]], [[1761.2, 24], [1779.95, 24], [1761.2, 31.5]], [[1741.95, 31.5], [1761.2, 31.5], [1741.95, 39.25]], [[1761.2, 31.5], [1779.95, 24], [1883.2, 193.25], [1741.95, 39.25]], [[1431.65, 39.25], [1741.95, 39.25], [1883.2, 193.25], [1431.65, 127.4]], [[884.25, 127.4], [1431.65, 127.4], [1883.2, 193.25], [884.25, 168.2]], [[533, 127.2], [533, 168.2], [511.5, 168.25], [511.5, 127.2]], [[533, 168.2], [884.25, 168.2], [1883.2, 193.25], [0, 193.25], [511.5, 168.25]], [[0, 168.25], [511.5, 168.25], [0, 193.25]], [[1779.95, 24], [1779.95, 15.75], [1883.2, 18.05], [1883.2, 193.25]]]);
			for (var bb:b2Shape = mainPlatfromBody.GetShapeList(); bb; bb = bb.m_next) {
				bb.SetFilterData(filterData);
				m_world.Refilter(bb);
			}
			
			CreateBody("boxPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[100, 0], [100, 18], [0, 18], [0, 0]]]);
			for(var i:int=0;i<3;i++) {
				CreateBody("box"+i.toString(),"Polygon",defaultDensity/5,defaultFriction,defaultRestitution,[[[20, 0], [20, 20], [0, 20], [0, 0]]]);
			}
			CreateBody("ceil","Polygon",0,defaultFriction,defaultRestitution,[[[184, 0], [184, 140.25], [0, 140.25], [0, 0]]]);
			CreateBody("bigBox","Polygon",defaultDensity/8,defaultFriction,defaultRestitution,[[[0, 0], [40, 0], [40, 40], [0, 40]]]);
			
			killStarBody = CreateBody("killStar","Circle",defaultDensity,defaultFriction,defaultRestitution,[40]);
			killStarBody.GetShapeList().SetFilterData(filterData);
			m_world.Refilter(killStarBody.GetShapeList());
			
			var rampaBody:b2Body = CreateBody("rampa","Polygon",0,0.1,defaultRestitution,[[[11.6, -14.25], [11.6, -8.2], [5.6, -8.2], [0, -14.25]], [[435.5, 84.5], [354.5, 64.5], [451, 87.5]], [[354.5, 64.5], [210.95, 30], [505.5, 94], [483.5, 92.5], [451, 87.5]], [[210.95, 30], [157.95, 18], [450, 81.5], [505.5, 94]], [[996, 70.6], [1015, 70.6], [1009, 76.6], [996, 76.6]], [[1015, 70.6], [1015, 94], [1009, 88.5], [1009, 76.6]], [[1015, 94], [505.5, 94], [507.5, 88.5], [1009, 88.5]], [[507.5, 88.5], [505.5, 94], [483, 86.5]], [[483, 86.5], [505.5, 94], [450, 81.5]], [[450, 81.5], [157.95, 18], [420, 74.5]], [[420, 74.5], [157.95, 18], [211, 23.5], [353.5, 57.5]], [[157.95, 18], [110, 12], [158, 11.5], [211, 23.5]], [[110, 12], [58.75, 7], [110, 5.5], [158, 11.5]], [[58.75, 7], [0, 7], [5.6, 0], [58.75, 0], [110, 5.5]], [[0, 7], [0, -14.25], [5.6, -8.2], [5.6, 0]]]);		
			var roll1Body:b2Body = CreateBody("roll1","Circle",defaultDensity,0.1,defaultRestitution,[8]);		
			var roll2Body:b2Body = CreateBody("roll2","Circle",defaultDensity,0.1,defaultRestitution,[8]);		
			var goPlatBody:b2Body = CreateBody("goPlat","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[5.45, 0.75], [5.45, 10.1], [0, 15.75], [0, 0.75]], [[5.45, 10.1], [54.05, 10.1], [59.75, 15.75], [0, 15.75]], [[54.05, 10.1], [54.05, 0], [59.75, 0], [59.75, 15.75]]]);	
						
			//CreateBody("","Polygon",defaultDensity,defaultFriction,defaultRestitution,);		
			
			var distanceJointDef:b2DistanceJointDef=new b2DistanceJointDef();
			var prismaticJointDef:b2PrismaticJointDef=new b2PrismaticJointDef();
			var revoluteJointDef:b2RevoluteJointDef=new b2RevoluteJointDef();
			
			prismaticJointDef.Initialize(killStarBody, m_ground, new b2Vec2(killStarBody.GetPosition().x+20/m_physScale,killStarBody.GetPosition().y+20/m_physScale), new b2Vec2(1,0));
			m_world.CreateJoint(prismaticJointDef);
			
			distanceJointDef.Initialize(goPlatBody, roll1Body, new b2Vec2(goPlatBody.GetPosition().x+3/m_physScale,goPlatBody.GetPosition().y+1/m_physScale), new b2Vec2(roll1Body.GetPosition().x+4/m_physScale,roll1Body.GetPosition().y+4/m_physScale));
			m_world.CreateJoint(distanceJointDef);
			distanceJointDef.Initialize(goPlatBody, roll2Body, new b2Vec2(goPlatBody.GetPosition().x+57/m_physScale,goPlatBody.GetPosition().y+1/m_physScale), new b2Vec2(roll2Body.GetPosition().x+4/m_physScale,roll2Body.GetPosition().y+4/m_physScale));
			m_world.CreateJoint(distanceJointDef);
			distanceJointDef.Initialize(roll1Body, roll2Body, new b2Vec2(roll1Body.GetPosition().x+4/m_physScale,roll1Body.GetPosition().y+4/m_physScale), new b2Vec2(roll2Body.GetPosition().x+4/m_physScale,roll2Body.GetPosition().y+4/m_physScale));
			m_world.CreateJoint(distanceJointDef);
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>500 ||
			   myContactListener.playerContactBodies.indexOf(killStarBody)!=-1) {
					if(playerBox.IsLive()) PlayerDie();
			}
			
			if(killStar.x<-1050) killStarDirection=1;
			if(killStar.x>-824) killStarDirection=-1;
			killStarBody.SetLinearVelocity(new b2Vec2(4*killStarDirection,0));
		}
	}
}