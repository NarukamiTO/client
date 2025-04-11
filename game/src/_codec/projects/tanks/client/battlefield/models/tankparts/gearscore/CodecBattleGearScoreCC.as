package _codec.projects.tanks.client.battlefield.models.tankparts.gearscore {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.tankparts.gearscore.BattleGearScoreCC;

  public class CodecBattleGearScoreCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_score:ICodec;

    public function CodecBattleGearScoreCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_score = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleGearScoreCC = new BattleGearScoreCC();
      local2.score = this.codec_score.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleGearScoreCC = BattleGearScoreCC(param2);
      this.codec_score.encode(param1,local3.score);
    }
  }
}
