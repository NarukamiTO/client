package com.hurlant.util.der {
  public dynamic class Set extends Sequence implements IAsn1Type {
    public function Set(param1:uint = 49, param2:uint = 0) {
      super(param1,param2);
    }

    override public function toString() : String {
      var local1:String = null;
      local1 = DER.indent;
      DER.indent += "    ";
      var local2:String = join("\n");
      DER.indent = local1;
      return DER.indent + "Set[" + type + "][" + len + "][\n" + local2 + "\n" + local1 + "]";
    }
  }
}
