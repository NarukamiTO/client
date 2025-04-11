package projects.tanks.client.battlefield.models.bonus.battle.battlefield {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battlefield.models.bonus.battle.BonusSpawnData;

  public class BattlefieldBonusesModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattlefieldBonusesModelServer;

    private var client:IBattlefieldBonusesModelBase = IBattlefieldBonusesModelBase(this);
    private var modelId:Long = Long.getLong(499495185,-1001709329);
    private var _attemptToTakeBonusFailedTankNotActiveId:Long = Long.getLong(1110230456,-1498226724);
    private var _attemptToTakeBonusFailedTankNotActive_bonusIdCodec:ICodec;
    private var _bonusTakenId:Long = Long.getLong(947041522,265172046);
    private var _bonusTaken_bonusIdCodec:ICodec;
    private var _removeBonusesId:Long = Long.getLong(1746264244,602761789);
    private var _removeBonuses_bonusIdsCodec:ICodec;
    private var _spawnBonusesId:Long = Long.getLong(325483057,2045730824);
    private var _spawnBonuses_spawnDataCodec:ICodec;
    private var _spawnBonusesOnGroundId:Long = Long.getLong(517408438,-497402786);
    private var _spawnBonusesOnGround_spawnDataCodec:ICodec;

    public function BattlefieldBonusesModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattlefieldBonusesModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(BattlefieldBonusesCC,false)));
      this._attemptToTakeBonusFailedTankNotActive_bonusIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._bonusTaken_bonusIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._removeBonuses_bonusIdsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
      this._spawnBonuses_spawnDataCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BonusSpawnData,false),false,1));
      this._spawnBonusesOnGround_spawnDataCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BonusSpawnData,false),false,1));
    }

    protected function getInitParam() : BattlefieldBonusesCC {
      return BattlefieldBonusesCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._attemptToTakeBonusFailedTankNotActiveId:
          this.client.attemptToTakeBonusFailedTankNotActive(Long(this._attemptToTakeBonusFailedTankNotActive_bonusIdCodec.decode(param2)));
          break;
        case this._bonusTakenId:
          this.client.bonusTaken(Long(this._bonusTaken_bonusIdCodec.decode(param2)));
          break;
        case this._removeBonusesId:
          this.client.removeBonuses(this._removeBonuses_bonusIdsCodec.decode(param2) as Vector.<Long>);
          break;
        case this._spawnBonusesId:
          this.client.spawnBonuses(this._spawnBonuses_spawnDataCodec.decode(param2) as Vector.<BonusSpawnData>);
          break;
        case this._spawnBonusesOnGroundId:
          this.client.spawnBonusesOnGround(this._spawnBonusesOnGround_spawnDataCodec.decode(param2) as Vector.<BonusSpawnData>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
