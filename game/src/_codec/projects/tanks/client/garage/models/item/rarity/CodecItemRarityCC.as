package _codec.projects.tanks.client.garage.models.item.rarity {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import projects.tanks.client.garage.models.item.rarity.ItemRarityCC;
  import projects.tanks.client.garage.models.item.rarity.Rarity;

  public class CodecItemRarityCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_rarity:ICodec;

    public function CodecItemRarityCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_rarity = param1.getCodec(new EnumCodecInfo(Rarity,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ItemRarityCC = new ItemRarityCC();
      local2.rarity = this.codec_rarity.decode(param1) as Rarity;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ItemRarityCC = ItemRarityCC(param2);
      this.codec_rarity.encode(param1,local3.rarity);
    }
  }
}
