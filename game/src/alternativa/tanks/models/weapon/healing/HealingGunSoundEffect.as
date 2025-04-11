package alternativa.tanks.models.weapon.healing {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.ISound3DEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.media.Sound;
  import flash.media.SoundChannel;
  import flash.media.SoundTransform;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisState;

  public class HealingGunSoundEffect extends PooledObject implements ISound3DEffect {
    private static const NUM_LOOPS:int = 100000;
    private static const NEAR_RADIUS:Number = 1000;
    private static const FAR_RADIUS:Number = 2000;
    private static const FAR_DELIMITER:Number = 2;
    private static const BASE_VOLUME:Number = 1;
    private static const MP3_BEGINNING_GAP:int = 200;
    private static const position:Vector3 = new Vector3();

    private var sfxData:HealingGunSFXData;
    private var object:Object3D;
    private var _type:IsisState;
    private var _enabled:Boolean;
    private var dead:Boolean;
    private var currentSound3D:Sound3D;
    private var soundChannel:SoundChannel;

    public function HealingGunSoundEffect(param1:Pool) {
      super(param1);
    }

    public function init(param1:HealingGunSFXData, param2:Object3D) : void {
      this.sfxData = param1;
      this.object = param2;
      this._type = IsisState.OFF;
      this.dead = false;
      this._enabled = false;
    }

    public function set type(param1:IsisState) : void {
      if(this._type != param1) {
        this._type = param1;
        this.changeSound();
      }
    }

    public function set enabled(param1:Boolean) : void {
      if(this._enabled != param1) {
        this._enabled = param1;
        if(!this._enabled) {
          this.currentSound3D.stop();
          this.soundChannel = null;
        }
      }
    }

    public function play(param1:int, param2:GameCamera) : void {
      if(!this.dead) {
        if(this.soundChannel == null) {
          this.soundChannel = this.currentSound3D.play(MP3_BEGINNING_GAP,NUM_LOOPS);
        }
        position.x = this.object.x;
        position.y = this.object.y;
        position.z = this.object.z;
        this.currentSound3D.checkVolume(param2.position,position,param2.xAxis);
      }
    }

    public function readPosition(param1:Vector3) : void {
      param1.x = this.object.x;
      param1.y = this.object.y;
      param1.z = this.object.z;
    }

    public function destroy() : void {
      if(this.currentSound3D != null) {
        Sound3D.destroy(this.currentSound3D);
        this.currentSound3D = null;
        this.soundChannel = null;
      }
      this.sfxData = null;
      this.object = null;
      recycle();
    }

    public function get numSounds() : int {
      return this.dead ? 0 : 1;
    }

    public function kill() : void {
      this.dead = true;
    }

    private function changeSound() : void {
      var local1:SoundTransform = null;
      if(this.soundChannel != null) {
        local1 = this.soundChannel.soundTransform;
        this.soundChannel = null;
      }
      if(this.currentSound3D != null) {
        Sound3D.destroy(this.currentSound3D);
      }
      var local2:Sound = this.getSound();
      this.currentSound3D = Sound3D.create(local2,BASE_VOLUME,NEAR_RADIUS,FAR_RADIUS,FAR_DELIMITER);
      if(local1 != null) {
        this.soundChannel = this.currentSound3D.play(MP3_BEGINNING_GAP,NUM_LOOPS);
        if(this.soundChannel != null) {
          this.soundChannel.soundTransform = local1;
        }
      }
    }

    private function getSound() : Sound {
      switch(this._type) {
        case IsisState.IDLE:
          return this.sfxData.idleSound;
        case IsisState.HEALING:
          return this.sfxData.healSound;
        case IsisState.DAMAGING:
          return this.sfxData.damageSound;
        default:
          throw new Error();
      }
    }
  }
}
