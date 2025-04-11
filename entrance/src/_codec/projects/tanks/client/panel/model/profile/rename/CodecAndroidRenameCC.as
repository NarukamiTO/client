package _codec.projects.tanks.client.panel.model.profile.rename {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.profile.rename.AndroidRenameCC;

  public class CodecAndroidRenameCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_renameEnabled:ICodec;

    public function CodecAndroidRenameCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_renameEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:AndroidRenameCC = new AndroidRenameCC();
      local2.renameEnabled = this.codec_renameEnabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:AndroidRenameCC = AndroidRenameCC(param2);
      this.codec_renameEnabled.encode(param1,local3.renameEnabled);
    }
  }
}
