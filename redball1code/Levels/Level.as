
package Levels{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.media.*;

	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	
	import caurina.transitions.*;
	
	public class Level extends MovieClip {
		public static const m_iterations:int=10;
		public static const m_timeStep:Number=1/30;
		public static const m_physScale:Number=30;
		
		public static const defaultDensity:Number=1;
		public static const defaultFriction:Number=1;
		public static const defaultRestitution:Number=0.2;

		protected var id:int;
		protected var m_world:b2World;
		protected var m_sprite:Sprite;
		protected var m_ground:b2Body;

		protected var isWin:Boolean=false;
		protected var isLose:Boolean=false;

		protected var playerBox:PlayerBox;
		protected var playerStartPosition:Point=new Point(0,0);
		private var Left:Boolean=false;
		private var Right:Boolean=false;
		private var Up:Boolean=false;
		private var Down:Boolean=false;

		private var levelAim:MovieClip;
		private var backGround:BackGround;
		private var backGroundStartPosition:Point=new Point(0,0);
		private var jumpTimer:Timer=new Timer(20,1);
		private var m_joint:Sprite;
		
		private var scaleTimer:Timer;
		
		protected var myContactListener:MyContactListener;
		
		protected var jumpPlatformSound:JumpPlatformSound = new JumpPlatformSound();
		protected var jumpPlatformSoundChannel:SoundChannel;
		private var levelSound:LevelSound = new LevelSound();
		private var levelSoundChannel:SoundChannel;
		protected var checkBoxSound:CheckBoxSound = new CheckBoxSound();
		protected var checkBoxSoundChannel:SoundChannel;
		
		private var ballJumpSound:BallJumpSound = new BallJumpSound();;
		private var ballJumpSoundChannel:SoundChannel;
		private var ballDieSound:BallDieSound = new BallDieSound();
		private var ballDieSoundChannel:SoundChannel;
		
		private var transformDieSound:SoundTransform = new SoundTransform(0.4, 0);
		private var transformLevelSound:SoundTransform = new SoundTransform(4, 0);
		protected var transformCheckBoxSound:SoundTransform = new SoundTransform(4, 0);

		protected var checkPoints:Array=new Array();
		public static var lastCheckNum:int=0;
		
		public function Level() {
			m_sprite=this;
			
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(-1000.0, -1000.0);
			worldAABB.upperBound.Set(1000.0, 1000.0);
			var gravity:b2Vec2=new b2Vec2(0.0,10.0);
			var doSleep:Boolean=true;
			m_world=new b2World(worldAABB,gravity,doSleep);
						
			m_ground=m_world.GetGroundBody();
			
			myContactListener=new MyContactListener();
			m_world.SetContactListener(myContactListener);
			
			backGround=m_sprite.getChildByName("backGroundMC") as BackGround;
			backGroundStartPosition=new Point(backGround.x,backGround.y);

			levelAim=m_sprite.getChildByName("levelAim") as MovieClip;
			levelAim.stop();
			
			m_joint=new Sprite();
			m_sprite.addChildAt(m_joint,m_sprite.numChildren);
			
			scaleTimer=new Timer(1000,0);
			scaleTimer.addEventListener(TimerEvent.TIMER,scaleTimerHandler);
			//scaleTimer.start();
									
			SetControl();
			
			for(var i:int=0;i<5;i++) {
				if(this.getChildByName("checkPoint"+i.toString())) {
					checkPoints.push(this.getChildByName("checkPoint"+i.toString()));
					checkPoints[i].stop();
					if(lastCheckNum>i) checkPoints[i].gotoAndStop(5);
				} else {
					break;
				}
			}
			
			playerStartPosition=new Point(checkPoints[lastCheckNum].x,checkPoints[lastCheckNum].y);
			playerBox=new PlayerBox(playerStartPosition.x,playerStartPosition.y,m_world,m_sprite);
		}

		public function GetID():int {
			return id;
		}

		public function SetControl():void {
			Preloader.stageLink.addEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
			Preloader.stageLink.addEventListener(KeyboardEvent.KEY_UP, KeyUpHandler);
			Left=false;
		 	Right=false;
			Up=false;
			Down=false;
		}
		
		public function OutControl():void {
			Preloader.stageLink.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
			Preloader.stageLink.removeEventListener(KeyboardEvent.KEY_UP, KeyUpHandler);
			Left=false;
		 	Right=false;
			Up=false;
			Down=false;
		}

		public function Win():Boolean {
			return isWin;
		}

		public function Lose():Boolean {
			return isLose;
		}
		
		public function PlayerWin():void {
			var playerWinTimer:Timer;
			if(id==12) playerWinTimer=new Timer(5000,1);
			else playerWinTimer=new Timer(2800,1);
			playerWinTimer.addEventListener(TimerEvent.TIMER,playerWinHandler);
			playerWinTimer.start();
			levelAim.play();
			OutControl();
			switch(id) {
				case 5:	 
				case 11: break;
				default: playerBox.body.m_linearDamping=3;
					     playerBox.body.m_angularDamping=3;
						 break;
			}
		}
		
		public function PlayerDie():void {
			var playerDieTimer:Timer=new Timer(1200,1);
			playerDieTimer.addEventListener(TimerEvent.TIMER,playerDieHandler);
			playerDieTimer.start();
			OutControl();
			for(var i:int=0;i<8;i++) {
				var newPlayerDiePart:PlayerDiePart=new PlayerDiePart();
				newPlayerDiePart.x=playerBox.x-4+5*Math.random()-5*Math.random();
				newPlayerDiePart.y=playerBox.y-4+5*Math.random()-5*Math.random();;
				newPlayerDiePart.name="playerDiePart"+i.toString();
				m_sprite.addChild(newPlayerDiePart);
				var newPlayerDiePartBody:b2Body = CreateBody("playerDiePart"+i.toString(),"Circle",defaultDensity,defaultFriction,0,[8]);
				newPlayerDiePartBody.SetLinearVelocity(new b2Vec2(playerBox.body.GetLinearVelocity().x/3+7*Math.cos(i*2*Math.PI/8),playerBox.body.GetLinearVelocity().y/3+7*Math.sin(i*2*Math.PI/8)));
			}
			playerBox.Kill();
			if(Game.soundIs && !ballDieSoundChannel) {
				ballDieSoundChannel=ballDieSound.play(0,1); 
				ballDieSoundChannel.soundTransform = transformDieSound;
				ballDieSoundChannel.addEventListener(Event.SOUND_COMPLETE, ballDieCompleteHandler);
			}
		}
		
		private function playerDieHandler(e:TimerEvent):void {
			isLose=true;
		}
		
		private function playerWinHandler(e:TimerEvent):void {
			isWin=true;
		}

		public function CreateBody(_name:String, _type:String, _density:Number, _friction:Number, _restruction:Number, _vertex:Array=null):b2Body {
			var currentSprite:Sprite=m_sprite.getChildByName(_name) as Sprite;
			var shape:Shape = new Shape();
			var currentBitmapData:BitmapData;

			var bodyDef:b2BodyDef;
			var newBody:b2Body;
			var polygonDef:b2PolygonDef;
			var circleDef:b2CircleDef;

			bodyDef = new b2BodyDef();
			bodyDef.position=new b2Vec2(currentSprite.x/m_physScale,currentSprite.y/m_physScale);
			bodyDef.angle = currentSprite.rotation*(Math.PI/180);
			bodyDef.userData=currentSprite;
			newBody=m_world.CreateBody(bodyDef);
						
			switch(_type) {
				case "Polygon":
				case "BluePolygon":
					for (var j:int=0; j<_vertex.length; j++) {
						polygonDef = new b2PolygonDef();
						polygonDef.vertexCount=_vertex[j].length;
		
						for (var i:int=0; i<polygonDef.vertexCount; i++) {
							polygonDef.vertices[i].Set(/*currentSprite.scaleX**/_vertex[j][i][0]/m_physScale,/*currentSprite.scaleY**/_vertex[j][i][1]/m_physScale);
						}
		
						polygonDef.density=_density;
						polygonDef.friction=_friction;
						polygonDef.restitution=_restruction;
		
						newBody.CreateShape(polygonDef);
					}
					break;
				case "Circle":
					circleDef = new b2CircleDef();
					circleDef.radius=_vertex[0]/m_physScale/2;
					circleDef.localPosition.Set(_vertex[0]/m_physScale/2,_vertex[0]/m_physScale/2);
					circleDef.density=_density;
					circleDef.friction=_friction;
					circleDef.restitution=_restruction;
					newBody.CreateShape(circleDef);
					break;
			}
			
			newBody.SetMassFromShapes();
			/*
			if(newBody.IsStatic()) currentBitmapData = brickBitmapData;
			else currentBitmapData = woodBitmapData;
						
			switch(_type) {
				case "Polygon":
				case "BluePolygon":
					while(currentSprite.numChildren>0) {
						currentSprite.removeChildAt(0);
					}
					for (var j:int=0; j<_vertex.length; j++) {
						shape = new Shape();
						if(_type=="BluePolygon") shape.graphics.lineStyle(2.0,0x0000FF,0.5);//shape.graphics.beginFill(0x0000FF,0.3);
						shape.graphics.beginBitmapFill(currentBitmapData);
						shape.graphics.moveTo(_vertex[j][0][0],_vertex[j][0][1]);
						for (var i:int=1; i<_vertex[j].length; i++) {
							shape.graphics.lineTo(_vertex[j][i][0],_vertex[j][i][1]);
						}
						shape.graphics.lineTo(_vertex[j][0][0],_vertex[j][0][1]);
						shape.graphics.endFill();
						currentSprite.addChild(shape);
					}
					break;
				case "Circle":
					shape = new Shape();
					shape.graphics.beginBitmapFill(currentBitmapData);
					shape.graphics.drawCircle(currentSprite.width/2,currentSprite.height/2,currentSprite.width/2)
					shape.graphics.endFill();
					while(currentSprite.numChildren>0) {
						currentSprite.removeChildAt(0);
					}
					currentSprite.addChild(shape);
					break;
			}
			*/
			return newBody;
		}
		
		public function DestroyBody(db:b2Body):void {
			db.m_userData.parent.removeChild(db.m_userData);
			m_world.DestroyBody(db);
		}

		public function Update(e:Event):void {
			m_sprite.graphics.clear();
			m_world.Step(m_timeStep, m_iterations);

			for (var bb:b2Body = m_world.m_bodyList; bb; bb = bb.m_next) {
				if (bb.m_userData is Sprite && ! bb.IsStatic()) {
					bb.m_userData.x=bb.GetPosition().x*m_physScale;
					bb.m_userData.y=bb.GetPosition().y*m_physScale;
					bb.m_userData.rotation = (bb.GetAngle() * (180/Math.PI)) % 360;
				}
			}
			
			m_joint.graphics.clear();
			m_joint.graphics.lineStyle(1,0x000000,1/1);
			for (var jj:b2Joint = m_world.m_jointList; jj; jj = jj.m_next){
				DrawJoint(jj);
			}
						
			var downIs:Boolean=GetBodyAtPoint(playerBox.body.GetPosition().x, playerBox.body.GetPosition().y+0.4,true);
			var downLeftIs:Boolean=GetBodyAtPoint(playerBox.body.GetPosition().x-0.2, playerBox.body.GetPosition().y+0.38,true);
			var downRightIs:Boolean=GetBodyAtPoint(playerBox.body.GetPosition().x+0.2, playerBox.body.GetPosition().y+0.38,true);
			var v0:b2Vec2=playerBox.body.GetLinearVelocity();
			
			if (Left) {
				playerBox.body.WakeUp();
				if (downIs || downLeftIs || downRightIs) {
					//if(v0.x<0) playerBox.body.SetLinearVelocity(new b2Vec2(v0.x-(0.5/(-v0.x+0.1)),v0.y));
					//else playerBox.body.SetLinearVelocity(new b2Vec2(v0.x-(0.5/(v0.x+0.1)),v0.y));
					if(playerBox.body.m_linearVelocity.x>-5) {
						playerBox.body.SetLinearVelocity(new b2Vec2(v0.x-0.5,v0.y));
					} 
				} else {
					if(playerBox.body.m_linearVelocity.x>-5/2) playerBox.body.SetLinearVelocity(new b2Vec2(v0.x-0.25,v0.y));
				}
			}
			
			if (Right) {
				playerBox.body.WakeUp();
				if (downIs || downLeftIs || downRightIs) {
					//if(v0.x>0) playerBox.body.SetLinearVelocity(new b2Vec2(v0.x+(0.5/(v0.x+0.1)),v0.y));
					//else playerBox.body.SetLinearVelocity(new b2Vec2(v0.x+(0.5/(-v0.x+0.1)),v0.y));
					if(playerBox.body.m_linearVelocity.x<5) {
						playerBox.body.SetLinearVelocity(new b2Vec2(v0.x+0.5,v0.y));
					} 
				} else {
					if(playerBox.body.m_linearVelocity.x<5/2) playerBox.body.SetLinearVelocity(new b2Vec2(v0.x+0.25,v0.y));
				}
			}
			
			if (Up) {  
				playerBox.body.WakeUp();
				if (myContactListener.playerContactBodies.length>0 && (downIs || downLeftIs || downRightIs)) {
					playerBox.body.ApplyForce(new b2Vec2(0.0, -65.0), playerBox.body.GetWorldCenter());
					if(Game.soundIs && !ballJumpSoundChannel) {
						ballJumpSoundChannel=ballJumpSound.play(0,1); 
						ballJumpSoundChannel.addEventListener(Event.SOUND_COMPLETE, ballJumpCompleteHandler);
					}
				} else  if(playerBox.body.m_linearVelocity.y<0) {
					playerBox.body.ApplyForce(new b2Vec2(0.0, -1), playerBox.body.GetWorldCenter());
				}
			}
			
			/*if(Down) {
				if (downIs) playerBox.body.SetLinearVelocity(new b2Vec2(playerBox.body.GetLinearVelocity().x/1.5,0));
			}*/
			
			Tweener.addTween(m_sprite, {x:m_sprite.scaleX*(-playerBox.x+Game.stageWidth/2), y:m_sprite.scaleY*(-playerBox.y+Game.stageHeight/2), time:1, transition:"easeOutExpo"});
			
			backGround.x=-m_sprite.x/10+backGroundStartPosition.x;
			backGround.y=-m_sprite.y/10+backGroundStartPosition.y;
			
			
			/*if (playerBox.x+m_sprite.x<175) {
				m_sprite.x=+(175-playerBox.x);
			}
			if (playerBox.x+m_sprite.x>375) {
				m_sprite.x=-(playerBox.x-375);
			}
			if (playerBox.y+m_sprite.y<150) {
				m_sprite.y=+(150-playerBox.y);
			}
			if (playerBox.y+m_sprite.y>250) {
				m_sprite.y=-(playerBox.y-250);
			}*/
			
			//playerBox.body.m_sweep.a = 0;

			if (playerBox.hitTestObject(levelAim) && levelAim.currentFrame==1) {
				if(Game.soundIs && !levelSoundChannel) {
					levelSoundChannel=levelSound.play(0,1); 
					levelSoundChannel.soundTransform = transformLevelSound;
					levelSoundChannel.addEventListener(Event.SOUND_COMPLETE, levelSoundCompleteHandler);
				}	
				PlayerWin();
			}
			if(levelAim.currentFrame==20) levelAim.stop();
			
			for(var i:int=0;i<m_sprite.numChildren;i++) {
				var currentSprite=m_sprite.getChildAt(i);
				if((currentSprite is Shipik) || (currentSprite is Ships10)) {
					if(playerBox.HitTestObjectControlPoints(currentSprite)) {
						if(playerBox.IsLive()) PlayerDie();
					}
				}
			}
			
			for(var i:int=0;i<5;i++) {
				if(checkPoints[i] && playerBox.hitTestObject(checkPoints[i]) && checkPoints[i].currentFrame==1) {
					if(i>lastCheckNum) {
						lastCheckNum=i;
						playerStartPosition=new Point(checkPoints[i].x,checkPoints[i].y);
						/*if(!checkPointSoundChannel) {
							checkPointSoundChannel=checkPointSound.play(0,1); 
							checkPointSoundChannel.addEventListener(Event.SOUND_COMPLETE, checkPointCompleteHandler);
						}	*/
					} 
					checkPoints[i].play();
				}
				if(checkPoints[i] && checkPoints[i].currentFrame==5) checkPoints[i].stop();
			}
		}
		
		private function ballJumpCompleteHandler(e:Event):void {
			ballJumpSoundChannel=null;
		}
		
		private function ballDieCompleteHandler(e:Event):void {
			ballDieSoundChannel=null;
		}
				
		private function levelSoundCompleteHandler(e:Event):void {
			levelSoundChannel=null;
		}
		
		private function scaleTimerHandler(e:TimerEvent):void {
			var scaleVel=0.001*Math.pow(playerBox.body.GetLinearVelocity().Length(),2);
			Tweener.addTween(m_sprite, {scaleX:1-scaleVel, scaleY:1-scaleVel, time:1, transition:"easeInQuint"});
		}

		private function KeyDownHandler(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.LEFT :
				case /*A*/65:
					Left=true;
					break;
				case Keyboard.RIGHT :
				case /*D*/68:
					Right=true;
					break;
				case Keyboard.UP :
				case /*W*/87:
					Up=true;
					break;
			}
		}

		private function KeyUpHandler(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.LEFT :
				case /*A*/65:
					Left=false;
					break;
				case Keyboard.RIGHT :
				case /*D*/68:
					Right=false;
					break;
				case Keyboard.UP :
				case /*W*/87:
					Up=false;
					break;
				/*case Keyboard.DOWN:
					Down=false;
					break;*/
			}
		}

		public function GetBodyAtPoint(_x:Number, _y:Number, includeStatic:Boolean=false):b2Body {
			var mousePVec:b2Vec2 = new b2Vec2(_x, _y);
			var aabb:b2AABB = new b2AABB();
			aabb.lowerBound.Set(_x - 0.001, _y - 0.001);
			aabb.upperBound.Set(_x + 0.001, _y + 0.001);

			var k_maxCount:int=10;
			var shapes:Array = new Array();
			var count:int=m_world.Query(aabb,shapes,k_maxCount);
			var body:b2Body=null;
			for (var i:int = 0; i < count; ++i) {
				if (shapes[i].GetBody().IsStatic()==false||includeStatic) {
					var tShape:b2Shape=shapes[i] as b2Shape;
					var inside:Boolean=tShape.TestPoint(tShape.GetBody().GetXForm(),mousePVec);
					if (inside) {
						body=tShape.GetBody();
						break;
					}
				}
			}
			return body;
		}
		
		public function DrawJoint(joint:b2Joint):void
		{
			var b1:b2Body = joint.m_body1;
			var b2:b2Body = joint.m_body2;
			
			var x1:b2Vec2 = b1.GetPosition();
			var x2:b2Vec2 = b2.GetPosition();
			var p1:b2Vec2 = joint.GetAnchor1();
			var p2:b2Vec2 = joint.GetAnchor2();
						
			switch (joint.m_type)
			{
				case b2Joint.e_distanceJoint:
					m_joint.graphics.moveTo(p1.x * m_physScale, p1.y * m_physScale);
					m_joint.graphics.lineTo(p2.x * m_physScale, p2.y * m_physScale);
					break;
				case b2Joint.e_revoluteJoint:
					/*var pointShape:Shape=new Shape();
					pointShape.graphics.lineStyle(1,0xFFFFFF,1);
					pointShape.graphics.drawCircle(1,1,2);
					pointShape.x=p1.x;
					pointShape.y=p1.y;
					b1.m_userData.addChildAt(pointShape,0);*/
					break;
				/*case b2Joint.e_pulleyJoint:
					var pulley:b2PulleyJoint = joint as b2PulleyJoint;
					var s1:b2Vec2 = pulley.GetGroundAnchor1();
					var s2:b2Vec2 = pulley.GetGroundAnchor2();
					m_sprite.graphics.moveTo(s1.x * m_physScale, s1.y * m_physScale);
					m_sprite.graphics.lineTo(p1.x * m_physScale, p1.y * m_physScale);
					m_sprite.graphics.moveTo(s2.x * m_physScale, s2.y * m_physScale);
					m_sprite.graphics.lineTo(p2.x * m_physScale, p2.y * m_physScale);
					break;*/
			}
		}
	}
}