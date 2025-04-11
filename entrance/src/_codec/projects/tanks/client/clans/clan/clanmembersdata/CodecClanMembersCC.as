package _codec.projects.tanks.client.clans.clan.clanmembersdata {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.clans.clan.clanmembersdata.ClanMembersCC;
  import projects.tanks.client.clans.clan.clanmembersdata.UserData;

  public class CodecClanMembersCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_users:ICodec;

    public function CodecClanMembersCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_users = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UserData,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClanMembersCC = new ClanMembersCC();
      local2.users = this.codec_users.decode(param1) as Vector.<UserData>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ClanMembersCC = ClanMembersCC(param2);
      this.codec_users.encode(param1,local3.users);
    }
  }
}
