package _codec.projects.tanks.client.panel.model.coin {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.coin.CoinInfoCC;

  public class CodecCoinInfoCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_coins:ICodec;
    private var codec_enabled:ICodec;

    public function CodecCoinInfoCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_coins = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_enabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CoinInfoCC = new CoinInfoCC();
      local2.coins = this.codec_coins.decode(param1) as int;
      local2.enabled = this.codec_enabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:CoinInfoCC = CoinInfoCC(param2);
      this.codec_coins.encode(param1,local3.coins);
      this.codec_enabled.encode(param1,local3.enabled);
    }
  }
}
