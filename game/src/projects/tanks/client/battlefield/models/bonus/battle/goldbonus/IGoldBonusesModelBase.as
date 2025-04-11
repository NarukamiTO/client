package projects.tanks.client.battlefield.models.bonus.battle.goldbonus {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;

  public interface IGoldBonusesModelBase {
    function hideDropZone(param1:BonusRegionData) : void;
    function notificationBonus(param1:IGameObject, param2:BonusRegionData) : void;
    function notificationBonusContainsUid(param1:IGameObject, param2:String, param3:BonusRegionData) : void;
  }
}
