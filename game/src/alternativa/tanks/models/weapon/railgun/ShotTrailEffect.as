package alternativa.tanks.models.weapon.railgun {
  import alternativa.engine3d.materials.Material;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class ShotTrailEffect extends PooledObject implements GraphicEffect {
    private var container:Scene3DContainer;
    private var trail:ShotTrail;
    private var startPoint:Vector3 = new Vector3();
    private var direction:Vector3 = new Vector3();
    private var beginScale:Number;
    private var endScale:Number;
    private var moveDistance:Number;
    private var lifeTime:int;
    private var time:int;

    public function ShotTrailEffect(param1:Pool) {
      super(param1);
      this.trail = new ShotTrail();
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
      this.trail.init(param4,local9,param3,param7);
      this.time = 0;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local4:Number = NaN;
      if(this.time > this.lifeTime) {
        return false;
      }
      SFXUtils.alignObjectPlaneToView(this.trail,this.startPoint,this.direction,param2.position);
      var local3:Number = this.time / this.lifeTime;
      local4 = Math.sqrt(local3);
      this.trail.scaleX = this.beginScale + (this.endScale - this.beginScale) * local4;
      this.trail.alpha = 1 - local3;
      this.trail.update(local4);
      this.time += param1;
      return true;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.trail);
    }

    public function destroy() : void {
      this.trail.clear();
      this.container.removeChild(this.trail);
      this.container = null;
      recycle();
    }

    public function kill() : void {
      this.time = this.lifeTime + 1;
    }
  }
}
