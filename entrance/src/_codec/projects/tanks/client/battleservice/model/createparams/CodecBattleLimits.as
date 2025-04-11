package _codec.projects.tanks.client.battleservice.model.createparams {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battleservice.model.createparams.BattleLimits;

  public class CodecBattleLimits implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_scoreLimit:ICodec;
    private var codec_timeLimitInSec:ICodec;

    public function CodecBattleLimits() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_scoreLimit = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_timeLimitInSec = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleLimits = new BattleLimits();
      local2.scoreLimit = this.codec_scoreLimit.decode(param1) as int;
      local2.timeLimitInSec = this.codec_timeLimitInSec.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleLimits = BattleLimits(param2);
      this.codec_scoreLimit.encode(param1,local3.scoreLimit);
      this.codec_timeLimitInSec.encode(param1,local3.timeLimitInSec);
    }
  }
}
