package alternativa.tanks.models.weapon.splash {
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;

  public class SplashParams {
    private var maxSplashDamageRadius:EncryptedNumber;
    private var minSplashDamageRadius:EncryptedNumber;
    private var minSplashDamagePercent:EncryptedNumber;
    private var maxSplashImpactForce:EncryptedNumber;

    public function SplashParams(param1:Number, param2:Number, param3:Number, param4:Number) {
      super();
      this.maxSplashDamageRadius = new EncryptedNumberImpl(param1);
      this.minSplashDamageRadius = new EncryptedNumberImpl(param2);
      this.minSplashDamagePercent = new EncryptedNumberImpl(param3);
      this.maxSplashImpactForce = new EncryptedNumberImpl(param4);
    }

    public function getSplashRadius() : Number {
      return this.minSplashDamageRadius.getNumber();
    }

    public function getImpactForce(param1:Number) : Number {
      return this.maxSplashImpactForce.getNumber() * this.getSplashImpactCoeff(param1);
    }

    private function getSplashImpactCoeff(param1:Number) : Number {
      var local2:Number = Number(this.maxSplashDamageRadius.getNumber());
      var local3:Number = Number(this.minSplashDamageRadius.getNumber());
      var local4:Number = Number(this.minSplashDamagePercent.getNumber());
      if(param1 < local2) {
        return 1;
      }
      if(param1 > local3) {
        return 0.1 * local4;
      }
      return 0.01 * (local4 + (local3 - param1) * (100 - local4) / (local3 - local2));
    }
  }
}
