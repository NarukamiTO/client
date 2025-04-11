package alternativa.tanks.models.weapon.gauss.sfx {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.weapon.BasicGlobalGunParams;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.LightAnimation;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.media.Sound;

  public class GaussPowerShotEffect extends PooledObject implements GraphicEffect {
    [Inject]
    public static var battleService:BattleService;

    private const EXPLOSION_OFFSET_TO_CAMERA:Number = 110;
    private const EXPLOSION_SPRITE_SIZE:Number = 1500;
    private const FAR_SHOT_MIN_DISTANCE:Number = 10000;

    private var sfxData:GaussSFXData;
    private var weaponPlatform:WeaponPlatform;
    private var target:Body;
    private var shotCounter:int;

    protected var hitPoint:Vector3;

    public function GaussPowerShotEffect(param1:Pool) {
      super(param1);
    }

    public function init(param1:GaussSFXData, param2:WeaponPlatform, param3:Body, param4:Vector3) : void {
      this.sfxData = param1;
      this.weaponPlatform = param2;
      this.target = param3;
      this.hitPoint = param4;
      var local5:BasicGlobalGunParams = new BasicGlobalGunParams();
      param2.getBasicGunParams(local5);
      this.createPowerMuzzleEffect(local5);
      this.createShotSound(local5.muzzlePosition);
      this.createLightningEffect(local5.muzzlePosition,param4);
      this.createPowerExplosionEffect();
      this.createExplosionSound(param4);
    }

    private function createPowerMuzzleEffect(param1:BasicGlobalGunParams) : void {
      var local2:* = new Vector3().copy(this.hitPoint).subtract(param1.muzzlePosition).normalize().scale(50).add(param1.muzzlePosition);
      this.createElectroEffect(param1.muzzlePosition,200 + Math.random() * 50,0);
      this.createElectroEffect(local2,300 + Math.random() * 50,0);
    }

    private function createShotSound(param1:Vector3) : void {
      var local2:* = battleService.getBattleScene3D().getCamera().position.distanceTo(param1);
      var local3:Sound = local2 < this.FAR_SHOT_MIN_DISTANCE ? this.sfxData.secondaryShotSound : this.sfxData.powerShotFarSounds[this.shotCounter % this.sfxData.powerShotFarSounds.length];
      battleService.addSound3DEffect(Sound3DEffect.create(param1,Sound3D.create(local3)));
      ++this.shotCounter;
    }

    private function createLightningEffect(param1:Vector3, param2:Vector3) : void {
      var local3:GaussLightningEffect = GaussLightningEffect(this.getObjectPool().getObject(GaussLightningEffect));
      local3.init(param1,param2,this.sfxData.trailTextureMaterial,this.sfxData.lightningTextureMaterial);
      battleService.addGraphicEffect(local3);
    }

    private function createPowerExplosionEffect() : void {
      this.createExplosionEffect(this.hitPoint);
      this.addLightAnimation(this.hitPoint,this.sfxData.secondaryExplosionLightAnimation);
      this.createElectroEffect(this.hitPoint,600 + Math.random() * 200,20 / 60);
      this.createElectroEffect(this.hitPoint,600 + Math.random() * 200,26 / 60);
      this.createElectroEffect(this.hitPoint,600 + Math.random() * 200,30 / 60);
    }

    private function createElectroEffect(param1:Vector3, param2:Number, param3:Number) : void {
      var local4:GaussElectroEffect = GaussElectroEffect(battleService.getObjectPool().getObject(GaussElectroEffect));
      local4.init(param1,param2,this.sfxData.electroTextureMaterial,param3);
      battleService.addGraphicEffect(local4);
    }

    private function addLightAnimation(param1:Vector3, param2:LightAnimation) : void {
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local3.init(param1,this.EXPLOSION_OFFSET_TO_CAMERA);
      var local4:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
      local4.init(local3,param2);
      battleService.addGraphicEffect(local4);
    }

    private function createExplosionEffect(param1:Vector3) : void {
      var local2:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local2.init(param1,this.EXPLOSION_OFFSET_TO_CAMERA);
      var local3:AnimatedSpriteEffect = AnimatedSpriteEffect(this.getObjectPool().getObject(AnimatedSpriteEffect));
      var local4:* = Math.random() * Math.PI - Math.PI / 2;
      local3.init(this.EXPLOSION_SPRITE_SIZE,this.EXPLOSION_SPRITE_SIZE,this.sfxData.explosionElectroTextureAnimation,local4,local2);
      battleService.addGraphicEffect(local3);
    }

    private function getObjectPool() : ObjectPool {
      return battleService.getObjectPool();
    }

    private function createExplosionSound(param1:Vector3) : void {
      battleService.addSound3DEffect(Sound3DEffect.create(param1,Sound3D.create(this.sfxData.secondaryHitSound)));
    }

    public function addedToScene(param1:Scene3DContainer) : void {
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      return false;
    }

    public function destroy() : void {
    }

    public function kill() : void {
    }
  }
}
