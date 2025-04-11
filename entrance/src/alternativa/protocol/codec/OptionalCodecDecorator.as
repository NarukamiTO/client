package alternativa.protocol.codec {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.codec.primitive.IPrimitiveCodec;

  public class OptionalCodecDecorator implements ICodec {
    private var codec:ICodec;
    private var nullobject:Object;

    public function OptionalCodecDecorator(param1:ICodec) {
      super();
      this.codec = param1;
      if(param1 is IPrimitiveCodec) {
        this.nullobject = IPrimitiveCodec(param1).nullValue();
      }
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == this.nullobject) {
        param1.optionalMap.addBit(true);
      } else {
        param1.optionalMap.addBit(false);
        this.codec.encode(param1,param2);
      }
    }

    public function decode(param1:ProtocolBuffer) : Object {
      return param1.optionalMap.get() ? this.nullobject : this.codec.decode(param1);
    }

    public function init(param1:IProtocol) : void {
      this.codec.init(param1);
    }
  }
}
