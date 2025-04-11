package _codec.projects.tanks.client.entrance.model.entrance.telegram {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.entrance.model.entrance.telegram.TelegramEntranceModelCC;

  public class CodecTelegramEntranceModelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_botName:ICodec;

    public function CodecTelegramEntranceModelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_botName = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TelegramEntranceModelCC = new TelegramEntranceModelCC();
      local2.botName = this.codec_botName.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TelegramEntranceModelCC = TelegramEntranceModelCC(param2);
      this.codec_botName.encode(param1,local3.botName);
    }
  }
}
