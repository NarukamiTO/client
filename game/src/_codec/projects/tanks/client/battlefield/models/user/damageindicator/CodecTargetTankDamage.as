package _codec.projects.tanks.client.battlefield.models.user.damageindicator {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.damageindicator.DamageIndicatorType;
  import projects.tanks.client.battlefield.models.user.damageindicator.TargetTankDamage;

  public class CodecTargetTankDamage implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_damageAmount:ICodec;
    private var codec_damageIndicatorType:ICodec;
    private var codec_target:ICodec;

    public function CodecTargetTankDamage() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_damageAmount = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_damageIndicatorType = param1.getCodec(new EnumCodecInfo(DamageIndicatorType,false));
      this.codec_target = param1.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TargetTankDamage = new TargetTankDamage();
      local2.damageAmount = this.codec_damageAmount.decode(param1) as Number;
      local2.damageIndicatorType = this.codec_damageIndicatorType.decode(param1) as DamageIndicatorType;
      local2.target = this.codec_target.decode(param1) as IGameObject;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TargetTankDamage = TargetTankDamage(param2);
      this.codec_damageAmount.encode(param1,local3.damageAmount);
      this.codec_damageIndicatorType.encode(param1,local3.damageIndicatorType);
      this.codec_target.encode(param1,local3.target);
    }
  }
}
