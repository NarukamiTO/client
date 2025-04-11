package _codec.projects.tanks.client.clans.panel.foreignclan {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;
  import projects.tanks.client.clans.panel.foreignclan.ForeignClanCC;

  public class CodecForeignClanCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_flags:ICodec;

    public function CodecForeignClanCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_flags = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ClanFlag,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ForeignClanCC = new ForeignClanCC();
      local2.flags = this.codec_flags.decode(param1) as Vector.<ClanFlag>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ForeignClanCC = ForeignClanCC(param2);
      this.codec_flags.encode(param1,local3.flags);
    }
  }
}
