package _codec.projects.tanks.client.tanksservices.model.proabonementnotifier {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.tanksservices.model.proabonementnotifier.ProAbonementNotifierCC;

  public class CodecProAbonementNotifierCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_abonementRemainingTimeInSec:ICodec;

    public function CodecProAbonementNotifierCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_abonementRemainingTimeInSec = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ProAbonementNotifierCC = new ProAbonementNotifierCC();
      local2.abonementRemainingTimeInSec = this.codec_abonementRemainingTimeInSec.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ProAbonementNotifierCC = ProAbonementNotifierCC(param2);
      this.codec_abonementRemainingTimeInSec.encode(param1,local3.abonementRemainingTimeInSec);
    }
  }
}
