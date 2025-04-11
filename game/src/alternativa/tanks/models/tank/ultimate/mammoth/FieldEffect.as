package alternativa.tanks.models.tank.ultimate.mammoth {
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

  public class FieldEffect extends PooledObject implements GraphicEffect {
    private static const SHINE_SIZE:int = 600;

    public static const SHINE_OFFSET:Number = 300;

    private static const HEART_SIZE:int = 250;

    public static const HEART_OFFSET:Number = 400;
    public static const FADE:Number = 0.5;
    public static const MIN:Number = 0.3;
    public static const HALF:Number = (1 - MIN) / 2;
    public static const LOOP_TIME_START:Number = 0.5;

    private static const vector:Vector3D = new Vector3D();
    private static const vector3:Vector3 = new Vector3();

    private var container:Scene3DContainer;
    private var target:Object3D;
    private var shine1:Sprite3D;
    private var shine2:Sprite3D;
    private var heart:Sprite3D;
    private var time:Number;
    private var fadeOutTime:Number;
    private var fadeOut:Boolean;
    private var startSound:Sound3D;
    private var loopSound:Sound3D;
    private var stopSound:Sound3D;
    private var startSoundPlayed:Boolean = false;
    private var loopSoundPlayed:Boolean = false;

    public function FieldEffect(param1:Pool) {
      super(param1);
      this.shine1 = new Sprite3D(SHINE_SIZE,SHINE_SIZE);
      this.shine2 = new Sprite3D(SHINE_SIZE,SHINE_SIZE);
      this.heart = new Sprite3D(HEART_SIZE,HEART_SIZE);
      this.shine1.useLight = false;
      this.shine1.useShadowMap = false;
      this.shine1.blendMode = BlendMode.ADD;
      this.shine1.softAttenuation = 200;
      this.shine2.useLight = false;
      this.shine2.useShadowMap = false;
      this.shine2.blendMode = BlendMode.ADD;
      this.shine2.rotation = Math.PI;
      this.shine2.softAttenuation = 200;
      this.heart.useLight = false;
      this.heart.useShadowMap = false;
      this.heart.blendMode = BlendMode.ADD;
      this.heart.softAttenuation = 200;
    }

    public function init(param1:TextureMaterial, param2:TextureMaterial, param3:Object3D, param4:Sound3D, param5:Sound3D, param6:Sound3D) : void {
      this.target = param3;
      this.startSound = param4;
      this.loopSound = param5;
      this.stopSound = param6;
      this.shine1.material = param1;
      this.shine2.material = param1;
      this.heart.material = param2;
      this.shine2.scaleX = MIN + HALF;
      this.shine2.scaleY = MIN + HALF;
      this.shine2.scaleZ = MIN + HALF;
      this.time = 0;
      this.fadeOutTime = 0;
      this.fadeOut = false;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.shine1);
      param1.addChild(this.shine2);
      param1.addChild(this.heart);
      this.startSoundPlayed = false;
      this.loopSoundPlayed = false;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local6:Number = NaN;
      var local3:Number = param1 / 1000;
      this.time += local3;
      this.playSounds(param2);
      vector.x = param2.x - this.target.x;
      vector.y = param2.y - this.target.y;
      vector.z = param2.z - this.target.z + 50;
      vector.normalize();
      this.shine1.x = this.target.x + vector.x * SHINE_OFFSET;
      this.shine1.y = this.target.y + vector.y * SHINE_OFFSET;
      this.shine1.z = this.target.z + vector.z * SHINE_OFFSET + 50;
      this.shine2.x = this.shine1.x;
      this.shine2.y = this.shine1.y;
      this.shine2.z = this.shine1.z;
      this.heart.x = this.target.x + vector.x * HEART_OFFSET;
      this.heart.y = this.target.y + vector.y * HEART_OFFSET;
      this.heart.z = this.target.z + vector.z * HEART_OFFSET + 50;
      var local4:Number = local3 * 0.75;
      var local5:Number = this.shine1.scaleX + local4;
      if(local5 > 1) {
        local5 = MIN;
      }
      this.shine1.scaleX = local5;
      this.shine1.scaleY = local5;
      this.shine1.scaleZ = local5;
      this.shine1.alpha = 1 - Math.abs(MIN + HALF - local5) / HALF;
      this.shine1.alpha = Math.sqrt(this.shine1.alpha);
      local5 = this.shine2.scaleX + local4;
      if(local5 > 1) {
        local5 = MIN;
      }
      this.shine2.scaleX = local5;
      this.shine2.scaleY = local5;
      this.shine2.scaleZ = local5;
      this.shine2.alpha = 1 - Math.abs(MIN + HALF - local5) / HALF;
      this.shine2.alpha = Math.sqrt(this.shine2.alpha);
      local5 = 0.9 + Math.sin(this.time * 8) / 10;
      this.heart.scaleX = local5;
      this.heart.scaleY = local5;
      this.heart.scaleZ = local5;
      this.heart.alpha = local5;
      if(this.heart.alpha > 1) {
        this.heart.alpha = 1;
      }
      if(this.fadeOut) {
        this.fadeOutTime += local3;
        local6 = (FADE - this.fadeOutTime) / FADE;
        this.shine1.alpha *= local6;
        this.shine2.alpha *= local6;
        this.heart.alpha *= local6;
        return local6 > 0;
      }
      if(this.time <= FADE) {
        local6 = this.time / FADE;
        this.shine1.alpha *= local6;
        this.shine2.alpha *= local6;
        this.heart.alpha *= local6;
        return true;
      }
      local6 = 1;
      this.shine1.alpha *= local6;
      this.shine2.alpha *= local6;
      this.heart.alpha *= local6;
      return true;
    }

    private function playSounds(param1:GameCamera) : void {
      vector3.reset(this.target.x,this.target.y,this.target.z);
      if(!this.startSoundPlayed) {
        this.startSound.play(0,0);
        this.startSound.checkVolume(param1.position,vector3,param1.xAxis);
        this.startSoundPlayed = true;
      }
      if(this.time >= LOOP_TIME_START) {
        if(!this.loopSoundPlayed) {
          this.loopSound.play(0,100000);
          this.loopSoundPlayed = true;
        }
        this.loopSound.checkVolume(param1.position,vector3,param1.xAxis);
      }
      this.stopSound.checkVolume(param1.position,vector3,param1.xAxis);
    }

    public function stop(param1:Boolean) : void {
      this.startSound.stop();
      this.loopSound.stop();
      if(param1) {
        this.stopSound.play(0,0);
      }
      this.fadeOut = true;
    }

    public function destroy() : void {
      this.container.removeChild(this.shine1);
      this.container.removeChild(this.shine2);
      this.container.removeChild(this.heart);
      this.startSound.stop();
      this.loopSound.stop();
      this.stopSound.stop();
      this.startSound = null;
      this.loopSound = null;
      this.stopSound = null;
      this.shine1.material = null;
      this.shine2.material = null;
      this.heart.material = null;
      this.container = null;
      this.target = null;
      recycle();
    }

    public function kill() : void {
      this.shine1.alpha = 0;
      this.shine2.alpha = 0;
      this.heart.alpha = 0;
    }
  }
}
