package alternativa.tanks.models.tank.explosion {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.AnimatedPlaneEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.LightAnimation;
  import alternativa.tanks.sfx.MovingObject3DPositionProvider;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.GraphicsUtils;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import flash.media.Sound;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.armor.explosion.ITankExplosionModelBase;
  import projects.tanks.client.battlefield.models.tankparts.armor.explosion.TankExplosionModelBase;

  [ModelInfo]
  public class TankExplosionModel extends TankExplosionModelBase implements ITankExplosionModelBase, ObjectLoadListener, ObjectUnloadListener, ITankExplosionModel {
    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    private static const EXPLOSION_SIZE:Number = 800;
    private static const SMOKE_SIZE:Number = 400;
    private static const SHOCKWAVE_SIZE:Number = 1000;
    private static const BASE_DIAGONAL:Number = 600;
    private static const MIN_SMOKE_SPEED:Number = 800;
    private static const SMOKE_SPEED_DELTA:Number = 200;
    private static const SMOKE_ACCELERATION:Number = -2000;
    private static const EXPLOSION_FIRE_OFFSET_TO_CAMERA:int = 200;
    private static const EXPLOSION_SOUND_VOLUME:Number = 0.4;

    private const rayHit:RayHit = new RayHit();
    private const position:Vector3 = new Vector3();
    private const eulerAngles:Vector3 = new Vector3();
    private const velocity:Vector3 = new Vector3();
    private const matrix:Matrix3 = new Matrix3();

    public function TankExplosionModel() {
      super();
    }

    private static function getEffectScale(param1:Tank) : Number {
      var local2:Mesh = param1.getSkin().getHullMesh();
      var local3:Number = local2.boundMaxX - local2.boundMinX;
      var local4:Number = local2.boundMaxY - local2.boundMinY;
      var local5:Number = local2.boundMaxZ - local2.boundMinZ;
      var local6:Number = Math.sqrt(local3 * local3 + local4 * local4 + local5 * local5);
      return local6 / BASE_DIAGONAL;
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:TextureAnimation = this.getTextureAnimation(getInitParam().explosionTexture,EXPLOSION_SIZE);
      var local2:TextureAnimation = this.getTextureAnimation(getInitParam().shockWaveTexture,SHOCKWAVE_SIZE);
      var local3:TextureAnimation = this.getTextureAnimation(getInitParam().smokeTextureId,SMOKE_SIZE);
      var local4:ExplosionData = new ExplosionData(local1,local2,local3);
      putData(ExplosionData,local4);
    }

    private function getTextureAnimation(param1:MultiframeTextureResource, param2:Number) : TextureAnimation {
      var local3:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      local3.material.resolution = param2 / param1.frameWidth;
      return local3;
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      this.releaseMaterials(ExplosionData(getData(ExplosionData)));
    }

    public function createExplosionEffects(param1:IGameObject, param2:Tank, param3:LightAnimation) : void {
      var local4:ExplosionData = ExplosionData(getData(ExplosionData));
      var local5:ObjectPool = battleService.getObjectPool();
      var local6:Number = getEffectScale(param2);
      this.createExplosionShockWave(param2,local5,local6,local4);
      this.createExplosionFire(local5,local6,local4);
      this.createExplosionSmoke(local5,local6,local4);
      this.createExplosionLighting(local5,param3);
      this.createExplosionSound(param2);
    }

    private function createExplosionSound(param1:Tank) : void {
      var local3:Sound3D = null;
      var local4:Object3D = null;
      var local2:Sound = battleService.getTankExplosionSound();
      if(local2 != null) {
        local3 = Sound3D.create(local2,EXPLOSION_SOUND_VOLUME);
        local4 = param1.getSkin().getTurret3D();
        battleService.addSound3DEffect(Sound3DEffect.create(new Vector3(local4.x,local4.y,local4.z),local3,0,0));
      }
    }

    private function createExplosionLighting(param1:ObjectPool, param2:LightAnimation) : void {
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(param1.getObject(StaticObject3DPositionProvider));
      var local4:AnimatedLightEffect = AnimatedLightEffect(param1.getObject(AnimatedLightEffect));
      local3.init(this.position,0);
      local4.init(local3,param2);
      battleService.addGraphicEffect(local4);
    }

    private function releaseMaterials(param1:ExplosionData) : void {
      materialRegistry.releaseMaterial(param1.flameAnimation.material);
      materialRegistry.releaseMaterial(param1.shockWaveAnimation.material);
      materialRegistry.releaseMaterial(param1.smokeAnimation.material);
    }

    private function createExplosionShockWave(param1:Tank, param2:ObjectPool, param3:Number, param4:ExplosionData) : void {
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Vector3 = null;
      var local10:Number = NaN;
      var local11:Vector3 = null;
      var local12:AnimatedPlaneEffect = null;
      var local5:Vector3 = new Vector3(0,0,-1);
      var local6:Number = 500;
      this.position.copy(param1.getBody().state.position);
      if(battleService.getBattleRunner().getCollisionDetector().raycastStatic(this.position,local5,255,local6,null,this.rayHit)) {
        this.rayHit.position.z += 10;
        local7 = SHOCKWAVE_SIZE;
        local8 = 200;
        if(this.rayHit.t > local8) {
          local7 *= (local6 - this.rayHit.t) / (local6 - local8);
        }
        local9 = this.rayHit.normal;
        local10 = Math.acos(local9.z);
        local11 = new Vector3(-local9.y,local9.x,0);
        local11.normalize();
        this.matrix.fromAxisAngle(local11,local10);
        this.matrix.getEulerAngles(this.eulerAngles);
        local12 = AnimatedPlaneEffect(param2.getObject(AnimatedPlaneEffect));
        local12.init(param3 * local7,this.rayHit.position,this.eulerAngles,param4.shockWaveAnimation,1);
        battleService.getBattleScene3D().addGraphicEffect(local12);
      }
    }

    private function createExplosionFire(param1:ObjectPool, param2:Number, param3:ExplosionData) : void {
      this.position.z += 50;
      var local4:StaticObject3DPositionProvider = StaticObject3DPositionProvider(param1.getObject(StaticObject3DPositionProvider));
      local4.init(this.position,EXPLOSION_FIRE_OFFSET_TO_CAMERA);
      var local5:AnimatedSpriteEffect = AnimatedSpriteEffect(param1.getObject(AnimatedSpriteEffect));
      var local6:Number = EXPLOSION_SIZE * param2;
      local5.init(local6,local6,param3.flameAnimation,Math.random() * 2 * Math.PI,local4);
      battleService.getBattleScene3D().addGraphicEffect(local5);
    }

    private function createExplosionSmoke(param1:ObjectPool, param2:Number, param3:ExplosionData) : void {
      var local5:Number = NaN;
      var local6:MovingObject3DPositionProvider = null;
      var local7:AnimatedSpriteEffect = null;
      var local8:Number = NaN;
      var local4:int = 0;
      while(local4 < 3) {
        local5 = MIN_SMOKE_SPEED + Math.random() * SMOKE_SPEED_DELTA;
        this.velocity.x = local5 * (1 - 2 * Math.random());
        this.velocity.y = local5 * (1 - 2 * Math.random());
        this.velocity.z = local5 * 0.5 * (1 + Math.random());
        local6 = MovingObject3DPositionProvider(param1.getObject(MovingObject3DPositionProvider));
        local6.init(this.position,this.velocity,SMOKE_ACCELERATION);
        local7 = AnimatedSpriteEffect(param1.getObject(AnimatedSpriteEffect));
        local8 = SMOKE_SIZE * param2;
        local7.init(local8,local8,param3.smokeAnimation,Math.random() * 2 * Math.PI,local6);
        battleService.getBattleScene3D().addGraphicEffect(local7);
        local4++;
      }
    }
  }
}
