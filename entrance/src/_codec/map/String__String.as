package _codec.map {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.impl.LengthCodecHelper;
  import alternativa.protocol.info.TypeCodecInfo;
  import flash.utils.Dictionary;

  public class String__String implements ICodec {
    private var keyCodec:ICodec;
    private var valueCodec:ICodec;
    private var optionalKey:Boolean;
    private var optionalValue:Boolean;

    public function String__String(param1:Boolean, param2:Boolean) {
      super();
      this.optionalKey = param1;
      this.optionalValue = param2;
    }

    public function init(param1:IProtocol) : void {
      this.keyCodec = param1.getCodec(new TypeCodecInfo(String,false));
      if(this.optionalKey) {
        this.keyCodec = new OptionalCodecDecorator(this.keyCodec);
      }
      this.valueCodec = param1.getCodec(new TypeCodecInfo(String,false));
      if(this.optionalValue) {
        this.valueCodec = new OptionalCodecDecorator(this.valueCodec);
      }
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:int = LengthCodecHelper.decodeLength(param1);
      var local3:Dictionary = new Dictionary();
      var local4:int = 0;
      while(local4 < local2) {
        local3[this.keyCodec.decode(param1)] = this.valueCodec.decode(param1);
        local4++;
      }
      return local3;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      var local5:* = undefined;
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:Dictionary = Dictionary(param2);
      var local4:int = 0;
      for(local5 in local3) {
        local4++;
      }
      LengthCodecHelper.encodeLength(param1,local4);
      for(local5 in local3) {
        this.keyCodec.encode(param1,local5);
        this.valueCodec.encode(param1,local3[local5]);
      }
    }
  }
}
