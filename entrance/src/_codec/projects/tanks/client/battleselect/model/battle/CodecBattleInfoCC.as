package _codec.projects.tanks.client.battleselect.model.battle {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battleselect.model.battle.BattleInfoCC;
  import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;

  public class CodecBattleInfoCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_roundStarted:ICodec;
    private var codec_suspicionLevel:ICodec;
    private var codec_timeLeftInSec:ICodec;

    public function CodecBattleInfoCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_roundStarted = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_suspicionLevel = param1.getCodec(new EnumCodecInfo(BattleSuspicionLevel,false));
      this.codec_timeLeftInSec = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleInfoCC = new BattleInfoCC();
      local2.roundStarted = this.codec_roundStarted.decode(param1) as Boolean;
      local2.suspicionLevel = this.codec_suspicionLevel.decode(param1) as BattleSuspicionLevel;
      local2.timeLeftInSec = this.codec_timeLeftInSec.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleInfoCC = BattleInfoCC(param2);
      this.codec_roundStarted.encode(param1,local3.roundStarted);
      this.codec_suspicionLevel.encode(param1,local3.suspicionLevel);
      this.codec_timeLeftInSec.encode(param1,local3.timeLeftInSec);
    }
  }
}
