package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.terminator {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.terminator.TerminatorCC;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;

  public class CodecTerminatorCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_primaryCC:ICodec;
    private var codec_secondaryCC:ICodec;
    private var codec_secondaryKickback:ICodec;

    public function CodecTerminatorCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_primaryCC = param1.getCodec(new TypeCodecInfo(RailgunCC,false));
      this.codec_secondaryCC = param1.getCodec(new TypeCodecInfo(RocketLauncherCC,false));
      this.codec_secondaryKickback = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TerminatorCC = new TerminatorCC();
      local2.primaryCC = this.codec_primaryCC.decode(param1) as RailgunCC;
      local2.secondaryCC = this.codec_secondaryCC.decode(param1) as RocketLauncherCC;
      local2.secondaryKickback = this.codec_secondaryKickback.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TerminatorCC = TerminatorCC(param2);
      this.codec_primaryCC.encode(param1,local3.primaryCC);
      this.codec_secondaryCC.encode(param1,local3.secondaryCC);
      this.codec_secondaryKickback.encode(param1,local3.secondaryKickback);
    }
  }
}
