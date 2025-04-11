package _codec.projects.tanks.client.panel.model.challenge.stars {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.challenge.stars.StarsInfoCC;

  public class CodecStarsInfoCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_stars:ICodec;

    public function CodecStarsInfoCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_stars = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:StarsInfoCC = new StarsInfoCC();
      local2.stars = this.codec_stars.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:StarsInfoCC = StarsInfoCC(param2);
      this.codec_stars.encode(param1,local3.stars);
    }
  }
}
