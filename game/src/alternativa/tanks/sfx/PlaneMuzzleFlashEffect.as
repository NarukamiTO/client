package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class PlaneMuzzleFlashEffect extends PooledObject implements GraphicEffect {
    private static const gunDirection:Vector3 = new Vector3();
    private static const globalMuzzlePosition:Vector3 = new Vector3();
    private static const turretMatrix:Matrix4 = new Matrix4();

    private var plane:SimplePlane;
    private var timetoLive:int;
    private var turret:Object3D;
    private var localMuzzlePosition:Vector3 = new Vector3();
    private var container:Scene3DContainer;

    public function PlaneMuzzleFlashEffect(param1:Pool) {
      super(param1);
      this.plane = new SimplePlane(1,1,0.5,0);
      this.plane.setUVs(0,0,0,1,1,1,1,0);
      this.plane.shadowMapAlphaThreshold = 2;
      this.plane.depthMapAlphaThreshold = 2;
      this.plane.useShadowMap = false;
      this.plane.useLight = false;
    }

    public function init(param1:Vector3, param2:Object3D, param3:TextureMaterial, param4:int, param5:Number, param6:Number) : void {
      this.localMuzzlePosition.copy(param1);
      this.turret = param2;
      this.timetoLive = param4;
      this.plane.setMaterialToAllFaces(param3);
      this.plane.width = param5;
      this.plane.length = param6;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(this.timetoLive < 0) {
        return false;
      }
      this.timetoLive -= param1;
      turretMatrix.setMatrix(this.turret.x,this.turret.y,this.turret.z,this.turret.rotationX,this.turret.rotationY,this.turret.rotationZ);
      turretMatrix.transformVector(this.localMuzzlePosition,globalMuzzlePosition);
      turretMatrix.getAxis(1,gunDirection);
      SFXUtils.alignObjectPlaneToView(this.plane,globalMuzzlePosition,gunDirection,param2.position);
      return true;
    }

    public function destroy() : void {
      this.container.removeChild(this.plane);
      this.container = null;
      this.turret = null;
      recycle();
    }

    public function kill() : void {
      this.timetoLive = -1;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.plane);
    }
  }
}
