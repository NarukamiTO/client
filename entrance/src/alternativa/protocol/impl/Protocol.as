package alternativa.protocol.impl {
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.*;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.codec.complex.ByteArrayCodec;
  import alternativa.protocol.codec.complex.StringCodec;
  import alternativa.protocol.codec.primitive.BooleanCodec;
  import alternativa.protocol.codec.primitive.ByteCodec;
  import alternativa.protocol.codec.primitive.DoubleCodec;
  import alternativa.protocol.codec.primitive.FloatCodec;
  import alternativa.protocol.codec.primitive.IntCodec;
  import alternativa.protocol.codec.primitive.LongCodec;
  import alternativa.protocol.codec.primitive.ShortCodec;
  import alternativa.protocol.codec.primitive.UIntCodec;
  import alternativa.protocol.codec.primitive.UShortCodec;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import alternativa.types.Short;
  import alternativa.types.UShort;
  import flash.utils.ByteArray;
  import flash.utils.Dictionary;
  import flash.utils.IDataInput;
  import flash.utils.IDataOutput;

  public class Protocol implements IProtocol {
    [Inject]
    public static var clientLog:IClientLog;

    private static const LOG_CHANNEL:String = "protocol";

    public static var defaultInstance:IProtocol = new Protocol();

    private var info2codec:Object = new Object();
    private var listInitCodec:Dictionary = new Dictionary(false);

    public function Protocol() {
      super();
      this.registerCodec(new TypeCodecInfo(int,false),new IntCodec());
      this.registerCodec(new TypeCodecInfo(Short,false),new ShortCodec());
      this.registerCodec(new TypeCodecInfo(Byte,false),new ByteCodec());
      this.registerCodec(new TypeCodecInfo(UShort,false),new UShortCodec());
      this.registerCodec(new TypeCodecInfo(uint,false),new UIntCodec());
      this.registerCodec(new TypeCodecInfo(Number,false),new DoubleCodec());
      this.registerCodec(new TypeCodecInfo(Float,false),new FloatCodec());
      this.registerCodec(new TypeCodecInfo(Boolean,false),new BooleanCodec());
      this.registerCodec(new TypeCodecInfo(Long,false),new LongCodec());
      this.registerCodec(new TypeCodecInfo(String,false),new StringCodec());
      this.registerCodec(new TypeCodecInfo(ByteArray,false),new ByteArrayCodec());
      this.registerCodec(new TypeCodecInfo(int,true),new OptionalCodecDecorator(new IntCodec()));
      this.registerCodec(new TypeCodecInfo(Short,true),new OptionalCodecDecorator(new ShortCodec()));
      this.registerCodec(new TypeCodecInfo(Byte,true),new OptionalCodecDecorator(new ByteCodec()));
      this.registerCodec(new TypeCodecInfo(UShort,true),new OptionalCodecDecorator(new UShortCodec()));
      this.registerCodec(new TypeCodecInfo(uint,true),new OptionalCodecDecorator(new UIntCodec()));
      this.registerCodec(new TypeCodecInfo(Number,true),new OptionalCodecDecorator(new DoubleCodec()));
      this.registerCodec(new TypeCodecInfo(Float,true),new OptionalCodecDecorator(new FloatCodec()));
      this.registerCodec(new TypeCodecInfo(Boolean,true),new OptionalCodecDecorator(new BooleanCodec()));
      this.registerCodec(new TypeCodecInfo(Long,true),new OptionalCodecDecorator(new LongCodec()));
      this.registerCodec(new TypeCodecInfo(String,true),new OptionalCodecDecorator(new StringCodec()));
      this.registerCodec(new TypeCodecInfo(ByteArray,true),new OptionalCodecDecorator(new ByteArrayCodec()));
    }

    public function registerCodec(param1:ICodecInfo, param2:ICodec) : void {
      this.info2codec[param1] = param2;
    }

    public function registerCodecForType(param1:Class, param2:ICodec) : void {
      this.info2codec[new TypeCodecInfo(param1,false)] = param2;
      this.info2codec[new TypeCodecInfo(param1,true)] = new OptionalCodecDecorator(param2);
    }

    public function getCodec(param1:ICodecInfo) : ICodec {
      var local2:ICodec = this.info2codec[param1];
      if(local2 == null) {
        throw Error("Codec not found for  " + param1);
      }
      if(this.listInitCodec[local2] == null) {
        this.listInitCodec[local2] = local2;
        local2.init(this);
      }
      return local2;
    }

    public function makeCodecInfo(param1:Class) : ICodecInfo {
      return new TypeCodecInfo(param1,false);
    }

    public function wrapPacket(param1:IDataOutput, param2:ProtocolBuffer, param3:CompressionType) : void {
      PacketHelper.wrapPacket(param1,param2,param3);
    }

    public function unwrapPacket(param1:IDataInput, param2:ProtocolBuffer, param3:CompressionType) : Boolean {
      return PacketHelper.unwrapPacket(param1,param2,param3);
    }

    public function decode(param1:Class, param2:ByteArray) : * {
      var local3:ICodec = this.getCodec(this.makeCodecInfo(param1));
      var local4:ByteArray = new ByteArray();
      var local5:ProtocolBuffer = new ProtocolBuffer(local4,local4,new OptionalMap());
      this.unwrapPacket(param2,local5,CompressionType.DEFLATE_AUTO);
      return local3.decode(local5);
    }
  }
}
