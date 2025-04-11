package alternativa.tanks.utils {
  import alternativa.math.Matrix4;

  public class Matrix4Validator {
    private var m:Matrix4;
    private var a:EncryptedNumber;
    private var b:EncryptedNumber;
    private var c:EncryptedNumber;
    private var d:EncryptedNumber;
    private var e:EncryptedNumber;
    private var f:EncryptedNumber;
    private var g:EncryptedNumber;
    private var h:EncryptedNumber;
    private var i:EncryptedNumber;
    private var j:EncryptedNumber;
    private var k:EncryptedNumber;
    private var l:EncryptedNumber;

    public function Matrix4Validator(param1:Matrix4) {
      super();
      this.m = param1;
      this.a = new EncryptedNumberImpl(param1.m00);
      this.b = new EncryptedNumberImpl(param1.m01);
      this.c = new EncryptedNumberImpl(param1.m02);
      this.d = new EncryptedNumberImpl(param1.m03);
      this.e = new EncryptedNumberImpl(param1.m10);
      this.f = new EncryptedNumberImpl(param1.m11);
      this.g = new EncryptedNumberImpl(param1.m12);
      this.h = new EncryptedNumberImpl(param1.m13);
      this.i = new EncryptedNumberImpl(param1.m20);
      this.j = new EncryptedNumberImpl(param1.m21);
      this.k = new EncryptedNumberImpl(param1.m22);
      this.l = new EncryptedNumberImpl(param1.m23);
    }

    public function isInvalid() : Boolean {
      return this.m.m00 != this.a.getNumber() || this.m.m01 != this.b.getNumber() || this.m.m02 != this.c.getNumber() || this.m.m03 != this.d.getNumber() || this.m.m10 != this.e.getNumber() || this.m.m11 != this.f.getNumber() || this.m.m12 != this.g.getNumber() || this.m.m13 != this.h.getNumber() || this.m.m20 != this.i.getNumber() || this.m.m21 != this.j.getNumber() || this.m.m23 != this.l.getNumber() || this.m.m22 != this.k.getNumber();
    }
  }
}
