package platform.client.core.general.resource.osgi {
  import _codec.platform.core.general.resource.types.imageframe.CodecResourceImageFrameParams;
  import _codec.platform.core.general.resource.types.imageframe.VectorCodecResourceImageFrameParamsLevel1;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.core.general.resource.types.imageframe.ResourceImageFrameParams;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var local3:ICodec = null;
      osgi = param1;
      var local2:IProtocol = IProtocol(osgi.getService(IProtocol));
      local3 = new CodecResourceImageFrameParams();
      local2.registerCodec(new TypeCodecInfo(ResourceImageFrameParams,false),local3);
      local2.registerCodec(new TypeCodecInfo(ResourceImageFrameParams,true),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecResourceImageFrameParamsLevel1(false);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ResourceImageFrameParams,false),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ResourceImageFrameParams,false),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecResourceImageFrameParamsLevel1(true);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ResourceImageFrameParams,true),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ResourceImageFrameParams,true),true,1),new OptionalCodecDecorator(local3));
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
