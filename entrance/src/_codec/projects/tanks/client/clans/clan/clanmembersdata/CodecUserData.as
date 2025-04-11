package _codec.projects.tanks.client.clans.clan.clanmembersdata {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.clanmembersdata.UserData;
  import projects.tanks.client.clans.clan.permissions.ClanPermission;

  public class CodecUserData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_dateInClanInSec:ICodec;
    private var codec_deaths:ICodec;
    private var codec_kills:ICodec;
    private var codec_lastVisitTime:ICodec;
    private var codec_permission:ICodec;
    private var codec_score:ICodec;
    private var codec_userId:ICodec;

    public function CodecUserData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_dateInClanInSec = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_deaths = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_kills = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_lastVisitTime = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_permission = param1.getCodec(new EnumCodecInfo(ClanPermission,true));
      this.codec_score = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_userId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UserData = new UserData();
      local2.dateInClanInSec = this.codec_dateInClanInSec.decode(param1) as int;
      local2.deaths = this.codec_deaths.decode(param1) as int;
      local2.kills = this.codec_kills.decode(param1) as int;
      local2.lastVisitTime = this.codec_lastVisitTime.decode(param1) as Long;
      local2.permission = this.codec_permission.decode(param1) as ClanPermission;
      local2.score = this.codec_score.decode(param1) as int;
      local2.userId = this.codec_userId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UserData = UserData(param2);
      this.codec_dateInClanInSec.encode(param1,local3.dateInClanInSec);
      this.codec_deaths.encode(param1,local3.deaths);
      this.codec_kills.encode(param1,local3.kills);
      this.codec_lastVisitTime.encode(param1,local3.lastVisitTime);
      this.codec_permission.encode(param1,local3.permission);
      this.codec_score.encode(param1,local3.score);
      this.codec_userId.encode(param1,local3.userId);
    }
  }
}
