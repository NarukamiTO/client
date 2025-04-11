package alternativa.tanks.models.weapon.railgun {
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;

  public class RailgunData {
    private var chargingTime:EncryptedInt;
    private var weakeningCoeff:EncryptedNumber;

    public function RailgunData(param1:int, param2:Number) {
      super();
      this.chargingTime = new EncryptedIntImpl(param1);
      this.weakeningCoeff = new EncryptedNumberImpl(param2);
    }

    public function getChargingTime() : int {
      return this.chargingTime.getInt();
    }

    public function getWeakeningCoeff() : Number {
      return this.weakeningCoeff.getNumber();
    }

    public function setChargingTime(param1:int) : void {
      this.chargingTime.setInt(param1);
    }
  }
}
