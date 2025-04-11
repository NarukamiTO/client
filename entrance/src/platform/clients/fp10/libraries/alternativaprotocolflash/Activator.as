package platform.clients.fp10.libraries.alternativaprotocolflash {
  import _codec.VectorCodecStringLevel1;
  import _codec.VectorCodecbyteLevel1;
  import _codec.VectorCodecfloatLevel1;
  import _codec.VectorCodecintLevel1;
  import _codec.VectorCodeclongLevel1;
  import _codec.VectorCodecshortLevel1;
  import _codec.unsigned.VectorCodecintLevel1;
  import _codec.unsigned.VectorCodecshortLevel1;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.impl.Protocol;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import alternativa.types.Short;
  import alternativa.types.UByte;
  import alternativa.types.UShort;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var codec:ICodec = null;
      var _osgi:OSGi = param1;
      osgi = _osgi;
      var protocol:IProtocol = Protocol.defaultInstance;
      codec = new VectorCodecStringLevel1(false);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,false),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodecStringLevel1(true);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,true),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(String,true),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodecbyteLevel1(false);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,false),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,false),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodecbyteLevel1(true);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,true),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Byte,true),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodecfloatLevel1(false);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,false),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,false),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodecfloatLevel1(true);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,true),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Float,true),true,1),new OptionalCodecDecorator(codec));
      codec = new _codec.VectorCodecintLevel1(false);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),true,1),new OptionalCodecDecorator(codec));
      codec = new _codec.VectorCodecintLevel1(true);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,true),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(int,true),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodeclongLevel1(false);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodeclongLevel1(true);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,true),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,true),true,1),new OptionalCodecDecorator(codec));
      codec = new _codec.VectorCodecshortLevel1(false);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,false),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,false),true,1),new OptionalCodecDecorator(codec));
      codec = new _codec.VectorCodecshortLevel1(true);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,true),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Short,true),true,1),new OptionalCodecDecorator(codec));
      codec = new _codec.unsigned.VectorCodecintLevel1(false);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,false),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,false),true,1),new OptionalCodecDecorator(codec));
      codec = new _codec.unsigned.VectorCodecintLevel1(true);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,true),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UShort,true),true,1),new OptionalCodecDecorator(codec));
      codec = new _codec.unsigned.VectorCodecshortLevel1(false);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,false),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,false),true,1),new OptionalCodecDecorator(codec));
      codec = new _codec.unsigned.VectorCodecshortLevel1(true);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,true),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UByte,true),true,1),new OptionalCodecDecorator(codec));
      osgi.injectService(IClientLog,function(param1:Object):void {
        Protocol.clientLog = IClientLog(param1);
      },function():IClientLog {
        return Protocol.clientLog;
      });
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
