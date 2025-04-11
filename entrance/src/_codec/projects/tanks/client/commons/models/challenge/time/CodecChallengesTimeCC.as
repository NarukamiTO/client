package _codec.projects.tanks.client.commons.models.challenge.time {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.commons.models.challenge.time.ChallengesTimeCC;

  public class CodecChallengesTimeCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_timeLeftSec:ICodec;

    public function CodecChallengesTimeCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_timeLeftSec = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ChallengesTimeCC = new ChallengesTimeCC();
      local2.timeLeftSec = this.codec_timeLeftSec.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ChallengesTimeCC = ChallengesTimeCC(param2);
      this.codec_timeLeftSec.encode(param1,local3.timeLeftSec);
    }
  }
}
