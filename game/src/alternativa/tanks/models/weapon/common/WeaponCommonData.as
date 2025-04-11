package alternativa.tanks.models.weapon.common {
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;

  public class WeaponCommonData {
    private var maxTurretRotationSpeed:EncryptedNumber;
    private var turretRotationAcceleration:EncryptedNumber;
    private var impactForce:EncryptedNumber;
    private var recoilForce:EncryptedNumber;

    public function WeaponCommonData(param1:Number, param2:Number, param3:Number, param4:Number) {
      super();
      this.maxTurretRotationSpeed = new EncryptedNumberImpl(param1);
      this.turretRotationAcceleration = new EncryptedNumberImpl(param2);
      this.impactForce = new EncryptedNumberImpl(param3);
      this.recoilForce = new EncryptedNumberImpl(param4);
    }

    public function getMaxTurretRotationSpeed() : Number {
      return this.maxTurretRotationSpeed.getNumber();
    }

    public function getTurretRotationAcceleration() : Number {
      return this.turretRotationAcceleration.getNumber();
    }

    public function getImpactForce() : Number {
      return this.impactForce.getNumber();
    }

    public function getRecoilForce() : Number {
      return this.recoilForce.getNumber();
    }

    public function setRecoilForce(param1:Number) : void {
      this.recoilForce.setNumber(param1);
    }
  }
}
