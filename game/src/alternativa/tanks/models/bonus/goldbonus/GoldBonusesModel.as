package alternativa.tanks.models.bonus.goldbonus {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.battle.ctf.MessageColor;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.bonus.notification.BonusNotification;
  import alternativa.tanks.services.bonusregion.IBonusRegionService;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;
  import projects.tanks.client.battlefield.models.bonus.battle.goldbonus.GoldBonusesModelBase;
  import projects.tanks.client.battlefield.models.bonus.battle.goldbonus.IGoldBonusesModelBase;

  [ModelInfo]
  public class GoldBonusesModel extends GoldBonusesModelBase implements IGoldBonusesModelBase, IGoldBonus {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var bonusRegionService:IBonusRegionService;

    private static const UID_PATTERN:String = "%USERNAME%";

    public function GoldBonusesModel() {
      super();
    }

    public function getRegions() : Vector.<BonusRegionData> {
      return getInitParam().regionsData;
    }

    [Obfuscation(rename="false")]
    public function notificationBonus(param1:IGameObject, param2:BonusRegionData) : void {
      var local3:BonusNotification = BonusNotification(param1.adapt(BonusNotification));
      this.notification(param1,param2,local3.getMessage());
    }

    [Obfuscation(rename="false")]
    public function notificationBonusContainsUid(param1:IGameObject, param2:String, param3:BonusRegionData) : void {
      var local4:BonusNotification = BonusNotification(param1.adapt(BonusNotification));
      var local5:String = local4.getMessageContainsUid().replace(UID_PATTERN,param2);
      this.notification(param1,param3,local5);
    }

    private function notification(param1:IGameObject, param2:BonusRegionData, param3:String) : void {
      var local4:SoundResource = BonusNotification(param1.adapt(BonusNotification)).getSoundNotification();
      if(local4 != null) {
        battleService.soundManager.playSound(local4.sound);
      }
      var local5:BattlefieldGUI = BattlefieldGUI(object.adapt(BattlefieldGUI));
      local5.showBattleMessage(MessageColor.ORANGE,param3);
      bonusRegionService.addAndShowRegion(param2);
    }

    [Obfuscation(rename="false")]
    public function hideDropZone(param1:BonusRegionData) : void {
      bonusRegionService.hideAndRemoveRegion(param1);
    }
  }
}
