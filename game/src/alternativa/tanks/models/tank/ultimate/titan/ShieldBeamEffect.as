package alternativa.tanks.models.tank.ultimate.titan {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.controlpoints.sfx.AnimatedBeam;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class ShieldBeamEffect extends PooledObject implements GraphicEffect {
    private static const direction:Vector3 = new Vector3();
    private static const unitLength:Number = 500;
    private static const animationSpeed:Number = -0.2;
    private static const beamWidth:Number = 80;
    private static const uRange:Number = 0.3;
    private static const alpha:Number = 1;
    private static const activationDuration:int = 100;
    private static const targetOffset:Number = 130;

    private var beam:AnimatedBeam = new AnimatedBeam(1,1,1,0);
    private var alive:Boolean = false;
    private var endPosition:Vector3 = new Vector3();
    private var startPosition:Vector3 = new Vector3();
    private var endAnchor:Object3D;
    private var container:Scene3DContainer;
    private var lifeTime:int = 0;

    public function ShieldBeamEffect(param1:Pool) {
      super(param1);
    }

    public function init(param1:Object3D, param2:Vector3, param3:TextureMaterial, param4:TextureMaterial) : void {
      this.endAnchor = param1;
      this.startPosition.copy(param2);
      this.beam.setMaterials(param4,param3);
      this.beam.setUnitLength(unitLength);
      this.beam.setWidth(beamWidth);
      this.beam.setTipLength(50);
      this.beam.setURange(uRange);
      this.beam.animationSpeed = animationSpeed;
      this.beam.alpha = alpha;
      this.lifeTime = 0;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      this.lifeTime += param1;
      this.endPosition.x = this.endAnchor.x;
      this.endPosition.y = this.endAnchor.y;
      this.endPosition.z = this.endAnchor.z;
      direction.diff(this.endPosition,this.startPosition);
      var local3:Number = Math.min(this.lifeTime / activationDuration,1);
      var local4:Number = Math.max(0,direction.length() - targetOffset) * local3;
      this.beam.setLength(local4);
      direction.normalize();
      SFXUtils.alignObjectPlaneToView(this.beam,this.startPosition,direction,param2.position);
      this.beam.update(param1 * 0.001);
      return this.alive;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.alive = true;
      this.container = param1;
      param1.addChild(this.beam);
    }

    public function destroy() : void {
      if(this.container != null) {
        this.container.removeChild(this.beam);
        this.container = null;
      }
    }

    public function kill() : void {
      this.alive = false;
    }
  }
}
