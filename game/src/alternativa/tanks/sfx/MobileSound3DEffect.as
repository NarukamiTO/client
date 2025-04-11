package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.events.Event;
  import flash.media.SoundChannel;

  public class MobileSound3DEffect extends PooledObject implements ISound3DEffect {
    private static const soundPosition:Vector3 = new Vector3();

    private var sound:Sound3D;
    private var playbackDelay:int;
    private var startTime:int;
    private var loops:int;
    private var object:Object3D;
    private var channel:SoundChannel;
    private var alive:Boolean;
    private var time:int;
    private var actualVolume:Number;
    private var volumeFadeSpeed:Number;
    private var listener:ISoundEffectDestructionListener;

    public function MobileSound3DEffect(param1:Pool) {
      super(param1);
    }

    public function shortInit(param1:Sound3D, param2:Object3D, param3:ISoundEffectDestructionListener = null) : void {
      this.init(param1,param2,0,1,0,param3);
    }

    public function init(param1:Sound3D, param2:Object3D, param3:int = 0, param4:int = 1, param5:int = 0, param6:ISoundEffectDestructionListener = null) : void {
      this.sound = param1;
      this.object = param2;
      this.playbackDelay = param3;
      this.loops = param4;
      this.startTime = param5;
      this.listener = param6;
      this.alive = true;
      this.time = 0;
      this.actualVolume = param1.volume;
      this.volumeFadeSpeed = 0;
    }

    public function play(param1:int, param2:GameCamera) : void {
      if(!this.alive) {
        return;
      }
      if(this.time < this.playbackDelay) {
        this.time += param1;
        return;
      }
      if(!this.sound.isPlaying()) {
        this.channel = this.sound.play(this.startTime,this.loops);
        if(this.channel != null) {
          this.channel.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
        }
      }
      soundPosition.x = this.object.x;
      soundPosition.y = this.object.y;
      soundPosition.z = this.object.z;
      if(this.volumeFadeSpeed > 0) {
        this.actualVolume -= this.volumeFadeSpeed * param1;
        if(this.actualVolume <= 0) {
          this.volumeFadeSpeed = 0;
          this.actualVolume = 0;
        }
        this.sound.volume = this.actualVolume;
      }
      this.sound.checkVolume(param2.position,soundPosition,param2.xAxis);
    }

    public function destroy() : void {
      this.removeListenerAndStopSound();
      Sound3D.destroy(this.sound);
      this.object = null;
      this.sound = null;
      if(this.listener != null) {
        this.listener.onSoundEffectDestroyed(this);
        this.listener = null;
      }
      recycle();
    }

    public function kill() : void {
      this.alive = false;
    }

    public function set enabled(param1:Boolean) : void {
      if(!param1) {
        this.removeListenerAndStopSound();
      }
    }

    public function readPosition(param1:Vector3) : void {
      param1.x = this.object.x;
      param1.y = this.object.y;
      param1.z = this.object.z;
    }

    public function get numSounds() : int {
      return this.alive ? 1 : 0;
    }

    public function fade(param1:int) : void {
      this.volumeFadeSpeed = this.actualVolume / param1;
    }

    private function onSoundComplete(param1:Event) : void {
      this.removeListenerAndStopSound();
      this.alive = false;
    }

    private function removeListenerAndStopSound() : void {
      if(this.channel != null) {
        this.channel.removeEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
        this.channel = null;
      }
      this.sound.stop();
      if(this.loops <= 1) {
        this.alive = false;
      }
    }
  }
}
