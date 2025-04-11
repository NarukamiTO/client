package alternativa.tanks.models.weapon.artillery.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class ArtillerySmoke extends PooledObject implements GraphicEffect {
    private static const SCALE_STEP:Number = 0.006;
    private static const ALPHA_STEP:Number = 0.007;

    private var container:Scene3DContainer;
    private var sprite:Sprite3D;

    public function ArtillerySmoke(param1:Pool) {
      super(param1);
      this.sprite = new Sprite3D(60,60);
    }

    public function init(param1:Mesh, param2:TextureMaterial) : void {
      this.sprite.material = param2;
      this.sprite.rotation = Math.random() * Math.PI * 2;
      this.sprite.scaleX = 1;
      this.sprite.scaleY = 1;
      this.sprite.scaleZ = 1;
      this.sprite.alpha = 1;
      this.sprite.x = param1.x;
      this.sprite.y = param1.y;
      this.sprite.z = param1.z;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      this.sprite.scaleX -= SCALE_STEP;
      this.sprite.scaleY -= SCALE_STEP;
      this.sprite.scaleZ -= SCALE_STEP;
      this.sprite.alpha -= ALPHA_STEP;
      if(this.sprite.alpha <= 0.05) {
        this.container.removeChild(this.sprite);
        return false;
      }
      return true;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.sprite);
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
