package alternativa.tanks.models.tank.ultimate.titan {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class ShieldEffect extends PooledObject implements GraphicEffect {
    private static const ALPHA:Number = 0.9;
    private static const ALPHA_PULSATION_FREQ:Number = 4;
    private static const ALPHA_PULSATION_AMPLITUDE:Number = 0.2;

    public static const FADE:Number = 0.5;

    private var container:Scene3DContainer;
    private var sphere:Mesh = null;
    private var time:Number;
    private var fadeOutTime:Number;
    private var fadeOut:Boolean;
    private var position:Vector3;

    public function ShieldEffect(param1:Pool) {
      super(param1);
    }

    public function init(param1:TextureMaterial, param2:Mesh, param3:Vector3, param4:Number, param5:Number) : void {
      this.position = param3;
      if(this.sphere == null) {
        this.sphere = param2.clone() as Mesh;
        this.sphere.shadowMapAlphaThreshold = 2;
        this.sphere.depthMapAlphaThreshold = 2;
        this.sphere.useLight = false;
        this.sphere.useShadowMap = false;
        this.sphere.softAttenuation = 200;
      }
      this.sphere.setMaterialToAllFaces(param1);
      this.sphere.x = param3.x;
      this.sphere.y = param3.y;
      this.sphere.z = param3.z;
      this.sphere.rotationX = 0;
      this.sphere.rotationY = 0;
      this.sphere.rotationZ = param5;
      this.sphere.calculateBounds();
      var local6:Number = 0.5 * (this.sphere.boundMaxX - this.sphere.boundMinX);
      var local7:Number = param4 / local6;
      this.sphere.scaleX = local7;
      this.sphere.scaleY = local7;
      this.sphere.scaleZ = local7;
      this.sphere.alpha = ALPHA;
      this.time = 0;
      this.fadeOut = false;
      this.fadeOutTime = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.sphere);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = param1 / 1000;
      this.time += local3;
      var local4:Number = ALPHA + Math.sin(this.time * ALPHA_PULSATION_FREQ) * ALPHA_PULSATION_AMPLITUDE;
      if(this.fadeOut) {
        this.fadeOutTime += local3;
        this.sphere.alpha = local4 * (FADE - this.fadeOutTime) / FADE;
        return this.sphere.alpha > 0;
      }
      if(this.time <= FADE) {
        this.sphere.alpha = local4 * this.time / FADE;
        return true;
      }
      this.sphere.alpha = local4;
      return true;
    }

    public function stop() : void {
      this.fadeOut = true;
    }

    public function destroy() : void {
      this.container.removeChild(this.sphere);
      this.sphere.setMaterialToAllFaces(null);
      this.container = null;
      recycle();
    }

    public function kill() : void {
      this.sphere.alpha = 0;
    }
  }
}
