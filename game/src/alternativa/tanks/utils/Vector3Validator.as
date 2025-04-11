package alternativa.tanks.utils {
  import alternativa.math.Vector3;

  public class Vector3Validator {
    private var vector:Vector3;
    private var x:EncryptedNumber;
    private var y:EncryptedNumber;
    private var z:EncryptedNumber;

    public function Vector3Validator(param1:Vector3) {
      super();
      this.vector = param1;
      this.x = new EncryptedNumberImpl(param1.x);
      this.y = new EncryptedNumberImpl(param1.y);
      this.z = new EncryptedNumberImpl(param1.z);
    }

    public function isInvalid() : Boolean {
      return this.vector.x != this.x.getNumber() || this.vector.y != this.y.getNumber() || this.vector.z != this.z.getNumber();
    }

    public function isValid() : Boolean {
      return !this.isInvalid();
    }

    public function getTrace() : String {
      return "";
    }
  }
}
