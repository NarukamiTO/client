package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon.StreamWeaponCC;

  public class CodecStreamWeaponCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_energyCapacity:ICodec;
    private var codec_energyDischargeSpeed:ICodec;
    private var codec_energyRechargeSpeed:ICodec;
    private var codec_weaponTickIntervalMsec:ICodec;

    public function CodecStreamWeaponCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_energyCapacity = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_energyDischargeSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_energyRechargeSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_weaponTickIntervalMsec = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:StreamWeaponCC = new StreamWeaponCC();
      local2.energyCapacity = this.codec_energyCapacity.decode(param1) as Number;
      local2.energyDischargeSpeed = this.codec_energyDischargeSpeed.decode(param1) as Number;
      local2.energyRechargeSpeed = this.codec_energyRechargeSpeed.decode(param1) as Number;
      local2.weaponTickIntervalMsec = this.codec_weaponTickIntervalMsec.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:StreamWeaponCC = StreamWeaponCC(param2);
      this.codec_energyCapacity.encode(param1,local3.energyCapacity);
      this.codec_energyDischargeSpeed.encode(param1,local3.energyDischargeSpeed);
      this.codec_energyRechargeSpeed.encode(param1,local3.energyRechargeSpeed);
      this.codec_weaponTickIntervalMsec.encode(param1,local3.weaponTickIntervalMsec);
    }
  }
}
