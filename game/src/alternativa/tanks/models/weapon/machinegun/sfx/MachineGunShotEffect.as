package alternativa.tanks.models.weapon.machinegun.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.engine3d.AnimatedSprite3D;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.weapon.BasicGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponUtils;
  import alternativa.tanks.sfx.AnimatedPlane;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;

  public class MachineGunShotEffect extends PooledObject implements GraphicEffect {
    [Inject]
    public static var battleService:BattleService;

    private static const SPARKLES_SIZE:int = 150;
    private static const TANK_SPARKLES_SIZE:int = 200;
    private static const SPARKLES_OFFSET_TO_CAMERA:int = 50;
    private static const FIRE_ALONG_WIDTH:Number = 150;
    private static const FIRE_ALONG_LENGTH:Number = 210;
    private static const FIRE_ALONG_Y_OFFSET:Number = -10;
    private static const FIRE_ACROSS_SIZE:Number = 130;
    private static const FIRE_ACROSS_Y_OFFSET:Number = 35;
    private static const SMOKE_Y_OFFSET:Number = 60;
    private static const SMOKE_SIZE:Number = 170;
    private static const SMOKE_SPEED:Number = 300;
    private static const SMOKE_TOP:Number = 170;
    private static const SMOKE_INTERVAL:Number = 0.3;
    private static const TRACER_Y_OFFSET:Number = 50;
    private static const TRACER_MAX_LENGTH:Number = 22222;
    private static const gunParams:BasicGlobalGunParams = new BasicGlobalGunParams();
    private static const origin:Vector3 = new Vector3();
    private static const tracerDirection:Vector3 = new Vector3();

    private const fireAlong:AnimatedPlane = new AnimatedPlane(FIRE_ALONG_WIDTH,FIRE_ALONG_LENGTH,0,FIRE_ALONG_LENGTH * 0.5,0);
    private const fireAcross:AnimatedPlane = new AnimatedPlane(FIRE_ACROSS_SIZE,FIRE_ACROSS_SIZE,0,0,0);
    private const sparkles:AnimatedSprite3D = new AnimatedSprite3D(SPARKLES_SIZE,SPARKLES_SIZE);
    private const tankSparkles:AnimatedSprite3D = new AnimatedSprite3D(TANK_SPARKLES_SIZE,TANK_SPARKLES_SIZE);
    private const tracer:Tracer = new Tracer();
    private const smoke:Smoke = new Smoke(SMOKE_SIZE,SMOKE_SPEED,SMOKE_TOP,SMOKE_INTERVAL);
    private const targetPosition:Vector3 = new Vector3();
    private const muzzleLocalPoint:Vector3 = new Vector3();

    private var time:Number = 0;
    private var container:Scene3DContainer;
    private var machineGunSFX:MachineGunSFXData;
    private var turret:Object3D;
    private var sparklesPosProvider:StaticObject3DPositionProvider;
    private var isPlaying:Boolean;
    private var isShooting:Boolean;
    private var hasHit:Boolean;
    private var isHitInTank:Boolean;
    private var isDummyShot:Boolean;

    public function MachineGunShotEffect(param1:Pool) {
      super(param1);
      SFXUtils.setEffectParams(this.fireAlong);
      SFXUtils.setEffectParams(this.fireAcross);
    }

    public function init(param1:Object3D, param2:Vector3, param3:MachineGunSFXData) : void {
      this.machineGunSFX = param3;
      this.turret = param1;
      this.muzzleLocalPoint.copy(param2);
      WeaponUtils.calculateBasicGunParams(param1,param2,gunParams);
      this.initFire(param3);
      this.targetPosition.copy(gunParams.muzzlePosition);
      this.smoke.setAnimation(param3.smokeTexture);
      this.tracer.init(param3.tracerTexture);
      this.sparklesPosProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      this.sparklesPosProvider.init(this.targetPosition,SPARKLES_OFFSET_TO_CAMERA);
      this.sparkles.looped = true;
      this.sparkles.setAnimationData(param3.sparklesTexture);
      this.tankSparkles.looped = true;
      this.tankSparkles.setAnimationData(param3.tankSparklesTexture);
      this.time = 0;
      this.hasHit = false;
      this.isDummyShot = false;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.fireAlong);
      param1.addChild(this.fireAcross);
      param1.addChild(this.tracer);
      param1.addChild(this.sparkles);
      param1.addChild(this.tankSparkles);
      this.smoke.setContainer(param1);
      this.smoke.start();
      this.tracer.visible = true;
      this.fireAlong.visible = true;
      this.fireAcross.visible = true;
      this.isShooting = true;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      WeaponUtils.calculateBasicGunParams(this.turret,this.muzzleLocalPoint,gunParams);
      var local3:Number = param1 / 1000;
      this.playFire(param2);
      this.playTracerAndSparkles(local3,param2,param1);
      this.playSmokeAndSetPlaying(local3);
      this.time += local3;
      return this.isPlaying || this.isShooting;
    }

    public function setTargetPosition(param1:Vector3, param2:Boolean) : void {
      this.targetPosition.copy(param1);
      this.hasHit = true;
      this.isHitInTank = param2;
    }

    public function clearTargetPosition(param1:Boolean) : void {
      this.hasHit = false;
      this.isDummyShot = param1;
    }

    public function destroy() : void {
      this.kill();
      this.fireAcross.clear();
      this.fireAlong.clear();
      this.smoke.clear();
      this.sparkles.clear();
      this.tankSparkles.clear();
      this.container = null;
      this.machineGunSFX = null;
      this.turret = null;
      this.sparklesPosProvider.destroy();
      this.sparklesPosProvider = null;
      recycle();
    }

    public function kill() : void {
      this.container.removeChild(this.fireAlong);
      this.container.removeChild(this.fireAcross);
      this.container.removeChild(this.tracer);
      this.container.removeChild(this.sparkles);
      this.container.removeChild(this.tankSparkles);
    }

    public function stop() : void {
      this.smoke.stop();
      this.tracer.visible = false;
      this.fireAlong.visible = false;
      this.fireAcross.visible = false;
      this.sparkles.visible = false;
      this.tankSparkles.visible = false;
      this.isShooting = false;
    }

    private function initFire(param1:MachineGunSFXData) : void {
      var local2:TextureAnimation = param1.fireAlongTexture;
      this.fireAlong.init(local2,local2.fps);
      this.fireAlong.blendMode = BlendMode.ADD;
      var local3:TextureAnimation = param1.fireAcrossTexture;
      this.fireAcross.init(local3,local3.fps);
      this.fireAcross.blendMode = BlendMode.ADD;
      this.rotateAcrossEffect();
    }

    private function rotateAcrossEffect() : void {
      var local1:Number = gunParams.direction.x;
      var local2:Number = gunParams.direction.y;
      this.fireAcross.rotationX = Math.atan2(gunParams.direction.z,Math.sqrt(local1 * local1 + local2 * local2)) - Math.PI / 2;
      this.fireAcross.rotationY = 0;
      this.fireAcross.rotationZ = -Math.atan2(local1,local2);
    }

    private function playFire(param1:GameCamera) : void {
      SFXUtils.calculateAlphaForObject(this.fireAlong,param1.position,gunParams.direction,false,8,0.9);
      SFXUtils.calculateAlphaForObject(this.fireAcross,param1.position,gunParams.direction,true,4,0.3);
      this.offsetPosition(gunParams.muzzlePosition,gunParams.direction,FIRE_ALONG_Y_OFFSET,origin);
      SFXUtils.alignObjectPlaneToView(this.fireAlong,origin,gunParams.direction,param1.position);
      this.fireAlong.setTime(this.time % this.fireAlong.getOneLoopTime());
      this.rotateAcrossEffect();
      this.alignObject(this.fireAcross,gunParams.muzzlePosition,gunParams.direction,FIRE_ACROSS_Y_OFFSET);
      this.fireAcross.setTime(this.time % this.fireAcross.getOneLoopTime());
    }

    private function playTracerAndSparkles(param1:Number, param2:GameCamera, param3:int) : void {
      var local4:Number = NaN;
      if(this.hasHit) {
        tracerDirection.copy(this.targetPosition);
        tracerDirection.subtract(gunParams.muzzlePosition);
        local4 = tracerDirection.length();
        tracerDirection.normalize();
        this.playSparkles(param1,param2,param3);
      } else {
        local4 = this.isDummyShot ? 0 : TRACER_MAX_LENGTH;
        tracerDirection.copy(gunParams.direction);
        this.hideSparkles();
      }
      this.offsetPosition(gunParams.muzzlePosition,gunParams.direction,TRACER_Y_OFFSET,origin);
      SFXUtils.alignObjectPlaneToView(this.tracer,origin,tracerDirection,param2.position);
      this.tracer.update(param3,local4 - TRACER_Y_OFFSET);
    }

    private function playSparkles(param1:Number, param2:GameCamera, param3:int) : void {
      this.hideSparkles();
      var local4:AnimatedSprite3D = this.isHitInTank ? this.tankSparkles : this.sparkles;
      local4.visible = this.isShooting;
      local4.update(param1);
      this.sparklesPosProvider.init(this.targetPosition,SPARKLES_OFFSET_TO_CAMERA);
      this.sparklesPosProvider.updateObjectPosition(local4,param2,param3);
    }

    private function hideSparkles() : void {
      this.sparkles.visible = false;
      this.tankSparkles.visible = false;
    }

    private function playSmokeAndSetPlaying(param1:Number) : void {
      this.offsetPosition(gunParams.muzzlePosition,gunParams.direction,SMOKE_Y_OFFSET,origin);
      this.smoke.setEmitterPosition(origin);
      this.isPlaying = this.smoke.update(param1);
    }

    private function offsetPosition(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3) : void {
      param4.copy(param1).addScaled(param3,param2);
    }

    private function alignObject(param1:Object3D, param2:Vector3, param3:Vector3, param4:Number) : void {
      param1.x = param2.x + param4 * param3.x;
      param1.y = param2.y + param4 * param3.y;
      param1.z = param2.z + param4 * param3.z;
    }
  }
}
