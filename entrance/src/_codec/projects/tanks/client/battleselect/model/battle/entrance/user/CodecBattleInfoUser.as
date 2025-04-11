package _codec.projects.tanks.client.battleselect.model.battle.entrance.user {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;

  public class CodecBattleInfoUser implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_clanId:ICodec;
    private var codec_score:ICodec;
    private var codec_suspicious:ICodec;
    private var codec_user:ICodec;

    public function CodecBattleInfoUser() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_clanId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_score = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_suspicious = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_user = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleInfoUser = new BattleInfoUser();
      local2.clanId = this.codec_clanId.decode(param1) as Long;
      local2.score = this.codec_score.decode(param1) as int;
      local2.suspicious = this.codec_suspicious.decode(param1) as Boolean;
      local2.user = this.codec_user.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleInfoUser = BattleInfoUser(param2);
      this.codec_clanId.encode(param1,local3.clanId);
      this.codec_score.encode(param1,local3.score);
      this.codec_suspicious.encode(param1,local3.suspicious);
      this.codec_user.encode(param1,local3.user);
    }
  }
}
