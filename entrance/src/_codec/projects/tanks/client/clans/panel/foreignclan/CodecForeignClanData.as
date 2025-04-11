package _codec.projects.tanks.client.clans.panel.foreignclan {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.clanmembersdata.UserData;
  import projects.tanks.client.clans.panel.foreignclan.ForeignClanData;

  public class CodecForeignClanData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_blocked:ICodec;
    private var codec_createTime:ICodec;
    private var codec_creatorId:ICodec;
    private var codec_description:ICodec;
    private var codec_flagId:ICodec;
    private var codec_incomingRequestEnabled:ICodec;
    private var codec_maxMembers:ICodec;
    private var codec_memberClan:ICodec;
    private var codec_minRankForAddClan:ICodec;
    private var codec_name:ICodec;
    private var codec_reasonForBlocking:ICodec;
    private var codec_requestInIncoming:ICodec;
    private var codec_requestInOutgoing:ICodec;
    private var codec_tag:ICodec;
    private var codec_timeBlocking:ICodec;
    private var codec_users:ICodec;

    public function CodecForeignClanData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_blocked = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_createTime = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_creatorId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_description = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_flagId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_incomingRequestEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_maxMembers = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_memberClan = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_minRankForAddClan = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_reasonForBlocking = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_requestInIncoming = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_requestInOutgoing = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_tag = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_timeBlocking = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_users = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UserData,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ForeignClanData = new ForeignClanData();
      local2.blocked = this.codec_blocked.decode(param1) as Boolean;
      local2.createTime = this.codec_createTime.decode(param1) as Long;
      local2.creatorId = this.codec_creatorId.decode(param1) as Long;
      local2.description = this.codec_description.decode(param1) as String;
      local2.flagId = this.codec_flagId.decode(param1) as Long;
      local2.incomingRequestEnabled = this.codec_incomingRequestEnabled.decode(param1) as Boolean;
      local2.maxMembers = this.codec_maxMembers.decode(param1) as int;
      local2.memberClan = this.codec_memberClan.decode(param1) as Boolean;
      local2.minRankForAddClan = this.codec_minRankForAddClan.decode(param1) as int;
      local2.name = this.codec_name.decode(param1) as String;
      local2.reasonForBlocking = this.codec_reasonForBlocking.decode(param1) as String;
      local2.requestInIncoming = this.codec_requestInIncoming.decode(param1) as Boolean;
      local2.requestInOutgoing = this.codec_requestInOutgoing.decode(param1) as Boolean;
      local2.tag = this.codec_tag.decode(param1) as String;
      local2.timeBlocking = this.codec_timeBlocking.decode(param1) as Long;
      local2.users = this.codec_users.decode(param1) as Vector.<UserData>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ForeignClanData = ForeignClanData(param2);
      this.codec_blocked.encode(param1,local3.blocked);
      this.codec_createTime.encode(param1,local3.createTime);
      this.codec_creatorId.encode(param1,local3.creatorId);
      this.codec_description.encode(param1,local3.description);
      this.codec_flagId.encode(param1,local3.flagId);
      this.codec_incomingRequestEnabled.encode(param1,local3.incomingRequestEnabled);
      this.codec_maxMembers.encode(param1,local3.maxMembers);
      this.codec_memberClan.encode(param1,local3.memberClan);
      this.codec_minRankForAddClan.encode(param1,local3.minRankForAddClan);
      this.codec_name.encode(param1,local3.name);
      this.codec_reasonForBlocking.encode(param1,local3.reasonForBlocking);
      this.codec_requestInIncoming.encode(param1,local3.requestInIncoming);
      this.codec_requestInOutgoing.encode(param1,local3.requestInOutgoing);
      this.codec_tag.encode(param1,local3.tag);
      this.codec_timeBlocking.encode(param1,local3.timeBlocking);
      this.codec_users.encode(param1,local3.users);
    }
  }
}
