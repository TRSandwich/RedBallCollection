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

	public class Level_6 extends Level {	
		private var blueBarierBody:b2Body;
		private var greenPlatformBody:b2Body;
		
		private var drop1Body:b2Body;
		private var drop2Body:b2Body;
		private var drop3Body:b2Body;
	
		public function Level_6() {
			super();
			id=6;
						
			CreateBody("rampa","Polygon",0,defaultFriction,defaultRestitution,[[[66.9, 0], [66.9, 22.15], [0, 0]], [[66.9, 22.15], [69.8, 47.2], [0, 0]], [[69.8, 47.2], [72.9, 68.15], [0, 0]], [[72.9, 68.15], [77.9, 90.15], [0, 0]], [[77.9, 90.15], [83.9, 108.15], [0, 0]], [[83.9, 108.15], [92.9, 127.15], [0, 0]], [[92.9, 127.15], [103.9, 146.15], [0, 0]], [[103.9, 146.15], [114.9, 162.15], [0, 261.1], [0, 0]], [[114.9, 162.15], [127.9, 174.15], [0, 261.1]], [[127.9, 174.15], [146.35, 187.35], [0, 261.1]], [[146.35, 187.35], [165.9, 194.65], [0, 261.1]], [[165.9, 194.65], [183.4, 197.65], [279.9, 261.1], [0, 261.1]], [[279.9, 138.15], [279.9, 261.1], [271.9, 155.65]], [[271.9, 155.65], [279.9, 261.1], [261.9, 171.65]], [[261.9, 171.65], [279.9, 261.1], [250.4, 183.65]], [[250.4, 183.65], [279.9, 261.1], [234.9, 194.15]], [[234.9, 194.15], [279.9, 261.1], [218.9, 198.15]], [[218.9, 198.15], [279.9, 261.1], [200.4, 198.65]], [[200.4, 198.65], [279.9, 261.1], [183.4, 197.65]]]);
			CreateBody("afterJump","Polygon",0,defaultFriction,defaultRestitution,[[[182, 0], [182, 20], [0, 20], [0, 0]]]);
			drop1Body=CreateBody("drop1","Polygon",0,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			drop2Body=CreateBody("drop2","Polygon",0,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			drop3Body=CreateBody("drop3","Polygon",0,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			var spinBody:b2Body = CreateBody("spin","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[60.55, -65.5], [67.75, -58.6], [26.3, -30.2]], [[5, -89.5], [5, -39.75], [-5, -39.75], [-5, -89.5]], [[5, -39.75], [26.3, -30.2], [-24.35, -31.4], [-24.6, -31.65], [-5, -39.75]], [[-24.6, -31.65], [-24.35, -31.4], [-31.7, -24.5], [-67.9, -57.8], [-61.1, -65.2]], [[-24.35, -31.4], [26.3, -30.2], [-31.45, 24.8], [-39.8, 4.3], [-39.65, -5.7], [-31.7, -24.5]], [[-88.95, -6.1], [-39.65, -5.7], [-39.8, 4.3], [-89.05, 3.9]], [[26.3, -30.2], [67.75, -58.6], [32.8, -23], [-24.65, 31.55], [-66.7, 60.1], [-31.45, 24.8]], [[-31.7, 24.55], [-31.45, 24.8], [-66.7, 60.1]], [[-59.6, 67.1], [-66.7, 60.1], [-24.65, 31.55]], [[-4.2, 39.8], [-24.65, 31.55], [-4.2, 39.4]], [[-4.85, 89.4], [-4.2, 39.8], [5.15, 89.5]], [[-4.2, 39.8], [-4.2, 39.4], [5.8, 39.6], [5.15, 89.5]], [[-4.2, 39.4], [-24.65, 31.55], [32.4, 23], [32.65, 23.2], [26.15, 30.3], [5.8, 39.6]], [[25.9, 30.6], [26.15, 30.3], [32.65, 23.2], [70.2, 55.6], [63.7, 63.2]], [[32.65, 23.2], [32.4, 23], [39.75, 4.45]], [[32.4, 23], [-24.65, 31.55], [32.8, -23], [39.65, -5.55], [39.75, 4.45]], [[89.05, 4], [39.75, 4.45], [39.65, -5.55], [88.95, -6]], [[33, -22.8], [32.8, -23], [67.75, -58.6]]]);
			CreateBody("voronkaLeft","Polygon",0,0,defaultRestitution,[[[0, 284.45], [105.5, 224], [107.5, 227], [1.5, 288]], [[105.5, 224], [112.5, 216.5], [115.5, 219], [107.5, 227]], [[112.5, 216.5], [115.5, 208], [115.5, 219]], [[115.5, 208], [115.5, 68.5], [115.5, 219]], [[115.5, 219], [115.5, 68.5], [119.5, 67.5], [119.5, 208]], [[115.5, 68.5], [88.5, 34.5], [92.5, 32], [119.5, 67.5]], [[88.5, 34.5], [83.5, 0], [88, 0], [92.5, 32]]]);
			CreateBody("voronkaRight","Polygon",0,0,defaultRestitution,[[[0, 306.2], [105.5, 245.75], [107.5, 248.75], [1.5, 309.75]], [[105.5, 245.75], [113.65, 240.2], [107.5, 248.75]], [[113.65, 240.2], [120.4, 233.95], [115.4, 243.2], [107.5, 248.75]], [[120.4, 233.95], [124.9, 226.45], [123.4, 235.7], [115.4, 243.2]], [[124.9, 226.45], [128.65, 216.95], [127.9, 227.45], [123.4, 235.7]], [[128.65, 216.95], [130.25, 207.95], [131.9, 218.2], [127.9, 227.45]], [[130.25, 207.95], [130.25, 67.5], [134.25, 68.5], [134.25, 207.95], [133.4, 212.95], [131.9, 218.2]], [[130.25, 67.5], [157.25, 32], [161.25, 34.5], [134.25, 68.5]], [[157.25, 32], [161.75, 0], [166.25, 0], [161.25, 34.5]]]);
			CreateBody("rampa2","Polygon",0,defaultFriction,defaultRestitution,[[[129.9, 0], [129.9, 26.4], [58.9, 26.4], [0, 0]], [[279.9, 191.15], [279.9, 284.1], [271.9, 208.65]], [[271.9, 208.65], [279.9, 284.1], [261.9, 224.65]], [[261.9, 224.65], [279.9, 284.1], [250.4, 236.65]], [[250.4, 236.65], [279.9, 284.1], [234.9, 247.15]], [[234.9, 247.15], [279.9, 284.1], [218.9, 251.15]], [[279.9, 284.1], [0, 284.1], [200.4, 251.65], [218.9, 251.15]], [[200.4, 251.65], [0, 284.1], [183.4, 250.65]], [[183.4, 250.65], [0, 284.1], [165.9, 247.65]], [[165.9, 247.65], [0, 284.1], [146.35, 240.35]], [[146.35, 240.35], [0, 284.1], [127.9, 227.15]], [[127.9, 227.15], [0, 284.1], [114.9, 215.15]], [[114.9, 215.15], [0, 284.1], [103.9, 199.15]], [[103.9, 199.15], [0, 284.1], [92.9, 180.15]], [[0, 284.1], [0, 0], [83.9, 161.15], [92.9, 180.15]], [[83.9, 161.15], [0, 0], [77.9, 143.15]], [[77.9, 143.15], [0, 0], [72.9, 121.15]], [[72.9, 121.15], [0, 0], [58.9, 26.4]]]);
			CreateBody("beforeBackBalls","Polygon",0,defaultFriction,defaultRestitution,[[[182, 0], [182, 20], [0, 20], [0, 0]]]);
			var backBall1Body:b2Body = CreateBody("backBall1","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[14.75, -16.85], [18.5, -12.7], [22.25, -3.1], [22.35, 2.5], [18.3, 13], [14.65, 16.95], [3.25, 22.15], [-2.4, 22.25], [-13.85, 17.7], [-17.65, 13.9], [-22.35, 2.4], [-22.25, -3.15], [-17.8, -13.65], [-13.8, -17.65], [-2.85, -22.15], [2.8, -22.15]], [[2.8, -50], [2.8, -22.15], [-2.85, -22.15], [-2.85, -50]], [[-49.95, -3.4], [-22.25, -3.15], [-22.35, 2.4], [-50, 2.2]], [[-2.75, 49.95], [-2.4, 22.25], [3.25, 22.15], [2.85, 50]], [[50, 2.25], [22.35, 2.5], [22.25, -3.1], [49.9, -3.35]]]);
			var backBall2Body:b2Body = CreateBody("backBall2","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[14.75, -16.85], [18.5, -12.7], [22.25, -3.1], [22.35, 2.5], [18.3, 13], [14.65, 16.95], [3.25, 22.15], [-2.4, 22.25], [-13.85, 17.7], [-17.65, 13.9], [-22.35, 2.4], [-22.25, -3.15], [-17.8, -13.65], [-13.8, -17.65], [-2.85, -22.15], [2.8, -22.15]], [[2.8, -50], [2.8, -22.15], [-2.85, -22.15], [-2.85, -50]], [[-49.95, -3.4], [-22.25, -3.15], [-22.35, 2.4], [-50, 2.2]], [[-2.75, 49.95], [-2.4, 22.25], [3.25, 22.15], [2.85, 50]], [[50, 2.25], [22.35, 2.5], [22.25, -3.1], [49.9, -3.35]]]);
			var backBall3Body:b2Body = CreateBody("backBall3","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[14.75, -16.85], [18.5, -12.7], [22.25, -3.1], [22.35, 2.5], [18.3, 13], [14.65, 16.95], [3.25, 22.15], [-2.4, 22.25], [-13.85, 17.7], [-17.65, 13.9], [-22.35, 2.4], [-22.25, -3.15], [-17.8, -13.65], [-13.8, -17.65], [-2.85, -22.15], [2.8, -22.15]], [[2.8, -50], [2.8, -22.15], [-2.85, -22.15], [-2.85, -50]], [[-49.95, -3.4], [-22.25, -3.15], [-22.35, 2.4], [-50, 2.2]], [[-2.75, 49.95], [-2.4, 22.25], [3.25, 22.15], [2.85, 50]], [[50, 2.25], [22.35, 2.5], [22.25, -3.1], [49.9, -3.35]]]);
			CreateBody("finishPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			
			var revoluteJointDef:b2RevoluteJointDef=new b2RevoluteJointDef();
			
			revoluteJointDef.Initialize(spinBody, m_ground, new b2Vec2(722/m_physScale,323/m_physScale));
			revoluteJointDef.motorSpeed = 0.3 * -Math.PI;
			revoluteJointDef.maxMotorTorque = 5000.0;
			revoluteJointDef.enableMotor = true;
			m_world.CreateJoint(revoluteJointDef);
			
			revoluteJointDef.Initialize(backBall1Body, m_ground, backBall1Body.GetPosition());
			revoluteJointDef.motorSpeed = 0.2 * Math.PI;
			revoluteJointDef.maxMotorTorque = 5000.0;
			revoluteJointDef.enableMotor = true;
			m_world.CreateJoint(revoluteJointDef);
			
			revoluteJointDef.Initialize(backBall2Body, m_ground, backBall2Body.GetPosition());
			revoluteJointDef.motorSpeed = 0.2 * Math.PI;
			revoluteJointDef.maxMotorTorque = 5000.0;
			revoluteJointDef.enableMotor = true;
			m_world.CreateJoint(revoluteJointDef);
			
			revoluteJointDef.Initialize(backBall3Body, m_ground, backBall3Body.GetPosition());
			revoluteJointDef.motorSpeed = 0.2 * Math.PI;
			revoluteJointDef.maxMotorTorque = 5000.0;
			revoluteJointDef.enableMotor = true;
			m_world.CreateJoint(revoluteJointDef);			
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>1060) {
					if(playerBox.IsLive()) PlayerDie();
			}
			
			if(myContactListener.playerContactBodies.indexOf(drop1Body)!=-1) {
				m_world.DestroyBody(drop1Body);
				drop1Body = CreateBody("drop1","Polygon",3*defaultDensity,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			}
			if(myContactListener.playerContactBodies.indexOf(drop2Body)!=-1) {
				m_world.DestroyBody(drop2Body);
				drop2Body = CreateBody("drop2","Polygon",3*defaultDensity,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			}
			if(myContactListener.playerContactBodies.indexOf(drop3Body)!=-1) {
				m_world.DestroyBody(drop3Body);
				drop3Body = CreateBody("drop3","Polygon",3*defaultDensity,defaultFriction,defaultRestitution,[[[100, 0], [100, 20], [0, 20], [0, 0]]]);
			}
		}
	}
}