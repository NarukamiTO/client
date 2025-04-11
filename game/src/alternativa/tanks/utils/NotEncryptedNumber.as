package alternativa.tanks.utils {
  public class NotEncryptedNumber implements EncryptedNumber {
    private var value:Number;

    public function NotEncryptedNumber(param1:Number = 0) {
      super();
      this.value = param1;
    }

    public function setNumber(param1:Number) : void {
      this.value = param1;
    }

    public function getNumber() : Number {
      return this.value;
    }
  }
}
