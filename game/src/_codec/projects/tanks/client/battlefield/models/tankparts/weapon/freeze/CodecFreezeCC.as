package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.freeze {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapon.freeze.FreezeCC;

  public class CodecFreezeCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_damageAreaConeAngle:ICodec;
    private var codec_damageAreaRange:ICodec;

    public function CodecFreezeCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_damageAreaConeAngle = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_damageAreaRange = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:FreezeCC = new FreezeCC();
      local2.damageAreaConeAngle = this.codec_damageAreaConeAngle.decode(param1) as Number;
      local2.damageAreaRange = this.codec_damageAreaRange.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:FreezeCC = FreezeCC(param2);
      this.codec_damageAreaConeAngle.encode(param1,local3.damageAreaConeAngle);
      this.codec_damageAreaRange.encode(param1,local3.damageAreaRange);
    }
  }
}
