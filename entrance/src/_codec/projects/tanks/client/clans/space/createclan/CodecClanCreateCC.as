package _codec.projects.tanks.client.clans.space.createclan {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.clans.space.createclan.ClanCreateCC;

  public class CodecClanCreateCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_minRankForCreateClan:ICodec;

    public function CodecClanCreateCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_minRankForCreateClan = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClanCreateCC = new ClanCreateCC();
      local2.minRankForCreateClan = this.codec_minRankForCreateClan.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ClanCreateCC = ClanCreateCC(param2);
      this.codec_minRankForCreateClan.encode(param1,local3.minRankForCreateClan);
    }
  }
}
