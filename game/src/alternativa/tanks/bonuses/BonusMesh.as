package alternativa.tanks.bonuses {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
  import alternativa.types.Long;
  import flash.geom.ColorTransform;

  public class BonusMesh extends BonusObject3DBase {
    [Inject]
    public static var lightingService:ILightingEffectsService;

    private var bonusColorTransform:ColorTransform;
    private var combinedColorTransform:ColorTransform = new ColorTransform();
    private var objectId:Long;

    public function BonusMesh(param1:Long, param2:Mesh) {
      super();
      this.objectId = param1;
      object = this.createMesh(param2);
    }

    private function createMesh(param1:Mesh) : Mesh {
      var local2:Mesh = Mesh(param1.clone());
      var local3:Face = param1.faces[0];
      local2.setMaterialToAllFaces(local3.material);
      local2.sorting = Sorting.DYNAMIC_BSP;
      return local2;
    }

    public function init() : void {
      object.rotationX = 0;
      object.rotationY = 0;
      object.rotationZ = 0;
      this.setScale(1);
      setAlpha(1);
      setAlphaMultiplier(1);
      this.bonusColorTransform = lightingService.getBonusColorAdjust();
      object.colorTransform = this.bonusColorTransform;
    }

    public function setScale(param1:Number) : void {
      object.scaleX = param1;
      object.scaleY = param1;
      object.scaleZ = param1;
    }

    public function getObjectId() : Long {
      return this.objectId;
    }

    public function recycle() : void {
      removeFromScene();
      object.colorTransform = null;
      BonusCache.putBonusMesh(this);
    }

    public function setRotationZ(param1:Number) : void {
      object.rotationZ = param1;
    }

    public function setColorTransform(param1:ColorTransform) : void {
      if(this.bonusColorTransform != null) {
        if(param1 == null) {
          object.colorTransform = this.bonusColorTransform;
        } else {
          this.copyColorTransform(this.bonusColorTransform,this.combinedColorTransform);
          this.combinedColorTransform.concat(param1);
          object.colorTransform = this.combinedColorTransform;
        }
      } else {
        object.colorTransform = param1;
      }
    }

    public function addRotationZ(param1:Number) : void {
      object.rotationZ += param1;
    }

    public function getScale() : Number {
      return object.scaleX;
    }

    private function copyColorTransform(param1:ColorTransform, param2:ColorTransform) : void {
      param2.redMultiplier = param1.redMultiplier;
      param2.greenMultiplier = param1.greenMultiplier;
      param2.blueMultiplier = param1.blueMultiplier;
      param2.alphaMultiplier = param1.alphaMultiplier;
      param2.redOffset = param1.redOffset;
      param2.greenOffset = param1.greenOffset;
      param2.blueOffset = param1.blueOffset;
      param2.alphaOffset = param1.alphaOffset;
    }
  }
}
