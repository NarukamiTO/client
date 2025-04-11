package _codec.projects.tanks.client.panel.model.shop.coinpackage {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.coinpackage.CoinPackageCC;

  public class CodecCoinPackageCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_amount:ICodec;
    private var codec_bonusAmount:ICodec;

    public function CodecCoinPackageCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_amount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_bonusAmount = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CoinPackageCC = new CoinPackageCC();
      local2.amount = this.codec_amount.decode(param1) as int;
      local2.bonusAmount = this.codec_bonusAmount.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:CoinPackageCC = CoinPackageCC(param2);
      this.codec_amount.encode(param1,local3.amount);
      this.codec_bonusAmount.encode(param1,local3.bonusAmount);
    }
  }
}
