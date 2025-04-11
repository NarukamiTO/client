package platform.client.core.general.resourcelocale.osgi {
  import _codec.platform.client.core.general.resourcelocale.format.CodecImagePair;
  import _codec.platform.client.core.general.resourcelocale.format.CodecLocalizedFileFormat;
  import _codec.platform.client.core.general.resourcelocale.format.CodecStringPair;
  import _codec.platform.client.core.general.resourcelocale.format.VectorCodecImagePairLevel1;
  import _codec.platform.client.core.general.resourcelocale.format.VectorCodecLocalizedFileFormatLevel1;
  import _codec.platform.client.core.general.resourcelocale.format.VectorCodecStringPairLevel1;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.core.general.resourcelocale.format.ImagePair;
  import platform.client.core.general.resourcelocale.format.LocalizedFileFormat;
  import platform.client.core.general.resourcelocale.format.StringPair;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var local3:ICodec = null;
      osgi = param1;
      var local2:IProtocol = IProtocol(osgi.getService(IProtocol));
      local3 = new CodecImagePair();
      local2.registerCodec(new TypeCodecInfo(ImagePair,false),local3);
      local2.registerCodec(new TypeCodecInfo(ImagePair,true),new OptionalCodecDecorator(local3));
      local3 = new CodecLocalizedFileFormat();
      local2.registerCodec(new TypeCodecInfo(LocalizedFileFormat,false),local3);
      local2.registerCodec(new TypeCodecInfo(LocalizedFileFormat,true),new OptionalCodecDecorator(local3));
      local3 = new CodecStringPair();
      local2.registerCodec(new TypeCodecInfo(StringPair,false),local3);
      local2.registerCodec(new TypeCodecInfo(StringPair,true),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecImagePairLevel1(false);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImagePair,false),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImagePair,false),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecImagePairLevel1(true);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImagePair,true),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImagePair,true),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecLocalizedFileFormatLevel1(false);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LocalizedFileFormat,false),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LocalizedFileFormat,false),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecLocalizedFileFormatLevel1(true);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LocalizedFileFormat,true),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LocalizedFileFormat,true),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecStringPairLevel1(false);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(StringPair,false),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(StringPair,false),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecStringPairLevel1(true);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(StringPair,true),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(StringPair,true),true,1),new OptionalCodecDecorator(local3));
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
