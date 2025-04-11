package alternativa.tanks.models.weapon.thunder {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.MuzzlePositionProvider;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.objectpool.ObjectPool;

  public class ThunderEffects implements IThunderEffects {
    private static const SHOT_VOLUME:Number = 0.7;
    private static const EXPLOSION_VOLUME:Number = 0.7;
    private static const EXPLOSION_OFFSET_TO_CAMERA:Number = 110;
    private static const DECAL_RADIUS:Number = 250;
    private static const turretMatrix:Matrix4 = new Matrix4();
    private static const muzzlePosition:Vector3 = new Vector3();

    private var battleService:BattleService;
    private var sfxData:ThunderSFXData;

    public function ThunderEffects(param1:BattleService, param2:ThunderSFXData) {
      super();
      this.battleService = param1;
      this.sfxData = param2;
    }

    public function createShotEffects(param1:Vector3, param2:Object3D) : void {
      var local3:ThunderShotEffect = ThunderShotEffect(this.battleService.getObjectPool().getObject(ThunderShotEffect));
      local3.init(param2,param1,this.sfxData.muzzleFlashMaterial);
      this.battleService.addGraphicEffect(local3);
      turretMatrix.setMatrix(param2.x,param2.y,param2.z,param2.rotationX,param2.rotationY,param2.rotationZ);
      turretMatrix.transformVector(param1,muzzlePosition);
      var local4:Sound3D = Sound3D.create(this.sfxData.shotSound,SHOT_VOLUME);
      this.battleService.addSound3DEffect(Sound3DEffect.create(muzzlePosition,local4));
      this.createShotLightEffects(param1,param2);
    }

    public function createShotLightEffects(param1:Vector3, param2:Object3D) : void {
      var local3:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local4:MuzzlePositionProvider = MuzzlePositionProvider(this.battleService.getObjectPool().getObject(MuzzlePositionProvider));
      local4.init(param2,param1);
      local3.init(local4,this.sfxData.shotLightAnimation);
      this.battleService.addGraphicEffect(local3);
    }

    public function createExplosionEffects(param1:Vector3) : void {
      this.createExplosionGraphicEffect(param1);
      this.createExplosionSoundEffect(param1);
      this.createExplosionLightEffect(param1);
    }

    private function createExplosionLightEffect(param1:Vector3) : void {
      var local2:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local3.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
      local2.init(local3,this.sfxData.hitLightAnimation);
      this.battleService.addGraphicEffect(local2);
    }

    public function createExplosionMark(param1:Vector3, param2:Vector3) : void {
      this.battleService.getBattleScene3D().addDecal(param2,param1,DECAL_RADIUS,this.sfxData.explosionMarkMaterial);
    }

    private function createExplosionGraphicEffect(param1:Vector3) : void {
      var local2:ObjectPool = this.battleService.getObjectPool();
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(local2.getObject(StaticObject3DPositionProvider));
      local3.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
      var local4:AnimatedSpriteEffect = AnimatedSpriteEffect(local2.getObject(AnimatedSpriteEffect));
      local4.init(this.sfxData.explosionSize,this.sfxData.explosionSize,this.sfxData.explosionAnimation,Math.random() * 2 * Math.PI,local3);
      this.battleService.addGraphicEffect(local4);
    }

    private function createExplosionSoundEffect(param1:Vector3) : void {
      var local2:Sound3D = Sound3D.create(this.sfxData.explosionSound,EXPLOSION_VOLUME);
      this.battleService.addSound3DEffect(Sound3DEffect.create(param1,local2));
    }
  }
}
