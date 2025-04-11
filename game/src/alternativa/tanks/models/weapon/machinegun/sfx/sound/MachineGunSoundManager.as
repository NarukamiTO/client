package alternativa.tanks.models.weapon.machinegun.sfx.sound {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunSFXData;
  import alternativa.tanks.sfx.ISound3DEffect;
  import alternativa.tanks.sfx.ISoundEffectDestructionListener;
  import alternativa.tanks.sfx.MobileSound3DEffect;
  import alternativa.tanks.sfx.Sound3D;
  import flash.media.Sound;

  public class MachineGunSoundManager implements ISoundEffectDestructionListener {
    [Inject]
    public static var battleService:BattleService;

    private static const INACTIVE_STATE:int = 0;
    private static const BEGIN_STATE:int = 1;
    private static const SHOOT_STATE:int = 2;
    private static const END_STATE:int = 3;
    private static const END_FAIL_STATE:int = 4;
    private static const VOLUME:Number = 0.7;
    private static const START_SOUND_START_TIME:int = 115;
    private static const BEGIN_SOUND_LENGTH:int = 3520;
    private static const SHOOT_SOUND_START_TIME:int = 80;
    private static const END_SOUND_START_TIME:int = 100;
    private static const END_FAIL_SOUND_START_TIME:int = 27;

    private var _currentState:int = 0;
    private var _turret:Object3D;
    private var _chainStartSound:Sound;
    private var _turbineStartSound:Sound;
    private var _shootSound:Sound;
    private var _shootEndSound:Sound;
    private var _longFailSound:Sound;
    private var hitSound3d:Sound3D;
    private var tankHitSound3d:Sound3D;
    private var _currentSoundEffect:MobileSound3DEffect;
    private var hitSoundEffect:MachineGunHitSoundEffect;
    private var _barrelAccelTime:Number;
    private var barrelTime:int;

    public function MachineGunSoundManager(param1:Object3D, param2:MachineGunSFXData, param3:Number) {
      super();
      this._turret = param1;
      this._chainStartSound = param2.chainStartSound;
      this._turbineStartSound = param2.turbineStartSound;
      this._shootSound = param2.shootSound;
      this._shootEndSound = param2.shootEndSound;
      this._longFailSound = param2.longFailSound;
      this.hitSound3d = this.createSound3D(param2.hitSound);
      this.tankHitSound3d = this.createSound3D(param2.tankHitSound);
      this._barrelAccelTime = param3;
    }

    public function playBeginSound(param1:int) : void {
      var local2:MobileSound3DEffect = null;
      var local3:Sound3D = null;
      if(this._currentState != BEGIN_STATE) {
        this._currentState = BEGIN_STATE;
        this.createSoundEffect(this._turbineStartSound,BEGIN_SOUND_LENGTH - this._barrelAccelTime);
        local2 = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
        local3 = Sound3D.create(this._chainStartSound,VOLUME);
        local2.init(local3,this._turret,0,0,START_SOUND_START_TIME);
        battleService.addSound3DEffect(local2);
      }
      this.barrelTime = param1;
    }

    public function playShootSound() : void {
      if(this._currentState != SHOOT_STATE) {
        this._currentState = SHOOT_STATE;
        this.createSoundEffect(this._shootSound,SHOOT_SOUND_START_TIME,1000000);
      }
    }

    public function playEndSound() : void {
      if(this._currentState != END_STATE) {
        this._currentState = END_STATE;
        this.createSoundEffect(this._shootEndSound,END_SOUND_START_TIME);
      }
    }

    public function playEndFailSound(param1:int) : void {
      if(this._currentState != END_FAIL_STATE) {
        this._currentState = END_FAIL_STATE;
        this.createSoundEffect(this._longFailSound,this._barrelAccelTime - this.barrelTime + END_FAIL_SOUND_START_TIME,0,param1);
      }
    }

    public function stopSound() : void {
      if(this._currentState != INACTIVE_STATE) {
        this._currentState = INACTIVE_STATE;
        this.killCurrentSound();
      }
    }

    private function createSoundEffect(param1:Sound, param2:int, param3:int = 0, param4:int = 0) : void {
      this.killCurrentSound();
      this._currentSoundEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
      var local5:Sound3D = this.createSound3D(param1);
      this._currentSoundEffect.init(local5,this._turret,0,param3,param2,this);
      battleService.addSound3DEffect(this._currentSoundEffect);
      if(param4 > 0) {
        this._currentSoundEffect.fade(param4);
      }
    }

    public function playHitSound(param1:Vector3, param2:Boolean) : void {
      if(this.hitSoundEffect == null) {
        this.hitSoundEffect = MachineGunHitSoundEffect(battleService.getObjectPool().getObject(MachineGunHitSoundEffect));
        this.hitSoundEffect.init(this.hitSound3d,this.tankHitSound3d);
        battleService.addSound3DEffect(this.hitSoundEffect);
      }
      this.hitSoundEffect.setTarget(param1,param2);
    }

    public function destroy() : void {
      this.killCurrentSound();
      this.destroyHitSounds();
      this._chainStartSound = null;
      this._turbineStartSound = null;
      this._shootSound = null;
      this._shootEndSound = null;
      this._longFailSound = null;
      this._turret = null;
    }

    private function destroyHitSounds() : void {
      this.stopHitSounds();
      Sound3D.destroy(this.hitSound3d);
      Sound3D.destroy(this.tankHitSound3d);
      this.hitSound3d = null;
      this.tankHitSound3d = null;
    }

    public function stopHitSounds() : void {
      if(this.hitSoundEffect != null) {
        this.hitSoundEffect.kill();
        this.hitSoundEffect = null;
      }
    }

    public function onSoundEffectDestroyed(param1:ISound3DEffect) : void {
      if(this._currentSoundEffect == param1) {
        this._currentSoundEffect = null;
      }
    }

    private function createSound3D(param1:Sound) : Sound3D {
      return Sound3D.create(param1,VOLUME);
    }

    private function killCurrentSound() : void {
      if(this._currentSoundEffect != null) {
        this._currentSoundEffect.kill();
        this._currentSoundEffect = null;
      }
    }
  }
}
