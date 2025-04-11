package _codec.projects.tanks.client.panel.model.shop.androidspecialoffer.offers {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.androidspecialoffer.offers.AndroidSpecialOfferModelCC;

  public class CodecAndroidSpecialOfferModelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_oldPrice:ICodec;
    private var codec_price:ICodec;
    private var codec_saleInPercent:ICodec;
    private var codec_timeLeftInSec:ICodec;
    private var codec_timeLimited:ICodec;

    public function CodecAndroidSpecialOfferModelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_oldPrice = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_price = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_saleInPercent = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_timeLeftInSec = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_timeLimited = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:AndroidSpecialOfferModelCC = new AndroidSpecialOfferModelCC();
      local2.oldPrice = this.codec_oldPrice.decode(param1) as Number;
      local2.price = this.codec_price.decode(param1) as Number;
      local2.saleInPercent = this.codec_saleInPercent.decode(param1) as int;
      local2.timeLeftInSec = this.codec_timeLeftInSec.decode(param1) as int;
      local2.timeLimited = this.codec_timeLimited.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:AndroidSpecialOfferModelCC = AndroidSpecialOfferModelCC(param2);
      this.codec_oldPrice.encode(param1,local3.oldPrice);
      this.codec_price.encode(param1,local3.price);
      this.codec_saleInPercent.encode(param1,local3.saleInPercent);
      this.codec_timeLeftInSec.encode(param1,local3.timeLeftInSec);
      this.codec_timeLimited.encode(param1,local3.timeLimited);
    }
  }
}
