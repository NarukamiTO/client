package _codec.projects.tanks.client.panel.model.presents {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.presents.PresentsSettingsCC;

  public class CodecPresentsSettingsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_receivePresentsEnabled:ICodec;

    public function CodecPresentsSettingsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_receivePresentsEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PresentsSettingsCC = new PresentsSettingsCC();
      local2.receivePresentsEnabled = this.codec_receivePresentsEnabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PresentsSettingsCC = PresentsSettingsCC(param2);
      this.codec_receivePresentsEnabled.encode(param1,local3.receivePresentsEnabled);
    }
  }
}
