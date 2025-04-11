package _codec.projects.tanks.client.battlefield.models.bonus.battle.battlefield {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.bonus.battle.BonusSpawnData;
  import projects.tanks.client.battlefield.models.bonus.battle.battlefield.BattlefieldBonusesCC;

  public class CodecBattlefieldBonusesCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bonusFallSpeed:ICodec;
    private var codec_bonuses:ICodec;

    public function CodecBattlefieldBonusesCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bonusFallSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_bonuses = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BonusSpawnData,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattlefieldBonusesCC = new BattlefieldBonusesCC();
      local2.bonusFallSpeed = this.codec_bonusFallSpeed.decode(param1) as Number;
      local2.bonuses = this.codec_bonuses.decode(param1) as Vector.<BonusSpawnData>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattlefieldBonusesCC = BattlefieldBonusesCC(param2);
      this.codec_bonusFallSpeed.encode(param1,local3.bonusFallSpeed);
      this.codec_bonuses.encode(param1,local3.bonuses);
    }
  }
}
