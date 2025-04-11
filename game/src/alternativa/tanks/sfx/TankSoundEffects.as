package alternativa.tanks.sfx {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.camera.GameCamera;
  import flash.events.Event;
  import flash.media.Sound;
  import flash.media.SoundChannel;

  public class TankSoundEffects implements ISound3DEffect {
    private static const _tankPosition:Vector3 = new Vector3();

    private var _tank:Tank;
    private var engineSounds:EngineSounds;
    private var turretSound:Sound3D;
    private var _engineMode:int = 1;
    private var _enabled:Boolean = false;
    private var _turretSoundEnabled:Boolean;

    public function TankSoundEffects(param1:Sound, param2:Sound, param3:Sound, param4:Sound) {
      super();
      this.engineSounds = new EngineSounds(param1,param2,param3);
      this.turretSound = Sound3D.create(param4,0.5,500,2000,5);
    }

    public function setIdleMode() : void {
      this._engineMode = EngineSounds.IDLE;
      if(this._enabled) {
        this.engineSounds.setIdleMode();
      }
    }

    public function setAccelerationMode() : void {
      this._engineMode = EngineSounds.ACCELERATING;
      if(this._enabled) {
        this.engineSounds.setAccelerationMode();
      }
    }

    public function setTurningMode() : void {
      this._engineMode = EngineSounds.TURNING;
      if(this._enabled) {
        this.engineSounds.setTurningMode();
      }
    }

    public function setTank(param1:Tank) : void {
      this._tank = param1;
    }

    public function playTurretSound(param1:Boolean) : void {
      var local2:SoundChannel = null;
      if(this._enabled) {
        if(param1 && this._turretSoundEnabled) {
          if(!this.turretSound.isPlaying()) {
            local2 = this.turretSound.play(100,0);
            if(local2 != null) {
              local2.addEventListener(Event.SOUND_COMPLETE,this.onTurretSoundComplete);
            }
          }
        } else if(this.turretSound.isPlaying()) {
          this.turretSound.stop();
        }
      }
    }

    private function onTurretSoundComplete(param1:Event) : void {
      if(this._turretSoundEnabled) {
        this.turretSound.play(3000,9999);
      }
    }

    public function set turretSoundEnabled(param1:Boolean) : void {
      if(this._turretSoundEnabled != param1) {
        this._turretSoundEnabled = param1;
        if(!this._turretSoundEnabled) {
          this.turretSound.stop();
        }
      }
    }

    public function play(param1:int, param2:GameCamera) : void {
      if(this._tank != null && this._enabled) {
        _tankPosition.copy(this._tank.getBody().state.position);
        this.engineSounds.update(param1,param2.position,_tankPosition,param2.xAxis);
        this.turretSound.checkVolume(param2.position,_tankPosition,param2.xAxis);
      }
    }

    public function destroy() : void {
      this.engineSounds.stop();
      this.turretSound.stop();
    }

    public function kill() : void {
    }

    public function get numSounds() : int {
      return 2;
    }

    public function readPosition(param1:Vector3) : void {
      param1.copy(this._tank.getBody().state.position);
    }

    public function set enabled(param1:Boolean) : void {
      if(this._enabled != param1) {
        this._enabled = param1;
        this.updateSounds();
      }
    }

    private function updateSounds() : void {
      if(this._enabled) {
        switch(this._engineMode) {
          case EngineSounds.IDLE:
            this.engineSounds.setIdleMode();
            break;
          case EngineSounds.ACCELERATING:
            this.engineSounds.setAccelerationMode();
            break;
          case EngineSounds.TURNING:
            this.engineSounds.setTurningMode();
        }
      } else {
        this.turretSound.stop();
        this.engineSounds.setSilentMode();
      }
    }
  }
}
