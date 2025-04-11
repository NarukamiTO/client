package projects.tanks.client.battlefield.bonus.randomgold.notification {
  import platform.client.fp10.core.type.IGameObject;

  public interface IRandomGoldBonusTakeModelBase {
    function showBonusNotification(param1:String, param2:IGameObject, param3:String, param4:String) : void;
  }
}
