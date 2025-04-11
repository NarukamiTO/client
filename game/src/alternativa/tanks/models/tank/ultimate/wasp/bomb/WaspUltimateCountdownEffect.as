package alternativa.tanks.models.tank.ultimate.wasp.bomb {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.engine3d.AnimatedSprite3D;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.utils.MathUtils;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class WaspUltimateCountdownEffect extends PooledObject implements GraphicEffect {
    private static const WIDTH:Number = 200;
    private static const HEIGHT:Number = 200;
    private static const ORIGIN_X:Number = 0.5;
    private static const ORIGIN_Y:Number = 1;
    private static const BLEND_MODE:String = "normal";
    private static const SOFT_ATTENUATION:Number = 130;
    private static const COUNTDOWN_Z_OFFSET:Number = 150;
    private static const DISTANCE_CHECK_TOLERANCE:Number = 10;
    private static const FAST_BEEPS:int = 4;

    private var alive:Boolean = true;
    private var spriteDanger:AnimatedSprite3D = this.createSprite();
    private var spriteHarmless:AnimatedSprite3D = this.createSprite();
    private var position:Vector3 = new Vector3();
    private var container:Scene3DContainer = null;
    private var initialTime:Number = 0;
    private var time:Number = 0;
    private var currentFrame:int = -1;
    private var lastFastBeep:int = -1;
    private var beepSound:Sound3D;
    private var dangerousStateAnimation:TextureAnimation = null;
    private var harmlessStateAnimation:TextureAnimation;
    private var damageCenter:Vector3 = new Vector3();
    private var squaredDamageRadius:Number;

    public var isHarmless:Boolean = false;

    private var localTankPositionProvider:LocalTankPositionProvider;
    private var localTankPosition:Vector3 = new Vector3();

    public function WaspUltimateCountdownEffect(param1:Pool) {
      super(param1);
    }

    private function createSprite() : AnimatedSprite3D {
      var local1:AnimatedSprite3D = new AnimatedSprite3D(WIDTH,HEIGHT);
      local1.originX = ORIGIN_X;
      local1.originY = ORIGIN_Y;
      local1.blendMode = BLEND_MODE;
      local1.softAttenuation = SOFT_ATTENUATION;
      return local1;
    }

    public function init(param1:Vector3, param2:Vector3, param3:Number, param4:Number, param5:LocalTankPositionProvider, param6:Boolean, param7:TextureAnimation, param8:TextureAnimation, param9:Sound3D) : void {
      this.position.copy(param1);
      this.damageCenter.copy(param2);
      this.squaredDamageRadius = MathUtils.square(param3 + DISTANCE_CHECK_TOLERANCE);
      this.initialTime = param4;
      this.localTankPositionProvider = param5;
      this.isHarmless = param6;
      this.dangerousStateAnimation = param7;
      this.harmlessStateAnimation = param8;
      this.beepSound = param9;
      this.alive = true;
      this.time = 0;
      this.currentFrame = -1;
      this.lastFastBeep = -1;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      this.setupSprite(this.spriteDanger,this.dangerousStateAnimation);
      this.setupSprite(this.spriteHarmless,this.harmlessStateAnimation);
      param1.addChild(this.spriteDanger);
      param1.addChild(this.spriteHarmless);
    }

    private function setupSprite(param1:AnimatedSprite3D, param2:TextureAnimation) : void {
      param1.x = this.position.x;
      param1.y = this.position.y;
      param1.z = this.position.z + COUNTDOWN_Z_OFFSET;
      param1.setAnimationData(param2);
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local7:int = 0;
      this.time += param1 / 1000;
      var local3:Number = this.initialTime - this.time;
      var local4:int = Math.ceil(local3);
      var local5:int = this.dangerousStateAnimation.frames.length - 1;
      var local6:int = local5 - local4;
      this.beepSound.checkVolume(param2.position,this.position,param2.xAxis);
      if(local6 <= 0) {
        this.spriteDanger.visible = false;
        this.spriteHarmless.visible = false;
        return true;
      }
      if(local6 >= local5) {
        this.spriteDanger.visible = false;
        this.spriteHarmless.visible = false;
        return false;
      }
      this.selectSprite();
      if(local6 != this.currentFrame) {
        this.spriteDanger.setFrameIndex(local6);
        this.spriteHarmless.setFrameIndex(local6);
        this.currentFrame = local6;
        this.beepSound.play(0,0);
      } else if(local3 < 1) {
        local7 = Math.floor(FAST_BEEPS * local3);
        if(local7 != this.lastFastBeep) {
          this.beepSound.play(0,0);
          this.lastFastBeep = local7;
        }
      }
      return this.alive;
    }

    private function selectSprite() : void {
      this.localTankPositionProvider.getLocalTankPosition(this.localTankPosition);
      var local1:Boolean = this.isHarmless || this.localTankPosition.distanceToSquared(this.damageCenter) > this.squaredDamageRadius;
      this.spriteDanger.visible = !local1;
      this.spriteHarmless.visible = local1;
    }

    public function destroy() : void {
      this.container.removeChild(this.spriteDanger);
      this.container.removeChild(this.spriteHarmless);
      this.container = null;
      this.dangerousStateAnimation = null;
      this.localTankPositionProvider = null;
      this.beepSound.stop();
      this.spriteDanger.clear();
      this.spriteHarmless.clear();
      recycle();
    }

    public function kill() : void {
      this.spriteDanger.visible = false;
      this.beepSound.stop();
    }

    public function stop() : void {
      this.alive = false;
    }
  }
}
