package _codec.projects.tanks.client.battlefield.models.battle.battlefield.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.battle.battlefield.types.HitTraceData;

  public class CodecHitTraceData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_armorPreEffectDamage:ICodec;
    private var codec_colorResistDamage:ICodec;
    private var codec_hullResistDamage:ICodec;
    private var codec_killerTurretName:ICodec;
    private var codec_origDamage:ICodec;
    private var codec_postHealth:ICodec;
    private var codec_targetHealth:ICodec;
    private var codec_targetHullName:ICodec;
    private var codec_weaponEffectsDamage:ICodec;

    public function CodecHitTraceData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_armorPreEffectDamage = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_colorResistDamage = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_hullResistDamage = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_killerTurretName = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_origDamage = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_postHealth = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_targetHealth = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_targetHullName = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_weaponEffectsDamage = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:HitTraceData = new HitTraceData();
      local2.armorPreEffectDamage = this.codec_armorPreEffectDamage.decode(param1) as Number;
      local2.colorResistDamage = this.codec_colorResistDamage.decode(param1) as Number;
      local2.hullResistDamage = this.codec_hullResistDamage.decode(param1) as Number;
      local2.killerTurretName = this.codec_killerTurretName.decode(param1) as String;
      local2.origDamage = this.codec_origDamage.decode(param1) as Number;
      local2.postHealth = this.codec_postHealth.decode(param1) as Number;
      local2.targetHealth = this.codec_targetHealth.decode(param1) as Number;
      local2.targetHullName = this.codec_targetHullName.decode(param1) as String;
      local2.weaponEffectsDamage = this.codec_weaponEffectsDamage.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:HitTraceData = HitTraceData(param2);
      this.codec_armorPreEffectDamage.encode(param1,local3.armorPreEffectDamage);
      this.codec_colorResistDamage.encode(param1,local3.colorResistDamage);
      this.codec_hullResistDamage.encode(param1,local3.hullResistDamage);
      this.codec_killerTurretName.encode(param1,local3.killerTurretName);
      this.codec_origDamage.encode(param1,local3.origDamage);
      this.codec_postHealth.encode(param1,local3.postHealth);
      this.codec_targetHealth.encode(param1,local3.targetHealth);
      this.codec_targetHullName.encode(param1,local3.targetHullName);
      this.codec_weaponEffectsDamage.encode(param1,local3.weaponEffectsDamage);
    }
  }
}
