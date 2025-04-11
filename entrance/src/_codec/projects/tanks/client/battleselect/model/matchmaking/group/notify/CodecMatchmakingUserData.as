package _codec.projects.tanks.client.battleselect.model.matchmaking.group.notify {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MatchmakingUserData;

  public class CodecMatchmakingUserData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_armorModification:ICodec;
    private var codec_armorName:ICodec;
    private var codec_armorUpgradeLevel:ICodec;
    private var codec_id:ICodec;
    private var codec_leader:ICodec;
    private var codec_local:ICodec;
    private var codec_rank:ICodec;
    private var codec_uid:ICodec;
    private var codec_userIsReady:ICodec;
    private var codec_weaponModification:ICodec;
    private var codec_weaponName:ICodec;
    private var codec_weaponUpgradeLevel:ICodec;

    public function CodecMatchmakingUserData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_armorModification = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_armorName = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_armorUpgradeLevel = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_id = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_leader = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_local = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_rank = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_uid = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_userIsReady = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_weaponModification = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_weaponName = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_weaponUpgradeLevel = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MatchmakingUserData = new MatchmakingUserData();
      local2.armorModification = this.codec_armorModification.decode(param1) as int;
      local2.armorName = this.codec_armorName.decode(param1) as String;
      local2.armorUpgradeLevel = this.codec_armorUpgradeLevel.decode(param1) as int;
      local2.id = this.codec_id.decode(param1) as Long;
      local2.leader = this.codec_leader.decode(param1) as Boolean;
      local2.local = this.codec_local.decode(param1) as Boolean;
      local2.rank = this.codec_rank.decode(param1) as int;
      local2.uid = this.codec_uid.decode(param1) as String;
      local2.userIsReady = this.codec_userIsReady.decode(param1) as Boolean;
      local2.weaponModification = this.codec_weaponModification.decode(param1) as int;
      local2.weaponName = this.codec_weaponName.decode(param1) as String;
      local2.weaponUpgradeLevel = this.codec_weaponUpgradeLevel.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MatchmakingUserData = MatchmakingUserData(param2);
      this.codec_armorModification.encode(param1,local3.armorModification);
      this.codec_armorName.encode(param1,local3.armorName);
      this.codec_armorUpgradeLevel.encode(param1,local3.armorUpgradeLevel);
      this.codec_id.encode(param1,local3.id);
      this.codec_leader.encode(param1,local3.leader);
      this.codec_local.encode(param1,local3.local);
      this.codec_rank.encode(param1,local3.rank);
      this.codec_uid.encode(param1,local3.uid);
      this.codec_userIsReady.encode(param1,local3.userIsReady);
      this.codec_weaponModification.encode(param1,local3.weaponModification);
      this.codec_weaponName.encode(param1,local3.weaponName);
      this.codec_weaponUpgradeLevel.encode(param1,local3.weaponUpgradeLevel);
    }
  }
}
