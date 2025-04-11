package _codec.projects.tanks.client.battleselect.model.battle.team {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
  import projects.tanks.client.battleselect.model.battle.team.TeamBattleInfoCC;

  public class CodecTeamBattleInfoCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_scoreBlue:ICodec;
    private var codec_scoreRed:ICodec;
    private var codec_usersBlue:ICodec;
    private var codec_usersRed:ICodec;

    public function CodecTeamBattleInfoCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_scoreBlue = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_scoreRed = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_usersBlue = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BattleInfoUser,false),false,1));
      this.codec_usersRed = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BattleInfoUser,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TeamBattleInfoCC = new TeamBattleInfoCC();
      local2.scoreBlue = this.codec_scoreBlue.decode(param1) as int;
      local2.scoreRed = this.codec_scoreRed.decode(param1) as int;
      local2.usersBlue = this.codec_usersBlue.decode(param1) as Vector.<BattleInfoUser>;
      local2.usersRed = this.codec_usersRed.decode(param1) as Vector.<BattleInfoUser>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TeamBattleInfoCC = TeamBattleInfoCC(param2);
      this.codec_scoreBlue.encode(param1,local3.scoreBlue);
      this.codec_scoreRed.encode(param1,local3.scoreRed);
      this.codec_usersBlue.encode(param1,local3.usersBlue);
      this.codec_usersRed.encode(param1,local3.usersRed);
    }
  }
}
