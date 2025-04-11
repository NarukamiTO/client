package _codec.projects.tanks.client.panel.model.mobilequest.profile {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.panel.model.mobilequest.profile.MobileQuestProfileCC;

  public class CodecMobileQuestProfileCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_currentStep:ICodec;
    private var codec_eventMember:ICodec;
    private var codec_remainingTimeInSec:ICodec;

    public function CodecMobileQuestProfileCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_currentStep = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_eventMember = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_remainingTimeInSec = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MobileQuestProfileCC = new MobileQuestProfileCC();
      local2.currentStep = this.codec_currentStep.decode(param1) as int;
      local2.eventMember = this.codec_eventMember.decode(param1) as Boolean;
      local2.remainingTimeInSec = this.codec_remainingTimeInSec.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MobileQuestProfileCC = MobileQuestProfileCC(param2);
      this.codec_currentStep.encode(param1,local3.currentStep);
      this.codec_eventMember.encode(param1,local3.eventMember);
      this.codec_remainingTimeInSec.encode(param1,local3.remainingTimeInSec);
    }
  }
}
