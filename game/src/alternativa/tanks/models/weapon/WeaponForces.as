package alternativa.tanks.models.weapon {
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;

  public class WeaponForces {
    private var impactForce:EncryptedNumber;
    private var recoilForce:EncryptedNumber;

    public function WeaponForces(param1:Number, param2:Number) {
      super();
      this.impactForce = new EncryptedNumberImpl(param1);
      this.recoilForce = new EncryptedNumberImpl(param2);
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
