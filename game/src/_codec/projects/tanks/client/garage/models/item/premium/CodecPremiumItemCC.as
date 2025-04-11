package _codec.projects.tanks.client.garage.models.item.premium {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.premium.PremiumItemCC;

  public class CodecPremiumItemCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_premiumItem:ICodec;

    public function CodecPremiumItemCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_premiumItem = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PremiumItemCC = new PremiumItemCC();
      local2.premiumItem = this.codec_premiumItem.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PremiumItemCC = PremiumItemCC(param2);
      this.codec_premiumItem.encode(param1,local3.premiumItem);
    }
  }
}
