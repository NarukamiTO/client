package _codec.projects.tanks.client.battleservice {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battleservice.BattleRoundParameters;

  public class CodecBattleRoundParameters implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_reArmorEnabled:ICodec;

    public function CodecBattleRoundParameters() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_reArmorEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleRoundParameters = new BattleRoundParameters();
      local2.reArmorEnabled = this.codec_reArmorEnabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleRoundParameters = BattleRoundParameters(param2);
      this.codec_reArmorEnabled.encode(param1,local3.reArmorEnabled);
    }
  }
}
