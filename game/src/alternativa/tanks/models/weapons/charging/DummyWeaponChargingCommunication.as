package alternativa.tanks.models.weapons.charging {
  public class DummyWeaponChargingCommunication implements WeaponChargingCommunication {
    public static var INSTANCE:DummyWeaponChargingCommunication = new DummyWeaponChargingCommunication();

    public function DummyWeaponChargingCommunication() {
      super();
    }

    public function startCharging(param1:int) : void {
    }

    public function finishCharging(param1:int) : void {
    }
  }
}
