package _codec.projects.tanks.client.battleselect.model.matchmaking.group.invitewindow {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battleselect.model.matchmaking.group.invitewindow.MatchMakingUserInfo;

  public class CodecMatchMakingUserInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_friend:ICodec;
    private var codec_id:ICodec;
    private var codec_onLine:ICodec;
    private var codec_rank:ICodec;
    private var codec_sameClan:ICodec;
    private var codec_uid:ICodec;

    public function CodecMatchMakingUserInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_friend = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_id = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_onLine = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_rank = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_sameClan = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_uid = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MatchMakingUserInfo = new MatchMakingUserInfo();
      local2.friend = this.codec_friend.decode(param1) as Boolean;
      local2.id = this.codec_id.decode(param1) as Long;
      local2.onLine = this.codec_onLine.decode(param1) as Boolean;
      local2.rank = this.codec_rank.decode(param1) as int;
      local2.sameClan = this.codec_sameClan.decode(param1) as Boolean;
      local2.uid = this.codec_uid.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MatchMakingUserInfo = MatchMakingUserInfo(param2);
      this.codec_friend.encode(param1,local3.friend);
      this.codec_id.encode(param1,local3.id);
      this.codec_onLine.encode(param1,local3.onLine);
      this.codec_rank.encode(param1,local3.rank);
      this.codec_sameClan.encode(param1,local3.sameClan);
      this.codec_uid.encode(param1,local3.uid);
    }
  }
}
