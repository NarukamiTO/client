package _codec.projects.tanks.client.battlefield.models.battle.pointbased {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class CodecClientTeamPoint implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_flagBasePosition:ICodec;
    private var codec_id:ICodec;
    private var codec_teamType:ICodec;

    public function CodecClientTeamPoint() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_flagBasePosition = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_id = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_teamType = param1.getCodec(new EnumCodecInfo(BattleTeam,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClientTeamPoint = new ClientTeamPoint();
      local2.flagBasePosition = this.codec_flagBasePosition.decode(param1) as Vector3d;
      local2.id = this.codec_id.decode(param1) as int;
      local2.teamType = this.codec_teamType.decode(param1) as BattleTeam;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ClientTeamPoint = ClientTeamPoint(param2);
      this.codec_flagBasePosition.encode(param1,local3.flagBasePosition);
      this.codec_id.encode(param1,local3.id);
      this.codec_teamType.encode(param1,local3.teamType);
    }
  }
}
