package _codec.projects.tanks.client.chat.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.chat.types.BattleChatLink;

  public class CodecBattleChatLink implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_battleIdHex:ICodec;
    private var codec_battleMode:ICodec;
    private var codec_battleName:ICodec;
    private var codec_link:ICodec;

    public function CodecBattleChatLink() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_battleIdHex = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_battleMode = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_battleName = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_link = param1.getCodec(new TypeCodecInfo(String,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleChatLink = new BattleChatLink();
      local2.battleIdHex = this.codec_battleIdHex.decode(param1) as String;
      local2.battleMode = this.codec_battleMode.decode(param1) as String;
      local2.battleName = this.codec_battleName.decode(param1) as String;
      local2.link = this.codec_link.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleChatLink = BattleChatLink(param2);
      this.codec_battleIdHex.encode(param1,local3.battleIdHex);
      this.codec_battleMode.encode(param1,local3.battleMode);
      this.codec_battleName.encode(param1,local3.battleName);
      this.codec_link.encode(param1,local3.link);
    }
  }
}
