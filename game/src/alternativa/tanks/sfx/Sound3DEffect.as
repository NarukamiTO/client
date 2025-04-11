package alternativa.tanks.sfx {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.events.Event;
  import flash.media.SoundChannel;

  public class Sound3DEffect extends PooledObject implements ISound3DEffect {
    [Inject]
    public static var battleService:BattleService;

    private var position:Vector3 = new Vector3();
    private var sound:Sound3D;
    private var playbackDelay:int;
    private var startTime:int;
    private var channel:SoundChannel;
    private var _enabled:Boolean = false;
    private var _playing:Boolean = false;
    private var listener:ISoundEffectDestructionListener;

    public function Sound3DEffect(param1:Pool) {
      super(param1);
    }

    public static function create(param1:Vector3, param2:Sound3D, param3:int = 0, param4:int = 0, param5:ISoundEffectDestructionListener = null) : Sound3DEffect {
      var local6:Sound3DEffect = Sound3DEffect(battleService.getObjectPool().getObject(Sound3DEffect));
      local6.init(param1,param2,param3,param4,param5);
      return local6;
    }

    public function init(param1:Vector3, param2:Sound3D, param3:int = 0, param4:int = 0, param5:ISoundEffectDestructionListener = null) : void {
      this.position.copy(param1);
      this.sound = param2;
      this.playbackDelay = param3;
      this.startTime = param4;
      this.listener = param5;
      this._enabled = false;
      this._playing = false;
    }

    public function play(param1:int, param2:GameCamera) : void {
      this.playbackDelay -= param1;
      if(this.playbackDelay > 0) {
        return;
      }
      if(!this._playing) {
        this._playing = true;
        this.channel = this.sound.play(this.startTime,1);
        if(this.channel == null) {
          return;
        }
        this.channel.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
      }
      this.sound.checkVolume(param2.position,this.position,param2.xAxis);
    }

    public function destroy() : void {
      Sound3D.destroy(this.sound);
      this.sound = null;
      this.onSoundComplete(null);
      if(this.listener != null) {
        this.listener.onSoundEffectDestroyed(this);
        this.listener = null;
      }
      recycle();
    }

    public function kill() : void {
      this._enabled = false;
    }

    public function set enabled(param1:Boolean) : void {
      if(this._enabled == param1) {
        return;
      }
      if(!(this._enabled = param1)) {
        this.onSoundComplete(null);
      }
    }

    public function readPosition(param1:Vector3) : void {
      param1.x = this.position.x;
      param1.y = this.position.y;
      param1.z = this.position.z;
    }

    public function get numSounds() : int {
      return this._enabled ? 1 : 0;
    }

    private function onSoundComplete(param1:Event) : void {
      if(this.channel != null) {
        this.channel.removeEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
      }
      this._enabled = false;
      this.channel = null;
    }
  }
}
