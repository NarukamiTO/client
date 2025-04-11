package _codec.projects.tanks.client.panel.model.donationalert.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.panel.model.donationalert.types.DonationData;
  import projects.tanks.client.panel.model.donationalert.types.GoodInfoData;

  public class CodecDonationData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_goods:ICodec;
    private var codec_time:ICodec;

    public function CodecDonationData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_goods = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(GoodInfoData,false),false,1));
      this.codec_time = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DonationData = new DonationData();
      local2.goods = this.codec_goods.decode(param1) as Vector.<GoodInfoData>;
      local2.time = this.codec_time.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DonationData = DonationData(param2);
      this.codec_goods.encode(param1,local3.goods);
      this.codec_time.encode(param1,local3.time);
    }
  }
}
