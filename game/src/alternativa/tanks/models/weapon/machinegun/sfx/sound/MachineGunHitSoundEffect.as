package alternativa.tanks.models.weapon.machinegun.sfx.sound {
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.ISound3DEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class MachineGunHitSoundEffect extends PooledObject implements ISound3DEffect {
    private static const NUMBER_OF_LOOPS:int = 99999;

    private var tankHitSound:Sound3D;
    private var hitSound:Sound3D;
    private var currentSound:Sound3D;
    private var previousSound:Sound3D;
    private var position:Vector3 = new Vector3();
    private var alive:Boolean;

    public function MachineGunHitSoundEffect(param1:Pool) {
      super(param1);
    }

    public function init(param1:Sound3D, param2:Sound3D) : void {
      this.hitSound = param1;
      this.tankHitSound = param2;
      this.alive = true;
      this.currentSound = param1;
    }

    public function setTarget(param1:Vector3, param2:Boolean) : void {
      this.position.copy(param1);
      this.previousSound = this.currentSound;
      this.currentSound = param2 ? this.tankHitSound : this.hitSound;
      if(this.previousSound != this.currentSound) {
        this.stopSounds();
      }
    }

    public function play(param1:int, param2:GameCamera) : void {
      if(!this.currentSound.isPlaying()) {
        this.currentSound.play(0,NUMBER_OF_LOOPS);
      }
      this.currentSound.checkVolume(param2.position,this.position,param2.xAxis);
    }

    public function destroy() : void {
      this.stopSounds();
      this.hitSound = null;
      this.tankHitSound = null;
      this.currentSound = null;
      this.previousSound = null;
      recycle();
    }

    public function kill() : void {
      this.alive = false;
    }

    public function set enabled(param1:Boolean) : void {
      if(!param1) {
        this.stopSounds();
      }
    }

    public function readPosition(param1:Vector3) : void {
      param1.copy(this.position);
    }

    public function get numSounds() : int {
      return this.alive ? 1 : 0;
    }

    private function stopSounds() : void {
      this.hitSound.stop();
      this.tankHitSound.stop();
    }
  }
}
