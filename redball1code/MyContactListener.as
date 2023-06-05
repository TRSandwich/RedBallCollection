package {
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;
	
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	
	public class MyContactListener extends b2ContactListener {
		public var playerContactBodies:Array=new Array();
		
		private var ballDownSound:BallDownSound = new BallDownSound();;
		private var ballDownSoundChannel:SoundChannel;
		private var transformBallDownSound:SoundTransform = new SoundTransform(0.6, 0);
		
		/// Called when a contact point is added. This includes the geometry and the forces.
		public override function Add(point:b2ContactPoint) : void{
			var body1:b2Body = point.shape1.GetBody();
    		var body2:b2Body = point.shape2.GetBody();
			
			if(body1.m_userData is PlayerBox) {
				playerContactBodies.push(body2);
			}
			if(body2.m_userData is PlayerBox) {
				playerContactBodies.push(body1);
			}
			//trace(playerContactBodies.length);
		}
	
		/// Called when a contact point persists. This includes the geometry and the forces.
		public override function Persist(point:b2ContactPoint) : void{
			
		}
	
		/// Called when a contact point is removed. This includes the last computed geometry and forces.
		public override function Remove(point:b2ContactPoint) : void{
			var body1:b2Body = point.shape1.GetBody();
    		var body2:b2Body = point.shape2.GetBody();
			
			if(body1.m_userData is PlayerBox && playerContactBodies.indexOf(body2)!=-1) {
				playerContactBodies.splice(body2,1);
			}
			if(body2.m_userData is PlayerBox && playerContactBodies.indexOf(body1)!=-1) {
				playerContactBodies.splice(body1,1);
			}
		}
		
		/// Called after a contact point is solved.
		public override function Result(point:b2ContactResult) : void{
			var body1:b2Body = point.shape1.GetBody();
    		var body2:b2Body = point.shape2.GetBody();
			
			if(Game.soundIs && ((body1.m_userData is PlayerBox) || (body2.m_userData is PlayerBox))) {
				if(point.normalImpulse>2) {
					if(!ballDownSoundChannel) {
						ballDownSoundChannel=ballDownSound.play(0,1); 
						ballDownSoundChannel.soundTransform = transformBallDownSound;
						ballDownSoundChannel.addEventListener(Event.SOUND_COMPLETE, ballDownSoundCompleteHandler);
					}
				}
			}
		}
		
		private function ballDownSoundCompleteHandler(e:Event):void {
			ballDownSoundChannel=null;
		}
		}
}