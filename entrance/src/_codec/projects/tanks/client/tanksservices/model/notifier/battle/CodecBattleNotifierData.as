package _codec.projects.tanks.client.tanksservices.model.notifier.battle {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierData;
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;

  public class CodecBattleNotifierData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_battleData:ICodec;
    private var codec_userId:ICodec;

    public function CodecBattleNotifierData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_battleData = param1.getCodec(new TypeCodecInfo(BattleInfoData,false));
      this.codec_userId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleNotifierData = new BattleNotifierData();
      local2.battleData = this.codec_battleData.decode(param1) as BattleInfoData;
      local2.userId = this.codec_userId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleNotifierData = BattleNotifierData(param2);
      this.codec_battleData.encode(param1,local3.battleData);
      this.codec_userId.encode(param1,local3.userId);
    }
  }
}
