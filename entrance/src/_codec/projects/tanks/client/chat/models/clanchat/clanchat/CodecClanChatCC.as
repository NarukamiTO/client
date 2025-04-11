package _codec.projects.tanks.client.chat.models.clanchat.clanchat {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.chat.models.clanchat.clanchat.ClanChatCC;

  public class CodecClanChatCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_inClan:ICodec;
    private var codec_selfName:ICodec;

    public function CodecClanChatCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_inClan = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_selfName = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClanChatCC = new ClanChatCC();
      local2.inClan = this.codec_inClan.decode(param1) as Boolean;
      local2.selfName = this.codec_selfName.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ClanChatCC = ClanChatCC(param2);
      this.codec_inClan.encode(param1,local3.inClan);
      this.codec_selfName.encode(param1,local3.selfName);
    }
  }
}
