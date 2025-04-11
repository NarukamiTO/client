package alternativa.tanks.models.weapon.gauss.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;

  public class GaussElectroEffect extends PooledObject implements GraphicEffect {
    private static const LIFE:Number = 9 / 60;

    private var container:Scene3DContainer;
    private var electro:Sprite3D = new Sprite3D(1,1);
    private var position:Vector3 = new Vector3();
    private var time:Number;
    private var delay:Number;
    private var vector:* = new Vector3();

    public function GaussElectroEffect(param1:Pool) {
      super(param1);
    }

    public function init(param1:Vector3, param2:Number, param3:TextureMaterial, param4:Number = 0) : void {
      this.position.copy(param1);
      this.delay = param4;
      this.electro.width = param2;
      this.electro.height = param2;
      this.electro.material = param3;
      this.electro.blendMode = BlendMode.ADD;
      this.electro.rotation = Math.random() * Math.PI * 2;
      if(Math.random() < 0.5) {
        this.electro.topLeftU = 0;
        this.electro.bottomRightU = 0.5;
      } else {
        this.electro.topLeftU = 0.5;
        this.electro.bottomRightU = 1;
      }
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.electro);
      this.time = -this.delay;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(this.time >= 0) {
        this.vector.copy(param2.position).subtract(this.position).normalize().scale(5).add(this.position);
        BattleUtils.setObjectPosition3d(this.electro,this.vector.toVector3d());
        this.electro.alpha = 1 - this.time / LIFE;
        this.electro.visible = true;
      } else {
        this.electro.visible = false;
      }
      this.time += param1 * 0.001;
      return this.time < LIFE;
    }

    public function destroy() : void {
      if(this.container != null) {
        this.container.removeChild(this.electro);
        this.container = null;
      }
      recycle();
    }

    public function kill() : void {
    }
  }
}
