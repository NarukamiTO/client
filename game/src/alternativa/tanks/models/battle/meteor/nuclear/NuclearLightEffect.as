package alternativa.tanks.models.battle.meteor.nuclear {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;

  public class NuclearLightEffect extends PooledObject implements GraphicEffect {
    private var light:Sprite3D = new Sprite3D(5000,5000);
    private var container:Scene3DContainer = null;
    private var time:Number = 0;
    private var epicenter:Vector3 = new Vector3();
    private var vector:Vector3 = new Vector3();

    internal var OFFSET:Number = 1550;

    public function NuclearLightEffect(param1:Pool) {
      super(param1);
    }

    public function init(param1:Vector3, param2:TextureMaterial) : void {
      this.epicenter.copy(param1);
      this.light.material = param2;
      this.light.useLight = false;
      this.light.useShadowMap = false;
      this.light.blendMode = BlendMode.ADD;
      this.light.softAttenuation = 400;
      this.time = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.light);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = param1 / 1000;
      this.time += local3;
      this.vector.x = param2.x - this.epicenter.x;
      this.vector.y = param2.y - this.epicenter.y;
      this.vector.z = param2.z - this.epicenter.z - NuclearBangEffect.HEIGHT9;
      this.vector.normalize();
      this.light.x = this.epicenter.x + this.vector.x * this.OFFSET;
      this.light.y = this.epicenter.y + this.vector.y * this.OFFSET;
      this.light.z = this.epicenter.z + this.vector.z * this.OFFSET + NuclearBangEffect.HEIGHT9;
      var local4:Number = NuclearBangEffect.KEY1 / 3;
      if(this.time <= local4) {
        this.light.alpha = this.time / local4;
        this.light.visible = true;
      } else if(this.time <= NuclearBangEffect.KEY2) {
        this.light.alpha = 1 - (this.time - local4) / (NuclearBangEffect.KEY2 - local4);
        this.light.visible = true;
      } else {
        this.light.visible = false;
      }
      return this.light.visible;
    }

    public function destroy() : void {
      if(this.container != null) {
        this.container.removeChild(this.light);
        this.container = null;
      }
      this.light.material = null;
      recycle();
    }

    public function kill() : void {
      this.destroy();
    }
  }
}
