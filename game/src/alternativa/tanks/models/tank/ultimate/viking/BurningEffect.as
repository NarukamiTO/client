package alternativa.tanks.models.tank.ultimate.viking {
  import alternativa.engine3d.core.Camera3D;
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

  public class BurningEffect extends PooledObject implements GraphicEffect {
    private static const FLAME_SIZE:int = 300;
    private static const SMOKE_SIZE:int = 500;

    public static const FADE:Number = 1;
    public static const MIN:Number = 0.7;
    public static const HALF:Number = (1 - MIN) / 2;
    public static const FLAME_OFFSET:Number = 330;
    public static const SMOKE_OFFSET:Number = 300;

    private static const vector:Vector3D = new Vector3D();
    private static const vector3:Vector3 = new Vector3();

    public static const EFFECT_OPACITY:Number = 0.5;

    private var container:Scene3DContainer;
    private var camera:Camera3D;
    private var target:Object3D;
    private var flame1:Sprite3D;
    private var flame2:Sprite3D;
    private var smoke1:Sprite3D;
    private var smoke2:Sprite3D;
    private var time:Number;
    private var fadeOut:Boolean;
    private var fadeOutTime:Number;
    private var sound:Sound3D;

    public function BurningEffect(param1:Pool) {
      super(param1);
      this.flame1 = new Sprite3D(FLAME_SIZE,FLAME_SIZE);
      this.flame1.useLight = false;
      this.flame1.useShadowMap = false;
      this.flame1.blendMode = BlendMode.ADD;
      this.flame1.softAttenuation = 200;
      this.flame2 = new Sprite3D(FLAME_SIZE,FLAME_SIZE);
      this.flame2.useLight = false;
      this.flame2.useShadowMap = false;
      this.flame2.blendMode = BlendMode.ADD;
      this.flame2.rotation = Math.PI;
      this.flame2.softAttenuation = 200;
      this.smoke1 = new Sprite3D(SMOKE_SIZE,SMOKE_SIZE);
      this.smoke1.useLight = false;
      this.smoke1.useShadowMap = false;
      this.smoke1.rotation = Math.PI / 2;
      this.smoke1.softAttenuation = 200;
      this.smoke2 = new Sprite3D(SMOKE_SIZE,SMOKE_SIZE);
      this.smoke2.useLight = false;
      this.smoke2.useShadowMap = false;
      this.smoke2.rotation = -Math.PI / 2;
      this.smoke2.softAttenuation = 200;
      this.flame1.alpha = EFFECT_OPACITY;
      this.flame2.alpha = EFFECT_OPACITY;
      this.smoke1.alpha = EFFECT_OPACITY;
      this.smoke2.alpha = EFFECT_OPACITY;
      this.fadeOut = false;
      this.fadeOutTime = 0;
    }

    private static function coerce(param1:Number, param2:Number, param3:Number) : Number {
      if(param1 < param2) {
        return param2;
      }
      if(param1 > param3) {
        return param3;
      }
      return param1;
    }

    public function init(param1:TextureMaterial, param2:TextureMaterial, param3:Object3D, param4:Sound3D) : void {
      this.target = param3;
      this.sound = param4;
      this.flame1.material = param1;
      this.flame2.material = param1;
      this.smoke1.material = param2;
      this.smoke2.material = param2;
      this.flame2.scaleX = MIN + HALF;
      this.flame2.scaleY = MIN + HALF;
      this.flame2.scaleZ = MIN + HALF;
      this.smoke2.scaleX = MIN + HALF;
      this.smoke2.scaleY = MIN + HALF;
      this.smoke2.scaleZ = MIN + HALF;
      this.time = 0;
      this.fadeOut = false;
      this.fadeOutTime = 0;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.flame1);
      param1.addChild(this.flame2);
      param1.addChild(this.smoke1);
      param1.addChild(this.smoke2);
      this.time = 0;
      this.fadeOut = false;
      this.fadeOutTime = 0;
      this.sound.play(0,1000);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = NaN;
      var local6:Number = NaN;
      local3 = param1 / 1000;
      this.time += local3;
      vector3.reset(this.target.x,this.target.y,this.target.z);
      this.sound.checkVolume(param2.position,vector3,param2.xAxis);
      vector.x = param2.x - this.target.x;
      vector.y = param2.y - this.target.y;
      vector.z = param2.z - this.target.z + 50;
      vector.normalize();
      this.flame1.x = this.target.x + vector.x * FLAME_OFFSET;
      this.flame1.y = this.target.y + vector.y * FLAME_OFFSET;
      this.flame1.z = this.target.z + vector.z * FLAME_OFFSET + 50;
      this.flame2.x = this.flame1.x;
      this.flame2.y = this.flame1.y;
      this.flame2.z = this.flame1.z;
      this.smoke1.x = this.target.x + vector.x * SMOKE_OFFSET;
      this.smoke1.y = this.target.y + vector.y * SMOKE_OFFSET;
      this.smoke1.z = this.target.z + vector.z * SMOKE_OFFSET + 50;
      this.smoke2.x = this.smoke1.x;
      this.smoke2.y = this.smoke1.y;
      this.smoke2.z = this.smoke1.z;
      var local4:Number = local3 * 0.4;
      var local5:Number = this.flame1.scaleX + local4;
      if(local5 > 1) {
        local5 = MIN;
      }
      this.flame1.scaleX = local5;
      this.flame1.scaleY = local5;
      this.flame1.scaleZ = local5;
      this.flame1.alpha = 1 - Math.abs(MIN + HALF - local5) / HALF;
      local5 = this.flame2.scaleX + local4;
      if(local5 > 1) {
        local5 = MIN;
      }
      this.flame2.scaleX = local5;
      this.flame2.scaleY = local5;
      this.flame2.scaleZ = local5;
      this.flame2.alpha = 1 - Math.abs(MIN + HALF - local5) / HALF;
      local5 = this.smoke1.scaleX - local4;
      if(local5 < MIN) {
        local5 = 1;
      }
      this.smoke1.scaleX = local5;
      this.smoke1.scaleY = local5;
      this.smoke1.scaleZ = local5;
      this.smoke1.alpha = 1 - Math.abs(MIN + HALF - local5) / HALF;
      local5 = this.smoke2.scaleX - local4;
      if(local5 < MIN) {
        local5 = 1;
      }
      this.smoke2.scaleX = local5;
      this.smoke2.scaleY = local5;
      this.smoke2.scaleZ = local5;
      this.smoke2.alpha = 1 - Math.abs(MIN + HALF - local5) / HALF;
      this.applyOpacity();
      if(this.fadeOut) {
        local6 = 1 - this.time / FADE;
        this.flame1.alpha = coerce(this.flame1.alpha * local6,0,1);
        this.flame2.alpha = coerce(this.flame2.alpha * local6,0,1);
        this.smoke1.alpha = coerce(this.smoke1.alpha * local6,0,1);
        this.smoke2.alpha = coerce(this.smoke2.alpha * local6,0,1);
        this.applyOpacity();
        return local6 > 0;
      }
      local6 = this.time / FADE;
      this.flame1.alpha = coerce(this.flame1.alpha * local6,0,1);
      this.flame2.alpha = coerce(this.flame2.alpha * local6,0,1);
      this.smoke1.alpha = coerce(this.smoke1.alpha * local6,0,1);
      this.smoke2.alpha = coerce(this.smoke2.alpha * local6,0,1);
      this.applyOpacity();
      return true;
    }

    private function applyOpacity() : void {
      this.flame1.alpha *= EFFECT_OPACITY;
      this.flame2.alpha *= EFFECT_OPACITY;
      this.smoke1.alpha *= EFFECT_OPACITY;
      this.smoke2.alpha *= EFFECT_OPACITY;
    }

    public function destroy() : void {
      this.container.removeChild(this.flame1);
      this.container.removeChild(this.flame2);
      this.container.removeChild(this.smoke1);
      this.container.removeChild(this.smoke2);
      this.flame1.material = null;
      this.flame2.material = null;
      this.smoke2.material = null;
      this.smoke1.material = null;
      this.camera = null;
      this.container = null;
      this.target = null;
      if(this.sound != null) {
        this.sound.stop();
      }
      this.sound = null;
      recycle();
    }

    public function stop() : void {
      this.fadeOut = true;
      if(this.sound != null) {
        this.sound.stop();
      }
    }

    public function kill() : void {
      this.sound.stop();
      this.flame1.alpha = 0;
      this.flame2.alpha = 0;
      this.smoke2.alpha = 0;
      this.smoke1.alpha = 0;
    }
  }
}
