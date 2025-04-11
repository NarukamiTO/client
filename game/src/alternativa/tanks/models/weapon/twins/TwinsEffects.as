package alternativa.tanks.models.weapon.twins {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.MuzzlePositionProvider;
  import alternativa.tanks.sfx.PlaneMuzzleFlashEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;

  public class TwinsEffects {
    public static const FLASH_SIZE:int = 120;

    private static const FLASH_LIFE_TIME:int = 50;

    private var battleService:BattleService;
    private var sfxData:TwinsSFXData;

    public function TwinsEffects(param1:BattleService, param2:TwinsSFXData) {
      super();
      this.battleService = param1;
      this.sfxData = param2;
    }

    public function createShotEffects(param1:Object3D, param2:Vector3) : void {
      this.createGraphicEffect(param2,param1);
      this.createMuzzleLightEffect(param2,param1);
      this.createSoundEffect(param1);
    }

    private function createGraphicEffect(param1:Vector3, param2:Object3D) : void {
      var local3:PlaneMuzzleFlashEffect = PlaneMuzzleFlashEffect(this.battleService.getObjectPool().getObject(PlaneMuzzleFlashEffect));
      local3.init(param1,param2,this.sfxData.muzzleFlashMaterial,FLASH_LIFE_TIME,FLASH_SIZE,FLASH_SIZE);
      this.battleService.addGraphicEffect(local3);
    }

    private function createMuzzleLightEffect(param1:Vector3, param2:Object3D) : void {
      var local3:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local4:MuzzlePositionProvider = MuzzlePositionProvider(this.battleService.getObjectPool().getObject(MuzzlePositionProvider));
      local4.init(param2,param1);
      local3.init(local4,this.sfxData.shotLightingAnimation);
      this.battleService.addGraphicEffect(local3);
    }

    private function createSoundEffect(param1:Object3D) : void {
      var local2:Number = NaN;
      var local3:Sound3D = null;
      if(this.sfxData.shotSound != null) {
        local2 = 0.8;
        local3 = Sound3D.create(this.sfxData.shotSound,local2);
        BattleUtils.tmpVector.reset(param1.x,param1.y,param1.z);
        this.battleService.addSound3DEffect(Sound3DEffect.create(BattleUtils.tmpVector,local3));
      }
    }
  }
}
