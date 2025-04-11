package _codec.projects.tanks.client.panel.model.shop.androidspecialoffer.banner {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.shop.androidspecialoffer.banner.AndroidBannerModelCC;
  import projects.tanks.client.panel.model.shop.androidspecialoffer.banner.AndroidBannerType;

  public class CodecAndroidBannerModelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_buttonIcon:ICodec;
    private var codec_cooldownTimeInHour:ICodec;
    private var codec_order:ICodec;
    private var codec_type:ICodec;

    public function CodecAndroidBannerModelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_buttonIcon = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_cooldownTimeInHour = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_order = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_type = param1.getCodec(new EnumCodecInfo(AndroidBannerType,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:AndroidBannerModelCC = new AndroidBannerModelCC();
      local2.buttonIcon = this.codec_buttonIcon.decode(param1) as ImageResource;
      local2.cooldownTimeInHour = this.codec_cooldownTimeInHour.decode(param1) as int;
      local2.order = this.codec_order.decode(param1) as int;
      local2.type = this.codec_type.decode(param1) as AndroidBannerType;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:AndroidBannerModelCC = AndroidBannerModelCC(param2);
      this.codec_buttonIcon.encode(param1,local3.buttonIcon);
      this.codec_cooldownTimeInHour.encode(param1,local3.cooldownTimeInHour);
      this.codec_order.encode(param1,local3.order);
      this.codec_type.encode(param1,local3.type);
    }
  }
}
