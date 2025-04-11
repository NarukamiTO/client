package alternativa.tanks.utils {
  public class EncryptedIntImpl implements EncryptedInt {
    private var mask:int;
    private var value:int;

    public function EncryptedIntImpl(param1:int = 0) {
      super();
      this.setInt(param1);
    }

    public function setInt(param1:int) : void {
      this.mask = Math.random() * 4294967295;
      this.value = param1 ^ this.mask;
    }

    public function getInt() : int {
      return this.value ^ this.mask;
    }
  }
}
