package com.hurlant.crypto.prng {
  import com.hurlant.crypto.hash.HMAC;
  import com.hurlant.crypto.hash.MD5;
  import com.hurlant.crypto.hash.SHA1;
  import com.hurlant.util.Memory;
  import flash.utils.ByteArray;
  import flash.utils.IDataOutput;

  public class TLSPRF {
    private var seed:ByteArray;
    private var s1:ByteArray;
    private var s2:ByteArray;
    private var a1:ByteArray;
    private var a2:ByteArray;
    private var p1:ByteArray;
    private var p2:ByteArray;
    private var d1:ByteArray;
    private var d2:ByteArray;
    private var hmac_md5:HMAC;
    private var hmac_sha1:HMAC;

    public function TLSPRF(param1:ByteArray, param2:String, param3:ByteArray) {
      super();
      var local4:int = Math.ceil(param1.length / 2);
      var local5:ByteArray = new ByteArray();
      var local6:ByteArray = new ByteArray();
      local5.writeBytes(param1,0,local4);
      local6.writeBytes(param1,param1.length - local4,local4);
      var local7:ByteArray = new ByteArray();
      local7.writeUTFBytes(param2);
      local7.writeBytes(param3);
      this.seed = local7;
      this.s1 = local5;
      this.s2 = local6;
      this.hmac_md5 = new HMAC(new MD5());
      this.hmac_sha1 = new HMAC(new SHA1());
      this.a1 = this.hmac_md5.compute(local5,this.seed);
      this.a2 = this.hmac_sha1.compute(local6,this.seed);
      this.p1 = new ByteArray();
      this.p2 = new ByteArray();
      this.d1 = new ByteArray();
      this.d2 = new ByteArray();
      this.d1.position = MD5.HASH_SIZE;
      this.d1.writeBytes(this.seed);
      this.d2.position = SHA1.HASH_SIZE;
      this.d2.writeBytes(this.seed);
    }

    public function nextBytes(param1:IDataOutput, param2:int) : void {
      while(Boolean(param2--)) {
        param1.writeByte(this.nextByte());
      }
    }

    public function nextByte() : int {
      if(this.p1.bytesAvailable == 0) {
        this.more_md5();
      }
      if(this.p2.bytesAvailable == 0) {
        this.more_sha1();
      }
      return this.p1.readUnsignedByte() ^ this.p2.readUnsignedByte();
    }

    public function dispose() : void {
      this.seed = this.dba(this.seed);
      this.s1 = this.dba(this.s1);
      this.s2 = this.dba(this.s2);
      this.a1 = this.dba(this.a1);
      this.a2 = this.dba(this.a2);
      this.p1 = this.dba(this.p1);
      this.p2 = this.dba(this.p2);
      this.d1 = this.dba(this.d1);
      this.d2 = this.dba(this.d2);
      this.hmac_md5.dispose();
      this.hmac_md5 = null;
      this.hmac_sha1.dispose();
      this.hmac_sha1 = null;
      Memory.gc();
    }

    public function toString() : String {
      return "tls-prf";
    }

    private function dba(param1:ByteArray) : ByteArray {
      var local2:uint = 0;
      while(local2 < param1.length) {
        param1[local2] = 0;
        local2++;
      }
      param1.length = 0;
      return null;
    }

    private function more_md5() : void {
      this.d1.position = 0;
      this.d1.writeBytes(this.a1);
      var local1:int = int(this.p1.position);
      var local2:ByteArray = this.hmac_md5.compute(this.s1,this.d1);
      this.a1 = this.hmac_md5.compute(this.s1,this.a1);
      this.p1.writeBytes(local2);
      this.p1.position = local1;
    }

    private function more_sha1() : void {
      this.d2.position = 0;
      this.d2.writeBytes(this.a2);
      var local1:int = int(this.p2.position);
      var local2:ByteArray = this.hmac_sha1.compute(this.s2,this.d2);
      this.a2 = this.hmac_sha1.compute(this.s2,this.a2);
      this.p2.writeBytes(local2);
      this.p2.position = local1;
    }
  }
}
