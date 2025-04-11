package _codec.projects.tanks.client.entrance.model.entrance.invite {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.entrance.model.entrance.invite.InviteEntranceCC;

  public class CodecInviteEntranceCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_enabled:ICodec;

    public function CodecInviteEntranceCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_enabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:InviteEntranceCC = new InviteEntranceCC();
      local2.enabled = this.codec_enabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:InviteEntranceCC = InviteEntranceCC(param2);
      this.codec_enabled.encode(param1,local3.enabled);
    }
  }
}
