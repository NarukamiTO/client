package alternativa.tanks.models.tank.ultimate.hunter {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;
  import flash.geom.Vector3D;

  public class ElectroEffect extends PooledObject implements GraphicEffect {
    private static const SIZE:int = 600;
    private static const FRAMES:int = 2;

    public static const FADE:Number = 0.5;
    public static const MID:Number = 10 / 60;
    public static const END:Number = 30 / 60;
    public static const OFFSET:Number = 150;

    private static const vector:Vector3D = new Vector3D();
    private static const vector3:Vector3 = new Vector3();

    private var container:Scene3DContainer;
    private var target:Object3D;
    private var sprite:Sprite3D;
    private var time:Number;
    private var fadeOut:Boolean;
    private var fadeOutTime:Number;
    private var frame:int = 0;
    private var sound:Sound3D;

    public function ElectroEffect(param1:Pool) {
      super(param1);
      this.sprite = new Sprite3D(SIZE,SIZE);
      this.sprite.rotation = Math.random() * Math.PI * 2;
      this.sprite.useLight = false;
      this.sprite.useShadowMap = false;
      this.sprite.blendMode = BlendMode.ADD;
      this.sprite.softAttenuation = 20;
    }

    public function init(param1:TextureMaterial, param2:Object3D, param3:Sound3D) : void {
      this.target = param2;
      this.sound = param3;
      this.time = 0;
      this.sprite.material = param1;
      this.sprite.topLeftU = 0;
      this.sprite.bottomRightU = 0.5;
      this.fadeOut = false;
      this.fadeOutTime = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.sprite);
      this.sound.play(0,100000);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local4:Number = NaN;
      var local3:Number = param1 / 1000;
      this.time += local3;
      vector.x = param2.x - this.target.x;
      vector.y = param2.y - this.target.y;
      vector.z = param2.z - this.target.z + 50;
      vector.normalize();
      vector3.reset(this.target.x,this.target.y,this.target.z + 50);
      this.sound.checkVolume(param2.position,vector3,param2.xAxis);
      this.sprite.x = this.target.x + vector.x * OFFSET;
      this.sprite.y = this.target.y + vector.y * OFFSET;
      this.sprite.z = this.target.z + vector.z * OFFSET + 100;
      if(this.fadeOut) {
        this.fadeOutTime += local3;
        local4 = 1 - this.fadeOutTime / FADE;
        if(local4 >= 0) {
          this.sprite.alpha = local4;
          return true;
        }
        return false;
      }
      if(this.time <= MID) {
        this.sprite.alpha = this.time / MID;
      } else if(this.time <= END) {
        this.sprite.alpha = 1 - (this.time - MID) / (END - MID);
      } else {
        this.switchFrame();
      }
      return true;
    }

    private function switchFrame() : void {
      this.frame = (this.frame + 1) % FRAMES;
      this.sprite.topLeftU = 1 / FRAMES * this.frame;
      this.sprite.bottomRightU = 0.5 + 1 / FRAMES * this.frame;
      this.sprite.rotation = Math.random() * Number.PI * 2;
      this.time = 0;
    }

    public function destroy() : void {
      this.container.removeChild(this.sprite);
      this.container = null;
      this.sound.stop();
      this.sound = null;
      this.sprite.material = null;
      this.target = null;
      recycle();
    }

    public function kill() : void {
      this.sprite.alpha = 0;
    }

    public function stop() : void {
      this.fadeOut = true;
      if(this.sound != null) {
        this.sound.stop();
      }
    }
  }
}
