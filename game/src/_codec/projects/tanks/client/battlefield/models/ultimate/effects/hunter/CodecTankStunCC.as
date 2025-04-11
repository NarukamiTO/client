package _codec.projects.tanks.client.battlefield.models.ultimate.effects.hunter {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.ultimate.effects.hunter.TankStunCC;

  public class CodecTankStunCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_stunned:ICodec;

    public function CodecTankStunCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_stunned = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TankStunCC = new TankStunCC();
      local2.stunned = this.codec_stunned.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TankStunCC = TankStunCC(param2);
      this.codec_stunned.encode(param1,local3.stunned);
    }
  }
}
