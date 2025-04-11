package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.weakening {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapon.weakening.WeaponWeakeningCC;

  public class CodecWeaponWeakeningCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_maximumDamageRadius:ICodec;
    private var codec_minimumDamagePercent:ICodec;
    private var codec_minimumDamageRadius:ICodec;

    public function CodecWeaponWeakeningCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_maximumDamageRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_minimumDamagePercent = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_minimumDamageRadius = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:WeaponWeakeningCC = new WeaponWeakeningCC();
      local2.maximumDamageRadius = this.codec_maximumDamageRadius.decode(param1) as Number;
      local2.minimumDamagePercent = this.codec_minimumDamagePercent.decode(param1) as Number;
      local2.minimumDamageRadius = this.codec_minimumDamageRadius.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:WeaponWeakeningCC = WeaponWeakeningCC(param2);
      this.codec_maximumDamageRadius.encode(param1,local3.maximumDamageRadius);
      this.codec_minimumDamagePercent.encode(param1,local3.minimumDamagePercent);
      this.codec_minimumDamageRadius.encode(param1,local3.minimumDamageRadius);
    }
  }
}
