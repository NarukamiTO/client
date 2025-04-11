package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.railgun {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunCC;

  public class CodecRailgunCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_chargingTimeMsec:ICodec;
    private var codec_weakeningCoeff:ICodec;

    public function CodecRailgunCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_chargingTimeMsec = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_weakeningCoeff = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RailgunCC = new RailgunCC();
      local2.chargingTimeMsec = this.codec_chargingTimeMsec.decode(param1) as int;
      local2.weakeningCoeff = this.codec_weakeningCoeff.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RailgunCC = RailgunCC(param2);
      this.codec_chargingTimeMsec.encode(param1,local3.chargingTimeMsec);
      this.codec_weakeningCoeff.encode(param1,local3.weakeningCoeff);
    }
  }
}
