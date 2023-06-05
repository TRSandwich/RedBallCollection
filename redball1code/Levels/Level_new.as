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

	public class Level_ extends Level {	
		public function Level_() {
			super();
			id=0;
			playerStartPosition=new Point(0,0);
			playerBox=new PlayerBox(playerStartPosition.x,playerStartPosition.y,m_world,m_sprite);
			
			//CreateBody("","Polygon",defaultDensity,defaultFriction,defaultRestitution,);
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>500) {
					if(playerBox.IsLive()) PlayerDie();
			}
		}
	}
}