package alternativa.tanks.models.weapons.charging {
  [ModelInterface]
  public interface WeaponChargingCommunication {
    function startCharging(param1:int) : void;
    function finishCharging(param1:int) : void;
  }
}
