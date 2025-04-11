package alternativa.tanks.utils.thirdparty {
  import flash.utils.ByteArray;

  public class URIEncodingBitmap extends ByteArray {
    public function URIEncodingBitmap(param1:String) {
      var local2:int = 0;
      var local4:int = 0;
      var local5:int = 0;
      super();
      var local3:ByteArray = new ByteArray();
      local2 = 0;
      while(local2 < 16) {
        this.writeByte(0);
        local2++;
      }
      local3.writeUTFBytes(param1);
      local3.position = 0;
      while(Boolean(local3.bytesAvailable)) {
        local4 = local3.readByte();
        if(local4 <= 127) {
          this.position = local4 >> 3;
          local5 = this.readByte();
          local5 |= 1 << (local4 & 7);
          this.position = local4 >> 3;
          this.writeByte(local5);
        }
      }
    }

    public function ShouldEscape(param1:String) : int {
      var local3:int = 0;
      var local4:int = 0;
      var local2:ByteArray = new ByteArray();
      local2.writeUTFBytes(param1);
      local2.position = 0;
      local3 = local2.readByte();
      if(Boolean(local3 & 0x80)) {
        return 0;
      }
      if(local3 < 31 || local3 == 127) {
        return local3;
      }
      this.position = local3 >> 3;
      local4 = this.readByte();
      if(Boolean(local4 & 1 << (local3 & 7))) {
        return local3;
      }
      return 0;
    }
  }
}
