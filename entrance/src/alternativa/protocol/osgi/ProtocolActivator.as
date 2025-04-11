package alternativa.protocol.osgi {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.codec.primitive.ByteCodec;
  import alternativa.protocol.codec.primitive.DoubleCodec;
  import alternativa.protocol.codec.primitive.FloatCodec;
  import alternativa.protocol.codec.primitive.IntCodec;
  import alternativa.protocol.codec.primitive.LongCodec;
  import alternativa.protocol.codec.primitive.ShortCodec;
  import alternativa.protocol.codec.primitive.UByteCodec;
  import alternativa.protocol.codec.primitive.UIntCodec;
  import alternativa.protocol.codec.primitive.UShortCodec;
  import alternativa.protocol.impl.Protocol;
  import alternativa.types.Byte;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import alternativa.types.Short;
  import alternativa.types.UByte;
  import alternativa.types.UShort;

  public class ProtocolActivator implements IBundleActivator {
    public function ProtocolActivator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var local2:IProtocol = Protocol.defaultInstance;
      param1.registerService(IProtocol,local2);
      local2.registerCodecForType(Byte,new ByteCodec());
      local2.registerCodecForType(Float,new FloatCodec());
      local2.registerCodecForType(Long,new LongCodec());
      local2.registerCodecForType(Short,new ShortCodec());
      local2.registerCodecForType(UByte,new UByteCodec());
      local2.registerCodecForType(UShort,new UShortCodec());
      local2.registerCodecForType(uint,new UIntCodec());
      local2.registerCodecForType(int,new IntCodec());
      local2.registerCodecForType(Number,new DoubleCodec());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
