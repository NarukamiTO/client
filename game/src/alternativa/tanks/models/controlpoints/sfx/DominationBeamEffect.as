package alternativa.tanks.models.controlpoints.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.osgi.service.console.variables.ConsoleVarFloat;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.utils.Dictionary;

  public class DominationBeamEffect extends PooledObject implements GraphicEffect {
    private static const conZOffset:ConsoleVarFloat = new ConsoleVarFloat("beam_zoffset",100,0,1000);
    private static const startPosition:Vector3 = new Vector3();
    private static const direction:Vector3 = new Vector3();

    private var beam:AnimatedBeam;
    private var alive:Boolean;
    private var object:Object3D;
    private var endPosition:Vector3 = new Vector3();
    private var excludedObects:Dictionary;
    private var container:Scene3DContainer;

    public function DominationBeamEffect(param1:Pool) {
      super(param1);
      this.beam = new AnimatedBeam(1,1,1,0);
    }

    public function init(param1:Object3D, param2:Vector3, param3:BeamProperties, param4:Dictionary) : void {
      this.object = param1;
      this.endPosition.copy(param2);
      this.beam.setMaterials(param3.beamTipMaterial,param3.beamMaterial);
      this.beam.setUnitLength(param3.unitLength);
      this.beam.animationSpeed = param3.animationSpeed;
      this.setBeamWidth(param3.beamWidth);
      this.beam.setURange(param3.uRange);
      this.beam.alpha = param3.alpha;
      this.alive = true;
      this.excludedObects = param4;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      startPosition.x = this.object.x;
      startPosition.y = this.object.y;
      startPosition.z = this.object.z + conZOffset.value;
      direction.diff(this.endPosition,startPosition);
      this.beam.setLength(direction.length());
      direction.normalize();
      SFXUtils.alignObjectPlaneToView(this.beam,startPosition,direction,param2.position);
      this.beam.update(param1 * 0.001);
      return this.alive;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.beam);
      this.excludedObects[this.beam] = true;
    }

    public function destroy() : void {
      this.object = null;
      this.container.removeChild(this.beam);
      this.beam.setMaterialToAllFaces(null);
      delete this.excludedObects[this.beam];
      this.excludedObects = null;
      recycle();
    }

    public function kill() : void {
      this.alive = false;
    }

    public function setBeamWidth(param1:Number) : void {
      this.beam.setWidth(param1);
      this.beam.setTipLength(param1);
    }
  }
}
