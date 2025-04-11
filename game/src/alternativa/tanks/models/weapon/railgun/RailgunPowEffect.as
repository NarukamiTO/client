package alternativa.tanks.models.weapon.railgun {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.AnimatedPlane;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class RailgunPowEffect extends PooledObject implements GraphicEffect {
    private var position:Vector3 = new Vector3();
    private var direction:Vector3 = new Vector3();
    private var currentTime:int;
    private var maxTime:int;
    private var plane:AnimatedPlane;
    private var container:Scene3DContainer;

    public function RailgunPowEffect(param1:Pool) {
      super(param1);
      this.plane = new AnimatedPlane(30,200,0,-100,0);
    }

    public function init(param1:Vector3, param2:Vector3, param3:TextureAnimation) : void {
      this.position.copy(param1);
      this.direction.copy(param2);
      this.plane.init(param3,0.001 * param3.fps);
      this.maxTime = this.plane.getOneLoopTime();
      this.currentTime = 0;
      this.plane.x = param1.x;
      this.plane.y = param1.y;
      this.plane.z = param1.z;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(this.currentTime >= this.maxTime) {
        return false;
      }
      this.plane.setTime(this.currentTime);
      this.currentTime += param1;
      SFXUtils.alignObjectPlaneToView(this.plane,this.position,this.direction,param2.position);
      return true;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.plane);
    }

    public function destroy() : void {
      this.container.removeChild(this.plane);
      this.container = null;
      this.plane.clear();
      recycle();
    }

    public function kill() : void {
      this.currentTime = this.maxTime;
    }
  }
}
