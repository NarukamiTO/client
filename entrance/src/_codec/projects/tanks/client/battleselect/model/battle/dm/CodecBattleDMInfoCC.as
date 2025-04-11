package _codec.projects.tanks.client.battleselect.model.battle.dm {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battleselect.model.battle.dm.BattleDMInfoCC;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;

  public class CodecBattleDMInfoCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_users:ICodec;

    public function CodecBattleDMInfoCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_users = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BattleInfoUser,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleDMInfoCC = new BattleDMInfoCC();
      local2.users = this.codec_users.decode(param1) as Vector.<BattleInfoUser>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleDMInfoCC = BattleDMInfoCC(param2);
      this.codec_users.encode(param1,local3.users);
    }
  }
}
