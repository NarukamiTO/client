package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals.VerticalAnglesCC;

  public class CodecVerticalAnglesCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_angleDown:ICodec;
    private var codec_angleUp:ICodec;

    public function CodecVerticalAnglesCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_angleDown = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_angleUp = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:VerticalAnglesCC = new VerticalAnglesCC();
      local2.angleDown = this.codec_angleDown.decode(param1) as Number;
      local2.angleUp = this.codec_angleUp.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:VerticalAnglesCC = VerticalAnglesCC(param2);
      this.codec_angleDown.encode(param1,local3.angleDown);
      this.codec_angleUp.encode(param1,local3.angleUp);
    }
  }
}
