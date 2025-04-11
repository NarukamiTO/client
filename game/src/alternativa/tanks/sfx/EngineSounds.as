package alternativa.tanks.sfx {
  import alternativa.math.Vector3;
  import flash.events.Event;
  import flash.media.Sound;
  import flash.media.SoundChannel;

  public class EngineSounds {
    public static const SILENT:int = 0;
    public static const IDLE:int = 1;
    public static const ACCELERATING:int = 2;
    public static const MOVING:int = 3;
    public static const TURNING:int = 4;

    private static const FADE_SPEED:Number = 0.001;
    private static const MP3_BEGINNING_GAP:int = 80;

    private var mode:int = 0;
    private var currentSound3D:Sound3D;
    private var idleSound3D:Sound3D;
    private var accelerationSound3D:Sound3D;
    private var movingSound3D:Sound3D;
    private var channel:SoundChannel;
    private var fading:Boolean;
    private var fadeLimit:Number = 1;

    public function EngineSounds(param1:Sound, param2:Sound, param3:Sound) {
      super();
      var local4:Number = 1;
      this.idleSound3D = Sound3D.create(param1,2);
      this.accelerationSound3D = Sound3D.create(param2,local4);
      this.movingSound3D = Sound3D.create(param3,local4);
      this.currentSound3D = this.idleSound3D;
    }

    public function update(param1:int, param2:Vector3, param3:Vector3, param4:Vector3) : void {
      if(this.mode != SILENT) {
        if(this.fading) {
          this.currentSound3D.volume -= FADE_SPEED * param1;
          if(this.currentSound3D.volume < this.fadeLimit) {
            this.fading = false;
            this.stop();
            this.currentSound3D = this.idleSound3D;
            this.currentSound3D.volume = this.mode == IDLE ? 2 : 3;
            this.currentSound3D.play(MP3_BEGINNING_GAP,10000);
          }
        }
        this.currentSound3D.checkVolume(param2,param3,param4);
      }
    }

    public function setSilentMode() : void {
      if(this.mode != SILENT) {
        this.mode = SILENT;
        this.stop();
      }
    }

    public function setIdleMode() : void {
      if(this.mode != IDLE) {
        if(this.mode == SILENT) {
          this.currentSound3D = this.idleSound3D;
          this.currentSound3D.volume = 1;
          this.currentSound3D.play(MP3_BEGINNING_GAP,1000);
        } else if(this.currentSound3D != this.idleSound3D) {
          this.fading = true;
          this.fadeLimit = 0.2;
        }
        this.mode = IDLE;
      }
    }

    public function setAccelerationMode() : void {
      if(this.mode == ACCELERATING || this.mode == MOVING) {
        return;
      }
      this.fading = false;
      this.mode = ACCELERATING;
      this.currentSound3D.stop();
      this.currentSound3D = this.accelerationSound3D;
      this.currentSound3D.volume = 1;
      this.channel = this.currentSound3D.play(0,0);
      if(this.channel != null) {
        this.channel.addEventListener(Event.SOUND_COMPLETE,this.soundComplete);
      }
    }

    public function setTurningMode() : void {
      if(this.mode != TURNING) {
        if(this.mode == IDLE) {
          if(!this.fading) {
            this.currentSound3D.volume = 3;
          }
        } else {
          this.fading = true;
        }
        this.fadeLimit = 0.6;
        this.mode = TURNING;
      }
    }

    public function stop() : void {
      if(this.channel != null) {
        this.channel.removeEventListener(Event.SOUND_COMPLETE,this.soundComplete);
        this.channel = null;
      }
      this.currentSound3D.stop();
    }

    public function destroy() : void {
      this.stop();
      Sound3D.destroy(this.idleSound3D);
      this.idleSound3D = null;
      Sound3D.destroy(this.accelerationSound3D);
      this.accelerationSound3D = null;
      Sound3D.destroy(this.movingSound3D);
      this.movingSound3D = null;
    }

    private function soundComplete(param1:Event) : void {
      if(this.channel == null || this.mode != ACCELERATING) {
        return;
      }
      this.channel.removeEventListener(Event.SOUND_COMPLETE,this.soundComplete);
      this.mode = MOVING;
      this.movingSound3D.volume = this.accelerationSound3D.volume;
      this.currentSound3D = this.movingSound3D;
      this.currentSound3D.play(MP3_BEGINNING_GAP,1000);
    }
  }
}
