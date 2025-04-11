package _codec.projects.tanks.client.clans.notifier {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.client.clans.notifier.ClanNotifierData;

  public class CodecClanNotifierData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_clanAction:ICodec;
    private var codec_clanId:ICodec;
    private var codec_clanIncoming:ICodec;
    private var codec_clanMember:ICodec;
    private var codec_clanName:ICodec;
    private var codec_clanOutgoing:ICodec;
    private var codec_clanTag:ICodec;
    private var codec_incomingRequestEnabled:ICodec;
    private var codec_minRankForJoinClan:ICodec;
    private var codec_restrictionTimeJoinClan:ICodec;
    private var codec_userId:ICodec;

    public function CodecClanNotifierData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_clanAction = param1.getCodec(new CollectionCodecInfo(new EnumCodecInfo(ClanAction,false),false,1));
      this.codec_clanId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_clanIncoming = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
      this.codec_clanMember = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_clanName = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_clanOutgoing = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
      this.codec_clanTag = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_incomingRequestEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_minRankForJoinClan = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_restrictionTimeJoinClan = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_userId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClanNotifierData = new ClanNotifierData();
      local2.clanAction = this.codec_clanAction.decode(param1) as Vector.<ClanAction>;
      local2.clanId = this.codec_clanId.decode(param1) as Long;
      local2.clanIncoming = this.codec_clanIncoming.decode(param1) as Vector.<Long>;
      local2.clanMember = this.codec_clanMember.decode(param1) as Boolean;
      local2.clanName = this.codec_clanName.decode(param1) as String;
      local2.clanOutgoing = this.codec_clanOutgoing.decode(param1) as Vector.<Long>;
      local2.clanTag = this.codec_clanTag.decode(param1) as String;
      local2.incomingRequestEnabled = this.codec_incomingRequestEnabled.decode(param1) as Boolean;
      local2.minRankForJoinClan = this.codec_minRankForJoinClan.decode(param1) as int;
      local2.restrictionTimeJoinClan = this.codec_restrictionTimeJoinClan.decode(param1) as Long;
      local2.userId = this.codec_userId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ClanNotifierData = ClanNotifierData(param2);
      this.codec_clanAction.encode(param1,local3.clanAction);
      this.codec_clanId.encode(param1,local3.clanId);
      this.codec_clanIncoming.encode(param1,local3.clanIncoming);
      this.codec_clanMember.encode(param1,local3.clanMember);
      this.codec_clanName.encode(param1,local3.clanName);
      this.codec_clanOutgoing.encode(param1,local3.clanOutgoing);
      this.codec_clanTag.encode(param1,local3.clanTag);
      this.codec_incomingRequestEnabled.encode(param1,local3.incomingRequestEnabled);
      this.codec_minRankForJoinClan.encode(param1,local3.minRankForJoinClan);
      this.codec_restrictionTimeJoinClan.encode(param1,local3.restrictionTimeJoinClan);
      this.codec_userId.encode(param1,local3.userId);
    }
  }
}
