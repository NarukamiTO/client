package _codec.projects.tanks.client.garage.models.item.discount.proabonement {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.discount.proabonement.ProAbonementRankDiscountCC;

  public class CodecProAbonementRankDiscountCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_percentDiscountPerRank:ICodec;

    public function CodecProAbonementRankDiscountCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_percentDiscountPerRank = param1.getCodec(new TypeCodecInfo(Number,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ProAbonementRankDiscountCC = new ProAbonementRankDiscountCC();
      local2.percentDiscountPerRank = this.codec_percentDiscountPerRank.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ProAbonementRankDiscountCC = ProAbonementRankDiscountCC(param2);
      this.codec_percentDiscountPerRank.encode(param1,local3.percentDiscountPerRank);
    }
  }
}
