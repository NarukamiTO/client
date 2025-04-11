package _codec.projects.tanks.client.battlefield.models.user.suicide {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.user.suicide.SuicideCC;

  public class CodecSuicideCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_suicideDelayMS:ICodec;

    public function CodecSuicideCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_suicideDelayMS = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SuicideCC = new SuicideCC();
      local2.suicideDelayMS = this.codec_suicideDelayMS.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SuicideCC = SuicideCC(param2);
      this.codec_suicideDelayMS.encode(param1,local3.suicideDelayMS);
    }
  }
}
