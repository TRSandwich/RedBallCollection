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

	public class Level_1 extends Level {
		public function Level_1() {
			super();
			id=1;
									
			CreateBody("startPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[200, 0], [200, 20], [0, 20], [0, 0]]]);
			CreateBody("exitPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[300, 0], [300, 20], [0, 20], [0, 0]]]);
			CreateBody("barier","Polygon",0,defaultFriction,defaultRestitution,[[[0, 0], [20, 0], [20, 50], [0, 50]]]);
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>550) {
					if(playerBox.IsLive()) PlayerDie();
			}

		}
	}
}