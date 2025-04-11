package alternativa.tanks.models.weapon.rocketlauncher.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class RocketSmoke extends PooledObject implements GraphicEffect {
    [Inject]
    public static var settings:ISettingsService;

    private static const INITIAL_ALPHA:Number = 0.4;
    private static const SCALE_STEP:Number = 0.02;
    private static const ALPHA_STEP:Number = 0.01;

    private var container:Scene3DContainer;
    private var sprite:Sprite3D;

    public function RocketSmoke(param1:Pool) {
      super(param1);
      this.sprite = new Sprite3D(100,100);
    }

    public function init(param1:Mesh, param2:Vector3, param3:TextureMaterial) : void {
      this.sprite.material = param3;
      this.sprite.rotation = Math.random() * Math.PI * 2;
      this.sprite.scaleX = 1;
      this.sprite.scaleY = 1;
      this.sprite.scaleZ = 1;
      this.sprite.alpha = INITIAL_ALPHA;
      this.sprite.x = param1.x - param2.x * 40;
      this.sprite.y = param1.y - param2.y * 40;
      this.sprite.z = param1.z - param2.z * 40;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      if(!settings.dust) {
        return;
      }
      this.container = param1;
      param1.addChild(this.sprite);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(!settings.dust) {
        return false;
      }
      this.sprite.scaleX += SCALE_STEP;
      this.sprite.scaleY += SCALE_STEP;
      this.sprite.scaleZ += SCALE_STEP;
      this.sprite.alpha -= ALPHA_STEP;
      return this.sprite.alpha > 0;
    }

    public function destroy() : void {
      if(Boolean(this.container)) {
        this.container.removeChild(this.sprite);
      }
      this.container = null;
      this.sprite.material = null;
      recycle();
    }

    public function kill() : void {
      this.sprite.alpha = 0;
    }
  }
}
