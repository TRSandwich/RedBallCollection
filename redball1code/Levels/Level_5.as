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

	public class Level_5 extends Level {	
		private var blueBarierBody:b2Body;
		private var greenPlatformBody:b2Body;
	
		public function Level_5() {
			super();
			id=5;
			
			CreateBody("firstPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[298.45, 0], [298.45, 0.3], [0, 20], [0, 0]], [[298.45, 0.3], [300, 0.3], [300, 20], [0, 20]]]);
			blueBarierBody = CreateBody("blueBarier","Polygon",0,defaultFriction,defaultRestitution,[[[0, 0], [10, 0], [10, 100], [0, 100]]]);
			CreateBody("mainPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[594.9, 0], [594.9, 136], [0, 136], [0, 116], [195.95, 0]]]);
			CreateBody("rightBarier","Polygon",0,defaultFriction,defaultRestitution,[[[0, 0], [30, 0], [1.05, 251], [0, 251]], [[1.05, 251], [30, 0], [30, 251.95], [1.05, 251.95]]]);
			CreateBody("jumpPlatform","Polygon",defaultDensity,defaultFriction,defaultRestitution,[[[226.95, 0], [226.95, 7], [0, 7], [0, 0]]]);
			greenPlatformBody = CreateBody("greenPlatform","Polygon",0,defaultFriction,defaultRestitution,[[[85, 0], [85, 15], [0, 15], [0, 0]]]);
			CreateBody("littleBall","Circle",defaultDensity,defaultFriction,defaultRestitution,[13]);
			CreateBody("bigBall","Circle",2*defaultDensity,defaultFriction,defaultRestitution,[83.5]);
			
			blueCheck.stop();
			greenCheck.stop();
		}
		
		public override function Update(e:Event):void {
			super.Update(e);
									
			if(playerBox.y>650) {
					if(playerBox.IsLive()) PlayerDie();
			}
			
			if(playerBox.hitTestObject(blueCheck) && blueCheck.currentFrame==1) {
				blueCheck.gotoAndStop(2);
				DestroyBody(blueBarierBody);
				if(Game.soundIs && !checkBoxSoundChannel) {
					checkBoxSoundChannel=checkBoxSound.play(0,1); 
					checkBoxSoundChannel.addEventListener(Event.SOUND_COMPLETE, checkBoxSoundCompleteHandler);
				}
			}
			if(playerBox.hitTestObject(greenCheck) && greenCheck.currentFrame==1) {
				greenCheck.gotoAndStop(2);
				DestroyBody(greenPlatformBody);
				if(Game.soundIs && !checkBoxSoundChannel) {
					checkBoxSoundChannel=checkBoxSound.play(0,1); 
					checkBoxSoundChannel.soundTransform = transformCheckBoxSound;
					checkBoxSoundChannel.addEventListener(Event.SOUND_COMPLETE, checkBoxSoundCompleteHandler);
				}
			}
		}
		
		private function checkBoxSoundCompleteHandler(e:Event):void {
			checkBoxSoundChannel=null;
		}
	}
}