package alternativa.tanks.models.weapon {
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;

  public class ConicAreaData {
    private var coneAngle:EncryptedNumber;
    private var range:EncryptedNumber;

    public function ConicAreaData(param1:Number, param2:Number) {
      super();
      this.coneAngle = new EncryptedNumberImpl(param1);
      this.range = new EncryptedNumberImpl(param2);
    }

    public function getConeAngle() : Number {
      return this.coneAngle.getNumber();
    }

    public function getRange() : Number {
      return this.range.getNumber();
    }
  }
}
