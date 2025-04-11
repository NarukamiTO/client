package platform.client.core.general.pushnotification.osgi {
  import _codec.platform.client.core.general.pushnotification.api.CodecNotificationClientPlatform;
  import _codec.platform.client.core.general.pushnotification.api.VectorCodecNotificationClientPlatformLevel1;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import platform.client.core.general.pushnotification.api.NotificationClientPlatform;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var local3:ICodec = null;
      osgi = param1;
      var local2:IProtocol = IProtocol(osgi.getService(IProtocol));
      local3 = new CodecNotificationClientPlatform();
      local2.registerCodec(new EnumCodecInfo(NotificationClientPlatform,false),local3);
      local2.registerCodec(new EnumCodecInfo(NotificationClientPlatform,true),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecNotificationClientPlatformLevel1(false);
      local2.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(NotificationClientPlatform,false),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(NotificationClientPlatform,false),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecNotificationClientPlatformLevel1(true);
      local2.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(NotificationClientPlatform,true),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(NotificationClientPlatform,true),true,1),new OptionalCodecDecorator(local3));
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
