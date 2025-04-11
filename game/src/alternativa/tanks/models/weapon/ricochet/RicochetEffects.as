package alternativa.tanks.models.weapon.ricochet {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.MuzzlePositionProvider;
  import alternativa.tanks.sfx.PlaneMuzzleFlashEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;

  public class RicochetEffects {
    public static const MUZZLE_FLASH_SIZE:Number = 150;

    private static const MUZZLE_FLASH_DURATION:int = 100;

    private var battleService:BattleService;
    private var sfxData:RicochetSFXData;

    public function RicochetEffects(param1:BattleService, param2:RicochetSFXData) {
      super();
      this.battleService = param1;
      this.sfxData = param2;
    }

    public function createShotEffects(param1:Object3D, param2:Vector3, param3:Vector3) : void {
      var local5:Number = NaN;
      var local6:Sound3D = null;
      var local7:Sound3DEffect = null;
      var local4:PlaneMuzzleFlashEffect = PlaneMuzzleFlashEffect(this.battleService.getObjectPool().getObject(PlaneMuzzleFlashEffect));
      local4.init(param2,param1,this.sfxData.muzzleFlashMaterial,MUZZLE_FLASH_DURATION,MUZZLE_FLASH_SIZE,MUZZLE_FLASH_SIZE);
      this.battleService.addGraphicEffect(local4);
      if(this.sfxData.shotSound != null) {
        local5 = 0.8;
        local6 = Sound3D.create(this.sfxData.shotSound,local5);
        local7 = Sound3DEffect.create(param3,local6);
        this.battleService.addSound3DEffect(local7);
      }
    }

    public function createLightEffect(param1:Object3D, param2:Vector3) : void {
      var local3:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local4:MuzzlePositionProvider = MuzzlePositionProvider(this.battleService.getObjectPool().getObject(MuzzlePositionProvider));
      local4.init(param1,param2);
      local3.init(local4,this.sfxData.shotLightAnimation);
      this.battleService.addGraphicEffect(local3);
    }
  }
}
