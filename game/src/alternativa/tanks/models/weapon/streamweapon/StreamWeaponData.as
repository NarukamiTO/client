package alternativa.tanks.models.weapon.streamweapon {
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;

  public class StreamWeaponData {
    private var energyCapacity:EncryptedNumber;
    private var energyDischargeSpeed:EncryptedNumber;
    private var energyRechargeSpeed:EncryptedNumber;
    private var tickIntervalMsec:EncryptedNumber;

    public function StreamWeaponData(param1:Number, param2:Number, param3:Number, param4:Number) {
      super();
      this.energyCapacity = new EncryptedNumberImpl(param1);
      this.energyDischargeSpeed = new EncryptedNumberImpl(param2);
      this.energyRechargeSpeed = new EncryptedNumberImpl(param3);
      this.tickIntervalMsec = new EncryptedNumberImpl(param4);
    }

    public function getEnergyCapacity() : Number {
      return this.energyCapacity.getNumber();
    }

    public function getEnergyDischargeSpeed() : Number {
      return this.energyDischargeSpeed.getNumber();
    }

    public function getEnergyRechargeSpeed() : Number {
      return this.energyRechargeSpeed.getNumber();
    }

    public function getTickIntervalMsec() : Number {
      return this.tickIntervalMsec.getNumber();
    }

    public function setEnergyDischargeSpeed(param1:Number) : void {
      this.energyDischargeSpeed.setNumber(param1);
    }
  }
}
