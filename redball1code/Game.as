package {
	import flash.display.*;
	import flash.events.*; 
	import flash.net.SharedObject;
	import flash.media.*;
	
	import Levels.*;

	public class Game extends Sprite {	
		private var m_currId:int=1;
		public var m_currLevel:Level;
				
		public static const stageWidth:Number=550;
		public static const stageHeight:Number=400;
		
		private var pause:Boolean;
		private var pauseTextField:TextField;
		private var quitSprite:Sprite;
		
		private var gameLoop1:GameLoop1 = new GameLoop1();
		private var gameLoop1Channel:SoundChannel;
		private var transformGameLoop1:SoundTransform = new SoundTransform(1, 0);
		
		public static var soundIs:Boolean=true;
		private var beforePauseSoundIs:Boolean;
		private var wasInPause:Boolean;
		private var loopPosition:Number=0;
										
		public function Game() {		
			m_currId=Preloader.startLevelNum;
			SetLevel(m_currId);
			addEventListener(Event.ENTER_FRAME,Update);
			Preloader.stageLink.addEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
			
			pauseTextField=getChildByName("pauseText") as TextField;
			pauseTextField.visible=false;
			quitSprite=getChildByName("quitText") as Sprite;
			quitSprite.visible=false;
			
			addEventListener(Event.DEACTIVATE,deactivateHandler);
			addEventListener(Event.ACTIVATE,activateHandler);
			
			SetSound(Game.soundIs);
			soundCheck.addEventListener(MouseEvent.CLICK,onCheckSoundHandler);
		}
		
		private function onCheckSoundHandler(e:MouseEvent):void {
			if(!pause) {
				soundIs=!soundIs;
				SetSound(soundIs);
			}
		}
		
		private function SetSound(_soundIs:Boolean):void {
			soundIs=_soundIs;
			if(soundIs) {
				soundCheck.gotoAndStop(1);
				gameLoop1Channel = gameLoop1.play(loopPosition,int.MAX_VALUE,transformGameLoop1);
			} else {
				soundCheck.gotoAndStop(2);
				if(gameLoop1Channel) {
					loopPosition = gameLoop1Channel.position;
					gameLoop1Channel.stop();
				}
			}
		}
				
		private function deactivateHandler(e:Event):void {
			if(!quitSprite.visible) {
				if(!pause) SetPause(true);
				else wasInPause=true;
			}
		}
		
		private function activateHandler(e:Event):void {
			if(!quitSprite.visible) {
				if(!wasInPause) SetPause(false);
			}
		}
		
		public function SetLevel(n:int):void {
			if(m_currLevel) removeChild(m_currLevel);
			m_currId=n;
			if(!Preloader.mySo.data.levelsAvaiable || Preloader.mySo.data.levelsAvaiable<m_currId) {
				Preloader.mySo.data.levelsAvaiable=m_currId;
				Preloader.mySo.flush(100);
				Preloader.levelsAvaiable=m_currId;
			}
			
			/*var levelClass:Class = loaderInfo.applicationDomain.getDefinition("Level_"+m_currId.toString()) as Class;
			m_currLevel = new levelClass();*/
						
			switch(m_currId) {
				case 1:
					m_currLevel=new Level_1();
					break;
				case 2:
					m_currLevel=new Level_2();
					break;
				case 3:
					m_currLevel=new Level_3();
					break;
				case 4:
					m_currLevel=new Level_4();
					break;
				case 5:
					m_currLevel=new Level_5();
					break;
				case 6:
					m_currLevel=new Level_6();
					break;
				case 7:
					m_currLevel=new Level_7();
					break;
				case 8:
					m_currLevel=new Level_8();
					break;
				case 9:
					m_currLevel=new Level_9();
					break;
				case 10:
					m_currLevel=new Level_10();
					break;
				case 11:
					m_currLevel=new Level_11();
					break;
				case 12:
					m_currLevel=new Level_12();
					break;
			}
			addChildAt(m_currLevel,0);
		}
		
		private function Update(e:Event):void {
			m_currLevel.Update(e);
			
			if(m_currLevel.Win()) {
				m_currId++;
				Level.lastCheckNum=0;
				if(m_currId<13) {
					SetLevel(m_currId);
				} else {
					ExitGame();
				}
			}
			
			if(m_currLevel.Lose()) {
				SetLevel(m_currId);
			}
		}
		
		private function KeyDownHandler(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case /*P*/80:
					if(!quitSprite.visible) {
						pause=!pause;
						SetPause(pause);
					}
					break;
				case /*R*/82:
					if(!pause) SetLevel(m_currId);
					break;
				case /*ESC*/27:
					if(!pause) {
						if(!quitSprite.visible) {
							m_currLevel.OutControl();
							removeEventListener(Event.ENTER_FRAME,Update);
							m_currLevel.alpha=.5;
							this.setChildIndex(quitSprite,this.numChildren-1);
							quitSprite.visible=true;
						}
						else {
							m_currLevel.SetControl();
							addEventListener(Event.ENTER_FRAME,Update);
							m_currLevel.alpha=1;
							quitSprite.visible=false;
						}
					}
					break;
				case /*Y*/89:
					if(quitSprite.visible) {
						ExitGame();
					}
					break;
				case /*N*/78:
					if(quitSprite.visible) {
						m_currLevel.SetControl();
						addEventListener(Event.ENTER_FRAME,Update);
						m_currLevel.alpha=1;
						quitSprite.visible=false;
					}
					break;
			}
		}
		
		private function SetPause(_pause:Boolean):void {
			pause=_pause;
			if(pause) {
				m_currLevel.OutControl();
				removeEventListener(Event.ENTER_FRAME,Update);
				m_currLevel.alpha=.5;
				this.setChildIndex(pauseTextField,this.numChildren-1);
				pauseTextField.visible=true;
				beforePauseSoundIs=soundIs;
				SetSound(false);
			} else {
				m_currLevel.SetControl();
				addEventListener(Event.ENTER_FRAME,Update);
				m_currLevel.alpha=1;
				this.setChildIndex(pauseTextField,this.numChildren-1);
				pauseTextField.visible=false;
				SetSound(beforePauseSoundIs);
				wasInPause=false;
			}
		}
		
		private function ExitGame():void {
			if(m_currLevel) removeChild(m_currLevel);
			gameLoop1Channel.stop();
			Level.lastCheckNum=0;
			Level_7.redCheckLevel=false;
			removeEventListener(Event.DEACTIVATE,deactivateHandler);
			removeEventListener(Event.ACTIVATE,activateHandler);
			removeEventListener(Event.ENTER_FRAME,Update);
			Preloader.stageLink.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDownHandler);
			(this.parent as MovieClip).gotoAndStop("menu_main");
		}
	}
}