package _codec.projects.tanks.client.panel.model.tutorialhints {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.tutorialhints.TutorialHintsCC;
  import projects.tanks.client.panel.model.tutorialhints.TutorialHintsData;

  public class CodecTutorialHintsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_tutorialHintsData:ICodec;

    public function CodecTutorialHintsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_tutorialHintsData = param1.getCodec(new TypeCodecInfo(TutorialHintsData,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TutorialHintsCC = new TutorialHintsCC();
      local2.tutorialHintsData = this.codec_tutorialHintsData.decode(param1) as TutorialHintsData;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TutorialHintsCC = TutorialHintsCC(param2);
      this.codec_tutorialHintsData.encode(param1,local3.tutorialHintsData);
    }
  }
}
