package alternativa.tanks.bonuses {
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.objects.Mesh;
  import platform.client.fp10.core.type.AutoClosable;

  public class Parachute extends BonusObject3DBase implements AutoClosable {
    public static const RADIUS:Number = 266;
    public static const NUM_STRAPS:int = 12;

    public function Parachute(param1:Mesh, param2:Mesh) {
      super();
      var local3:Object3DContainer = new Object3DContainer();
      local3.addChild(this.createMesh(param1));
      local3.addChild(this.createMesh(param2));
      object = local3;
    }

    private function createMesh(param1:Mesh) : Mesh {
      var local2:Mesh = Mesh(param1.clone());
      local2.shadowMapAlphaThreshold = 2;
      return local2;
    }

    public function recycle() : void {
      removeFromScene();
      setAlpha(1);
      setAlphaMultiplier(1);
      object.scaleX = 1;
      object.scaleY = 1;
      object.scaleZ = 1;
      BonusCache.putParachute(this);
    }

    public function addScaleXY(param1:Number) : void {
      object.scaleX += param1;
      object.scaleY += param1;
    }

    public function addScaleZ(param1:Number) : void {
      object.scaleZ += param1;
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      var local1:Object3DContainer = Object3DContainer(object);
      while(local1.numChildren > 0) {
        local1.removeChildAt(0);
      }
      object = null;
    }
  }
}
