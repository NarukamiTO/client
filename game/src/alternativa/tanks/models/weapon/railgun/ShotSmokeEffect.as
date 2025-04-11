package alternativa.tanks.models.weapon.railgun {
  import alternativa.engine3d.materials.Material;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class ShotSmokeEffect extends PooledObject implements GraphicEffect {
    private var container:Scene3DContainer;
    private var smoke:ShotSmoke;
    private var startPoint:Vector3 = new Vector3();
    private var direction:Vector3 = new Vector3();
    private var beginScale:Number;
    private var endScale:Number;
    private var moveDistance:Number;
    private var lifeTime:int;
    private var time:int;

    public function ShotSmokeEffect(param1:Pool) {
      super(param1);
      this.smoke = new ShotSmoke();
    }

    public function init(param1:Vector3, param2:Vector3, param3:Material, param4:Number, param5:Number, param6:Number, param7:Number, param8:int) : void {
      this.startPoint.copy(param1);
      this.direction.diff(param2,param1);
      var local9:Number = this.direction.length();
      this.direction.scale(1 / local9);
      this.beginScale = param5;
      this.endScale = param6;
      this.moveDistance = param7;
      this.lifeTime = param8;
      this.smoke.init(param4,local9,param3,param7);
      this.time = 0;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local4:Number = NaN;
      if(this.time > this.lifeTime) {
        return false;
      }
      SFXUtils.alignObjectPlaneToView(this.smoke,this.startPoint,this.direction,param2.position);
      var local3:Number = this.time / this.lifeTime;
      local4 = Math.sqrt(local3);
      this.smoke.scaleX = this.beginScale + (this.endScale - this.beginScale) * local4;
      this.smoke.alpha = 1 - local3;
      this.smoke.update(local4);
      this.time += param1;
      return true;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.smoke);
    }

    public function destroy() : void {
      this.smoke.clear();
      this.container.removeChild(this.smoke);
      this.container = null;
      recycle();
    }

    public function kill() : void {
      this.time = this.lifeTime + 1;
    }
  }
}
