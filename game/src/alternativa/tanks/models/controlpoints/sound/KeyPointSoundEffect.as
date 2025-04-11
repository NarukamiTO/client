package alternativa.tanks.models.controlpoints.sound {
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.ISound3DEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.media.Sound;

  public class KeyPointSoundEffect extends PooledObject implements ISound3DEffect {
    private static const NEAR_RADIUS:Number = 1500;
    private static const FAR_RADIUS:Number = 5000;
    private static const FAR_DELIMITER:Number = 10;
    private static const BASE_VOLUME:Number = 1.3;

    private var sound3d:Sound3D;
    private var position:Vector3 = new Vector3();
    private var alive:Boolean;

    public function KeyPointSoundEffect(param1:Pool) {
      super(param1);
    }

    public function init(param1:Sound, param2:Vector3) : void {
      this.sound3d = Sound3D.create(param1,BASE_VOLUME,NEAR_RADIUS,FAR_RADIUS,FAR_DELIMITER);
      this.position.copy(param2);
      this.alive = true;
    }

    public function play(param1:int, param2:GameCamera) : void {
      if(!this.sound3d.isPlaying()) {
        this.sound3d.play(0,99999);
      }
      this.sound3d.checkVolume(param2.position,this.position,param2.xAxis);
    }

    public function destroy() : void {
      this.sound3d.stop();
      Sound3D.destroy(this.sound3d);
      this.sound3d = null;
      recycle();
    }

    public function kill() : void {
      this.alive = false;
    }

    public function set enabled(param1:Boolean) : void {
      if(!param1) {
        this.sound3d.stop();
      }
    }

    public function readPosition(param1:Vector3) : void {
      param1.copy(this.position);
    }

    public function get numSounds() : int {
      return this.alive ? 1 : 0;
    }
  }
}
