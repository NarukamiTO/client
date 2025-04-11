package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.ricochet {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetCC;

  public class CodecRicochetCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_energyCapacity:ICodec;
    private var codec_energyPerShot:ICodec;
    private var codec_energyRechargeSpeed:ICodec;
    private var codec_maxRicochetCount:ICodec;
    private var codec_shellRadius:ICodec;
    private var codec_shellSpeed:ICodec;
    private var codec_shotDistance:ICodec;

    public function CodecRicochetCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_energyCapacity = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_energyPerShot = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_energyRechargeSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_maxRicochetCount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_shellRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_shellSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_shotDistance = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RicochetCC = new RicochetCC();
      local2.energyCapacity = this.codec_energyCapacity.decode(param1) as Number;
      local2.energyPerShot = this.codec_energyPerShot.decode(param1) as Number;
      local2.energyRechargeSpeed = this.codec_energyRechargeSpeed.decode(param1) as Number;
      local2.maxRicochetCount = this.codec_maxRicochetCount.decode(param1) as int;
      local2.shellRadius = this.codec_shellRadius.decode(param1) as Number;
      local2.shellSpeed = this.codec_shellSpeed.decode(param1) as Number;
      local2.shotDistance = this.codec_shotDistance.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RicochetCC = RicochetCC(param2);
      this.codec_energyCapacity.encode(param1,local3.energyCapacity);
      this.codec_energyPerShot.encode(param1,local3.energyPerShot);
      this.codec_energyRechargeSpeed.encode(param1,local3.energyRechargeSpeed);
      this.codec_maxRicochetCount.encode(param1,local3.maxRicochetCount);
      this.codec_shellRadius.encode(param1,local3.shellRadius);
      this.codec_shellSpeed.encode(param1,local3.shellSpeed);
      this.codec_shotDistance.encode(param1,local3.shotDistance);
    }
  }
}
