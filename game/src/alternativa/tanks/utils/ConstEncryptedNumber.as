package alternativa.tanks.utils {
  import flash.utils.ByteArray;

  public class ConstEncryptedNumber implements EncryptedNumber {
    private static var byteArray:ByteArray = new ByteArray();

    private var mask:int;
    private var v1:int;
    private var v2:int;

    public function ConstEncryptedNumber(param1:Number) {
      super();
      this.mask = Math.random() * 4294967295;
      byteArray.position = 0;
      byteArray.writeDouble(param1);
      byteArray.position = 0;
      this.v1 = byteArray.readInt() ^ this.mask;
      this.v2 = byteArray.readInt() ^ this.mask;
    }

    public function setNumber(param1:Number) : void {
    }

    public function getNumber() : Number {
      byteArray.position = 0;
      byteArray.writeInt(this.v1 ^ this.mask);
      byteArray.writeInt(this.v2 ^ this.mask);
      byteArray.position = 0;
      return byteArray.readDouble();
    }
  }
}
