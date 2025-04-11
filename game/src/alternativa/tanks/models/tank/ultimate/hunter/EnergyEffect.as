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

  public class EnergyEffect extends PooledObject implements GraphicEffect {
    public static const FADE:Number = 0.17;
    public static const OFFSET:Number = 300;
    public static const MIN:Number = 0.4;

    private static const vector:Vector3D = new Vector3D();
    private static const vector3:Vector3 = new Vector3();

    private var container:Scene3DContainer;
    private var target:Object3D;
    private var charging:Number;
    private var secondBegin:Number;
    private var firstEnd:Number;
    private var energy1:Sprite3D;
    private var energy2:Sprite3D;
    private var time:Number;
    private var chargingSound:Sound3D;

    internal var fadeOut:Boolean = false;

    private var chargingSoundPlayed:Boolean = false;

    public function EnergyEffect(param1:Pool) {
      super(param1);
      this.energy1 = new Sprite3D(700,700);
      this.energy1.useLight = false;
      this.energy1.useShadowMap = false;
      this.energy1.blendMode = BlendMode.ADD;
      this.energy1.softAttenuation = 200;
      this.energy2 = new Sprite3D(700,700);
      this.energy2.useLight = false;
      this.energy2.useShadowMap = false;
      this.energy2.blendMode = BlendMode.ADD;
      this.energy2.rotation = Math.PI;
      this.energy2.softAttenuation = 200;
    }

    public function init(param1:TextureMaterial, param2:Object3D, param3:Number, param4:Sound3D) : * {
      this.target = param2;
      this.charging = param3;
      this.secondBegin = param3 * 0.33;
      this.firstEnd = param3 - param3 * 0.13;
      this.chargingSound = param4;
      this.energy1.material = param1;
      this.energy2.material = param1;
      this.time = 0;
      this.fadeOut = false;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.energy1);
      param1.addChild(this.energy2);
      this.chargingSoundPlayed = false;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local3:Number = param1 / 1000;
      this.time += local3;
      if(this.fadeOut) {
        return false;
      }
      this.playSounds(param2);
      vector.x = param2.x - this.target.x;
      vector.y = param2.y - this.target.y;
      vector.z = param2.z - this.target.z + 50;
      vector.normalize();
      this.energy1.x = this.target.x + vector.x * OFFSET;
      this.energy1.y = this.target.y + vector.y * OFFSET;
      this.energy1.z = this.target.z + vector.z * OFFSET + 100;
      this.energy2.x = this.energy1.x;
      this.energy2.y = this.energy1.y;
      this.energy2.z = this.energy1.z;
      if(this.time <= this.charging) {
        local4 = this.time / this.firstEnd;
        if(local4 > 1) {
          local4 = 1;
        }
        local5 = MIN + (1 - MIN) * local4;
        this.energy1.scaleX = local5;
        this.energy1.scaleY = local5;
        this.energy1.scaleZ = local5;
        this.energy1.alpha = local4;
        local4 = (this.time - this.secondBegin) / (this.charging - this.secondBegin);
        if(local4 < 0) {
          local4 = 0;
        }
        local5 = MIN + (1 - MIN) * local4;
        this.energy2.scaleX = local5;
        this.energy2.scaleY = local5;
        this.energy2.scaleZ = local5;
        this.energy2.alpha = local4;
        return true;
      }
      if(this.time <= this.charging + FADE) {
        local4 = 1 - (this.time - this.charging) / FADE;
        this.energy1.alpha = local4;
        this.energy2.alpha = local4;
        return true;
      }
      return false;
    }

    private function playSounds(param1:GameCamera) : void {
      vector3.reset(this.target.x,this.target.y,this.target.z);
      if(!this.chargingSoundPlayed) {
        this.chargingSound.play(0,0);
        this.chargingSound.checkVolume(param1.position,vector3,param1.xAxis);
        this.chargingSoundPlayed = true;
      }
    }

    public function stop() : void {
      this.fadeOut = true;
    }

    public function destroy() : void {
      this.container.removeChild(this.energy1);
      this.container.removeChild(this.energy2);
      this.energy1.material = null;
      this.energy2.material = null;
      this.container = null;
      this.target = null;
      if(this.chargingSound != null) {
        this.chargingSound.stop();
        this.chargingSound = null;
      }
      recycle();
    }

    public function kill() : void {
      this.energy1.alpha = 0;
      this.energy2.alpha = 0;
    }
  }
}
