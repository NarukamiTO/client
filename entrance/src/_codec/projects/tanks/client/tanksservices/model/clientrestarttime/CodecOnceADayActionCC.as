package _codec.projects.tanks.client.tanksservices.model.clientrestarttime {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.tanksservices.model.clientrestarttime.OnceADayActionCC;

  public class CodecOnceADayActionCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_todayRestartTime:ICodec;

    public function CodecOnceADayActionCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_todayRestartTime = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:OnceADayActionCC = new OnceADayActionCC();
      local2.todayRestartTime = this.codec_todayRestartTime.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:OnceADayActionCC = OnceADayActionCC(param2);
      this.codec_todayRestartTime.encode(param1,local3.todayRestartTime);
    }
  }
}
