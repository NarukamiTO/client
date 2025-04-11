package _codec.projects.tanks.client.panel.model.profile.userproperties {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.panel.model.profile.userproperties.UserPropertiesCC;
  import projects.tanks.client.users.model.userbattlestatistics.rank.RankBounds;

  public class CodecUserPropertiesCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_canUseGroup:ICodec;
    private var codec_crystals:ICodec;
    private var codec_crystalsRating:ICodec;
    private var codec_daysFromLastVisit:ICodec;
    private var codec_daysFromRegistration:ICodec;
    private var codec_gearScore:ICodec;
    private var codec_goldsTakenRating:ICodec;
    private var codec_hasSpectatorPermissions:ICodec;
    private var codec_id:ICodec;
    private var codec_rank:ICodec;
    private var codec_rankBounds:ICodec;
    private var codec_registrationTimestamp:ICodec;
    private var codec_score:ICodec;
    private var codec_scoreRating:ICodec;
    private var codec_uid:ICodec;
    private var codec_userProfileUrl:ICodec;
    private var codec_userRating:ICodec;

    public function CodecUserPropertiesCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_canUseGroup = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_crystals = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_crystalsRating = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_daysFromLastVisit = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_daysFromRegistration = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_gearScore = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_goldsTakenRating = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_hasSpectatorPermissions = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_id = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_rank = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_rankBounds = param1.getCodec(new TypeCodecInfo(RankBounds,false));
      this.codec_registrationTimestamp = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_score = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_scoreRating = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_uid = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_userProfileUrl = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_userRating = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UserPropertiesCC = new UserPropertiesCC();
      local2.canUseGroup = this.codec_canUseGroup.decode(param1) as Boolean;
      local2.crystals = this.codec_crystals.decode(param1) as int;
      local2.crystalsRating = this.codec_crystalsRating.decode(param1) as int;
      local2.daysFromLastVisit = this.codec_daysFromLastVisit.decode(param1) as int;
      local2.daysFromRegistration = this.codec_daysFromRegistration.decode(param1) as int;
      local2.gearScore = this.codec_gearScore.decode(param1) as int;
      local2.goldsTakenRating = this.codec_goldsTakenRating.decode(param1) as int;
      local2.hasSpectatorPermissions = this.codec_hasSpectatorPermissions.decode(param1) as Boolean;
      local2.id = this.codec_id.decode(param1) as Long;
      local2.rank = this.codec_rank.decode(param1) as int;
      local2.rankBounds = this.codec_rankBounds.decode(param1) as RankBounds;
      local2.registrationTimestamp = this.codec_registrationTimestamp.decode(param1) as int;
      local2.score = this.codec_score.decode(param1) as int;
      local2.scoreRating = this.codec_scoreRating.decode(param1) as int;
      local2.uid = this.codec_uid.decode(param1) as String;
      local2.userProfileUrl = this.codec_userProfileUrl.decode(param1) as String;
      local2.userRating = this.codec_userRating.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UserPropertiesCC = UserPropertiesCC(param2);
      this.codec_canUseGroup.encode(param1,local3.canUseGroup);
      this.codec_crystals.encode(param1,local3.crystals);
      this.codec_crystalsRating.encode(param1,local3.crystalsRating);
      this.codec_daysFromLastVisit.encode(param1,local3.daysFromLastVisit);
      this.codec_daysFromRegistration.encode(param1,local3.daysFromRegistration);
      this.codec_gearScore.encode(param1,local3.gearScore);
      this.codec_goldsTakenRating.encode(param1,local3.goldsTakenRating);
      this.codec_hasSpectatorPermissions.encode(param1,local3.hasSpectatorPermissions);
      this.codec_id.encode(param1,local3.id);
      this.codec_rank.encode(param1,local3.rank);
      this.codec_rankBounds.encode(param1,local3.rankBounds);
      this.codec_registrationTimestamp.encode(param1,local3.registrationTimestamp);
      this.codec_score.encode(param1,local3.score);
      this.codec_scoreRating.encode(param1,local3.scoreRating);
      this.codec_uid.encode(param1,local3.uid);
      this.codec_userProfileUrl.encode(param1,local3.userProfileUrl);
      this.codec_userRating.encode(param1,local3.userRating);
    }
  }
}
