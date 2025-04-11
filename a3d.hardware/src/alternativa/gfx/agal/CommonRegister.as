package alternativa.gfx.agal {
  public class CommonRegister extends Register {
    protected static const X:int = 0;
    protected static const Y:int = 1;
    protected static const Z:int = 2;
    protected static const W:int = 3;

    public var x:Register;
    public var y:Register;
    public var z:Register;
    public var w:Register;
    public var xyz:Register;
    public var xy:Register;
    public var xw:Register;
    public var xz:Register;
    public var zw:Register;

    public function CommonRegister(param1:int, param2:int) {
      super();
      this.index = param1;
      this.emitCode = param2;
      this.x = Register.get(getSwizzle(X,X,X,X),getDestMask(true,false,false,false),this);
      this.y = Register.get(getSwizzle(Y,Y,Y,Y),getDestMask(false,true,false,false),this);
      this.z = Register.get(getSwizzle(Z,Z,Z,Z),getDestMask(false,false,true,false),this);
      this.w = Register.get(getSwizzle(W,W,W,W),getDestMask(false,false,false,true),this);
      this.xyz = Register.get(getSwizzle(X,Y,Z,Z),getDestMask(true,true,true,false),this);
      this.xy = Register.get(getSwizzle(X,Y,Y,Y),getDestMask(true,true,false,false),this);
      this.xz = Register.get(getSwizzle(X,Z,Z,Z),getDestMask(true,false,true,false),this);
      this.xw = Register.get(getSwizzle(X,W,W,W),getDestMask(true,false,false,true),this);
      this.zw = Register.get(getSwizzle(Z,W,W,W),getDestMask(false,false,true,true),this);
    }
  }
}
