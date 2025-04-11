package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.healing {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisCC;

  public class CodecIsisCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_capacity:ICodec;
    private var codec_chargeRate:ICodec;
    private var codec_checkPeriodMsec:ICodec;
    private var codec_coneAngle:ICodec;
    private var codec_dischargeDamageRate:ICodec;
    private var codec_dischargeHealingRate:ICodec;
    private var codec_dischargeIdleRate:ICodec;
    private var codec_radius:ICodec;

    public function CodecIsisCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_capacity = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_chargeRate = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_checkPeriodMsec = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_coneAngle = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_dischargeDamageRate = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_dischargeHealingRate = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_dischargeIdleRate = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_radius = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:IsisCC = new IsisCC();
      local2.capacity = this.codec_capacity.decode(param1) as Number;
      local2.chargeRate = this.codec_chargeRate.decode(param1) as Number;
      local2.checkPeriodMsec = this.codec_checkPeriodMsec.decode(param1) as int;
      local2.coneAngle = this.codec_coneAngle.decode(param1) as Number;
      local2.dischargeDamageRate = this.codec_dischargeDamageRate.decode(param1) as Number;
      local2.dischargeHealingRate = this.codec_dischargeHealingRate.decode(param1) as Number;
      local2.dischargeIdleRate = this.codec_dischargeIdleRate.decode(param1) as Number;
      local2.radius = this.codec_radius.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:IsisCC = IsisCC(param2);
      this.codec_capacity.encode(param1,local3.capacity);
      this.codec_chargeRate.encode(param1,local3.chargeRate);
      this.codec_checkPeriodMsec.encode(param1,local3.checkPeriodMsec);
      this.codec_coneAngle.encode(param1,local3.coneAngle);
      this.codec_dischargeDamageRate.encode(param1,local3.dischargeDamageRate);
      this.codec_dischargeHealingRate.encode(param1,local3.dischargeHealingRate);
      this.codec_dischargeIdleRate.encode(param1,local3.dischargeIdleRate);
      this.codec_radius.encode(param1,local3.radius);
    }
  }
}
