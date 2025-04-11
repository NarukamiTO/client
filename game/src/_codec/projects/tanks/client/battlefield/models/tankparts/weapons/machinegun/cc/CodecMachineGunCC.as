package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.cc {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.cc.MachineGunCC;

  public class CodecMachineGunCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_spinDownTime:ICodec;
    private var codec_spinUpTime:ICodec;
    private var codec_started:ICodec;
    private var codec_state:ICodec;
    private var codec_temperatureHittingTime:ICodec;
    private var codec_weaponTurnDecelerationCoeff:ICodec;

    public function CodecMachineGunCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_spinDownTime = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_spinUpTime = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_started = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_state = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_temperatureHittingTime = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_weaponTurnDecelerationCoeff = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MachineGunCC = new MachineGunCC();
      local2.spinDownTime = this.codec_spinDownTime.decode(param1) as int;
      local2.spinUpTime = this.codec_spinUpTime.decode(param1) as int;
      local2.started = this.codec_started.decode(param1) as Boolean;
      local2.state = this.codec_state.decode(param1) as Number;
      local2.temperatureHittingTime = this.codec_temperatureHittingTime.decode(param1) as int;
      local2.weaponTurnDecelerationCoeff = this.codec_weaponTurnDecelerationCoeff.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MachineGunCC = MachineGunCC(param2);
      this.codec_spinDownTime.encode(param1,local3.spinDownTime);
      this.codec_spinUpTime.encode(param1,local3.spinUpTime);
      this.codec_started.encode(param1,local3.started);
      this.codec_state.encode(param1,local3.state);
      this.codec_temperatureHittingTime.encode(param1,local3.temperatureHittingTime);
      this.codec_weaponTurnDecelerationCoeff.encode(param1,local3.weaponTurnDecelerationCoeff);
    }
  }
}
