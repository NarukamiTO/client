package alternativa.tanks.utils {
  public class NotEncryptedInt implements EncryptedInt {
    private var value:int;

    public function NotEncryptedInt(param1:int = 0) {
      super();
      this.value = param1;
    }

    public function setInt(param1:int) : void {
      this.value = param1;
    }

    public function getInt() : int {
      return this.value;
    }
  }
}
