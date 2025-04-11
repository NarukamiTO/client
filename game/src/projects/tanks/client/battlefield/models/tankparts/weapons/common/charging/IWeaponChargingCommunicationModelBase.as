package projects.tanks.client.battlefield.models.tankparts.weapons.common.charging {
  public interface IWeaponChargingCommunicationModelBase {
    function handleChargingFinish(param1:int) : void;
    function handleChargingStart() : void;
  }
}
