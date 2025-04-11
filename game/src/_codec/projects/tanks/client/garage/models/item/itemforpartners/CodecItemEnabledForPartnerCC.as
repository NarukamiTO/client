package _codec.projects.tanks.client.garage.models.item.itemforpartners {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.itemforpartners.ItemEnabledForPartnerCC;

  public class CodecItemEnabledForPartnerCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_availableForNonPartnerUsers:ICodec;
    private var codec_partnerId:ICodec;

    public function CodecItemEnabledForPartnerCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_availableForNonPartnerUsers = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_partnerId = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ItemEnabledForPartnerCC = new ItemEnabledForPartnerCC();
      local2.availableForNonPartnerUsers = this.codec_availableForNonPartnerUsers.decode(param1) as Boolean;
      local2.partnerId = this.codec_partnerId.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ItemEnabledForPartnerCC = ItemEnabledForPartnerCC(param2);
      this.codec_availableForNonPartnerUsers.encode(param1,local3.availableForNonPartnerUsers);
      this.codec_partnerId.encode(param1,local3.partnerId);
    }
  }
}
