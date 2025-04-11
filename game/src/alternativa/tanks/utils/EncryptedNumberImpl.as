package alternativa.tanks.utils {
  import flash.utils.ByteArray;

  public class EncryptedNumberImpl implements EncryptedNumber {
    private static var byteArray:ByteArray = new ByteArray();

    private var mask:int;
    private var v1:int;
    private var v2:int;

    public function EncryptedNumberImpl(param1:Number = 0) {
      super();
      this.setNumber(param1);
    }

    public function setNumber(param1:Number) : void {
      this.mask = Math.random() * 4294967295;
      byteArray.position = 0;
      byteArray.writeDouble(param1);
      byteArray.position = 0;
      this.v1 = ShiftUtils.rotateLeft(byteArray.readInt() ^ this.mask,5);
      this.v2 = ShiftUtils.rotateLeft(byteArray.readInt() ^ this.mask,5);
    }

    public function getNumber() : Number {
      byteArray.position = 0;
      byteArray.writeInt(ShiftUtils.rotateRight(this.v1,5) ^ this.mask);
      byteArray.writeInt(ShiftUtils.rotateRight(this.v2,5) ^ this.mask);
      byteArray.position = 0;
      return byteArray.readDouble();
    }
  }
}
